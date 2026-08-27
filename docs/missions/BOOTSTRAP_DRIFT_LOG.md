# BOOTSTRAP_DRIFT_LOG

## Proposte

### M-NEXUS-000 — 2026-06-17 [retrofit post-mortem] — unknown / oracode

**Severity**: major | **Stato**: pending
**always_loaded esclusi**: 3 file

**loaded_unused** (pre-allocati mai consultati):
- (nessuno)

**used_unloaded** (consultati ma non pre-allocati):
- `CLAUDE.md`
- `Fucina/docs/ssot/SSOT_LOOP_PROTOCOL.md`
- `docs/lso`
- `docs/lso/SSOT_REGISTRY.json`
- `docs/missions/M-NEXUS-000_SHARED.md`
- `docs/missions/MISSION_REGISTRY.json`
- `docs/paradigm/index/Oracode-Nexus-index.md`
- `docs/paradigm/kernel/00_OSZ_ORACODE_SYSTEM_ZERO.md`
- `docs/paradigm/kernel/TIER0_CLAUSOLE_IMMUTABILI_v1.0.0.md`
- `docs/paradigm/lso/00_LSO_LIVING_SOFTWARE_ORGANISM.md`
- `docs/paradigm/lso/MANIFESTO_LSO.md`
- `docs/paradigm/lso/PATTERN_ANELLO_AUTOMIGLIORAMENTO_v1.0.0.md`
- `docs/paradigm/nomenclature/LSO_NOMENCLATURE_v2.md`

**Proposta**:
- `by_mission_type.unknown` o `by_organ`: consider adding 13 file

**Reasoning**: drift empirico rilevato su M-NEXUS-000 (unknown/oracode). Singola osservazione — CEO valuta se pattern ricorrente o specifico di questa mission.

### M-NEXUS-014 — 2026-06-29 [retrofit post-mortem] — unknown / oracode, EGI-DOC, EGI, fabiocherici

**Severity**: major | **Stato**: pending
**always_loaded esclusi**: 3 file

**loaded_unused** (pre-allocati mai consultati):
- (nessuno)

**used_unloaded** (consultati ma non pre-allocati):
- `docs/missions/HANDOFF_ANELLO_AUTOMIGLIORAMENTO.md`
- `docs/missions/MISSION_REGISTRY.json`
- `docs/paradigm/index/Oracode-Nexus-index.md`
- `docs/paradigm/lso/PATTERN_ANELLO_AUTOMIGLIORAMENTO_v1.0.0.md`
- `docs/tests/m-nexus-014/verify_cycle_order.sh`

**Proposta**:
- `by_mission_type.unknown` o `by_organ`: consider adding 5 file

**Reasoning**: drift empirico rilevato su M-NEXUS-014 (unknown/oracode, EGI-DOC, EGI, fabiocherici). Singola osservazione — CEO valuta se pattern ricorrente o specifico di questa mission.

### M-NEXUS-018 — 2026-08-27 — fix / oracode, EGI-DOC, FORTINO

**Severity**: major | **Stato**: rejected (2026-08-27) — motivo: Letture puntuali di una correzione di puntatore una tantum, non moduli di bootstrap ricorrenti per il tipo fix: non si arricchisce l'indice.
**always_loaded esclusi**: 3 file

**loaded_unused** (pre-allocati mai consultati):
- `/home/fabio/oracode/docs/paradigm/modules/DEV_DISCIPLINE.md`
- `/home/fabio/oracode/docs/paradigm/modules/WEB_PUBLIC_STANDARDS.md`

**used_unloaded** (consultati ma non pre-allocati):
- `"docs/tests`
- `FORTINO/CLAUDE_ORACODE_CORE.md`
- `docs/lso/CAPABILITY_INTENTS.jsonl`
- `docs/lso/SSOT_REGISTRY.json`
- `docs/missions/HANDOFF_ANELLO_v2_ripresa_2026-07-18.md`
- `docs/missions/HANDOFF_M-NEXUS-018.md`
- `docs/missions/MISSION_REGISTRY.json`
- `docs/paradigm/index/Oracode-Nexus-index.md`
- `docs/paradigm/modules/EGIDA_ASSE_DIFESA.md`
- `docs/tests/m-nexus-018/verify_rimando_egida.sh`
- `os3-matrix/docs/design/M-OS3-144_TAVOLA_DIETA_CORE.md`
- `os3-matrix/docs/ssot/DOTTRINA_CAPACITA.md`
- `os3-matrix/docs/ssot/ESEMPI_CAPACITA.md`
- `templates/CLAUDE_ORACODE_CORE.md`

**Proposta**:
- `by_mission_type.fix`: consider removing 2 file
- `by_mission_type.fix` o `by_organ`: consider adding 14 file

**Reasoning**: drift empirico rilevato su M-NEXUS-018 (fix/oracode, EGI-DOC, FORTINO). Singola osservazione — CEO valuta se pattern ricorrente o specifico di questa mission.

