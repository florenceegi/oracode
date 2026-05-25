"""
Organ Index — Symbol extractors for PHP, Python, and TypeScript.

@author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
@version 1.0.0 (FlorenceEGI — Oracode)
@date 2026-04-10
@purpose Extract public symbols (classes, methods, functions) from source files
"""

import ast
import re

# ─── PHP Patterns ───────────────────────────────────────────────────────────

RE_PHP_NAMESPACE = re.compile(r'^\s*namespace\s+([\w\\]+)\s*;', re.MULTILINE)
RE_PHP_CLASS = re.compile(
    r'^\s*(?:abstract\s+|final\s+)?class\s+(\w+)', re.MULTILINE
)
RE_PHP_INTERFACE = re.compile(r'^\s*interface\s+(\w+)', re.MULTILINE)
RE_PHP_TRAIT = re.compile(r'^\s*trait\s+(\w+)', re.MULTILINE)
RE_PHP_ENUM = re.compile(r'^\s*enum\s+(\w+)', re.MULTILINE)
RE_PHP_PUBLIC_METHOD = re.compile(
    r'^\s*public\s+(?:static\s+)?function\s+(\w+)\s*\(', re.MULTILINE
)

# ─── TypeScript Patterns ────────────────────────────────────────────────────

RE_TS_EXPORT_CLASS = re.compile(
    r'^\s*export\s+(?:default\s+)?(?:abstract\s+)?class\s+(\w+)', re.MULTILINE
)
RE_TS_EXPORT_FUNCTION = re.compile(
    r'^\s*export\s+(?:default\s+)?(?:async\s+)?function\s+(\w+)', re.MULTILINE
)
RE_TS_EXPORT_CONST_FN = re.compile(
    r'^\s*export\s+const\s+(\w+)\s*=\s*(?:async\s*)?\(', re.MULTILINE
)
RE_TS_EXPORT_INTERFACE = re.compile(
    r'^\s*export\s+(?:default\s+)?interface\s+(\w+)', re.MULTILINE
)
RE_TS_EXPORT_TYPE = re.compile(
    r'^\s*export\s+(?:default\s+)?type\s+(\w+)\s*=', re.MULTILINE
)
RE_TS_EXPORT_ENUM = re.compile(
    r'^\s*export\s+(?:const\s+)?enum\s+(\w+)', re.MULTILINE
)


# ─── PHP Extractor ──────────────────────────────────────────────────────────

def extract_php_symbols(filepath: str) -> list[dict]:
    """Extract classes, interfaces, traits, enums, and public methods."""
    symbols: list[dict] = []
    try:
        with open(filepath, "r", encoding="utf-8", errors="replace") as f:
            content = f.read()
    except (OSError, UnicodeDecodeError):
        return symbols

    ns_match = RE_PHP_NAMESPACE.search(content)
    namespace = ns_match.group(1) if ns_match else ""

    type_patterns = [
        (RE_PHP_CLASS, "class"),
        (RE_PHP_INTERFACE, "interface"),
        (RE_PHP_TRAIT, "trait"),
        (RE_PHP_ENUM, "enum"),
    ]

    for regex, sym_type in type_patterns:
        for m in regex.finditer(content):
            line_no = content[:m.start()].count("\n") + 1
            symbols.append({
                "name": m.group(1),
                "type": sym_type,
                "namespace": namespace,
                "line": line_no,
            })

    for m in RE_PHP_PUBLIC_METHOD.finditer(content):
        name = m.group(1)
        if name.startswith("__"):
            continue
        line_no = content[:m.start()].count("\n") + 1
        symbols.append({
            "name": name,
            "type": "public_method",
            "namespace": namespace,
            "line": line_no,
        })

    return symbols


# ─── Python Extractor ───────────────────────────────────────────────────────

def extract_python_symbols(filepath: str) -> list[dict]:
    """Extract classes, functions, and public methods using AST."""
    symbols: list[dict] = []
    try:
        with open(filepath, "r", encoding="utf-8", errors="replace") as f:
            source = f.read()
        tree = ast.parse(source, filename=filepath)
    except (SyntaxError, OSError, UnicodeDecodeError):
        return symbols

    for node in ast.iter_child_nodes(tree):
        if isinstance(node, ast.ClassDef):
            symbols.append({
                "name": node.name,
                "type": "class",
                "namespace": "",
                "line": node.lineno,
            })
            for item in node.body:
                if isinstance(item, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    if not item.name.startswith("_"):
                        symbols.append({
                            "name": f"{node.name}.{item.name}",
                            "type": "public_method",
                            "namespace": "",
                            "line": item.lineno,
                        })

        elif isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            if not node.name.startswith("_"):
                kind = ("async_function" if isinstance(node, ast.AsyncFunctionDef)
                        else "function")
                symbols.append({
                    "name": node.name,
                    "type": kind,
                    "namespace": "",
                    "line": node.lineno,
                })

    return symbols


# ─── TypeScript Extractor ───────────────────────────────────────────────────

def extract_ts_symbols(filepath: str) -> list[dict]:
    """Extract exported classes, functions, interfaces, types from TS/TSX."""
    symbols: list[dict] = []
    try:
        with open(filepath, "r", encoding="utf-8", errors="replace") as f:
            content = f.read()
    except (OSError, UnicodeDecodeError):
        return symbols

    extractors = [
        (RE_TS_EXPORT_CLASS, "class"),
        (RE_TS_EXPORT_FUNCTION, "function"),
        (RE_TS_EXPORT_CONST_FN, "function"),
        (RE_TS_EXPORT_INTERFACE, "interface"),
        (RE_TS_EXPORT_TYPE, "type"),
        (RE_TS_EXPORT_ENUM, "enum"),
    ]

    for regex, sym_type in extractors:
        for m in regex.finditer(content):
            line_no = content[:m.start()].count("\n") + 1
            symbols.append({
                "name": m.group(1),
                "type": sym_type,
                "namespace": "",
                "line": line_no,
            })

    return symbols
