#!/usr/bin/env python3
"""
Mission Retrospective — Bootstrap auto-migliorante per Mission Protocol v2.0.0
Confronta moduli pre-allocati (MISSION_BOOTSTRAP_INDEX) con moduli usati (MISSION_READ_LOG)
e genera proposte di update nel BOOTSTRAP_DRIFT_LOG.

Invocazione: python3 mission_retrospective.py [--mission M-NNN]
Sede: /home/fabio/oracode/bin/
@author Padmin D. Curtis for Fabio Cherici
@purpose Retrospective empirico FASE 6 — confronto caricato vs usato
"""

import json
import argparse
import sys
from datetime import datetime, timezone
from pathlib import Path

EGI_DOC = Path("/home/fabio/EGI-DOC")
REGISTRY_PATH = EGI_DOC / "docs/missions/MISSION_REGISTRY.json"
BOOTSTRAP_INDEX_PATH = EGI_DOC / "docs/missions/MISSION_BOOTSTRAP_INDEX.json"
READ_LOG_PATH = EGI_DOC / "audit/MISSION_READ_LOG.jsonl"
DRIFT_LOG_PATH = EGI_DOC / "docs/missions/BOOTSTRAP_DRIFT_LOG.md"

SSOT_CANDIDATE_PATTERNS = [
    "docs/",
    "CLAUDE.md",
    "CLAUDE_ECOSYSTEM_CORE.md",
]

ALWAYS_LOADED_LABEL = "(excluded — always_loaded baseline)"


def load_json(path: Path) -> dict:
    with open(path) as f:
        return json.load(f)


def find_current_mission(registry: dict, force_id: str | None) -> dict | None:
    if force_id:
        for m in registry.get("missions", []):
            if m["mission_id"] == force_id:
                return m
        print(f"ERROR: {force_id} not found in registry", file=sys.stderr)
        return None

    candidates = [
        m for m in registry.get("missions", [])
        if m.get("stato") in ("planning", "in_progress")
    ]
    if not candidates:
        print("No mission in planning/in_progress state", file=sys.stderr)
        return None

    candidates.sort(key=lambda x: x.get("data_apertura", ""), reverse=True)
    return candidates[0]


def get_expected_modules(bootstrap: dict, tipo: str, organi: list[str]) -> set[str]:
    expected = set()

    type_modules = bootstrap.get("by_mission_type", {}).get(tipo, [])
    expected.update(type_modules)

    for organo in organi:
        organ_modules = bootstrap.get("by_organ", {}).get(organo, [])
        expected.update(organ_modules)

    return expected


def get_actual_modules(mission_id: str) -> set[str]:
    actual = set()
    if not READ_LOG_PATH.exists():
        return actual

    with open(READ_LOG_PATH) as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                entry = json.loads(line)
            except json.JSONDecodeError:
                continue

            if entry.get("mission") != mission_id:
                continue

            action = entry.get("action", "")
            if "read" not in action:
                continue

            if entry.get("tool") in ("Read", "Edit"):
                path = entry.get("path", "")
                if path:
                    actual.add(normalize_path(path))
            elif entry.get("tool") == "Bash":
                paths = entry.get("paths") or []
                for p in paths:
                    actual.add(normalize_path(p))

    return actual


def normalize_path(path: str) -> str:
    path = path.removeprefix("/home/fabio/")
    path = path.removeprefix("EGI-DOC/")
    path = path.rstrip("/")
    return path


def is_ssot_candidate(path: str) -> bool:
    return any(pattern in path for pattern in SSOT_CANDIDATE_PATTERNS)


def calc_severity(loaded_unused: set, used_unloaded: set) -> str:
    total = len(loaded_unused) + len(used_unloaded)
    bidirectional = bool(loaded_unused) and bool(used_unloaded)

    if total >= 5 or bidirectional:
        return "major"
    elif total >= 2:
        return "moderate"
    else:
        return "minor"


