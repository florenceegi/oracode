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

from .config import ORGANS, SKIP_DIRS
from .extractors import extract_php_symbols, extract_python_symbols, extract_ts_symbols


def should_skip(dirpath: str) -> bool:
    """Check if directory should be skipped."""
    parts = Path(dirpath).parts
    return any(part in SKIP_DIRS for part in parts)


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

    for organ_name, config in organs_to_scan.items():
        print(f"  Scanning {organ_name}...", end=" ", flush=True)
        files_index = scan_organ(organ_name, config)
        file_count = len(files_index)
        sym_count = sum(len(syms) for syms in files_index.values())
        print(f"{file_count} files, {sym_count} symbols")

        index["organs"][organ_name] = {
            "path": config["path"],
            "files": files_index,
            "file_count": file_count,
            "symbol_count": sym_count,
        }
        total_files += file_count
        total_symbols += sym_count

    index["stats"] = {
        "total_organs": len(organs_to_scan),
        "total_files": total_files,
        "total_symbols": total_symbols,
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
        f"**{index['stats']['total_files']}** files | "
        f"**{index['stats']['total_symbols']}** symbols",
        "",
        "---",
        "",
    ]

    for organ_name, organ_data in sorted(index["organs"].items()):
        lines.append(f"## {organ_name}")
        lines.append("")
        lines.append(
            f"**{organ_data['file_count']}** files | "
            f"**{organ_data['symbol_count']}** symbols"
        )
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
