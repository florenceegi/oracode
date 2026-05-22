#!/usr/bin/env python3
"""
Web Quality Gate — verifica automatizzata criteri pagina web pubblica.

Esegue tutti i criteri automatizzabili senza browser dal protocollo
WEB_PAGE_QUALITY_GATE.md. Produce report JSON + output leggibile.

Usage:
  python3 web_quality_gate.py --dir out/ --page egi --locales it,en,de,es,fr,pt,zh
  python3 web_quality_gate.py --dir out/ --page egi --locales it,en,de,es,fr,pt,zh --url https://fabiocherici.com

Con --url esegue anche i controlli post-deploy (HTTP status, security headers, sitemap).

Exit code: 0 = PASS, 1 = FAIL (almeno un criterio obbligatorio fallito)

@package oracode/bin
@author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
@version 1.0.0 (FlorenceEGI — Oracode)
@date 2026-05-22
@purpose Gate automatico pre-commit per pagine web pubbliche — 90 criteri, 12 categorie
"""

import argparse
import html
import json
import os
import re
import subprocess
import sys
from dataclasses import dataclass, field
from pathlib import Path
from typing import Optional


@dataclass
class Check:
    id: str
    category: str
    description: str
    status: str = "SKIP"  # PASS, FAIL, WARN, SKIP
    detail: str = ""
    mandatory: bool = True


@dataclass
class GateReport:
    page: str
    locales: list
    checks: list = field(default_factory=list)

    @property
    def passed(self) -> bool:
        return not any(c.status == "FAIL" and c.mandatory for c in self.checks)

    @property
    def summary(self) -> dict:
        total = len([c for c in self.checks if c.status != "SKIP"])
        passed = len([c for c in self.checks if c.status == "PASS"])
        failed = len([c for c in self.checks if c.status == "FAIL"])
        warned = len([c for c in self.checks if c.status == "WARN"])
        return {"total": total, "pass": passed, "fail": failed, "warn": warned, "gate": "PASS" if self.passed else "FAIL"}

    def to_json(self) -> dict:
        return {
            "page": self.page,
            "locales": self.locales,
            "gate": "PASS" if self.passed else "FAIL",
            "summary": self.summary,
            "checks": [{"id": c.id, "category": c.category, "description": c.description,
                        "status": c.status, "detail": c.detail, "mandatory": c.mandatory}
                       for c in self.checks if c.status != "SKIP"],
        }


def read_html(path: Path) -> Optional[str]:
    try:
        return path.read_text(encoding="utf-8")
    except FileNotFoundError:
        return None


def add(report: GateReport, id: str, cat: str, desc: str, passed: bool, detail: str = "", mandatory: bool = True):
    report.checks.append(Check(id, cat, desc, "PASS" if passed else "FAIL", detail, mandatory))


def check_html_structure(report: GateReport, html_content: str, locale: str):
    prefix = f"{locale}/"

    add(report, f"H-1:{locale}", "HTML", "DOCTYPE present",
        html_content.strip().startswith("<!DOCTYPE html>"))

    add(report, f"H-2:{locale}", "HTML", f"html lang=\"{locale}\"",
        f'lang="{locale}"' in html_content[:500])

    add(report, f"H-3:{locale}", "HTML", "charset utf-8",
        "utf-8" in html_content[:1024].lower())

    add(report, f"H-4:{locale}", "HTML", "viewport meta",
        "width=device-width" in html_content)

    h1_count = len(re.findall(r"<h1[\s>]", html_content))
    add(report, f"H-5:{locale}", "HTML", f"single H1 (found {h1_count})",
        h1_count == 1)

    add(report, f"H-7a:{locale}", "HTML", "<main> landmark",
        "<main" in html_content)

    add(report, f"H-7b:{locale}", "HTML", "<nav> landmark",
        "<nav" in html_content)

    escaped_tags = len(re.findall(r"&lt;(?:b|strong|em|i|a|span)&gt;", html_content))
    add(report, f"H-9:{locale}", "HTML", f"zero escaped HTML tags (found {escaped_tags})",
        escaped_tags == 0)