def generate_drift_entry(
    mission: dict,
    loaded_unused: set,
    used_unloaded: set,
    severity: str,
    always_loaded_count: int,
) -> str:
    mid = mission["mission_id"]
    date = datetime.now(timezone.utc).strftime("%Y-%m-%d")
    tipo = mission.get("tipo_missione", "unknown")
    organi = ", ".join(mission.get("organi_coinvolti", []))

    lines = [
        f"### {mid} — {date} — {tipo} / {organi}",
        "",
        f"**Severity**: {severity} | **Stato**: pending",
        f"**always_loaded esclusi**: {always_loaded_count} file",
        "",
    ]

    lines.append("**loaded_unused** (pre-allocati mai consultati):")
    if loaded_unused:
        for p in sorted(loaded_unused):
            lines.append(f"- `{p}`")
    else:
        lines.append("- (nessuno)")
    lines.append("")

    lines.append("**used_unloaded** (consultati ma non pre-allocati):")
    if used_unloaded:
        for p in sorted(used_unloaded):
            lines.append(f"- `{p}`")
    else:
        lines.append("- (nessuno)")
    lines.append("")

    if loaded_unused or used_unloaded:
        lines.append("**Proposta**:")
        if loaded_unused:
            lines.append(f"- `by_mission_type.{tipo}`: consider removing {len(loaded_unused)} file")
        if used_unloaded:
            lines.append(f"- `by_mission_type.{tipo}` o `by_organ`: consider adding {len(used_unloaded)} file")
        lines.append("")

    lines.append(f"**Reasoning**: drift empirico rilevato su {mid} ({tipo}/{organi}). "
                 "Singola osservazione — CEO valuta se pattern ricorrente o specifico di questa mission.")
    lines.append("")

    return "\n".join(lines)


def append_to_drift_log(entry_text: str) -> None:
    content = DRIFT_LOG_PATH.read_text()
    marker = "## Proposte"
    placeholder = "*(nessuna proposta ancora registrata"

    if placeholder in content:
        content = content.replace(
            f"{placeholder} — il log si popola alla chiusura delle prossime mission)*",
            entry_text,
        )
    else:
        content = content.rstrip() + "\n\n" + entry_text + "\n"

    DRIFT_LOG_PATH.write_text(content)


def update_registry(registry: dict, mission_id: str) -> None:
    for m in registry.get("missions", []):
        if m["mission_id"] == mission_id:
            m["retrospective_executed"] = True
            break

    with open(REGISTRY_PATH, "w") as f:
        json.dump(registry, f, indent=2, ensure_ascii=False)


def main():
    parser = argparse.ArgumentParser(description="Mission Bootstrap Retrospective")
    parser.add_argument("--mission", help="Force specific mission ID (default: auto-detect)")
    args = parser.parse_args()

    registry = load_json(REGISTRY_PATH)
    mission = find_current_mission(registry, args.mission)
    if not mission:
        sys.exit(1)

    mid = mission["mission_id"]
    tipo = mission.get("tipo_missione", "")
    organi = mission.get("organi_coinvolti", [])

    print(f"Retrospective for {mid} (tipo={tipo}, organi={organi})")

    bootstrap = load_json(BOOTSTRAP_INDEX_PATH)
    always_loaded = set(bootstrap.get("always_loaded", []))

    expected = get_expected_modules(bootstrap, tipo, organi)
    expected -= always_loaded

    actual_raw = get_actual_modules(mid)
    actual = {p for p in actual_raw if is_ssot_candidate(p)}
    actual -= {normalize_path(p) for p in always_loaded}

    loaded_unused = expected - actual
    used_unloaded = actual - expected

    print(f"  always_loaded excluded: {len(always_loaded)} files")
    print(f"  expected (by_type + by_organ): {len(expected)} files")
    print(f"  actual (read_log, SSOT only): {len(actual)} files")
    print(f"  loaded_unused: {len(loaded_unused)}")
    print(f"  used_unloaded: {len(used_unloaded)}")

    if loaded_unused or used_unloaded:
        severity = calc_severity(loaded_unused, used_unloaded)
        entry = generate_drift_entry(mission, loaded_unused, used_unloaded, severity, len(always_loaded))
        append_to_drift_log(entry)
        print(f"  → Drift detected (severity={severity}). Entry appended to BOOTSTRAP_DRIFT_LOG.md")
    else:
        print("  → no_changes. No entry in DRIFT_LOG.")

    update_registry(registry, mid)
    print(f"  → retrospective_executed=true set in MISSION_REGISTRY for {mid}")


if __name__ == "__main__":
    main()
