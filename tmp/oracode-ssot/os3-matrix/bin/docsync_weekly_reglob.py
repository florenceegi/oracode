#!/usr/bin/env python3
"""
DOC-SYNC v2.1.0 — Weekly Re-Glob Safety Net

Runs weekly via cron (Sunday 03:00 default). Re-expands every watch pattern
against the live filesystem, detects:
  - patterns that became broken since last run
  - new uncovered files appeared in repos
  - drift_score above configured alert threshold
  - SSOTs whose coverage dropped

Outputs:
  - /home/fabio/.local/state/docsync_coverage_history.jsonl  (append-only log)
  - /home/fabio/.local/state/docsync_alerts.log               (rotating alert file)

NOTE: this is the "safety net secondary" allowed by Anti-pattern 4 of the
DOC-SYNC v2 spec. It does NOT trigger actions. It only emits alerts that
the operator (or another mission) consumes.

@version 2.1.0 (FlorenceEGI — ecosistema)
@date 2026-05-12
@author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
"""
from __future__ import annotations

import json
import os
import subprocess
import sys
from datetime import datetime
from pathlib import Path

STATE_DIR = Path("/home/fabio/.local/state")
HISTORY = STATE_DIR / "docsync_coverage_history.jsonl"
ALERTS = STATE_DIR / "docsync_alerts.log"
COVERAGE_BIN = "/home/fabio/oracode/bin/rag_natan_coverage.py"
REG_PATH = "/home/fabio/EGI-DOC/docs/lso/SSOT_REGISTRY.json"
CFG_PATH = "/home/fabio/EGI-DOC/docs/lso/COVERAGE_CONFIG.json"


def run_coverage() -> dict:
    out = subprocess.run(
        [sys.executable, COVERAGE_BIN, "--json"],
        capture_output=True, text=True, timeout=300,
    )
    return json.loads(out.stdout)


def load_config() -> dict:
    if os.path.exists(CFG_PATH):
        with open(CFG_PATH) as f:
            return json.load(f)
    return {}


def load_last_snapshot() -> dict | None:
    if not HISTORY.exists():
        return None
    last = None
    with open(HISTORY) as f:
        for line in f:
            line = line.strip()
            if line:
                last = json.loads(line)
    return last


def compute_drift_alerts(cfg: dict) -> list[str]:
    """Read SSOT registry and emit alert per SSOT with drift > threshold."""
    if not os.path.exists(REG_PATH):
        return []
    with open(REG_PATH) as f:
        reg = json.load(f)
    thr = cfg.get("drift_alert_threshold", 0.5)
    alerts: list[str] = []
    for entry in reg["documents"]:
        ds = entry.get("last_drift_score")
        if ds is None:
            continue
        if ds > thr:
            alerts.append(
                f"DRIFT_HIGH  {entry.get('organ','?'):20s}  "
                f"{entry['ssot_id']:35s}  drift={ds:.3f} > thr={thr}"
            )
    return alerts


def diff_snapshot(prev: dict, curr: dict) -> list[str]:
    """Identify coverage regressions or new broken patterns."""
    alerts: list[str] = []
    if not prev:
        return alerts
    prev_cov = {c["repo"]: c["pct"] for c in prev.get("coverage", []) if c.get("pct") is not None}
    curr_cov = {c["repo"]: c["pct"] for c in curr.get("coverage", []) if c.get("pct") is not None}
    for repo, now in curr_cov.items():
        before = prev_cov.get(repo)
        if before is None:
            continue
        delta = now - before
        if delta < -5.0:
            alerts.append(
                f"COVERAGE_DROP  {repo:24s}  {before:.2f}% → {now:.2f}%  "
                f"(Δ {delta:+.2f}pp)"
            )
    prev_broken = prev.get("broken_patterns_count", 0)
    curr_broken = curr.get("broken_patterns_count", 0)
    if curr_broken > prev_broken + 5:
        alerts.append(
            f"BROKEN_RISE  broken patterns {prev_broken} → {curr_broken}  "
            f"(+{curr_broken - prev_broken})"
        )
    prev_dead = set(prev.get("dead_ssots", []))
    curr_dead = set(curr.get("dead_ssots", []))
    new_dead = curr_dead - prev_dead
    for sid in sorted(new_dead):
        alerts.append(f"NEW_DEAD_SSOT  {sid}  (was alive previous run)")
    return alerts


def write_alert(msg: str) -> None:
    STATE_DIR.mkdir(parents=True, exist_ok=True)
    with open(ALERTS, "a") as f:
        f.write(f"[{datetime.utcnow().isoformat(timespec='seconds')}] {msg}\n")


def main() -> int:
    STATE_DIR.mkdir(parents=True, exist_ok=True)
    cfg = load_config()
    prev = load_last_snapshot()
    curr = run_coverage()
    curr["_timestamp"] = datetime.utcnow().isoformat(timespec="seconds")
    curr["_source"] = "docsync_weekly_reglob"

    alerts: list[str] = []
    alerts.extend(compute_drift_alerts(cfg))
    alerts.extend(diff_snapshot(prev or {}, curr))

    thresholds = cfg.get("thresholds", {"_default": 50.0})
    default = thresholds.get("_default", 50.0)
    for c in curr.get("coverage", []):
        if c.get("status") != "OK":
            continue
        thr = thresholds.get(c["repo"], default)
        if c["pct"] < thr:
            alerts.append(
                f"COVERAGE_LOW  {c['repo']:24s}  {c['pct']:.2f}% < thr {thr:.1f}%"
            )

    with open(HISTORY, "a") as f:
        f.write(json.dumps(curr, ensure_ascii=False) + "\n")

    for a in alerts:
        write_alert(a)

    print(f"[docsync_weekly_reglob] alerts emitted: {len(alerts)}")
    for a in alerts:
        print(f"  {a}")
    return 0 if not alerts else 2


if __name__ == "__main__":
    sys.exit(main())