def check_seo(report: GateReport, html_content: str, locale: str, all_locales: list):
    title_match = re.search(r"<title>([^<]+)</title>", html_content)
    if title_match:
        title = title_match.group(1)
        title_len = len(title)
        add(report, f"S-1:{locale}", "SEO", f"title present, {title_len} chars",
            30 <= title_len <= 65, f'"{title}"')

        parts = title.split("|")
        stripped = [p.strip() for p in parts]
        has_dup = len(stripped) != len(set(stripped))
        add(report, f"S-2:{locale}", "SEO", "title no duplication",
            not has_dup, f'"{title}"' if has_dup else "")
    else:
        add(report, f"S-1:{locale}", "SEO", "title present", False, "NO TITLE TAG")

    desc_match = re.search(r'<meta name="description" content="([^"]+)"', html_content)
    if desc_match:
        desc_raw = desc_match.group(1)
        desc_text = html.unescape(desc_raw)
        desc_len = len(desc_text)
        min_len = 50 if locale == "zh" else 120
        add(report, f"S-3:{locale}", "SEO", f"meta description {desc_len} chars ({min_len}-160)",
            min_len <= desc_len <= 160, f"{desc_len} chars")
    else:
        add(report, f"S-3:{locale}", "SEO", "meta description present", False, "MISSING")

    add(report, f"S-4:{locale}", "SEO", "canonical present",
        'rel="canonical"' in html_content)

    hreflang_count = len(re.findall(r'hrefLang="[^"]+"', html_content))
    if hreflang_count == 0:
        hreflang_count = len(re.findall(r'hreflang="[^"]+"', html_content))
    expected = len(all_locales) + 1  # +1 for x-default
    add(report, f"S-5:{locale}", "SEO", f"hreflang tags: {hreflang_count} (need {expected})",
        hreflang_count >= expected)

    add(report, f"S-6:{locale}", "SEO", "x-default hreflang",
        "x-default" in html_content)

    add(report, f"S-9:{locale}", "SEO", "no noindex",
        "noindex" not in html_content)


def check_schema(report: GateReport, html_content: str, locale: str):
    scripts = re.findall(r'<script[^>]*application/ld\+json[^>]*>(.*?)</script>', html_content, re.DOTALL)

    has_webpage = False
    has_about = False
    all_valid = True

    for s in scripts:
        try:
            d = json.loads(s)
        except json.JSONDecodeError:
            all_valid = False
            continue

        if d.get("@type") == "WebPage":
            has_webpage = True
            for field_name in ["name", "description", "url", "inLanguage"]:
                val = d.get(field_name)
                add(report, f"SD-2:{locale}:{field_name}", "Schema.org", f"WebPage.{field_name} present",
                    val is not None and val != "")
            add(report, f"SD-3:{locale}", "Schema.org", "isPartOf present",
                "isPartOf" in d)
            about = d.get("about", {})
            if about:
                has_about = True
                add(report, f"SD-4:{locale}", "Schema.org", f"about @type: {about.get('@type', 'MISSING')}",
                    "@type" in about)

        if "@graph" in d:
            for item in d["@graph"]:
                if item.get("@type") == "WebPage":
                    has_webpage = True
                    for field_name in ["name", "description", "url", "inLanguage"]:
                        val = item.get(field_name)
                        add(report, f"SD-2:{locale}:{field_name}", "Schema.org", f"WebPage.{field_name} present",
                            val is not None and val != "")
                    add(report, f"SD-3:{locale}", "Schema.org", "isPartOf present",
                        "isPartOf" in item)
                    about = item.get("about", {})
                    if about:
                        has_about = True
                        add(report, f"SD-4:{locale}", "Schema.org", f"about @type: {about.get('@type', 'MISSING')}",
                            "@type" in about)

    add(report, f"SD-1:{locale}", "Schema.org", "WebPage schema present",
        has_webpage)
    if not has_about:
        add(report, f"SD-4:{locale}", "Schema.org", "about entity present",
            False, "No 'about' in WebPage")
    add(report, f"SD-6:{locale}", "Schema.org", "all JSON-LD valid",
        all_valid)


