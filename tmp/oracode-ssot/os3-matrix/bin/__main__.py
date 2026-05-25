#!/usr/bin/env python3
"""
Oracode Organ Index — Entrypoint.

Usage:
    python3 -m organ_index
    python3 -m organ_index --organ NATAN_LOC
    python3 -m organ_index --search "getCsrfToken"

@author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
@version 1.0.0 (FlorenceEGI — Oracode)
@date 2026-04-10
@purpose CLI entrypoint for the organ index generator
"""

import argparse
import json
import os
import sys

from .config import OUTPUT_JSON, OUTPUT_MD
from .scanner import build_index, search_index, write_json, write_summary_md


def print_search_results(results: list[dict]) -> None:
    """Print search results to stdout."""
    if not results:
        print("  No matches found.")
        return
    print(f"  Found {len(results)} match(es):\n")
    for r in results:
        print(f"  {r['organ']:20s} {r['type']:15s} {r['name']}")
        print(f"  {'':20s} → {r['file']}:{r['line']}")
        print()


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Oracode Organ Index — catalog all public symbols"
    )
    parser.add_argument(
        "--organ", type=str, default=None,
        help="Scan only a specific organ (e.g., NATAN_LOC)"
    )
    parser.add_argument(
        "--search", type=str, default=None,
        help="Search existing index for a symbol name"
    )
    parser.add_argument(
        "--json-out", type=str, default=OUTPUT_JSON,
        help=f"Output JSON path (default: {OUTPUT_JSON})"
    )
    parser.add_argument(
        "--md-out", type=str, default=OUTPUT_MD,
        help=f"Output Markdown path (default: {OUTPUT_MD})"
    )
    args = parser.parse_args()

    print("Oracode Organ Index v1.0.0")
    print("=" * 50)

    if args.search:
        if not os.path.exists(args.json_out):
            print(f"  Index not found at {args.json_out}")
            print("  Run without --search first to generate the index.")
            sys.exit(1)
        with open(args.json_out, "r") as f:
            index = json.load(f)
        results = search_index(args.search, index)
        print_search_results(results)
        return

    organ_count = "all" if not args.organ else args.organ
    print(f"Scanning {organ_count} organ(s)...\n")
    index = build_index(args.organ)

    print(f"\nTotal: {index['stats']['total_files']} files, "
          f"{index['stats']['total_symbols']} symbols\n")

    write_json(index, args.json_out)
    write_summary_md(index, args.md_out)
    print("\nDone.")


if __name__ == "__main__":
    main()
