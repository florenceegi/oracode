"""
Organ Index — Scanner and output generators.

@author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
@version 1.0.0 (FlorenceEGI — Oracode)
@date 2026-04-10
@purpose Scan organs, build index, write JSON and Markdown output
"""

import json
import os
from datetime import datetime
from pathlib import Path

from .config import ORGANS, SKIP_DIRS, FILE_TYPE_MAP, SKIP_EXTENSIONS
from .extractors import extract_php_symbols, extract_python_symbols, extract_ts_symbols
from .line_analyzer import analyze_lines


def should_skip(dirpath: str) -> bool:
    """Check if directory should be skipped."""
    parts = Path(dirpath).parts
    return any(part in SKIP_DIRS for part in parts)


def _classify_file(filename: str) -> str | None:
    """Classify a file by type. Returns None if should be skipped."""
    if any(filename.endswith(ext) for ext in SKIP_EXTENSIONS):
        return None
    # Check compound extensions first (blade.php before .php)
    for ext, ftype in sorted(FILE_TYPE_MAP.items(), key=lambda x: -len(x[0])):
        if filename.endswith(ext):
            return ftype
    return None


def count_lines_by_type(organ_path: str) -> dict:
    """Count lines per file type with code/comment/blank breakdown."""
    counts: dict[str, dict[str, int]] = {}
    if not os.path.isdir(organ_path):
        return counts

    for root, dirs, files in os.walk(organ_path):
        dirs[:] = [d for d in dirs if d not in SKIP_DIRS]
        if should_skip(root):
            continue
        for fname in files:
            ftype = _classify_file(fname)
            if ftype is None:
                continue
            fpath = os.path.join(root, fname)
            try:
                with open(fpath, "r", encoding="utf-8", errors="replace") as f:
                    content = f.read()
            except OSError:
                continue
            analysis = analyze_lines(content, ftype)
            if ftype not in counts:
                counts[ftype] = {"files": 0, "lines": 0,
                                 "code": 0, "comment": 0, "blank": 0}
            counts[ftype]["files"] += 1
            counts[ftype]["lines"] += analysis["total"]
            counts[ftype]["code"] += analysis["code"]
            counts[ftype]["comment"] += analysis["comment"]
            counts[ftype]["blank"] += analysis["blank"]

    return counts


def scan_organ(organ_name: str, config: dict) -> dict:
    """Scan a single organ and return all symbols by file."""
    organ_path = config["path"]
    if not os.path.isdir(organ_path):
        return {}

    files_index: dict[str, list[dict]] = {}

    scan_targets = [
        ("php_dirs", ".php", extract_php_symbols),
        ("py_dirs", ".py", extract_python_symbols),
        ("ts_dirs", (".ts", ".tsx"), extract_ts_symbols),
    ]

    for dir_key, extensions, extractor in scan_targets:
        for src_dir in config.get(dir_key, []):
            full_dir = os.path.join(organ_path, src_dir)
            if not os.path.isdir(full_dir):
                continue
            for root, dirs, files in os.walk(full_dir):
                dirs[:] = [d for d in dirs if d not in SKIP_DIRS]
                if should_skip(root):
                    continue
                for fname in files:
                    if isinstance(extensions, tuple):
                        if not fname.endswith(extensions):
                            continue
                    elif not fname.endswith(extensions):
                        continue
                    if fname.endswith(".d.ts"):
                        continue
                    fpath = os.path.join(root, fname)
                    rel_path = os.path.relpath(fpath, organ_path)
                    symbols = extractor(fpath)
                    if symbols:
                        files_index[rel_path] = symbols

    return files_index


