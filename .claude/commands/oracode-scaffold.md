# /oracode-scaffold — Genera lo scaffold del progetto dai parametri raccolti

Micro-skill del ciclo `/project`. Data la config di `/oracode-configure`, genera l'albero del progetto e i
descrittori (incluso il **ponte L1→L3**). È il pezzo più delicato: il descrittore e lo schema registry abilitano
l'auto-registrazione delle mission. Non raccoglie parametri (→ `/oracode-configure`).

## Fase 4 — Generazione scaffold

Dopo tutte le risposte:

Convenzione path (portabile, NO path assoluti baked): `$ORACODE_HOME` = radice del repo `oracode`
(default: il clone da cui gira `/project`); `$MATRIX_CLONE` = clone temporaneo di `os3-matrix` usato da `/oracode-install`.

1. **Crea directory progetto**: `<CWD>/NOME-DOC/`
2. **Copia scaffold base**: da `$ORACODE_HOME/templates/PROJECT-DOC/`
   Include automaticamente: `docs/missions/MISSION_BOOTSTRAP_INDEX.json`,
   `docs/missions/BOOTSTRAP_DRIFT_LOG.md`, `audit/doc_sync/.gitkeep`.
2b. **Copia il boot context del paradigma (fonte unica)**: copia `$ORACODE_HOME/templates/CLAUDE_ORACODE_CORE.md`
   (CANONICA) → `<project>/CLAUDE_ORACODE_CORE.md`. NON esiste una seconda copia versionata nello scaffold
   (era fonte di drift, M-OS3-078): la CORE viene sempre dalla canonica → mai stale.
3. **Compila CLAUDE.md**: sostituisci tutti i placeholder `{{...}}` con le risposte raccolte
4. **Compila MISSION_REGISTRY.json**: inserisci dati progetto, counter=0. **Schema chiavi INGLESE** (id/title/type/organs/status/date_open/date_close/...) — decisione paradigma (vedi `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`).
5. **Compila SSOT_REGISTRY.json**: inserisci dati progetto, documents vuoto
6. **Compila `.oracode/project.json`** (PONTE L1→L3 — OBBLIGATORIO per l'auto-registrazione mission): sostituisci i placeholder con:
   - `{{DATE}}` = data corrente
   - `{{PROJECT_NAME}}` = nome progetto
   - `{{ORACODE_LEVEL}}` = livello (numero)
   - `{{INSTANCE_ROOT}}` = **path assoluto** della dir progetto creata (es. `<percorso-assoluto>/Cliente-DOC`)
   Compila anche `docs/missions/REPO_MAP.json` (`{{GITHUB_REPO}}` = url repo, o `null` se non ancora creato).
   > Senza questo descrittore, `bin/mission`/`/mission` NON auto-registra le mission nel MISSION_REGISTRY del progetto (regressione "mission fantasma"). È il ponte Livello 1 (motore) → Livello 3 (registry del progetto).
6b. **Installa la difesa Egida (difesa-by-default)** — solo se Matrix presente e `egida_profile` definito (livello 2+, o livello 1 *con* Matrix). EGIDA_INSTALL_CONTRACT §6 (interfaccia autoritativa):
   - **Scaffolda gli invarianti**: copia lo starter del profilo dalla copia persistita da `/oracode-install`
     (step 2.3.e) → la root del nuovo repo:
     ```
     .oracode/etc/egida/SECURITY_INVARIANTS.starter.<egida_profile>.json  →  <project>/SECURITY_INVARIANTS.json
     ```
     I target sono `<PLACEHOLDER>` generici: li riempie la corsia dell'organo coi valori reali (path/bucket/SG),
     NON `/project`. Conforme a `FORTINO/SECURITY_INVARIANTS.schema.json`.
   - **Registra il gate nel descrittore**: aggiungi a `.oracode/project.json` (lo stesso compilato allo step 6):
     ```json
     "egida_gate": true,
     "egida_profile": "<egida_profile>"
     ```
     `egida_gate: true` segnala che l'LSO è soggetto al Banco di Prova (`/collaudo`) prima della consegna;
     l'hook enforcement os3-matrix (`bin/egida-gate-check`, M-OS3-100) lo legge al close di una mission `type==release`.
   - **NON** toccare os3-matrix (corsia Fortino); **NON** deployare `fortino-check` (runtime); **NON** calcolare
     il triage domini (lo fa `bin/collaudo`); **NON** scrivere valori reali negli invarianti.

   > **Livello 1 paradigm-only (senza Matrix)**: salta 6b interamente — nessun `SECURITY_INVARIANTS.json`,
   > nessun `egida_gate`. L'hook tratta il flag assente come zero requisito ("dove ha senso", proporzionalità).
7. **Se livello 2+**: includi configurazione OS3 Matrix nel boot context
8. **Se livello 3+ (LSO mono-organo)**: sistema circolatorio completo
   - Crea `docs/missions/MISSION_TYPES.json` che estende
     `$ORACODE_HOME/templates/MISSION_TYPES_BASE.json` (tassonomia ibrida — Opzione 3)
   - Compila `docs/missions/MISSION_BOOTSTRAP_INDEX.json` sostituendo placeholder
     `{{DATE}}`, `{{INSTANCE_NAME}}`, `{{CEO_NAME}}`, `{{CTO_NAME}}`
   - Inserisci nel CLAUDE.md istanza la convenzione `instance_root` (path assoluto)
     usata da agent `doc-sync-v2`
   - Se Q7.1 ha runtime RAG: prepara `bin/apply-rag-schema.sh` che applica
     `$MATRIX_CLONE/nervous-system/rag-schema-template.sql` con
     placeholder risolti (`{{RAG_SCHEMA}}` da Q7.2, `{{TS_LANGUAGE}}` mappato da
     locale principale Q5, `{{LANGUAGES_CHECK}}` derivato da Q5,
     `{{EMBEDDING_DIM}}=1536`, `{{IVFFLAT_LISTS}}=100`)
   - Se Q7.1 = nessuno runtime: annota `LSO ridotto — RAG offline` nel CLAUDE.md
9. **Se livello 4**: includi sezione organi e sistema circolatorio cross-organo
10. **Registra librerie installate**: nel boot context, sezione dipendenze

<!-- Fase 4 sara espansa con step aggiuntivi futuri -->