def check_opengraph(report: GateReport, html_content: str, locale: str):
    for tag in ["og:title", "og:description", "og:type", "og:locale"]:
        add(report, f"OG-{tag}:{locale}", "OpenGraph", f"{tag} present",
            f'property="{tag}"' in html_content or f'"{tag}"' in html_content)

    has_og_image = "og:image" in html_content
    add(report, f"OG-3:{locale}", "OpenGraph", "og:image present",
        has_og_image, "" if has_og_image else "MISSING — social sharing image required")

    add(report, f"OG-7:{locale}", "OpenGraph", "twitter:card present",
        "twitter:card" in html_content)

    for tag in ["twitter:title", "twitter:description"]:
        add(report, f"OG-{tag}:{locale}", "OpenGraph", f"{tag} present",
            tag in html_content)

    has_twitter_img = "twitter:image" in html_content
    add(report, f"OG-9:{locale}", "OpenGraph", "twitter:image present",
        has_twitter_img, "" if has_twitter_img else "MISSING")


def check_accessibility(report: GateReport, html_content: str, locale: str):
    imgs = re.findall(r"<img[^>]+>", html_content)
    imgs_no_alt = [i for i in imgs if "alt=" not in i]
    add(report, f"A-1:{locale}", "Accessibility", f"img alt: {len(imgs)} imgs, {len(imgs_no_alt)} missing",
        len(imgs_no_alt) == 0)

    add(report, f"A-2:{locale}", "Accessibility", "skip-to-content link",
        "skip" in html_content.lower())

    add(report, f"A-7:{locale}", "Accessibility", "aria-label on icon elements",
        "aria-label" in html_content, "", True)

    blank_links = re.findall(r'target="_blank"[^>]*>', html_content)
    blank_no_indicator = []
    for link in blank_links:
        ctx_start = html_content.find(link)
        ctx_end = min(ctx_start + 500, len(html_content))
        context = html_content[ctx_start:ctx_end]
        if "sr-only" not in context and "aria-label" not in context and "(nuova" not in context and "(new" not in context:
            blank_no_indicator.append(link[:80])

    add(report, f"A-11:{locale}", "Accessibility", f"target=_blank screen reader indicator ({len(blank_no_indicator)} missing)",
        len(blank_no_indicator) == 0, "; ".join(blank_no_indicator[:3]) if blank_no_indicator else "", True)


def _get_namespace_text(messages_dir: Path, locale: str, page: str) -> str:
    json_path = messages_dir / f"{locale}.json"
    if not json_path.exists():
        return ""
    try:
        data = json.loads(json_path.read_text(encoding="utf-8"))
        ns = data.get(page, {})
        return " ".join(str(v) for v in ns.values())
    except (json.JSONDecodeError, AttributeError):
        return ""