def build_index(organs_filter: str | None = None) -> dict:
    """Build the complete organ index."""
    index = {
        "generated_at": datetime.now().isoformat(timespec="seconds"),
        "generator": "oracode/bin/organ_index v1.0.0",
        "organs": {},
        "stats": {},
    }

    organs_to_scan = ORGANS
    if organs_filter:
        organs_to_scan = {
            k: v for k, v in ORGANS.items()
            if k.upper() == organs_filter.upper()
        }

    total_symbols = 0
    total_files = 0
    total_lines_by_type: dict[str, dict[str, int]] = {}

    for organ_name, config in organs_to_scan.items():
        print(f"  Scanning {organ_name}...", end=" ", flush=True)
        files_index = scan_organ(organ_name, config)
        file_count = len(files_index)
        sym_count = sum(len(syms) for syms in files_index.values())

        lines_by_type = count_lines_by_type(config["path"])
        organ_total_lines = sum(v["lines"] for v in lines_by_type.values())
        organ_total_files = sum(v["files"] for v in lines_by_type.values())
        print(f"{sym_count} symbols, {organ_total_files} files, "
              f"{organ_total_lines:,} lines")

        index["organs"][organ_name] = {
            "path": config["path"],
            "files": files_index,
            "file_count": file_count,
            "symbol_count": sym_count,
            "lines_by_type": lines_by_type,
            "total_lines": organ_total_lines,
            "total_files_all": organ_total_files,
        }
        total_files += file_count
        total_symbols += sym_count

        for ftype, counts in lines_by_type.items():
            if ftype not in total_lines_by_type:
                total_lines_by_type[ftype] = {"files": 0, "lines": 0,
                                               "code": 0, "comment": 0, "blank": 0}
            for key in ("files", "lines", "code", "comment", "blank"):
                total_lines_by_type[ftype][key] += counts[key]

    grand_total_lines = sum(v["lines"] for v in total_lines_by_type.values())
    grand_total_files = sum(v["files"] for v in total_lines_by_type.values())

    index["stats"] = {
        "total_organs": len(organs_to_scan),
        "total_symbol_files": total_files,
        "total_symbols": total_symbols,
        "total_files": grand_total_files,
        "total_lines": grand_total_lines,
        "lines_by_type": total_lines_by_type,
    }

    return index


def search_index(query: str, index: dict) -> list[dict]:
    """Search the index for a symbol name (case-insensitive partial match)."""
    results = []
    q = query.lower()
    for organ_name, organ_data in index.get("organs", {}).items():
        for filepath, symbols in organ_data.get("files", {}).items():
            for sym in symbols:
                if q in sym["name"].lower():
                    results.append({
                        "organ": organ_name,
                        "file": filepath,
                        "name": sym["name"],
                        "type": sym["type"],
                        "line": sym["line"],
                    })
    return sorted(results, key=lambda r: r["name"].lower())


# ─── Output Writers ─────────────────────────────────────────────────────────

def write_json(index: dict, output_path: str) -> None:
    """Write the index as JSON."""
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(index, f, indent=2, ensure_ascii=False)
    print(f"  JSON → {output_path}")


