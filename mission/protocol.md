# Oracode Mission Protocol

A structured process for tracking every significant change to your codebase.

## Why missions?

When AI writes code, changes happen fast. Without structure, you lose track of what changed, why, and whether the documentation was updated. Missions give you traceability.

## The 6 phases

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

### Phase 6 — Report (mandatory)
Update mission registry with:
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

## Registry schema

See `mission/registry-schema.json` for the full schema.
