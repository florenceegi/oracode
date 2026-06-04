# /oracode-scaffold — Genera lo scaffold del progetto dai parametri raccolti

Micro-skill del ciclo `/project`. Data la config di `/oracode-configure`, genera l'albero del progetto e i
descrittori (incluso il **ponte L1→L3**). È il pezzo più delicato: il descrittore e lo schema registry abilitano
l'auto-registrazione delle mission. Non raccoglie parametri (→ `/oracode-configure`).

## Fase 4 — Generazione scaffold

Dopo tutte le risposte:

1. **Crea directory progetto**: `<CWD>/NOME-DOC/`
2. **Copia scaffold base**: da `/home/fabio/oracode/templates/PROJECT-DOC/`
   Include automaticamente: `docs/missions/MISSION_BOOTSTRAP_INDEX.json`,
   `docs/missions/BOOTSTRAP_DRIFT_LOG.md`, `audit/doc_sync/.gitkeep`.
3. **Compila CLAUDE.md**: sostituisci tutti i placeholder `{{...}}` con le risposte raccolte
4. **Compila MISSION_REGISTRY.json**: inserisci dati progetto, counter=0. **Schema chiavi INGLESE** (id/title/type/organs/status/date_open/date_close/...) — decisione paradigma (vedi `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`).
5. **Compila SSOT_REGISTRY.json**: inserisci dati progetto, documents vuoto
6. **Compila `.oracode/project.json`** (PONTE L1→L3 — OBBLIGATORIO per l'auto-registrazione mission): sostituisci i placeholder con:
   - `{{DATE}}` = data corrente
   - `{{PROJECT_NAME}}` = nome progetto
   - `{{ORACODE_LEVEL}}` = livello (numero)
   - `{{INSTANCE_ROOT}}` = **path assoluto** della dir progetto creata (es. `/home/utente/Cliente-DOC`)
   Compila anche `docs/missions/REPO_MAP.json` (`{{GITHUB_REPO}}` = url repo, o `null` se non ancora creato).
   > Senza questo descrittore, `bin/mission`/`/mission` NON auto-registra le mission nel MISSION_REGISTRY del progetto (regressione "mission fantasma"). È il ponte Livello 1 (motore) → Livello 3 (registry del progetto).
7. **Se livello 2+**: includi configurazione OS3 Matrix nel boot context
8. **Se livello 3+ (LSO mono-organo)**: sistema circolatorio completo
   - Crea `docs/missions/MISSION_TYPES.json` che estende
     `/home/fabio/oracode/templates/MISSION_TYPES_BASE.json` (tassonomia ibrida — Opzione 3)
   - Compila `docs/missions/MISSION_BOOTSTRAP_INDEX.json` sostituendo placeholder
     `{{DATE}}`, `{{INSTANCE_NAME}}`, `{{CEO_NAME}}`, `{{CTO_NAME}}`
   - Inserisci nel CLAUDE.md istanza la convenzione `instance_root` (path assoluto)
     usata da agent `doc-sync-v2`
   - Se Q7.1 ha runtime RAG: prepara `bin/apply-rag-schema.sh` che applica
     `/home/fabio/os3-matrix/nervous-system/rag-schema-template.sql` con
     placeholder risolti (`{{RAG_SCHEMA}}` da Q7.2, `{{TS_LANGUAGE}}` mappato da
     locale principale Q5, `{{LANGUAGES_CHECK}}` derivato da Q5,
     `{{EMBEDDING_DIM}}=1536`, `{{IVFFLAT_LISTS}}=100`)
   - Se Q7.1 = nessuno runtime: annota `LSO ridotto — RAG offline` nel CLAUDE.md
9. **Se livello 4**: includi sezione organi e sistema circolatorio cross-organo
10. **Registra librerie installate**: nel boot context, sezione dipendenze

<!-- Fase 4 sara espansa con step aggiuntivi futuri -->