def write_summary_md(index: dict, output_path: str) -> None:
    """Write a human-readable Markdown summary."""
    lines = [
        "---",
        "title: Organ Index — Symbol Catalog",
        "doc_type: auto-generated",
        f"generated_at: '{index['generated_at']}'",
        "rag_indexed: false",
        "---",
        "",
        "# Organ Index — FlorenceEGI Symbol Catalog",
        "",
        f"> Auto-generated on {index['generated_at']} by `organ_index.py`",
        f"> **{index['stats']['total_organs']}** organs | "
        f"**{index['stats'].get('total_files', 0):,}** files | "
        f"**{index['stats'].get('total_lines', 0):,}** lines | "
        f"**{index['stats']['total_symbols']}** symbols",
        "",
    ]

    # Global line breakdown
    global_lbt = index["stats"].get("lines_by_type", {})
    if global_lbt:
        lines.extend(_build_lines_table("Ecosystem", global_lbt))

    lines.extend(["---", ""])

    for organ_name, organ_data in sorted(index["organs"].items()):
        lines.append(f"## {organ_name}")
        lines.append("")
        total_l = organ_data.get("total_lines", 0)
        total_f = organ_data.get("total_files_all", 0)
        lines.append(
            f"**{total_f:,}** files | "
            f"**{total_l:,}** lines | "
            f"**{organ_data['symbol_count']}** symbols"
        )

        organ_lbt = organ_data.get("lines_by_type", {})
        if organ_lbt:
            lines.extend(_build_lines_table(organ_name, organ_lbt))
        lines.append("")

        type_groups: dict[str, list[tuple[str, str, int]]] = {}
        for filepath, symbols in sorted(organ_data["files"].items()):
            for sym in symbols:
                stype = sym["type"]
                if stype not in type_groups:
                    type_groups[stype] = []
                type_groups[stype].append((sym["name"], filepath, sym["line"]))

        type_order = ["class", "interface", "trait", "enum", "type",
                      "function", "async_function", "public_method"]
        for stype in type_order:
            if stype not in type_groups:
                continue
            items = sorted(type_groups[stype], key=lambda x: x[0].lower())
            label = stype.replace("_", " ").title() + "s"
            lines.append(f"### {label} ({len(items)})")
            lines.append("")
            lines.append("| Name | File | Line |")
            lines.append("|------|------|------|")
            for name, fpath, line in items:
                lines.append(f"| `{name}` | `{fpath}` | {line} |")
            lines.append("")

        lines.append("---")
        lines.append("")

    lines.extend(_build_duplicates_section(index))

    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with open(output_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))
    print(f"  Markdown → {output_path}")


def _build_lines_table(label: str, lines_by_type: dict) -> list[str]:
    """Build a markdown table of lines per file type with code/comment/blank."""
    rows = ["", "#### Lines by type", "",
            "| Type | Files | Code | Comment | Blank | Total | % |",
            "|------|------:|-----:|--------:|------:|------:|--:|"]
    total_lines = sum(v["lines"] for v in lines_by_type.values())
    total_code = sum(v.get("code", 0) for v in lines_by_type.values())
    total_comment = sum(v.get("comment", 0) for v in lines_by_type.values())
    total_blank = sum(v.get("blank", 0) for v in lines_by_type.values())
    for ftype, counts in sorted(lines_by_type.items(),
                                 key=lambda x: -x[1]["lines"]):
        pct = (counts["lines"] / total_lines * 100) if total_lines else 0
        rows.append(
            f"| {ftype} | {counts['files']:,} | {counts.get('code', 0):,} "
            f"| {counts.get('comment', 0):,} | {counts.get('blank', 0):,} "
            f"| {counts['lines']:,} | {pct:.1f}% |"
        )
    rows.append(
        f"| **Total** | | **{total_code:,}** | **{total_comment:,}** "
        f"| **{total_blank:,}** | **{total_lines:,}** | |"
    )
    rows.append("")
    return rows


def _build_duplicates_section(index: dict) -> list[str]:
    """Build the potential duplicates section."""
    lines = [
        "## Potential Duplicates",
        "",
        "Symbols with the same name in multiple organs (candidates for consolidation):",
        "",
    ]

    name_locations: dict[str, list[str]] = {}
    structural_types = {"class", "interface", "trait", "enum",
                        "function", "async_function"}
    for organ_name, organ_data in index["organs"].items():
        for filepath, symbols in organ_data["files"].items():
            for sym in symbols:
                if sym["type"] in structural_types:
                    key = sym["name"]
                    if key not in name_locations:
                        name_locations[key] = []
                    loc = f"{organ_name}:{filepath}"
                    if loc not in name_locations[key]:
                        name_locations[key].append(loc)

    duplicates = {k: v for k, v in name_locations.items() if len(v) > 1}

    if duplicates:
        lines.append("| Symbol | Locations |")
        lines.append("|--------|-----------|")
        for name, locs in sorted(duplicates.items()):
            loc_str = ", ".join(f"`{l}`" for l in locs)
            lines.append(f"| `{name}` | {loc_str} |")
    else:
        lines.append("*No duplicates found.*")

    lines.extend(["", "---", "",
                   "*Auto-generated by `oracode/bin/organ_index` — do not edit manually*"])
    return lines
