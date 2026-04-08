# Oracode

**AI governance framework for Claude Code.**

Hooks that block dangerous changes before they're written. Gates that validate against your rules before you push. A nervous system that knows when your documentation drifts from your code.

Built in production on a 500,000+ line ecosystem with 7 live products.

---

## The problem

AI coding assistants write code fast. Too fast for humans to review everything. Without mechanical enforcement, you get:

- **Secrets leaked** — the AI cats your `.env` into a prompt or commits it
- **Business values changed** — a commission rate, a threshold, a pricing constant silently modified
- **Legacy code broken** — the AI "improves" a file that works in production and shouldn't be touched
- **Documentation rot** — code changes but docs don't, and nobody notices for weeks
- **Untraceable changes** — "what changed, when, and why?" has no answer

Oracode solves all of these. Mechanically, not procedurally.

---

## How it works

```
You write code with Claude Code
        │
        ▼
┌─────────────────────────────────┐
│  PREVENTION (PreToolUse hooks)  │  Blocks dangerous actions BEFORE they happen
│  env-guard          │ secrets   │
│  immutable-guard    │ values    │
│  legacy-guard       │ files     │
│  gate               │ pre-push  │
├─────────────────────────────────┤
│  DETECTION (PostToolUse hooks)  │  Catches issues the moment code is written
│  audit-static       │ patterns  │
│  ssot-reflex        │ doc drift │
├─────────────────────────────────┤
│  TRACKING (Mission Protocol)    │  Full traceability of every change
│  mission registry   │ who/what  │
│  doc-sync tracking  │ verified? │
├─────────────────────────────────┤
│  NERVOUS SYSTEM (SSOT Living)   │  Docs that know when they're stale
│  ssot-registry      │ mapping   │
│  health-check       │ drift     │
└─────────────────────────────────┘
```

---

## Quick start

```bash
npx oracode init
```

The wizard asks what you need and generates everything:

```
? Single project or multi-project ecosystem? [single/multi]
? Secrets protection (blocks .env exposure)? [Y/n]
? Immutable values protection? [Y/n]
? Legacy file warnings? [Y/n]
? Static audit on every file write? [Y/n]
? Gate (pre-push validation)? [Y/n]
? Nervous system (doc drift detection)? [Y/n]
? Mission protocol (change tracking)? [Y/n]
```

It creates `.oracode/` in your workspace and registers hooks in Claude Code automatically:

```
.oracode/
├── config.json              ← your rules
├── hooks/
│   ├── env-guard.sh         ← blocks secret exposure
│   ├── immutable-values-guard.sh
│   ├── legacy-guard.sh
│   ├── audit-static.sh      ← audits every file write
│   ├── gate.sh              ← validates before push
│   └── ssot-reflex-guard.sh ← nervous system reflex
├── agents/
│   ├── gate.md              ← AI-powered pre-push validator
│   └── audit-specialist.md  ← deep code reviewer
├── ssot-registry.json       ← doc-to-code mapping
└── mission-registry.json    ← change tracking
```

That's it. Start using Claude Code — Oracode is watching.

---

## Features

### Secrets protection

The `env-guard` hook blocks any attempt to read, echo, or commit `.env` files:

```
ORACODE ENV-GUARD: blocked access to .env file.
Secrets must never be exposed.
```

### Immutable values

Define values that must never be changed without explicit approval:

```json
// .oracode/config.json
{
  "immutable_values": [
    { "pattern": "COMMISSION_RATE = 0.035", "description": "Business commission rate" },
    { "pattern": "MIN_SIMILARITY = 0.45", "description": "RAG similarity threshold" }
  ]
}
```

The AI tries to change one:

```
ORACODE IMMUTABLE-GUARD: this edit touches protected values:
  - Business commission rate (pattern: COMMISSION_RATE = 0.035)

These values require explicit approval before modification.
```

### Legacy file protection

Mark files that work in production and shouldn't be touched without a plan:

```json
{
  "legacy_files": [
    "services/payment_processor.py",
    "controllers/legacy_.*\\.php"
  ]
}
```

### Static audit

Every file written by AI is automatically checked for:
- Hardcoded secrets
- Debug statements left in code
- Raw SQL without parameterization
- innerHTML without sanitization
- TODO/FIXME markers

### Gate (pre-push validation)

Before `git push`, the gate checks:
- File size limits (default 500 lines)
- Uncommitted changes
- Oversized files in the diff

For AI-powered deep validation, use the `oracode-gate` agent.

### Nervous system

Map your documentation to the code it describes:

```json
// .oracode/ssot-registry.json
{
  "documents": [
    {
      "ssot_id": "api-architecture",
      "path": "docs/architecture.md",
      "title": "API Architecture",
      "watches": {
        "repos": ["."],
        "paths": ["src/routes/*.ts", "src/controllers/*.ts"]
      }
    }
  ]
}
```

When Claude modifies a watched file, the reflex fires immediately:

```
ORACODE NERVE SIGNAL: src/routes/orders.ts is watched by 1 SSOT doc:
  - [critical] API Architecture -> docs/architecture.md

Documentation may need updating before closing this task.
```

Check overall health:

```bash
npx oracode health
```

```
==================================
  Oracode Health Check
  2026-04-08 22:00:00
  Scope: all
==================================

  Documents: 12 | OK: 8 | Stale: 3 | Drift: 1
  Health Score: 66%
```

### Mission protocol

Track every significant change with full traceability:

```json
{
  "mission_id": "M-042",
  "title": "Add Stripe webhook for refunds",
  "status": "completed",
  "doc_sync_executed": true,
  "doc_verified": false,
  "files_modified": ["src/webhooks/stripe.ts", "src/services/refund.ts"]
}
```

The `doc_verified` field starts `false` — the nervous system sets it to `true` after verifying documentation alignment.

---

## Multi-project ecosystems

Oracode was built for a 7-project ecosystem. It handles multi-project workspaces natively:

```bash
npx oracode init
# > Multi-project ecosystem
# > Project directories: api, web, ai-service, docs
```

The nervous system watches files across all projects and maps them to shared documentation.

---

## What Oracode is NOT

- **Not a linter** — linters check syntax. Oracode checks *business semantics*.
- **Not a CI/CD pipeline** — Oracode works in real-time, during development, not after commit.
- **Not a replacement for code review** — it's the layer that catches what humans miss when AI writes 50 files in a session.

---

## Origin

Oracode was created by [Fabio Cherici](https://fabiocherici.com) at [FlorenceEGI](https://florenceegi.com) to govern an AI-assisted development ecosystem spanning 7 production products, 500,000+ lines of code, and 88 living documentation files.

It has been running in production since March 2026, enforcing rules across Laravel, Python/FastAPI, TypeScript/React, and Node.js codebases — processing 30+ tracked missions with zero undetected regressions.

---

## License

MIT

---

## Contributing

Oracode is in early release. If you're using Claude Code on a non-trivial project and want to try it, [open an issue](https://github.com/florenceegi/oracode/issues) — we'd love to hear what you need.
