"""
Organ Index — Line analyzer: classifies lines as code, comment, or blank.

Supports PHP, Python, TypeScript/JavaScript, Blade, CSS/SCSS, HTML,
Shell, YAML, SQL, Markdown.

@author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
@version 1.0.0 (FlorenceEGI — Oracode)
@date 2026-04-10
@purpose Classify source lines into code, comments, and blanks
"""

import re

# Multiline comment state patterns
RE_C_BLOCK_OPEN = re.compile(r'/\*')
RE_C_BLOCK_CLOSE = re.compile(r'\*/')
RE_PY_TRIPLE_DQ = re.compile(r'"""')
RE_PY_TRIPLE_SQ = re.compile(r"'''")
RE_HTML_COMMENT_OPEN = re.compile(r'<!--')
RE_HTML_COMMENT_CLOSE = re.compile(r'-->')

# Single-line comment patterns by file type group
SINGLE_LINE_COMMENTS = {
    "c_style": re.compile(r'^\s*//'),       # PHP, TS, JS, TSX, JSX, CSS
    "hash": re.compile(r'^\s*#'),            # Python, Shell, YAML
    "html": re.compile(r'^\s*<!--.*-->'),    # HTML single-line
    "blade": re.compile(r'^\s*\{\{--.*--\}\}'),  # Blade single-line
    "sql": re.compile(r'^\s*--'),            # SQL
}

# Which file types use which comment styles
FILE_TYPE_STYLES: dict[str, dict] = {
    "php":        {"single": ["c_style", "hash"], "block": "c_style"},
    "blade":      {"single": ["blade", "html"], "block": "html"},
    "python":     {"single": ["hash"], "block": "python"},
    "typescript": {"single": ["c_style"], "block": "c_style"},
    "tsx":        {"single": ["c_style"], "block": "c_style"},
    "javascript": {"single": ["c_style"], "block": "c_style"},
    "jsx":        {"single": ["c_style"], "block": "c_style"},
    "css":        {"single": ["c_style"], "block": "c_style"},
    "scss":       {"single": ["c_style"], "block": "c_style"},
    "html":       {"single": ["html"], "block": "html"},
    "shell":      {"single": ["hash"], "block": None},
    "yaml":       {"single": ["hash"], "block": None},
    "sql":        {"single": ["sql"], "block": "c_style"},
    "markdown":   {"single": [], "block": None},
    "json":       {"single": [], "block": None},
    "env":        {"single": ["hash"], "block": None},
}


def analyze_lines(content: str, file_type: str) -> dict[str, int]:
    """Classify each line of content into code, comment, or blank.

    Returns {"code": N, "comment": N, "blank": N, "total": N}
    """
    lines = content.split("\n")
    # Trailing empty string from final newline
    if lines and lines[-1] == "":
        lines = lines[:-1]

    total = len(lines)
    if total == 0:
        return {"code": 0, "comment": 0, "blank": 0, "total": 0}

    style = FILE_TYPE_STYLES.get(file_type)
    if style is None:
        # Unknown type — count all non-blank as code
        blank = sum(1 for line in lines if line.strip() == "")
        return {"code": total - blank, "comment": 0, "blank": blank, "total": total}

    code = 0
    comment = 0
    blank = 0
    in_block = False
    block_type = style.get("block")

    for line in lines:
        stripped = line.strip()

        # Blank line
        if stripped == "":
            blank += 1
            continue

        # Inside a multiline comment block
        if in_block:
            comment += 1
            if _block_closes(stripped, block_type):
                in_block = False
            continue

        # Check for block comment opening
        if block_type and _block_opens(stripped, block_type):
            comment += 1
            # Check if it also closes on same line
            if not _block_closes_after_open(stripped, block_type):
                in_block = True
            continue

        # Check single-line comment patterns
        single_styles = style.get("single", [])
        is_comment = False
        for sname in single_styles:
            pattern = SINGLE_LINE_COMMENTS.get(sname)
            if pattern and pattern.match(stripped):
                is_comment = True
                break

        if is_comment:
            comment += 1
        else:
            code += 1

    return {"code": code, "comment": comment, "blank": blank, "total": total}


def _block_opens(line: str, block_type: str) -> bool:
    """Check if a line opens a multiline comment block."""
    if block_type == "c_style":
        return bool(RE_C_BLOCK_OPEN.search(line))
    if block_type == "python":
        return bool(RE_PY_TRIPLE_DQ.search(line) or RE_PY_TRIPLE_SQ.search(line))
    if block_type == "html":
        return bool(RE_HTML_COMMENT_OPEN.search(line))
    return False


def _block_closes(line: str, block_type: str) -> bool:
    """Check if a line closes a multiline comment block."""
    if block_type == "c_style":
        return bool(RE_C_BLOCK_CLOSE.search(line))
    if block_type == "python":
        return bool(RE_PY_TRIPLE_DQ.search(line) or RE_PY_TRIPLE_SQ.search(line))
    if block_type == "html":
        return bool(RE_HTML_COMMENT_CLOSE.search(line))
    return False


def _block_closes_after_open(line: str, block_type: str) -> bool:
    """Check if block opens AND closes on the same line (e.g., /* ... */)."""
    if block_type == "c_style":
        # Find first /*, then check for */ after it
        m = RE_C_BLOCK_OPEN.search(line)
        if m:
            return bool(RE_C_BLOCK_CLOSE.search(line, m.end()))
        return False
    if block_type == "python":
        # Count triple quotes — if even count, opens and closes on same line
        dq_count = len(RE_PY_TRIPLE_DQ.findall(line))
        sq_count = len(RE_PY_TRIPLE_SQ.findall(line))
        return (dq_count >= 2) or (sq_count >= 2)
    if block_type == "html":
        m = RE_HTML_COMMENT_OPEN.search(line)
        if m:
            return bool(RE_HTML_COMMENT_CLOSE.search(line, m.end()))
        return False
    return False
