# Oracode Mission Protocol

A structured process for tracking every significant change to your codebase.

## Why missions?

When AI writes code, changes happen fast. Without structure, you lose track of what changed, why, and whether the documentation was updated. Missions give you traceability — and real production metrics.

## The 7 phases

### Phase 0 — Assignment
Assign a mission ID from the registry. Communicate: "Mission M-XXX opened."

### Phase 1 — Requirements
Gather: what, which layer, reference file, branch, constraints.

### Phase 2 — Analysis
Read relevant files. Grep for existing patterns. Map the complete flow. Identify risks.

### Phase 3 — Plan
Present the plan before writing any code. List files, sequence, risks. Get approval.

### Phase 4 — Execution
One file at a time. Verify file size limits. Build if frontend.

### Phase 5 — Closure
List files created/modified. Document next steps.

### Phase 6 — Report and Stats (mandatory)

#### 6a. Update mission registry
```json
{
  "mission_id": "M-XXX",
  "title": "...",
  "date_opened": "YYYY-MM-DD",
  "date_closed": "YYYY-MM-DD",
  "status": "completed | suspended | blocked",
  "type": "feature | bugfix | refactor | docsync | audit",
  "projects_involved": ["..."],
  "doc_sync_executed": true,
  "doc_verified": false,
  "files_modified": ["path/to/file1", "path/to/file2"]
}
```

#### 6b. Calculate and write stats

```bash
node mission/stats-calculator.js .oracode/mission-registry.json .oracode/config.json
```

This calculates from git log: commits, lines +/-, net, files, weighted commits, cognitive load, productivity index, commit hashes. Writes everything into the `stats` field of the mission in the registry JSON.

**MANDATORY** — a mission without stats is incomplete.

The stats field looks like:
```json
{
  "stats": {
    "total_commits": 12,
    "lines_added": 845,
    "lines_deleted": 120,
    "lines_net": 725,
    "lines_touched": 965,
    "files_touched": 8,
    "weighted_commits": 14.5,
    "cognitive_load": 2.85,
    "productivity_index": 127.43,
    "tags_breakdown": { "FEAT": 8, "FIX": 3, "DOC": 1 },
    "commit_hashes": ["abc123...", "def456..."],
    "calculated_at": "2026-04-09"
  }
}
```

#### 6c. Commit and push

```bash
git add .oracode/mission-registry.json
git commit -m "[DOC] Mission report M-XXX — title"
git push
```

## Guard hook

The `mission-stats-guard` hook runs on every `git push` and warns if any completed mission is missing stats. This is the safety net — Phase 6b is the first line of defense.

## Registry schema

See `mission/registry-schema.json` for the full schema.