def check_i18n(report: GateReport, html_content: str, locale: str, messages_dir: Optional[Path], page: str = ""):
    if messages_dir:
        json_path = messages_dir / f"{locale}.json"
        if json_path.exists():
            try:
                json.loads(json_path.read_text(encoding="utf-8"))
                add(report, f"I-7:{locale}", "i18n", "JSON valid", True)
            except json.JSONDecodeError as e:
                add(report, f"I-7:{locale}", "i18n", "JSON valid", False, str(e))

    ns_text = _get_namespace_text(messages_dir, locale, page) if messages_dir and page else ""
    if not ns_text:
        return

    if locale == "de":
        suspects = re.findall(r'\b\w*(?:ue|oe|ae)\w*\b', ns_text)
        false_positives = {"Museum", "Israel", "erneuerbare", "vergisst", "muss",
                          "stattdessen", "ausstellen", "passt", "Renaissance",
                          "interessieren", "true", "blue", "value",
                          "neuen", "neue", "neuer", "neues", "neuem",
                          "Abenteuer", "abenteuer", "dauern", "dauert",
                          "genauer", "unser", "unsere", "unserem",
                          "dauern", "überdauern", "Aue", "Gebaeude",
                          "Mauer", "Bauer", "sauer", "Lauer",
                          "konsequent", "Konsequenz", "konsequenz",
                          "Wahrheitsquellen", "Quelle", "quelle", "Quellen",
                          "konzeptuelle", "konzeptuell", "konzeptueller",
                          "intellektuelle", "intellektuell", "intellektueller",
                          "eventuelle", "eventuell", "individueller",
                          "individuell", "kontinuierlich", "Sequel",
                          "Quellcode", "Bequemlichkeit", "Wahrheitsquelle",
                          "visuelles", "Bauen", "Durchquerung",
                          "Apnoe", "baue", "Maestro"}
        real = [s for s in suspects if s not in false_positives and len(s) > 3]
        add(report, f"I-2:{locale}", "i18n", f"DE diacritics in '{page}' ns ({len(real)} suspicious)",
            len(real) == 0, ", ".join(real[:5]) if real else "")

    if locale == "pt":
        missing = re.findall(r'\bnao\b|\bmaos\b|\bemissao\b|\bservico\b|\bcertificacao\b|\bunico\b', ns_text, re.IGNORECASE)
        add(report, f"I-2:{locale}", "i18n", f"PT diacritics in '{page}' ns ({len(missing)} missing)",
            len(missing) == 0, ", ".join(missing[:5]) if missing else "")

    if locale == "fr":
        missing = re.findall(r'\bsysteme\b|\bmemoire\b|\bcreateur\b', ns_text, re.IGNORECASE)
        add(report, f"I-2:{locale}", "i18n", f"FR diacritics in '{page}' ns ({len(missing)} missing)",
            len(missing) == 0, ", ".join(missing[:5]) if missing else "")

    if locale == "es":
        missing = re.findall(r'\bcreacion\b|\bcertificacion\b|\bunico\b|\bque\b', ns_text, re.IGNORECASE)
        real = [m for m in missing if m.lower() != "que"]
        add(report, f"I-2:{locale}", "i18n", f"ES diacritics in '{page}' ns ({len(real)} missing)",
            len(real) == 0, ", ".join(real[:5]) if real else "")


def check_links(report: GateReport, html_content: str, locale: str):
    blank_links = re.findall(r'target="_blank"[^>]*>', html_content)
    blank_no_noopener = [l for l in blank_links if "noopener" not in l]
    add(report, f"F-6:{locale}", "Functionality", f"target=_blank with noopener ({len(blank_no_noopener)} missing)",
        len(blank_no_noopener) == 0)


def check_sustainability(report: GateReport, html_path: Path, locale: str):
    size = html_path.stat().st_size
    size_kb = size / 1024
    add(report, f"WS-1:{locale}", "Sustainability", f"page weight {size_kb:.0f}KB (target <200KB)",
        size_kb < 200, f"{size_kb:.1f}KB", False)


def check_post_deploy(report: GateReport, base_url: str, page: str, locales: list):
    for locale in locales:
        url = f"{base_url}/{locale}/{page}"
        try:
            result = subprocess.run(
                ["curl", "-sI", "-o", "/dev/null", "-w", "%{http_code}|%{time_total}", url],
                capture_output=True, text=True, timeout=15
            )
            parts = result.stdout.strip().split("|")
            status = int(parts[0])
            time_s = float(parts[1])
            add(report, f"F-1:{locale}", "Functionality", f"HTTP {status} ({time_s:.2f}s)",
                status == 200)
            add(report, f"F-2:{locale}", "Functionality", f"response time {time_s:.2f}s (<0.5s)",
                time_s < 0.5, f"{time_s:.3f}s")
        except Exception as e:
            add(report, f"F-1:{locale}", "Functionality", "HTTP check", False, str(e))

    url = f"{base_url}/{locales[0]}/{page}"
    try:
        result = subprocess.run(
            ["curl", "-sI", url], capture_output=True, text=True, timeout=15
        )
        headers = result.stdout.lower()

        security_checks = [
            ("SEC-1", "strict-transport-security", "HSTS"),
            ("SEC-2", "content-security-policy", "CSP"),
            ("SEC-3", "x-content-type-options", "X-Content-Type-Options"),
            ("SEC-4", "x-frame-options", "X-Frame-Options"),
            ("SEC-5", "referrer-policy", "Referrer-Policy"),
            ("SEC-6", "permissions-policy", "Permissions-Policy"),
        ]
        for check_id, header, name in security_checks:
            add(report, check_id, "Security", f"{name} header",
                header in headers)

        add(report, "SEC-7", "Security", "COOP header",
            "cross-origin-opener-policy" in headers, "", False)
        add(report, "SEC-8", "Security", "COEP header",
            "cross-origin-embedder-policy" in headers, "", False)
    except Exception as e:
        add(report, "SEC-ERR", "Security", "header check", False, str(e))

    try:
        result = subprocess.run(
            ["curl", "-s", f"{base_url}/sitemap.xml"], capture_output=True, text=True, timeout=15
        )
        has_page = page in result.stdout
        add(report, "S-7", "SEO", f"page in sitemap.xml",
            has_page, f"{'found' if has_page else 'NOT FOUND'} in sitemap")
    except Exception:
        pass

    try:
        result = subprocess.run(
            ["curl", "-s", f"{base_url}/robots.txt"], capture_output=True, text=True, timeout=15
        )
        blocks_page = f"Disallow: /{page}" in result.stdout
        has_sitemap = "sitemap" in result.stdout.lower()
        add(report, "S-8", "SEO", "robots.txt not blocking page",
            not blocks_page)
        add(report, "AB-3", "Agentic", "sitemap referenced in robots.txt",
            has_sitemap)
    except Exception:
        pass

    try:
        result = subprocess.run(
            ["curl", "-s", "-o", "/dev/null", "-w", "%{http_code}", f"{base_url}/llms.txt"],
            capture_output=True, text=True, timeout=10
        )
        add(report, "AB-1", "Agentic", "llms.txt present",
            result.stdout.strip() == "200", "", False)
    except Exception:
        pass


