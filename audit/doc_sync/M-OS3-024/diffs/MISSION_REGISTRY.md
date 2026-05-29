# Diff narrativo — docs/missions/MISSION_REGISTRY.json

**Mission:** M-OS3-024
**SSOT:** MISSION_REGISTRY (operational tracker)
**Mode:** substitutive (sezione operativa entry M-OS3-024)
**Resolution:** FASE 6 self-close automatico

## Modifica entry M-OS3-024

| Campo | Prima | Dopo |
|---|---|---|
| `status` | `closing` | `closed` |
| `date_close` | `null` | `2026-05-29` |
| `file` | `tests/m-os3-024/test_mission_registry_bootstrap.sh` | `docs/missions/MISSION_REGISTRY.json` (artefatto reale; test spostato in `test_file`) |
| `doc_sync_executed` | (assente) | `true` |
| `doc_sync_outcome` | (assente) | `success` |
| `audit_findings` | (assente) | `GREEN (2 fix minori pre-applicati)` |
| `test_file` | (assente) | `tests/m-os3-024/test_mission_registry_bootstrap.sh` |
| `note` | "Self-registering bootstrap. Status closing → closed dopo FASE 6." | nota arricchita con dual-tracking |

## Hash

- before: `aacfefe6d51f3b174603684b62261e9fbd20a50708890aa51076bd5596a77b74`
- after:  `3337962e6948fad1c6096567e21652fe035790d866970c048b622220d3fd61eb`

## Razionale

Chiusura autoreferenziale: la mission che crea il registry chiude se stessa nel registry.
Schema della entry allineato a M-OS3-023 (campi `doc_sync_*`, `test_file`, `audit_findings`).
Nessuna modifica al blocco `_meta` (manual-only). `counter` resta 23 (semantica: ultimo ID assegnato).
