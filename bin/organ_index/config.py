"""
Organ Index — Configuration: organ paths, output paths, skip rules.

@author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
@version 1.0.0 (FlorenceEGI — Oracode)
@date 2026-04-10
@purpose Centralized configuration for organ scanning
"""

from typing import Any

ORGANS: dict[str, dict[str, Any]] = {
    "EGI": {
        "path": "/home/fabio/EGI",
        "php_dirs": ["app"],
        "ts_dirs": ["resources/js", "resources/ts", "resources/react"],
        "py_dirs": [],
    },
    "EGI-HUB": {
        "path": "/home/fabio/EGI-HUB",
        "php_dirs": ["backend/app", "src"],
        "ts_dirs": ["frontend/src"],
        "py_dirs": [],
    },
    "NATAN_LOC": {
        "path": "/home/fabio/NATAN_LOC",
        "php_dirs": ["laravel_backend/app"],
        "ts_dirs": ["laravel_backend/resources/js"],
        "py_dirs": ["python_ai_service/app"],
    },
    "EGI-Credential": {
        "path": "/home/fabio/EGI-Credential",
        "php_dirs": ["backend/app"],
        "ts_dirs": ["frontend/src", "vc-engine/src"],
        "py_dirs": [],
    },
    "EGI-SIGILLO": {
        "path": "/home/fabio/EGI-SIGILLO",
        "php_dirs": [],
        "ts_dirs": ["src"],
        "py_dirs": [],
    },
    "EGI-HUB-HOME-REACT": {
        "path": "/home/fabio/EGI-HUB-HOME-REACT",
        "php_dirs": [],
        "ts_dirs": ["src"],
        "py_dirs": [],
    },
    "EGI-INFO": {
        "path": "/home/fabio/EGI-INFO",
        "php_dirs": [],
        "ts_dirs": ["src"],
        "py_dirs": [],
    },
    "EGI-STAT": {
        "path": "/home/fabio/EGI-STAT",
        "php_dirs": [],
        "ts_dirs": ["frontend/src"],
        "py_dirs": ["backend"],
    },
    "YURI-BIAGINI": {
        "path": "/home/fabio/YURI-BIAGINI",
        "php_dirs": [],
        "ts_dirs": ["app", "components", "lib"],
        "py_dirs": [],
    },
}

OUTPUT_JSON = "/home/fabio/EGI-DOC/docs/ecosistema/ORGAN_INDEX.json"
OUTPUT_MD = "/home/fabio/EGI-DOC/docs/ecosistema/ORGAN_INDEX_SUMMARY.md"

SKIP_DIRS = {
    "node_modules", "vendor", ".git", "__pycache__", ".venv", "venv",
    "dist", "build", "storage", "cache", ".next", "coverage",
    "bootstrap", "public", ".history", ".idea", ".vscode",
}

# File type classification for line counting
FILE_TYPE_MAP = {
    ".blade.php": "blade",
    ".php": "php",
    ".py": "python",
    ".ts": "typescript",
    ".tsx": "tsx",
    ".js": "javascript",
    ".jsx": "jsx",
    ".css": "css",
    ".scss": "scss",
    ".json": "json",
    ".yaml": "yaml",
    ".yml": "yaml",
    ".md": "markdown",
    ".html": "html",
    ".sql": "sql",
    ".sh": "shell",
    ".env": "env",
}

# Extensions to skip entirely for line counting
SKIP_EXTENSIONS = {
    ".lock", ".map", ".min.js", ".min.css", ".ico", ".png",
    ".jpg", ".jpeg", ".gif", ".svg", ".woff", ".woff2", ".ttf",
    ".eot", ".pdf", ".zip", ".tar", ".gz", ".log",
}