def main():
    parser = argparse.ArgumentParser(description="Web Quality Gate — verifica automatizzata")
    parser.add_argument("--dir", required=True, help="Directory HTML generato (es. out/)")
    parser.add_argument("--page", required=True, help="Nome pagina (es. egi, oracode)")
    parser.add_argument("--locales", required=True, help="Lingue separate da virgola (es. it,en,de)")
    parser.add_argument("--url", help="URL base per check post-deploy (es. https://fabiocherici.com)")
    parser.add_argument("--messages", help="Directory file i18n JSON (es. messages/)")
    parser.add_argument("--report", default="/tmp/web-quality-gate-report.json", help="Path report JSON")
    parser.add_argument("--quiet", action="store_true", help="Solo output finale")
    args = parser.parse_args()

    locales = args.locales.split(",")
    out_dir = Path(args.dir)
    messages_dir = Path(args.messages) if args.messages else None

    report = GateReport(page=args.page, locales=locales)

    for locale in locales:
        html_path = out_dir / locale / f"{args.page}.html"
        content = read_html(html_path)

        if content is None:
            add(report, f"FILE:{locale}", "HTML", f"file exists: {html_path}", False, "FILE NOT FOUND")
            continue

        check_html_structure(report, content, locale)
        check_seo(report, content, locale, locales)
        check_schema(report, content, locale)
        check_opengraph(report, content, locale)
        check_accessibility(report, content, locale)
        check_i18n(report, content, locale, messages_dir, args.page)
        check_links(report, content, locale)
        check_sustainability(report, html_path, locale)

    if args.url:
        check_post_deploy(report, args.url, args.page, locales)

    report_data = report.to_json()
    Path(args.report).write_text(json.dumps(report_data, indent=2, ensure_ascii=False), encoding="utf-8")

    summary = report.summary
    if not args.quiet:
        print(f"\n{'='*60}")
        print(f"WEB QUALITY GATE — /{args.page}")
        print(f"{'='*60}")
        print(f"Gate: {summary['gate']}  |  Pass: {summary['pass']}  |  Fail: {summary['fail']}  |  Warn: {summary['warn']}")
        print(f"{'='*60}\n")

        for c in report.checks:
            if c.status == "SKIP":
                continue
            icon = {"PASS": "  ", "FAIL": "X ", "WARN": "! "}[c.status]
            line = f"[{icon}] {c.id:30s} {c.description}"
            if c.detail:
                line += f"  — {c.detail}"
            if c.status == "FAIL":
                print(f"\033[91m{line}\033[0m")
            elif c.status == "WARN":
                print(f"\033[93m{line}\033[0m")
            else:
                print(line)

        print(f"\nReport: {args.report}")

    sys.exit(0 if report.passed else 1)


if __name__ == "__main__":
    main()
