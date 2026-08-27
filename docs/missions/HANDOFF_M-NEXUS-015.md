# HANDOFF — M-NEXUS-015 · deprecazione della cornice stale della gerarchia Nexus

> **Validità:** fino alla chiusura di M-NEXUS-015 (2026-08-27). CONSUMATO alla chiusura.
> Autore: Padmin D. Curtis (CTO) per Fabio Cherici (CEO).

## Cosa è questa mission

Aperta il 2026-07-06 nella sessione della gerarchia operativa (M-OS3-138, os3-matrix). Compito: fissare lo **stato corrente**
della gerarchia Nexus in uno SSOT (`docs/paradigm/nomenclature/NEXUS_HIERARCHY_CURRENT_STATE.md`) e mettere un **banner di
deprecazione** sui documenti del paradigma che portavano le clausole di stato superate («FlorenceEGI/EGI-DOC accoppiati, caso
unico; Softwarehouse differita»), senza toccare le definizioni core né il corpo dei documenti LOCKED.

## Cosa è stato fatto (commit `c768623`, 2026-07-06; verificato oggi: test `docs/tests/m-nexus-015/verify_cornice_gerarchia.sh` verde)

- SSOT `NEXUS_HIERARCHY_CURRENT_STATE.md`: `status: current`, 19 voci in `supersedes_clauses`; aggiornato l'11/07 da M-OS3-144 (6 ruoli).
- Banner DEPRECATO con rimando allo SSOT su 13 file di `docs/paradigm` (incluso `ORACODE_NEXUS_3_TIER.md`, banner in testa, corpo LOCKED intatto).
- La mission restò in `draft` per 52 giorni (residuo dichiarato negli handoff del 10/07 e 25/07). Il 27/08 le è stato attaccato per errore un
  piano-capacità di M-NEXUS-018; corretto via giudice del taglio (REVISE → piano vero a uno step, `gerarchia-corrente-ha-uno-ssot`,
  ratificato dal CEO a conteggio 0, doc-mission).

## Residuo di contenuto segnalato dal giudice (non di questa mission)

Il banner del 3_TIER (r.6) elenca «DeepDebug» tra le istanze-clienti; lo SSOT dello stato corrente (11/07) lo classifica Libreria LSO.
Drift tra i due file, da correggere in una mission di nomenclatura.

## PROSSIMO PASSO

1. Chiudere M-NEXUS-015 (auditing → closed → finalize).
2. Registrare `NEXUS_HIERARCHY_CURRENT_STATE.md` nel SSOT_REGISTRY di oracode (oggi non registrato) — via verdetto del critico al close.
