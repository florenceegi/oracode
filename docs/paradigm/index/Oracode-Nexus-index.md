---
visibility: public
rag: public
---

# Oracode Nexus — Index Documenti Vitali

> **Scopo**: indice navigabile anti-degradazione per Padmin Supervisor. Sintesi compatta + path assoluto + sezioni chiave per ogni documento vitale di Oracode + OS3 Matrix + Layer Stack LSO.
> **Path canonical**: `/home/fabio/oracode/docs/paradigm/index/Oracode-Nexus-index.md`. Rilocazione paradigma in `docs/paradigm/` COMPLETATA (M-OS3-022).
> **Versione**: 0.6.3 (M-FUC-029 — scaffold step 5b: censimento del nuovo SSOT_REGISTRY nell'indice Nexus + `ssot-index-check` verde)
> **Autore**: Padmin Supervisor for Fabio Cherici
> **Data inizio**: 2026-05-27 — **Ultimo aggiornamento**: 2026-06-12

---

## 🔒 LEGGI PER PRIMO — Decisioni LOCKED (anti-deriva)

Prima di qualsiasi mission strutturale, leggi questi SSOT autoritativi. Sono **legge**, si rileggono, non si reinventano.

| SSOT locked | Path | Cosa fissa |
|---|---|---|
| **Gerarchia a 3 Livelli** | `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md` | Mission tracking su 3 livelli (GLOBALE visibile / HUB aggregatore / ISTANZA repo). **Mai collassare in 2. Globale mai nascosto.** Ponte L1→L3 via `.oracode/project.json`. |
| **Trasferimento Know-How** | `docs/paradigm/ssot/KNOW_HOW_TRANSFER_PROTOCOL.md` | Esperienza privata d'istanza ≠ prodotto. Il know-how operativo GENERICO si **promuove** a un vettore di prodotto (CORE/SSOT/agente/skill/hook/engine), non resta in memoria privata. Gate in FASE 6/DOC-SYNC. Vedi CORE §Trasferimento Know-How. |
| **Asse Difesa Costitutivo — Egida** | `EGI-DOC/docs/oracode/Egida/00_EGIDA_CHARTER.md` + CORE §Asse Difesa Costitutivo | **In OSZ da M-NEXUS-005** (4 [DECISIONE CEO] ratificati 2026-06-08). Clausola: *"un LSO si difende e prova la propria difesa, in proporzione al rischio; chi non lo fa non è un LSO"*. **Fortino** difende (runtime) · **DeepDebug** collauda (banco di prova, esiste già) · **Egida** = usarli insieme · **Sigillo** certifica. Difesa = parte della definizione di LSO. Profilo scalato sul livello (vetrina→leggero, denaro/PII/blockchain→pieno). |
| **Dottrina del Supervisor** | CORE §Dottrina del Supervisor (`templates/CLAUDE_ORACODE_CORE.md`) | **Nel kernel da M-NEXUS-007** (richiesta CEO 2026-06-08, CORE 1.1.0→1.2.0; generica → si diffonde a tutti i progetti via `@import`). Il Supervisor opera al livello degli specialisti adottandone i **5 riflessi**: grounding (mai da memoria — legge la fonte o spawna lo specialista grounded), routing (triage → instrada; **il pool grounded è l'esecutore di default**; il Supervisor orchestra e sintetizza, non scrive codice di produzione da solo quando esiste lo specialista), REGOLA ZERO + onestà epistemica (FATTO vs IPOTESI), misura-prima (metro esterno/evaluation, Pilastro 5), no over-claim. Unità di lavoro ben condotta = *triage → pool grounded esegue → sintesi onesta misurata*, non "il Supervisor fa tutto". |

### Oracode Nexus in una frase

**Oracode Nexus** = il sistema completo: **paradigma** (regole + 13 P0 + pilastri) + **3 livelli** di mission tracking + **ecosistema** HUB/istanze.

```
L1 — GLOBALE   il MOTORE (~/oracode-engine, VISIBILE — non un registro): scratch runtime
               (missions/, focus/, audit/, state/, license.json). Paradigma = oracode + os3-matrix.
L2 — HUB       softwarehouse acquirente: PRIMO vero MISSION_REGISTRY (statistiche + numerazione
               GLOBALE UNICA), versionato nel repo HUB-DOC.
L3 — ISTANZA   singolo progetto/cliente: MISSION_REGISTRY proprio, nel repo del progetto.
```

**Stato attuale (M-OS3-025):**
- ✅ **FATTO** — Migrazione `~/.oracode/` → `~/oracode-engine/` (cartella globale VISIBILE; symlink `~/.oracode` di compat resta). [U1]
- ✅ **FATTO** — `/mission` slash command GLOBALE context-aware (wrapper di `bin/mission`, rileva istanza da CWD). [U2]
- ✅ **FATTO** — Ponte automatico **L1→L3** via `.oracode/project.json` (`bin/mission` auto-registra nel registry del progetto, parallel-safe). [U3]
- ⏳ **DIFFERITO** — Aggregator HUB + stats/numerazione cross-istanza (al 2° cliente). [U4/U5]

**Flusso operativo Nexus:** `/discovery` (acquisizione) → `/project` (bootstrap istanza, scaffolda `.oracode/project.json` + **difesa Egida-by-default** per i progetti con Matrix, liv 2+) → `/mission` (lavoro, auto-registrato L1→L3).

---

## Stato di lettura (tracking onesto)

Legenda: ✅ letto integrale | 🟡 letto parziale | ❌ non letto | 🗂️ skip (non vitale per ora)

---

## TIER 1A — Definizioni fondative (kernel + paradigma)

### `00_OSZ_ORACODE_SYSTEM_ZERO.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/kernel/00_OSZ_ORACODE_SYSTEM_ZERO.md`
- **Status**: ✅ (letto integrale, 309 righe)
- **Versione/data**: v1.0 — 2026-01-14 — autore Fabio Cherici + Antigravity AI
- **Sintesi**: Kernel concettuale Oracode. **Bio-architettura**: 4 primitivi (Wrapper<T> unità atomica EGI / Interface giunture stabili API+contratti / Instance organi sostituibili / Nerve sistema nervoso AI). FlorenceEGI = organismo economico-cognitivo, non piattaforma. OSZ = COSA (organismo). OS3 = COME AI lo costruisce (REGOLA ZERO P0-P3). OS4 = COME umani lo usano (ASSIOMA 0 + 4 regole epistemiche: TSM Truth Source Manager + RI Reliability Index + Registro Cognitivo). **Regola coerenza:** OSZ è verità, OS3/OS4 si allineano a OSZ mai contrario.
- **Sezioni chiave**: §Bio-architettura (4 primitivi) | §OS3 spalletta AI | §OS4 spalletta umana | §Coerenza | §Learning path
- **Cita docs vitali NON ANCORA NEL MIO INDEX**:
  - `/docs/00_ECOSISTEMA.md` (dettaglio bio-architettura — DA SCOPRIRE PATH REALE)
  - `Oracode_Systems/OS3/00_OS3_Executive_Summary.md`
  - `Oracode_Systems/OS3/03_Modulo_2_REGOLA_ZERO.md`
  - `Oracode_Systems/OS3/04_Modulo_3_Sistema_Priorita_P0_P3.md`
  - `Oracode_Systems/OS4/OS4_FOUNDATION_DOCUMENT.md`

### `ORACODE_PARADIGM_v2_draft.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/roadmap/ORACODE_PARADIGM_v2_draft.md`
- **Status**: ❌
- **Versione/data**: v2 draft
- **Sintesi**: TBD — definizione integrale paradigma v2

### `ORACODE_NEXUS_SYSTEM_REFERENCE.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/ssot/ORACODE_NEXUS_SYSTEM_REFERENCE.md`
- **Status**: 🟡 (letto top 80 righe)
- **Versione/data**: v1.2.0 — 2026-05-27 (aggiornato da CEO altra chat M-OS3-018)
- **Sintesi**: SSOT consolidato Oracode. Triade OSZ/OS3/OS4. LSO 6 principi. Open source MIT. Dati produzione 7 organi 500k LOC 34+ mission.
- **Sezioni chiave**: §1 Cos'è Oracode | §2 LSO | §3 6 principi | §4 Triade

### `MANIFESTO_LSO.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/lso/MANIFESTO_LSO.md`
- **Status**: ✅ (letto integrale, 187 righe)
- **Versione/data**: v1.0.0 — 2026-03-27 — Fabio Cherici autore
- **Sintesi**: Manifesto LSO come **nuova categoria di software** (al pari di OS, SaaS, sistemi distribuiti). "Le regole NON sono documentazione, sono struttura". 4 proprietà fondamentali: Awareness (sa dove si trova), Prevention (errori strutturalmente impossibili), Detection (vede ciò che sfugge), Evolution (impara e cresce). Software tradizionale vs LSO: tabella confronto netta. Analogie biologiche (identità/metabolismo/immunitario/memoria/gerarchia). "I Contratti, non le Prose" — dalle regole che *dovrebbero* essere seguite alle strutture che le rendono *inevitabili*.
- **Sezioni chiave**: §Cos'è LSO 4 proprietà | §Tabella confronto tradizionale vs LSO | §Concetto organismo | §Pilota e sistema | §Contratti vs prose

### `00_LSO_LIVING_SOFTWARE_ORGANISM.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/lso/00_LSO_LIVING_SOFTWARE_ORGANISM.md`
- **Status**: ✅ (letto integrale, 548 righe)
- **Versione/data**: v4.0.0 — aggiornato 2026-05-08
- **Sintesi**: Implementazione concreta LSO per FlorenceEGI. **6 principi** (i 4 manifesto + Consciousness + Nervous System NUOVO v4.0). Layer Stack v3.0 con 8 layer + 4 sub-layer dentro L8. Lista completa **27 hook** categorizzati per livello (PreToolUse + PostToolUse). Lista **10 agenti attivi** (os3-audit, os3-gate, organ-gap-scout, oracode-alignment-interpreter, oracode-specialist, doc-sync-v2, egili-blood-keeper, m093-remediation, node-ts, corporate-finance). **DOC-SYNC v2 dettaglio 4 sub-layer L0-L3** con analogie biologiche (mielina/nocicettori/arco riflesso/propriocezione/sistema autonomo). **8 organi in produzione (caso esemplare: istanza FlorenceEGI)** (EGI-HUB, EGI-HUB-HOME, EGI, NATAN_LOC, Sigillo, EGI-Credential, EGI-INFO, CREATOR-STAGING).
- **Sezioni chiave**: §5 Principi LSO | §Architettura Layer Stack 8 layer | §Hook System tabella 27 hook | §Agenti tabella 10 | §Sistema Nervoso 4 sub-layer | §Ciclo vitale | §Organi tabella | §Mente organismo (SSOT→RAG→ai_sidebar)
- **Cita strumenti NON ANCORA NEL MIO INDEX**:
  - `rag_<istanza>.*` schema DB condiviso (es. `rag_natan` su FlorenceEGI) (RAG piattaforma — specifico dell'istanza)
  - lo schema RAG di un organo (es. `natan.rag_*` per NATAN_LOC) (USE Pipeline)
  - `marketing_rag.*` (NPE marketing)
  - **Tool RAG**: re-index + query, nell'enforcement privato (OS3 Matrix). Le citazioni `rag_natan_*` in 00_LSO sono nomi storici dell'istanza FlorenceEGI. Inventario path: SSOT privato `oracode-nexus-index-impl`.
  - reflex guard passivo (PostToolUse, Sistema Nervoso L1) + cron di staleness (L3) — impl privata
  - `ai_sidebar` con chat in ogni organo (SigilloAdvisorService, CredentialAdvisorService, ecc.)
- **DOC-SYNC v2 5b clarification**: hook auto-update ARCHIVIATO (anti-pattern 6), responsabilità trasferita a DOC-SYNC v2 Step 5b che aggiorna `last_verified` SOLO post-verifica semantica + RAG conferma

---

## TIER 1B — Nomenclatura e vocabolario

### `LSO_NOMENCLATURE_v2.md` — DOCUMENTO CENTRALE
- **Path**: `/home/fabio/oracode/docs/paradigm/nomenclature/LSO_NOMENCLATURE_v2.md`
- **Status**: ✅ (letto integrale, 1270 righe)
- **Versione/data**: v2.1.0 — 2026-05-22 (Working Draft, evoluzione continua)
- **Sintesi**: **IL** documento architetturale di Oracode Nexus. Separa formalmente **4 livelli concettuali** (mai mescolare):
  - **§1.1 Oracode** (paradigma universale, MIT)
    - **§1.1.A Oracode-paradigma** (regole epistemiche, pattern, standard — pubblico gratuito)
    - **§1.1.B OS3 Matrix (OSMx)** (enforcement runtime — commerciale Florence EGI S.R.L.)
  - **§1.2 Libreria LSO** (componenti tecnologici riusabili opzionali estratti da istanze mature)
  - **§1.3 Organismo** (metafora architetturale multi-organo)
  - **§1.4 FlorenceEGI** (prima istanza-laboratorio, oggi accoppiata HUB+istanze, ruolo Formula 1)

  **4 offerte commerciali distinte** (§4.1):
  - Offerta 1: FlorenceEGI prodotto verticale B2C/B2B
  - Offerta 2: **Magicsoft 2.0** software house custom Oracode (8-25k€/commessa PMI italiana)
  - Offerta 3: **OS3 Matrix** prodotto autonomo distribuibile a software house terze
  - Offerta 4: Libreria LSO pacchetti licenziabili (futuro)

  **Roadmap disaccoppiamento §4.4.1** (4 aree parallele):
  - Area 1: Magicsoft 2.0 dominio esterno
  - Area 2: Fornitore AI singolo (Gamba A vincolo L9)
  - Area 3: Layer Stack completo (Gamba B = DOC-SYNC v2 operativo)
  - Area 4: Validazione esterna (terzi adottanti)

  **Distinzione LSO-pieno vs LSO-ridotto §2.7** — diagnosi dominio cliente PMI è PRIMO step pitch commerciale.
  **Flusso unidirezionale §2.6** — Oracode → Libreria LSO → Applicazione. Libreria NON modifica Oracode.

- **Sezioni chiave** (per jump rapido):
  - §1 4 livelli (1.1 Oracode + 1.1.A paradigma + 1.1.B Matrix + 1.2 Libreria + 1.3 Organismo + 1.4 FlorenceEGI)
  - §2 Rapporti (2.1 Oracode genera Libreria | 2.2 Oracode produce applicazione | 2.3 Multi-organo formano Organismo | 2.4 FlorenceEGI = Organismo + laboratorio | 2.5 Libreria = fertilizzante incrociato | 2.6 Flusso unidirezionale | **2.7 LSO-pieno vs ridotto**)
  - §3 Mappa appartenenza (3.1.A 15 componenti paradigma | **3.1.A.12 nota dual-tracking Mission Engine** | 3.1.A.15 Layer Stack L0-L11 | 3.1.B componenti OS3 Matrix | 3.2 Libreria LSO 4 componenti | 3.3 FlorenceEGI specifico 7 sezioni | **3.3.7 Maturity matrix verificata M-LS-AUDIT-001**)
  - §4 Conseguenze pratiche (4.1 4 offerte commerciali | 4.2 doc da aggiornare | 4.3 future istanze Padmin | 4.4 spin-off pubblico | **4.4.1 Roadmap disaccoppiamento 4 aree** | 4.5 bozzolo→farfalla)
  - §5 Domande aperte (5.1.1 Egili Bible spin-off | 5.1.2 4 livelli esaustivi | 5.1.3 LSO-pieno/ridotto commerciale | **5.2.1 P0-13 storia** | **5.2.2 Ls Audit pattern ricorrente** | 5.2.3 co-creazione mission | 5.2.4 3 Frontiere A/B/C non verificate)

- **CONVERGENZE CRITICHE per M-OS3-021**:
  1. **§3.1.A.12 nota Mission Engine dual-tracking** — ⚠ AGGIORNATO: il testo §3.1.A.12 descrive la sync come "manuale oggi, automatica via `.oracode/project.json` domani". Quel "domani" è **ARRIVATO**: il ponte automatico L1→L3 è implementato (M-OS3-025 U3, `bin/mission` propaga via `.oracode/project.json`, parallel-safe). La sync NON è più manuale. La nota in `LSO_NOMENCLATURE_v2.md` va riallineata.
  2. **§3.3.7 Maturity Matrix verificata** (audit M-LS-AUDIT-001 del 7 mag 2026): Solo L4 PRODUCTION (Claude Code scope), L1-L3 e L5-L8 PARTIAL, L9 DESIGN, L10 CONCEPT, L11 VISION. 3 gap critici: L6 Testing (zero CI gate), L3 Detection (no notification dispatcher), L5 UEM (no pattern recognition adattivo).
  3. **Modello commerciale formalizzato** (§1.1.B + §4.1): Oracode-paradigma MIT pubblico, OS3 Matrix commerciale Florence EGI S.R.L. Distinzione MIT/commerciale **decisione del 22 maggio 2026**.
  4. **Co-creazione riposizionata** (§3.3.3 decisione 6 mag 2026): da principio fondativo a opzione discrezionale creator. Mission implementazione da definire.

- **Test di coerenza (vincolo spin-off)**: ogni componente Oracode-paradigma deve passare il test "applicabile a dominio completamente diverso senza modifiche concettuali". OS3 Matrix passa: enforcement meccanico universale, implementazioni hook cambiano per dominio.

- **Tre fasi evoluzione documento** (bozzolo interno → maturazione derivati pubblici → farfalla spin-off pubblico): target STABLE non prima di 6-9 mesi (fine 2026/inizio 2027).

### `LSO_NOMENCLATURE_INDEX.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/nomenclature/LSO_NOMENCLATURE_INDEX.md`
- **Status**: ✅ (letto integrale, 81 righe)
- **Versione/data**: v2.0.0 — aggiornato 2026-05-22 — source di `LSO_NOMENCLATURE_v2.md`
- **Sintesi**: **Vocabolario sintetico always-loaded.** 4 livelli: (1) Oracode paradigma universale / (2) Libreria LSO componenti estratti / (3) Organismo metafora architetturale / (4) FlorenceEGI prima istanza-laboratorio. Regola stratificazione: mai mescolare livelli. **Layer Stack L0-L11** completo con maturity FlorenceEGI (L4 PRODUCTION sola). 3 soglie qualitative: L0→L1, L8→L9 (metacognizione, soglia attuale), L10→L11. **Vincolo L9**: operativo SOLO se disaccoppiato da LLM esterni. 6 principi invarianti dello stack.
- **Sezioni chiave**: §1 4 livelli | §2 Layer Stack tabella | §3 Vincolo L9 | §4 6 principi invarianti

### `proposals/M-NOMENCL-OSMX-002_DELTA.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/nomenclature/proposals/M-NOMENCL-OSMX-002_DELTA.md`
- **Status**: ✅ (letto integrale)
- **Versione/data**: v2 — 2026-05-22 — IN ATTESA APPROVAZIONE CEO
- **Sintesi**: Distinzione formale Oracode-paradigma (§1.1.A) vs OS3 Matrix (§1.1.B). 35 componenti mappati. Test coerenza (sw eseguibile + piano OS3 + scopo enforcement + se rimosso paradigma integro). 12 punti di modifica al LSO_NOMENCLATURE_v2.md.
- **Sezioni chiave**: §a Mappatura 35 componenti | §b Nuova struttura §1.1 | §c Nuova struttura §3.1 | §d 12 punti modifica | §e Test coerenza | §f Nota OS4/OSZ

---

## TIER 1C — Mission Protocol + Tooling

### `MISSION_PROTOCOL.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/missions/MISSION_PROTOCOL.md`
- **Status**: ✅ (letto integrale)
- **Versione/data**: v3.0.0 — 2026-05-27 (M-OS3-018, CEO altra chat)
- **Sintesi**: Protocollo mission. FASE 0 (prenotazione ID) + 1 (apertura+bootstrap mirato) + 2-5 (analisi/piano/exec/review) + 6 (chiusura: DOC-SYNC + retrospective + report + stats + commit, 8 step). State machine 7 stati codificata. CLI `bin/mission` v0.3 evoluzione. AMENDMENT pattern. Test red whitelist tests/** in planned. Multi-mission v0.2 + Multi-write per session_id v0.3.
- **Sezioni chiave**: §3 FASE 0 | §4 FASE 1 (bootstrap mirato + MISSION_BOOTSTRAP_INDEX) | §6 FASE 6 (8 step + DOC-SYNC + retrospective + ESITO A/B/C) | §7 State machine 7 stati | §8 CLI bin/mission | §9 Multi-mission | §10 Multi-write | §11 Spawn fingerprint | §12 Test-red whitelist | §13 Scope hash | §14 AMENDMENT pattern | §18 Changelog M-OS3

### `READ_TRACKING_TECH_SPEC.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/tech-specs/READ_TRACKING_TECH_SPEC.md`
- **Status**: ✅ (letto integrale)
- **Versione/data**: v1.0.0 — 2026-05-08 (M-158 mission origine)
- **Sintesi**: Hook PostToolUse (privato) che cattura accessi filesystem per retrospective FASE 6. **Stato runtime per-mission (L1, scratch)** vive in `~/oracode-engine/{missions,focus,audit}` — la mission corrente si risolve dallo scratch dell'engine. Il **registry di progetto (L3)** è risolto via `.oracode/project.json`, non hardcoded. Log `MISSION_READ_LOG.jsonl` JSONL append-only (path `EGI-DOC/audit/...` = specifico dell'istanza FlorenceEGI, non universale). `always_loaded` invisibili (limitazione strutturale `@` include CLAUDE.md). Copertura Bash ~60-70%.
- **Sezioni chiave**: §1 Architettura | §3 Sede log | §4 Schema JSONL | §5 Parsing Bash | §6 Limitazione always_loaded
- **Prerequisito di**: M-159 retrospective

### `RETROSPECTIVE_TECH_SPEC.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/tech-specs/RETROSPECTIVE_TECH_SPEC.md`
- **Status**: ✅ (letto integrale)
- **Versione/data**: v1.0.0 — 2026-05-08 (M-159 mission origine)
- **Sintesi**: Script di retrospective nell'enforcement privato (OS3 Matrix; vecchia spec `oracode/bin/` superata). Confronta caricato (`MISSION_BOOTSTRAP_INDEX` per `type`+`organs`) vs usato (`MISSION_READ_LOG.jsonl`). Esclude `always_loaded`. Filtro pool SSOT hardcoded. Severity minor/moderate/major. Entry in `BOOTSTRAP_DRIFT_LOG.md`. NO apply automatico (CEO decision).
- **Sezioni chiave**: §1 Arch | §2 Ordine FASE 6 | §3 Logica diff | §4 Pool SSOT | §6 Severity | §7 Format DRIFT_LOG

### Schema mission / registry (enforcement)
- Lo schema canonico del `MISSION_REGISTRY` e la versione di protocollo del motore vivono nell'OS3 Matrix (privato) — vedi SSOT `oracode-nexus-index-impl`.

---

## TIER 1D — DOC-SYNC v2 + SSOT + Coverage

### `DOC-SYNC_v2_SPECIFICA_OPERATIVA.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/doc-sync/DOC-SYNC_v2_SPECIFICA_OPERATIVA.md`
- **Status**: ❌ — 629 righe
- **Sintesi**: TBD — spec completa DOC-SYNC v2

### `DOC-SYNC_v2_PIANO_IMPLEMENTATIVO.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/doc-sync/DOC-SYNC_v2_PIANO_IMPLEMENTATIVO.md`
- **Status**: ❌ — 919 righe (più grande di SPECIFICA)
- **Sintesi**: TBD — piano impl DOC-SYNC v2

### `DOC-SYNC_v2_STATO_DELLARTE.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/doc-sync/DOC-SYNC_v2_STATO_DELLARTE.md`
- **Status**: ✅ (letto integrale, 162 righe)
- **Versione/data**: v1.0.0 — 2026-05-15 (M-189 wiring coverage hook)
- **Sintesi**: DOC-SYNC v2 **operativo in produzione dal 2026-05-08** (M-160a). v2.1.0 con Coverage Native completato M-189. Mappa operativa: agent v2.1.0, guard v4.0.0, coverage hook v2.1.0, 3 CLI Python (reindex/query/coverage), config soglie, history JSONL, cron settimanale NON SCHEDULATO (gap basso). **Mission processate**: 136 totali, 100 (73.5%) con doc_sync_executed, 24 con log strutturato v2. **Coverage ecosistema**: 39.3% (3048/7750 file). 13 organi monitorati con soglia per-organo. Pattern broken 19.5% (sotto 25%). Dead SSOT 0/149. **Gap dual-tracking RISOLTO**: il Mission Registry dual-tracking (scratch runtime L1 `~/oracode-engine` vs MISSION_REGISTRY del repo L3) è chiuso dal **ponte automatico L1→L3** (M-OS3-025 U3): `bin/mission` propaga lo stato della state machine nel registry del progetto via `.oracode/project.json` risolto dal CWD, con lockfile parallel-safe. Niente più sync manuale né "mission fantasma". **Drift sessione 2 Poli M-002** (closed nel report, in_progress nel registry — finding S2-1) era sintomo di questo gap, ora coperto dal ponte automatico.
- **Sezioni chiave**: §2 Mappa componenti | §3 Metriche produzione | §4 Architettura runtime (3 layer) | §5 Gap noti tabella | §7 Cronologia M-148→M-189
- **CONVERGENZA RISOLTA**: il fix dual-tracking, già previsto da ROADMAP_ORACODE e DOC-SYNC_v2_STATO_DELLARTE, è stato implementato come ponte automatico L1→L3 (M-OS3-025 U3, commit 8760c5d). Il conflitto-nome M-OS3-014 non è più una questione aperta.

### `LEGACY_STACK_POLICY.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/standards/LEGACY_STACK_POLICY.md`
- **Status**: ✅ (letto integrale, 132 righe)
- **Versione/data**: v1.0.0 — 2026-04-22 (M-094)
- **Sintesi**: Ban universale 3 stack frontend/backend per **codice NUOVO** dell'ecosistema (caso esemplare: istanza FlorenceEGI): **Alpine.js** (collision Vanilla TS + Vite), **Livewire** (accoppiamento server↔view, debug difficile), **Filament** (esperienza diretta CEO admin v4 art.florenceegi.com non girava). Tabella stack per 9 organi (✅/❌/🟡). Enforcement hook PreToolUse di stack-ban con pattern regex bloccanti. Strategia Delta solo EGI legacy (organo EGI dell'istanza FlorenceEGI) (sezioni Livewire/Alpine pre-policy, no rifattorizzazione, on-touch-only).
- **Sezioni chiave**: §1 Ban tabella 3 stack | §2 Stack per organo | §3 Alternative approvate | §4 Hook enforcement | §6 Storico

### `SSOT_REGISTRY.json` (EGI-DOC)
- **Path**: `/home/fabio/EGI-DOC/docs/lso/SSOT_REGISTRY.json` (istanza FlorenceEGI)
- **Status**: 🟡 (letto 80 righe su 3777)
- **Versione/data**: v1.1.0 — 2026-05-25 (M-180 rebase: 68 rewrites, 9 baseline additions, 101 unrepairable)
- **Sintesi**: SSOT Registry dell'istanza (es. FlorenceEGI) Layer 0 MIELINA. Schema RICCO: ssot_id, path, title, organ, doc_type, priority, check_frequency (on_commit/daily/weekly/on_demand), watches (repos + paths + patterns), last_verified, last_drift_score, last_verified_by, missions_since_last_check, known_drift.
- **Sezioni chiave**: _meta | check_frequencies | documents[] (centinaia di SSOT)

### `COVERAGE_CONFIG.json`
- **Path**: `/home/fabio/EGI-DOC/docs/lso/COVERAGE_CONFIG.json` (istanza FlorenceEGI)
- **Status**: ✅ (letto integrale)
- **Versione/data**: v2.1.0 — 2026-05-12
- **Sintesi**: Config DOC-SYNC v2.1 Coverage Native. Soglie per organo (default 50%, EGI 30%, EGI-DOC 5%, YURI-BIAGINI 0%, EGI-STAT 30%, EGI-HUB-HOME-REACT 30%, EGI-SALES 30%). max_broken_patterns_pct 25%, max_dead_ssots_pct 5%, drift_alert_threshold 0.5. Esclusioni regex (node_modules, vendor, asset binari, lock, ecc.). Applies to `rag_natan_coverage.py` + cron `docsync_weekly_reglob`.

---

## TIER 1E — Identità AI + Standard codice

### `PADMIN_INDEX.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/padmin/PADMIN_INDEX.md`
- **Status**: ✅ (letto integrale)
- **Versione/data**: v1.1.0 — 2026-05-27 (M-OS3-016 step 10.a aggiunta § 5bis multi-write)
- **Sintesi**: Briefing executive Padmin. 2 forme operative (Supervisor VSCode + Watchdog claude.ai). Pattern 10 step mission strutturali. REGOLA ZERO + 4 estensioni. Top 5 anti-pattern. § 5bis Multi-write concurrency v0.3.
- **Sezioni chiave**: §1 Due forme | §2 Pattern 10 step | §3 REGOLA ZERO+4 estensioni | §4 Top 5 anti-pattern | §5bis Multi-write v0.3 | §6 Cosa NON fare

### `PADMIN_ONBOARDING.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/padmin/PADMIN_ONBOARDING.md`
- **Status**: ❌ — 463 righe
- **Sintesi**: TBD — manuale operativo esteso (vs PADMIN_INDEX briefing)

### `PADMIN_AI_IDENTITY.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/padmin/PADMIN_AI_IDENTITY.md`
- **Status**: ❌ — 382 righe
- **Sintesi**: TBD — identità Padmin (cosa è, come si comporta)

### Memoria privata del partner
- **Path**: archivio privato fuori dal repo pubblico (dati personali — non nel paradigma MIT)
- **Status**: 🔒 (memoria operativa specifica dell'istanza, non vitale per il paradigma)
- **Sintesi**: handoff AI-to-AI sullo stato del partner umano. Vive fuori dal repo pubblico per privacy/GDPR.

### `NAMING_STANDARD_CODE.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/standards/NAMING_STANDARD_CODE.md`
- **Status**: ✅ (letto integrale)
- **Versione/data**: v1.0.0 — 2026-04-10
- **Sintesi**: Standard naming PHP/Python/TypeScript. Pattern organi (es. Natan*, Sigillo*, Egi* nell'istanza FlorenceEGI). Suffix universali (Service/Exception/Enum/Interface/Dto). Anti-pattern (no prefix I/T/Abstract). Organ Index `EGI-DOC/docs/ecosistema/ORGAN_INDEX.json` (istanza FlorenceEGI) generato da `/home/fabio/oracode/bin/organ_index.py`.
- **Sezioni chiave**: PHP/Python/TS conventions | Cross-language | Anti-pattern | P0-4 esteso verifica pre-creazione | Organ Index

### `LEGACY_STACK_POLICY.md` — (sintesi sopra in TIER 1D, riferimento)

---

## TIER 1F — Standard di qualità + Roadmap

### `WEB_PAGE_QUALITY_GATE.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/standards/WEB_PAGE_QUALITY_GATE.md`
- **Status**: ✅ (letto integrale)
- **Versione/data**: v1.3.0 — 2026-06-04 (origine M-211; v1.1.0 Asse Distinzione CR/MO/PE da M-LEVESPE; v1.2.0 F-8/F-9/SEC-11/A-13/A-14 da M-OS3-072; v1.3.0 MO-8 immagini displacement + nota effetti riusabili skill da M-OS3-074)
- **Sintesi**: Protocollo Quality Gate **automatico** per mission deliverable web. Trigger: `type ∈ [feature, refactor]` (chiave canonica inglese; `tipo_missione` = legacy EGI-DOC) + file `.tsx`/`.html`/`.blade.php` pubblici. Integrazione Mission Protocol come gate FASE 4 → FASE 5 obbligatorio. 12 sezioni criteri (HTML, SEO, Schema.org, OG, A11y WCAG 2.2 AA, Performance Core Web Vitals, Security headers HSTS+CSP+COOP/COEP, i18n, Funzionalità, Privacy/GDPR, Agentic Browsing Lighthouse 13.3+, Sustainability W3C WSG).
- **Sezioni chiave**: §0 Scope/trigger | §1 Ricerca standard FASE 1 | §3 12 sezioni criteri | §4 Processo verifica | §5 Escalation | §6 Checklist sintetica

### `ROADMAP_ORACODE.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/roadmap/ROADMAP_ORACODE.md`
- **Status**: ✅ (letto integrale)
- **Versione/data**: v1.0.0 Working Draft — 2026-05-22
- **Sintesi**: Roadmap disaccoppiamento Oracode. STEP A (Magicsoft 2.0/Poli dominio esterno) + STEP B (modello-agnostico LLM diverso da Claude) + STEP C (Layer Stack L0-L11 completo PRODUCTION) + STEP D (validazione esterna terzi). A/B/C in parallelo, D presuppone A+C. Cita debito tecnico Mission Engine (state machine HOME vs MISSION_REGISTRY repo) e fix via `.oracode/project.json` descrittore (mission OS3 dedicata da aprire).
- **Sezioni chiave**: §0 Punto arrivo | §1 Stato | §2 STEP A/B/C/D | §5 Cronologia 2026-05-22 + 2026-05-26 (sessione 2 simulazione Poli)

---

## TIER 2 — Sistema Nervoso + Guard Testing

### `LSO_GUARD_TESTING_PROTOCOL_v1.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/lso/LSO_GUARD_TESTING_PROTOCOL_v1.md`
- **Status**: ❌ — 383 righe
- **Sintesi**: TBD — protocollo testing guard/hook

### `LSO_GUARD_TESTING_PROTOCOL_INDEX.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/lso/LSO_GUARD_TESTING_PROTOCOL_INDEX.md`
- **Status**: ❌ — 104 righe (sintesi)
- **Sintesi**: TBD

---

## TIER 3 — Boot context paradigma + template

### `oracode/CLAUDE.md`
- **Path**: `/home/fabio/oracode/CLAUDE.md`
- **Status**: ❌ — 50 righe (boot context repo oracode)
- **Sintesi**: TBD

### `os3-matrix/CLAUDE.md`
- **Path**: boot context del motore (OS3 Matrix, privato)
- **Status**: ❌ — 33 righe
- **Sintesi**: TBD

### `os3-matrix/CLAUDE_OS3_MATRIX_TEMPLATE.md`
- **Path**: template boot context istanze (OS3 Matrix, privato)
- **Status**: ❌ — 174 righe
- **Sintesi**: TBD — template boot context per istanze che usano OS3 Matrix

### `templates/CLAUDE_ORACODE_CORE.md`
- **Path**: `/home/fabio/oracode/templates/CLAUDE_ORACODE_CORE.md`
- **Status**: ✅
- **Sintesi**: Boot context paradigma incluso via `@CLAUDE_ORACODE_CORE.md` in CLAUDE.md istanze. OSZ kernel, REGOLA ZERO, 6+1 pilastri, 13 P0, P0-13 4 fasi, Strategia Delta, Firma OS3, Pattern CEO/CTO, **Dottrina del Supervisor** (5 riflessi; pool grounded = esecutore default — M-NEXUS-007, CORE 1.2.0), Mission Protocol sintesi, Trigger Matrix DOC-SYNC, Tag commit, Soglie git safety, Checklist pre-risposta, Ultra libs, Layer Stack L0-L11, Protocollo epistemologico spawn agenti, Asse Difesa Costitutivo Egida.
- **Versione/data**: CORE 1.2.0 — 2026-06-09 (M-NEXUS-007: Dottrina del Supervisor)

### `templates/CLAUDE_PROJECT_TEMPLATE.md`
- **Path**: `/home/fabio/oracode/templates/CLAUDE_PROJECT_TEMPLATE.md`
- **Status**: ✅
- **Sintesi**: Template istanza progetto con placeholder {{...}} (PROJECT_NAME, COMPANY_NAME, DOMAIN_DESCRIPTION, ORACODE_LEVEL, CEO_NAME, CTO_NAME, BACKEND/FRONTEND/DATABASE/INFRA, TARGET_LANGUAGES, ORGANS_MAP per livello 4, DOMAIN_P0_RULES).

### `templates/MISSION_TYPES_BASE.json`
- **Path**: `/home/fabio/oracode/templates/MISSION_TYPES_BASE.json`
- **Status**: ✅
- **Sintesi**: Tassonomia universale tipi mission. 11 types: feature/fix/refactor/doc-sync/guard/infrastructure/migration/compliance/bootstrap/epic/oracode-audit. Estendibile per istanza via `MISSION_TYPES.json` con campo `extends`.

---

## TIER 4 — OS3 Sistemi (subdir) — DA DISCOVERARE CONTENUTO

Discovery OS3 subdir: **6 file Moduli + Executive Summary**:
- `00_OS3_Executive_Summary.md` (271 r) ✅ letto
- `01_Modulo_0_Il_Manifesto_OS3.md` (320 r) ✅ letto
- `02_Modulo_1_I_6_Pilastri_Cardinali.md` (516 r) ❌
- `03_Modulo_2_REGOLA_ZERO.md` (490 r) ❌
- `04_Modulo_3_Sistema_Priorita_P0_P3.md` (559 r) ❌
- `05_Modulo_4_TOON_Format_Standard.md` (393 r) ❌

Discovery OS4 subdir: 1 file principale:
- `OS4_FOUNDATION_DOCUMENT.md` (394 r) ❌

Archive (storico):
- `Oracode_Systems/_archive/OS3_OS4_REFERENCE_GUIDE.md` (465 r) ❌
- `_archive/Part I-IV...` + `FRAMMENTI_COSCIENZA_EVOLUTIVA.md` + altri 6 file

00_ECOSISTEMA.md path REALE confermato:
- `/home/fabio/EGI-DOC/docs/egi-hub/00_ECOSISTEMA.md` (214 r) ✅ letto — vive sotto organo egi-hub (istanza FlorenceEGI)

### `00_ECOSISTEMA.md` (egi-hub)
- **Path**: `/home/fabio/EGI-DOC/docs/egi-hub/00_ECOSISTEMA.md` (istanza FlorenceEGI)
- **Status**: ✅ (letto integrale, 214 righe)
- **Versione/data**: v2.0.1 — 2026-03-25
- **Sintesi**: FlorenceEGI (caso esemplare d'istanza) come **protocollo economico**, non piattaforma. EGI = `Wrapper<T> + Regole + Audit + Valore` (contenitore tipizzato, NON NFT). Progetti orbitanti = istanze di oggetti con interfacce comuni (sostituibili, scollegabili, aggiornabili) — **SOLID applicato a ecosistema**. Giunture = API contract, Payment contracts, EGI schema, Wallet protocol, Audit protocol, AI gateway. AI come Sistema Nervoso Digitale (governatori/validatori/regolatori di flusso). 6 pattern fusi in una ontologia: Microservizi + Factory + DI + Policy engines + Event sourcing + AI agents. **Stato doc**: molti campi "DA COMPLETARE".
- **Sezioni chiave**: §1 Natura protocollo | §2 EGI wrapper | §3 Progetti orbitanti SOLID | §4 Giunture interfacce | §5 AI regolatori | §6 Pattern architetturali

### `OS3/00_OS3_Executive_Summary.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/execution/OS3/00_OS3_Executive_Summary.md`
- **Status**: ✅ (letto integrale, 271 righe)
- **Versione/data**: v3.0.0 — Novembre 2025 — Foundation Document
- **Sintesi**: Executive summary OS3. **Innovazioni distintive**: REGOLA ZERO (Settimo Pilastro) + Sistema P0-P3 + 7 Regole P0 Blocking (P0-1..P0-7, antecedente alle 13 P0 attuali) + Partnership Model CEO/CTO + Implementation Patterns ULM/UEM/GDPR. **6+1 Pilastri Cardinali**: 1 Intenzionalità Esplicita / 2 Semplicità Potenziante / 3 Coerenza Semantica / 4 Circolarità Virtuosa / 5 Evoluzione Ricorsiva / 6 Sicurezza Proattiva + 7 REGOLA ZERO. ROI medio: Qualità +85%, Velocità +40%, Bug prod -70%, Compliance da 40% a 95%. Struttura White Paper Moduli 0-10.
- **Sezioni chiave**: §Innovazioni 1-5 | §6+1 Pilastri | §Quando usare | §Quick Start | §Risultati misurabili | §Struttura White Paper

### `OS3/01_Modulo_0_Il_Manifesto_OS3.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/execution/OS3/01_Modulo_0_Il_Manifesto_OS3.md`
- **Status**: ✅ (letto integrale, 320 righe)
- **Versione/data**: v3.0.0 — Novembre 2025
- **Sintesi**: Manifesto OS3. **Trauma fondante**: "L'AI non pensa. Predice. Non deduce logicamente. Completa statisticamente." Sample Fabio: "Mi diceva che un metodo esisteva. Con sicurezza. Con esempi. L'ho implementato. Tutto compilava. Solo a runtime ho scoperto: quel metodo non esisteva. L'aveva inventato." OS3 rifiuta dicotomia Velocità OR Affidabilità. **Evoluzione OS1 (2023, filosofia) → OS2 (2024, 6 Pilastri + 12 Derivati) → OS3 (2025, Execution Engine)**. 3 innovazioni rivoluzionarie: REGOLA ZERO + Sistema P0-P3 + Partnership Model. Esempio pre/post REGOLA ZERO. Statistics: errori assunzione 40%→5%, debug 6-8h→1-2h, trust developer 30%→95%.
- **Sezioni chiave**: §Trauma | §Evoluzione OS1→OS2→OS3 | §3 innovazioni | §Promessa per ruolo (Developer/CTO/CEO/PA)

### `Oracode_Systems/PADMIN_IDENTITY_OS3_*` (5 file)
- **Path**: `/home/fabio/oracode/docs/paradigm/padmin/PADMIN_IDENTITY_OS3_*.md`
- **Status**: ❌
- **Sintesi**: TBD — identità Padmin OS3 in 5 file (CORE, INDEX, INTEGRATION_GUIDE, P1_PRINCIPLES, P2_PATTERNS, P3_REFERENCE)

### `Oracode_Systems/PDTDP_Paradigma_Torre_di_Pisa.md`
- **Path**: `/home/fabio/oracode/docs/paradigm/padmin/PDTDP_Paradigma_Torre_di_Pisa.md`
- **Status**: ❌ — 235 righe
- **Sintesi**: TBD — paradigma "Torre di Pisa" (?)

---

## TIER 5 — Pipeline + Council + Specifici

### `EGI_DOC_PIPELINE.md`
- **Path**: `/home/fabio/EGI-DOC/docs/oracode/EGI_DOC_PIPELINE.md`
- **Status**: ❌ — 292 righe
- **Sintesi**: TBD

### `COUNCIL_MIGRATION_PLAN.md`
- **Path**: `/home/fabio/EGI-DOC/docs/oracode/COUNCIL_MIGRATION_PLAN.md`
- **Status**: ❌ — 368 righe
- **Sintesi**: TBD

### `Enterprise/` (FASE1_HEALTH_CHECK, FASE2_DISASTER_RECOVERY)
- **Path**: `/home/fabio/EGI-DOC/docs/oracode/Enterprise/`
- **Status**: 🗂️ (specifico)

### `Fortino/` (5 file: ORGANO, GUARDIANO, DOTTRINA, HANDOFF, M-195)
- **Path**: `/home/fabio/EGI-DOC/docs/oracode/Fortino/`
- **Status**: 🗂️ (organo specifico FlorenceEGI)

---

## TIER 6 — Agenti & Slash commands (modello)

Il **flusso operativo pubblico** è la catena di slash command globali: `/discovery` (acquisizione)
→ `/project` (bootstrap istanza, scaffolda `.oracode/project.json`) → `/mission` (lifecycle mission,
auto-registrato L1→L3). Gli **agenti** specializzati (audit, gate, diagnostica, DOC-SYNC, dominio)
sono coordinati dal Supervisor; la **fonte versionata** e l'inventario concreto (roster, deploy,
destinazioni) sono `visibility:private` nell'OS3 Matrix — SSOT `oracode-nexus-index-impl`.
Confine mono (M-OS3-048).

## TIER 7 — Tool scripts paradigma

### `~/oracode-engine/` — cartella globale L1 (VISIBILE)
- **Path**: `/home/fabio/oracode-engine/`
- **Status**: ✅ (M-OS3-025 U1 FATTO; ex `~/.oracode` nascosta, symlink di compat presente)
- **Natura**: L1 = scratch runtime del motore (NON un registro versionato). Contiene: `missions/` (stato runtime per-mission), `focus/` (focus per-session, M-OS3-016), `audit/` (task-invocations.jsonl spawn fingerprint), `state/`, `license.json`. Il primo vero MISSION_REGISTRY è L2 (HUB).

> **Inventario tooling privato (M-OS3-048).** I tool Python operativi (mission engine,
> retrospective, RAG reindex/query, coverage, quality-gate executor, organ-index, ssot-audit)
> vivono nell'enforcement OS3 Matrix (repo privato) — inventario path concreto nel SSOT
> `visibility: private` `oracode-nexus-index-impl`. Confine mono.

| Tool pubblico | Path | Scopo | Status |
|---|---|---|---|
| `cli.js` | `/home/fabio/oracode/bin/cli.js` (npx oracode init) | Bootstrap nuovo progetto Oracode | 🟡 |

---

## TIER 8 — Hook globali

42 hook totali governano Mission Protocol, sicurezza e DOC-SYNC (state-guard, spawn-fingerprint,
trigger-matrix, UEM guard, quality gate, ecc.). **Inventario hook concreto** (nomi, versioni,
wiring) → SSOT privato `oracode-nexus-index-impl` (OS3 Matrix). Confine mono — M-OS3-048.

## TIER 9 — Mission/design documenti OS3 Matrix

I documenti di design e sessione dell'enforcement (deliverable
mission, backlog, timing/handoff di sessione) sono **privati** — inventario nel SSOT
`oracode-nexus-index-impl` (OS3 Matrix). Confine mono — M-OS3-048.

---

## Cross-Reference tematici

### Flusso operativo Nexus (punto d'ingresso reale)
1. `/discovery` — acquisizione nuovo progetto/cliente
2. `/project` — bootstrap istanza: scaffolda `.oracode/project.json` (descrittore L3) + installa la **difesa Egida-by-default** per i progetti con Matrix (liv 2+) — operazionalizza l'Asse Difesa Costitutivo (M-NEXUS-005) via `EGIDA_INSTALL_CONTRACT §6`: `/oracode-configure` Q8 sceglie `egida_profile` (`L1`/`L2-L3`/`L3-L4`, upgrade a `L3-L4` per organi denaro/PII/blockchain), `/oracode-scaffold` step 6b scaffolda `SECURITY_INVARIANTS.json` (target `<PLACEHOLDER>`) + scrive `egida_gate`/`egida_profile` nel descrittore. L1 paradigm-only senza Matrix: nessuna difesa-by-default ("dove ha senso"). [M-NEXUS-006 E5]
   - **Step 5b — censimento registry nell'indice Nexus (M-FUC-029, forzante f.1):** `/oracode-scaffold` censisce il nuovo `SSOT_REGISTRY.json` appena compilato nell'indice Nexus dei registry (`os3-matrix/contracts/ssot-registry-index.json`, entry completa `instance`/`instance_root`/`registry_path`/`registry_schema: "documents"`/`scope`/`organs_covered`/`export`/`status: "active"`/`added_by_mission`) e richiede `os3-matrix/bin/ssot-index-check` verde (exit 0) PRIMA di proseguire — **nessun registry nasce orfano**.
3. `/mission` — wrapper GLOBALE context-aware del Mission Engine: rileva l'istanza dal CWD e auto-registra la mission nel MISSION_REGISTRY del progetto via ponte L1→L3

### Mission lifecycle (FASE 0 → FASE 6)
1. `MISSION_PROTOCOL.md` (canonical) → `/mission` (CLI) + guard di stato mission (hook privato)
2. FASE 0: prenotazione ID + commit immediato → richiede MISSION_REGISTRY canonical schema
3. FASE 1: bootstrap mirato → `MISSION_BOOTSTRAP_INDEX.json` per (`type`, `organs`) — chiavi canoniche INGLESI (`tipo_missione`/`organi_coinvolti` = legacy EGI-DOC), come fissato in `ORACODE_NEXUS_3_TIER.md` §Lingua chiavi
4. FASE 4: Web Quality Gate trigger se deliverable web
5. FASE 6: 8 step → `doc-sync-v2` agent + `mission_retrospective.py` + `enrich_registry.py`

### DOC-SYNC v2 (Layer 2 Deep Audit / Layer 8 Nervous System)
1. `DOC-SYNC_v2_SPECIFICA_OPERATIVA.md` (spec)
2. `DOC-SYNC_v2_PIANO_IMPLEMENTATIVO.md` (impl plan)
3. `DOC-SYNC_v2_STATO_DELLARTE.md` (stato attuale)
4. `agents/doc-sync-v2.md` (agent OS3 Matrix)
5. `SSOT_REGISTRY.json` (input watches)
6. `COVERAGE_CONFIG.json` (soglie + cron)
7. Executors RAG/coverage nell'enforcement privato (OS3 Matrix); `rag_natan_coverage.py` citato in COVERAGE_CONFIG = nome legacy istanza FlorenceEGI. Path: SSOT privato `oracode-nexus-index-impl`

### Nomenclatura / 4 Livelli
1. `LSO_NOMENCLATURE_v2.md` (canonical integrale)
2. `LSO_NOMENCLATURE_INDEX.md` (sintesi sempre disponibile)
3. `proposals/M-NOMENCL-OSMX-002_DELTA.md` (proposta distinzione §1.1.A/B paradigma vs matrix — in attesa CEO approval)
4. `00_LSO_LIVING_SOFTWARE_ORGANISM.md` + `MANIFESTO_LSO.md`

### Padmin AI identità
1. `PADMIN_INDEX.md` (briefing executive)
2. `PADMIN_ONBOARDING.md` (manuale esteso)
3. `PADMIN_AI_IDENTITY.md` (identità sostantiva)
4. `Oracode_Systems/PADMIN_IDENTITY_OS3_*` (5 file)

### Triade OSZ → OS3 → OS4
1. `ORACODE_NEXUS_SYSTEM_REFERENCE.md` (§1 sintesi)
2. `Oracode_Systems/00_OSZ_ORACODE_SYSTEM_ZERO.md` (OSZ kernel)
3. `Oracode_Systems/OS3/` (livello execution)
4. `Oracode_Systems/OS4/` (livello educazione)

### Standard ecosystem
1. `NAMING_STANDARD_CODE.md` (PHP/Python/TS)
2. `WEB_PAGE_QUALITY_GATE.md` (web qualità)
3. `LEGACY_STACK_POLICY.md` (Strategia Delta concretizzata)
4. `LSO_GUARD_TESTING_PROTOCOL_v1.md` (guard testing)

---

## Memory feedback salvate per Padmin Supervisor

3 file in `/home/fabio/.claude/projects/-tmp-oracode/memory/`:
- `feedback_no_quick_fix.md` — mai proporre "fix veloce"
- `feedback_concurrency_os3_012.md` — multi-write bug noto (CLOSED M-OS3-016)
- `feedback_mai_contraddire_ceo.md` — leggere design prima di obiettare

Aggiungere:
- `feedback_oracode_nexus_3_tier.md` — architettura HUB + istanze LSO (CEO chiarimento 2026-05-27)
- `feedback_lso_richiede_mission_registry.md` — istanza LSO DEVE avere proprio MISSION_REGISTRY (correzione mia errata)
- `feedback_nexus_index_anti_degradazione.md` — esiste questo index per navigare paradigma

---

## TODO Padmin (auto-update progressivo durante lettura)

- [ ] Leggere TIER 1A (4 doc kernel/paradigma)
- [ ] Leggere TIER 1B (LSO_NOMENCLATURE_v2 1270 righe + INDEX)
- [ ] Leggere TIER 1D (DOC-SYNC v2 3 doc, 1710 righe tot)
- [ ] Leggere TIER 1E (PADMIN_ONBOARDING + PADMIN_AI_IDENTITY + LEGACY_STACK_POLICY)
- [ ] Leggere TIER 2 (LSO_GUARD_TESTING_PROTOCOL)
- [ ] Leggere TIER 3 (boot context oracode + os3-matrix CLAUDE.md)
- [ ] Leggere TIER 4 selettivo (OS3/ OS4/ subdir)
- [ ] Leggere TIER 6 selettivo (agent definitions vitali)
- [ ] Leggere TIER 7 selettivo (tool scripts vitali)
- [ ] Verificare quali hook TIER 8 esistono davvero (inventario privato)
- [ ] Aggiornare index per ogni file letto con sintesi 3-5 righe + sezioni chiave
- [ ] Salvare 3 memory feedback nuove
- [ ] Riformulare M-OS3-021 epic con quadro completo

---

**Versione index**: 0.6.3 — 2026-06-12 (M-FUC-029: scaffold step 5b — censimento del nuovo `SSOT_REGISTRY.json` nell'indice Nexus dei registry `os3-matrix/contracts/ssot-registry-index.json` + `ssot-index-check` verde prima di proseguire; forzante f.1 ADR M-FUC-029, D1-D8 firmate CEO — "nessun registry nasce orfano". Storico 0.6.2 — 2026-06-09: M-NEXUS-007 Dottrina del Supervisor — promossa dal CLAUDE.md locale Fucina al kernel paradigma `CLAUDE_ORACODE_CORE.md` in versione generica (CORE 1.1.0→1.2.0, si diffonde a tutti i progetti via `@import`); aggiunta alle Decisioni LOCKED + sintesi CORE template aggiornata. Storico 0.6.1 — 2026-06-08: M-NEXUS-006 E5 Egida difesa-by-default operazionalizzata nel bootstrap `/project` — `egida_profile` da `/oracode-configure` Q8, `SECURITY_INVARIANTS.json` + `egida_gate`/`egida_profile` da `/oracode-scaffold` step 6b. Storico 0.6.0 — 2026-06-08: M-NEXUS-005 Asse Difesa Costitutivo Egida aggiunto alle Decisioni LOCKED. Storico 0.5.0 — 2026-05-31: audit post-M-OS3-025, Nexus 3-livelli allineato — engine visibile, /mission globale, ponte L1→L3 FATTI; path tool e chiavi registry inglesi verificati alla fonte)
**Documenti letti integrali totali**: 18 — TIER 1A/B/C/D/E/F principali completi
**Documenti TBD vitali ancora da leggere**:
- TIER 1D: `DOC-SYNC_v2_SPECIFICA_OPERATIVA.md` (629 r)
- TIER 1D: `DOC-SYNC_v2_PIANO_IMPLEMENTATIVO.md` (919 r)
- TIER 1A: `ORACODE_PARADIGM_v2_draft.md` (790 r)
- TIER 1E: `PADMIN_ONBOARDING.md` (463 r)
- TIER 1E: `PADMIN_AI_IDENTITY.md` (382 r)
- TIER 1F: `OS3_Moduli_02_03_04_05.md` (1958 r)
- TIER 1F: `OS4_FOUNDATION_DOCUMENT.md` (394 r)
- TIER 2: `LSO_GUARD_TESTING_PROTOCOL_v1.md` + INDEX (487 r)
- TIER 3: oracode + os3-matrix CLAUDE.md (~257 r totali)
- TIER 6: agent definitions (selettivo)
- TIER 7: tool scripts (selettivo)

---

## CONVERGENZE STRUTTURALI EMERSE (cosa serve sapere subito per M-OS3-021)

### 1. **Dual-tracking Mission Registry — fix FATTO (ponte automatico L1→L3)**
Il fix architetturale previsto da DUE documenti è stato implementato:
- `ROADMAP_ORACODE.md §5` (22 mag) → "candidato a mission OS3 dedicata" per `.oracode/project.json`
- `DOC-SYNC_v2_STATO_DELLARTE.md §5` (15 mag) → `bin/mission` legge `.oracode/project.json` del progetto attivo e propaga automaticamente le transizioni

**Stato: ✅ FATTO** in **M-OS3-025 Unità 3** (commit 8760c5d): `bin/mission` → `syncToRepoRegistry(state)` risolve `.oracode/project.json` dal CWD e propaga lo stato della state machine (L1, `~/oracode-engine`) → MISSION_REGISTRY del progetto (L3), parallel-safe. La separazione netta L1 (motore/scratch) vs L2 (HUB, primo vero registro) vs L3 (istanza) scioglie anche il conflitto-nome M-OS3-014: non è più una questione aperta.

### 2. **DOC-SYNC v2 è MOLTO più articolato di quello che usavo**
v2.1.0 in produzione include:
- Coverage Native con soglie per organo (COVERAGE_CONFIG.json)
- Cron settimanale (`docsync_weekly_reglob.py`, NON schedulato — gap basso)
- 3 CLI Python (reindex + query + coverage)
- Hook coverage-check-precheck PreToolUse + ssot-reflex-guard PostToolUse + doc-sync-v2-guard PreToolUse Bash 2-livelli (cutoff M-149 + M-160a)
- History JSONL append-only
- Metriche produzione 136 mission processate, 39.3% coverage ecosistema

### 3-4. **Inventario hook/agenti/tooling — privato**
L'ecosistema enforcement (27+ hook, 10 agenti, tooling Python canonico) è operativo. L'**inventario
concreto** (nomi, path `bin/`, versioni) è `visibility: private`: SSOT `oracode-nexus-index-impl`
(OS3 Matrix). Confine mono — M-OS3-048. Qui resta solo il *modello*: enforcement meccanico
multi-livello (PreToolUse/PostToolUse), agenti specializzati, tool Python deterministici.

### 5. **REGOLA ZERO è il breakthrough cardine**
Da OS3 Manifesto (Modulo 0): "L'AI non pensa. Predice. Non deduce. Completa statisticamente." REGOLA ZERO = contromisura strutturale. **In OS3 originale v3.0.0 (Nov 2025) erano 7 Regole P0**. Sono evolute in **13 P0** nel paradigma corrente (visibile in CLAUDE_ORACODE_CORE.md).

### 6. **OS3 è solo l'enforcement, NON tutto**
Triade OSZ/OS3/OS4:
- **OSZ** = organismo (cosa stiamo costruendo) — kernel costituzionale immutabile
- **OS3** = come AI lo costruisce (REGOLA ZERO, P0-P3, partnership)
- **OS4** = come umani lo usano (ASSIOMA 0, TSM Truth Source Manager, RI Reliability Index)

Importante per M-NOMENCL-OSMX-002: "Esiste solo OS3 Matrix" — no OS4 Matrix né OSZ Matrix (OS4 opera sull'umano = no gate meccanici, OSZ è costituzionale = non si enforcea, è).

### 7. **Layer Stack L0-L11 con maturity FlorenceEGI**
Solo **L4 PRODUCTION** sola, L1-L8 PARTIAL, L9 DESIGN, L10 CONCEPT, L11 VISION.
**Soglia L8→L9 è la frontiera attuale**. **Vincolo L9**: operativo SOLO se disaccoppiato dagli LLM esterni (auto-osservazione che dipende da LLM esterno = interpretazione esterna travestita).

---

## File NUOVI scoperti durante Batch 1 (da aggiungere a discovery)

| File citato | Vivo dove? | Priorità |
|---|---|---|
| `EGI-DOC/docs/00_ECOSISTEMA.md` (istanza FlorenceEGI) | EGI-DOC root docs/ (citato da OSZ) | ALTA — dettaglio bio-architettura OSZ |
| `Oracode_Systems/OS3/00_OS3_Executive_Summary.md` | da verificare path | ALTA |
| `Oracode_Systems/OS3/03_Modulo_2_REGOLA_ZERO.md` | da verificare path | ALTA — il breakthrough |
| `Oracode_Systems/OS3/04_Modulo_3_Sistema_Priorita_P0_P3.md` | da verificare path | ALTA |
| `Oracode_Systems/OS4/OS4_FOUNDATION_DOCUMENT.md` | da verificare path | ALTA |
| Tool RAG (re-index/query) | enforcement privato (OS3 Matrix); `rag_natan_*` = nomi storici istanza | MEDIA |
| Hook Sistema Nervoso (reflex L1, cron staleness L3, deep-audit L2) | inventario privato (OS3 Matrix) | MEDIA |
| `CLAUDE_ECOSYSTEM_CORE.md` + `CLAUDE_ECOSYSTEM_REF.md` | ogni organo `/home/fabio/*/` | MEDIA — boot context organi |
| `EGI-DOC/contracts/*.json` (7 contratti L7, istanza FlorenceEGI) | EGI-DOC/contracts/ | MEDIA |
| Schema DB `rag_<istanza>.*` (es. `rag_natan` su FlorenceEGI) | DB condiviso | BASSA (specifico istanza FlorenceEGI) |
