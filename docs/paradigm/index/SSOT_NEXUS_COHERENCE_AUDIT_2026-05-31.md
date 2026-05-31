# SSOT Nexus Coherence Audit — 2026-05-31

> Generato dal team (14 agenti audit + sintesi). 74 finding su 28 doc.
> Verità di riferimento: ORACODE_NEXUS_3_TIER.md

# CONSOLIDAMENTO AUDIT SSOT — Lista Modifiche per Documento

> Input: 14 cluster, 74 finding espliciti (+ nexus_framing per cluster).
> Tre filoni dominanti: (A) "7 Regole P0" obsolete vs 13 canoniche; (B) chiavi registry italiane vs INGLESE locked; (C) `~/.oracode` + "sync manuale" vs `~/oracode-engine` + ponte L1→L3 automatico FATTO.

---

## 1. SOMMARIO

**Documenti impattati: 28** (su ~40 doc paradigma auditati).

### Per severità
| Severità | N. finding |
|----------|-----------|
| **ALTA** | 31 |
| **MEDIA** | 30 |
| **BASSA** | 13 |
| **Totale** | 74 |

### Per tipo
| Tipo | N. | Significato |
|------|----|-----|
| **drift-codebase** | 30 | Doc descrive path/comportamento che non esiste più (`~/.oracode`, sync manuale, path tool errati, "7 regole") |
| **missing-nexus-framing** | 26 | Doc non inquadra il contenuto dentro Oracode Nexus / 3 livelli |
| **incoherence-ssot** | 18 | Doc contraddice direttamente la legge (chiavi IT vs EN, numero P0, mappatura pilastri) |

### Tre famiglie di drift trasversali (toccano quasi tutti i doc)
1. **"7 Regole P0"** → 13 Regole P0 Universali (kernel OSZ, OS3 Summary, Manifesto, Modulo 3, TOON) — 4 finding ALTA + propagazione.
2. **Chiavi registry italiane** (`tipo_missione`, `organi_coinvolti`, `data_apertura`, `stato`) → INGLESE (`type`, `organs`, `date_open`, `status`) — 11 finding su 7 doc.
3. **`~/.oracode` + sync manuale + "ponte futuro/candidato"** → `~/oracode-engine` (visibile, L1) + ponte L1→L3 AUTOMATICO FATTO (M-OS3-025 U3) — ~14 finding su 9 doc.

---

## 2. INCOERENZE CROSS-SSOT (le più gravi)

Doc che si contraddicono tra loro o con `ORACODE_NEXUS_3_TIER.md` (la LEGGE locked). Da risolvere PRIMA, perché propagano errore.

### CROSS-A — "7 Regole P0" vs "13 Regole P0 Universali"
La legge è `templates/CLAUDE_ORACODE_CORE.md` → **13 P0**. Contraddetta da:
- `kernel/00_OSZ_ORACODE_SYSTEM_ZERO.md` ("7 regole sacre", "REGOLA ZERO il Settimo Pilastro")
- `execution/OS3/00_OS3_Executive_Summary.md` (sezione "Le 7 Regole P0 Blocking", ripetuto)
- `execution/OS3/01_Modulo_0_Il_Manifesto_OS3.md` ("7 Regole P0 Blocking")
- `execution/OS3/04_Modulo_3_Sistema_Priorita_P0_P3.md` (**FONTE del "7"**: definisce il numero e lo argomenta — "Perché Così Poche?")
- `execution/OS3/05_Modulo_4_TOON` (mappatura pilastri errata: "Pilastro 3 = Eccellenza", "Pilastro 6 = Partnership" → corretti: Coerenza Semantica / Sicurezza Proattiva)

**Ordine di fix**: prima Modulo 3 (fonte), poi i 4 doc che propagano.

### CROSS-B — Chiavi registry ITALIANO vs INGLESE (decisione CEO 2026-05-30, locked)
La legge: chiavi `id/title/type/organs/status/date_open/date_close`; italiano EGI-DOC = LEGACY. **Due doc dicono l'esatto contrario** (vietano l'inglese):
- `lso/LSO_GUARD_TESTING_PROTOCOL_INDEX.md` §4: "tutti i nuovi SSOT in italiano"; §7 anti-pattern: "naming inglese vietato"
- `lso/LSO_GUARD_TESTING_PROTOCOL_v1.md` §4.1/4.2: impone italiano come policy vincolante
- `padmin/PADMIN_ONBOARDING.md` AP-5: "naming inglese vietato d'ora in avanti"

E **9 doc usano chiavi italiane come canoniche**: `missions/MISSION_PROTOCOL.md`, `ssot/00_ORACODE_SYSTEM_SSOT.md` (§18.1), `standards/WEB_PAGE_QUALITY_GATE.md`, `tech-specs/READ_TRACKING_TECH_SPEC.md`, `tech-specs/RETROSPECTIVE_TECH_SPEC.md`, `roadmap/ORACODE_PARADIGM_v2_draft.md`, `index/Oracode-Nexus-index.md`, `nomenclature/LSO_NOMENCLATURE_v2.md`, `README.md` (`mission_id`→`id`).

**Rischio concreto**: un guard costruito seguendo la policy italiana cercherebbe `data_chiusura`/`stato` in un registry che oggi contiene `date_close`/`status` → riproduce il bug M-148 a polarità invertita. **La policy oggi GENERA il drift che pretende di prevenire.**

### CROSS-C — Sync manuale state↔registry vs Ponte L1→L3 AUTOMATICO (FATTO)
La legge + codice (`os3-matrix/bin/mission` righe 373/554/915-973, `syncToRepoRegistry`, parallel-safe via lockfile, M-OS3-025 Unità 3 commit `8760c5d`): **ponte automatico FATTO**. Contraddetto come "manuale oggi / automatico domani / candidato" da:
- `nomenclature/LSO_NOMENCLATURE_v2.md` §3.1.A.12
- `missions/MISSION_PROTOCOL.md` FASE 0
- `ssot/00_ORACODE_SYSTEM_SSOT.md` §18
- `padmin/PADMIN_INDEX.md` §5bis
- `doc-sync/DOC-SYNC_v2_STATO_DELLARTE.md` §5 (cita "M-OS3-014 candidato" → è M-OS3-025 FATTO)
- `roadmap/ROADMAP_ORACODE.md` §5 + `roadmap/ORACODE_PARADIGM_v2_draft.md` Macroarea 4 §10
- `index/Oracode-Nexus-index.md` (CONVERGENZE righe 611-617)
- `tech-specs/RETROSPECTIVE_TECH_SPEC.md` §2 ("comando esplicito" vs finalize automatico)

### CROSS-D — Path cartella globale `~/.oracode` (nascosta) vs `~/oracode-engine` (visibile, L1)
`ORACODE_HOME = ~/oracode-engine` (`bin/mission` riga 31); `~/.oracode` = solo symlink di compat. Doc che citano `~/.oracode` come canonico: `LSO_NOMENCLATURE_v2.md`, `MISSION_PROTOCOL.md` §10, `00_ORACODE_SYSTEM_SSOT.md` §18bis, `PADMIN_INDEX.md` §5bis, `DOC-SYNC_v2_STATO_DELLARTE.md` §5, `ORACODE_PARADIGM_v2_draft.md` §10, `Oracode-Nexus-index.md`, `00_LSO_LIVING_SOFTWARE_ORGANISM.md`.

### CROSS-E — Path tool errati (P0-12 Anti-Infra-Invention)
`/home/fabio/oracode/bin/` contiene SOLO `cli.js`. Doc che citano script inesistenti lì:
- `mission_retrospective.py` → reale: `os3-matrix/bin/mission_retrospective.py` (in `MISSION_PROTOCOL.md` §6.2, `RETROSPECTIVE_TECH_SPEC.md` §1/§2)
- `organ_index.py` → reale: `os3-matrix/bin/organ_index/` (in `NAMING_STANDARD_CODE.md`)
- `rag_natan_*.py` → da verificare alla fonte, doc INDEX si auto-contraddice (riga 72 vs 633-640)
- `web_quality_gate.py` esiste in `os3-matrix/bin/` ma `WEB_PAGE_QUALITY_GATE.md` lo ignora

### CROSS-F — Path doc paradigma obsoleti (`/docs/Oracode_Systems/`, EGI-DOC) post M-OS3-022
- `kernel/00_OSZ...` cita `/docs/Oracode_Systems/...` (dir inesistente) e `00_ECOSISTEMA.md` (path morto)
- `ssot/00_ORACODE_SYSTEM_SSOT.md` tabella Riferimenti punta a `EGI-DOC/docs/oracode/...` per doc paradigma ora in `docs/paradigm/`
- `doc-sync/PIANO` cita `CLAUDE_ECOSYSTEM_CORE.md` → oggi `CLAUDE_ORACODE_CORE.md`

---

## 3. MODIFICHE PER DOCUMENTO

Ordinate per severità decrescente dentro ogni doc.

### `kernel/00_OSZ_ORACODE_SYSTEM_ZERO.md`
- **[ALTA]** Sez "OS3 - Spalletta Lato AI": "P0 (BLOCKING): 7 regole sacre" → "13 Regole P0 Universali. Violazione = STOP"; "REGOLA ZERO (Il Settimo Pilastro)" → "REGOLA ZERO (il +1 dei Pilastri 6+1, autorità superiore)".
- **[ALTA]** "DOCUMENTI FONDAMENTALI/RIFERIMENTO": riscrivere tutti i `/docs/Oracode_Systems/...` → `docs/paradigm/execution/OS3/{00_OS3_Executive_Summary,03_Modulo_2_REGOLA_ZERO,04_Modulo_3_Sistema_Priorita_P0_P3}.md` e `docs/paradigm/education/OS4_FOUNDATION_DOCUMENT.md`. Verificare/correggere `OS3_OS4_REFERENCE_GUIDE.md`.
- **[ALTA]** Doc #2 e learning path Passo 2: `00_ECOSISTEMA.md` è path MORTO — verificare col CEO se esiste/deprecato; rimuovere o sostituire.
- **[MEDIA]** Path autoreferenziale `/docs/00_OSZ_...` → `docs/paradigm/kernel/00_OSZ_ORACODE_SYSTEM_ZERO.md`.
- **[MEDIA]** Aggiungere dopo "COS'È OSZ" il framing Nexus (vedi §4).
- **[BASSA]** Aggiornare "STATO DELL'ARTE (Gennaio 2026)" → maggio 2026 (M-OS3-022, Nexus 3-tier, oracode-engine, ponte L1→L3); bump versione.

### `execution/OS3/04_Modulo_3_Sistema_Priorita_P0_P3.md` (FONTE del "7")
- **[ALTA]** "Le 7 Regole P0 Blocking" (P0-1..P0-7) → importare P0-8..P0-13 dal core. Riscrivere "Perché Così Poche?" (il vincolo non è "7" ma "poche, ciascuna da una cicatrice"). Tabella riga 184: "Numero regole 7" → "13".
- **[BASSA]** Aggiungere sez "P0-P3 nel contesto Oracode Nexus" (rimando a Trigger Matrix DOC-SYNC + Layer Stack L0-L11; P0-11/P0-13 = aggancio metabolismo L1/L6).

### `execution/OS3/00_OS3_Executive_Summary.md`
- **[ALTA]** Sez 3 + riga 73 + riga 245 + blocco "Attivazione AI Partner": "7 Regole P0 Blocking" → "13 Regole P0 Universali"; estendere elenco con P0-8..P0-13.
- **[MEDIA]** Struttura White Paper (Moduli 0-10): solo 0-4 esistono sul FS. Marcare Modulo 5-10 come "DA SCRIVERE/pianificati" o rimuovere rimandi operativi. Sanare incoerenza numerazione interna (riga 245 "Modulo 5" vs riga 73 "Modulo 4").
- **[MEDIA]** Aggiungere riquadro "OS3 dentro Oracode Nexus" in apertura (vedi §4).

### `execution/OS3/01_Modulo_0_Il_Manifesto_OS3.md`
- **[ALTA]** "7 Regole P0 Blocking" → "13 Regole P0 Universali" (sez OS3 Execution Engine + "Risposta di OS3"), mantenendo "violation = STOP".
- **[BASSA]** Partnership Model: genericizzare "FABIO CHERICI (CEO)"/"PADMIN D. CURTIS (CTO)" hardcoded → ruoli astratti, Fabio/Padmin come istanza di riferimento/autori. Allineare a "Modello Operativo CEO/CTO" del core.

### `execution/OS3/05_Modulo_4_TOON_Format_Standard.md`
- **[BASSA]** Sez Riferimenti Tecnici: rimuovere/astrarre path machine-local (`/home/fabio/NATAN_LOC/...`, `/docs/Progetti/...`) e riferimenti NATAN_LOC (viola purezza MIT). Verificare email maintainer `fabio@oracode.com`.
- **[BASSA]** Filosofia OS3: "Pilastro 3 (Eccellenza)" → "Pilastro 3 (Coerenza Semantica)"; "Pilastro 6 (Partnership)" → "Pilastro 6 (Sicurezza Proattiva)".

### `lso/LSO_GUARD_TESTING_PROTOCOL_v1.md`
- **[ALTA]** §4.1/§4.2: invertire policy → chiavi INGLESE (`date_close`, `status`, `mission_id`; stati `completed/closed/archived`). §4.3: SSOT italiani EGI-DOC migrano lazy verso EN. §7 anti-pattern 5 → "naming italiano in nuovi SSOT". §4.4 esempi header → campi EN (`stats.calculated_at`, `date_close`). Lasciare intatta dottrina test pos/neg, header, idempotenza.
- **[MEDIA]** §4.4/§1/§2: riquadrare M-148 come EVENTO STORICO (al 2026-04-30 registry era IT; lezione coerenza valida ma oggi campi canonici sono EN).

### `lso/LSO_GUARD_TESTING_PROTOCOL_INDEX.md`
- **[ALTA]** §4: "tutti i nuovi SSOT in italiano" → INGLESE (per ORACODE_NEXUS_3_TIER.md). §7 anti-pattern 5: "naming italiano in nuovi SSOT — vietato". Mantenere Criterio 2 (coerenza campi letti = reali).

### `lso/00_LSO_LIVING_SOFTWARE_ORGANISM.md`
- **[MEDIA]** Aggiungere box "un LSO = ISTANZA L3 di Oracode Nexus" (vedi §4); generalizzare "FlorenceEGI" → "un LSO", FlorenceEGI come prima istanza.
- **[MEDIA]** Tabella tool: correggere path `~/oracode/bin/rag_natan_*.py` (verificare alla fonte). Sez Layer 2 Propriocezione: sostituire "sincronizzazione manuale / unico registry EGI-DOC" con ponte automatico L1→L3 (parallel-safe).

### `lso/MANIFESTO_LSO.md`
- **[—]** (nessun finding esplicito) Aggiungere solo paragrafo nominale "un LSO vive come istanza L3 dentro Oracode Nexus" (vedi §4). Non appesantire con path.

### `nomenclature/LSO_NOMENCLATURE_v2.md`
- **[ALTA]** §3.1.A.12 riga 558: `~/.oracode/missions/<ID>/state.json` → `~/oracode-engine/...`; sostituire "sincronizzazione manuale / debito noto / candidata a mission" con stato ATTUALE automatico (ponte L1→L3, M-OS3-025 U3); rimuovere "manuale oggi/automatica domani".
- **[MEDIA]** Stessa nota: aggiungere collocazione L3 ISTANZA + chiavi INGLESE + numerazione/statistiche = L2 HUB.
- **[MEDIA]** §1: aggiungere paragrafo che distingue asse CONCETTUALE (4 livelli) da asse OPERATIVO Nexus (3 livelli L1/L2/L3), ortogonali.

### `nomenclature/LSO_NOMENCLATURE_INDEX.md`
- **[MEDIA]** Aggiungere §1bis "Gerarchia operativa Oracode Nexus (3 livelli)" — è il glossario always-loaded al bootstrap, punto di massimo impatto. Una riga per L1/L2/L3 + "i due assi sono ortogonali. SSOT: ORACODE_NEXUS_3_TIER.md".

### `nomenclature/proposals/M-NOMENCL-OSMX-002_DELTA.md`
- **[BASSA]** Non riscrivere (artefatto storico pre-3-tier). Aggiungere in testa nota "⚠ Superseded-context" (precede Nexus 3-tier e ponte L1→L3) OPPURE spostare in `proposals/archived/`.

### `missions/MISSION_PROTOCOL.md`
- **[ALTA]** Sez 1 tabella + Sez 16: MISSION_REGISTRY trattato come solo "Istanza" → riscrivere su 3 livelli (L2 HUB registro primario con statistiche+numerazione globale; L3 istanza). Aggiungere riga HUB. Sede "EGI-DOC" → esempio neutro legacy accoppiato.
- **[ALTA]** Sez 3 FASE 0: rimuovere flusso manuale "leggi counter/incrementa/commit" → `bin/mission open <ID>`, registrazione AUTOMATICA via ponte L1→L3 (`.oracode/project.json`, CWD-resolved, lockfile); numerazione globale = HUB L2.
- **[ALTA]** Sez 4.1/4.3: chiavi IT → EN (`mission_id→id`, `titolo→title`, `data_apertura→date_open`, `stato→status`, `tipo_missione→type`, `organi_coinvolti→organs`, `cross_organo→cross_organ`). Nota: IT = legacy EGI-DOC.
- **[ALTA]** Sez 6.2 riga 263: `/home/fabio/oracode/bin/mission_retrospective.py` → `os3-matrix/bin/mission_retrospective.py` (preferibile: descrivere via `bin/mission finalize`).
- **[MEDIA]** Sez 10 riga 406/408: `~/.oracode/focus/<session_id>.json` → `~/oracode-engine/focus/...` (+ nota symlink compat).
- **[MEDIA]** Sez 6.1/16: path/organi EGI-DOC, EGI, NATAN_LOC, `FLORENCE_EGI_INSTANCE.md` → segnaposto generici `<istanza>-DOC/...`, `<ORGAN_A>`, marcati legacy.
- **[MEDIA]** Header + Sez 7-8: aggiungere rimando a ORACODE_NEXUS_3_TIER.md; precisare bin/mission = motore L1 (`os3-matrix`, ORACODE_HOME=`~/oracode-engine`) che auto-propaga a L3.

### `ssot/00_ORACODE_SYSTEM_SSOT.md`
- **[ALTA]** Dopo §1: nuova sez "1bis. Oracode Nexus — gerarchia a 3 livelli" (tabella L1/L2/L3). Rinviare a ORACODE_NEXUS_3_TIER.md. Bump version 1.3.0, date 2026-05-31.
- **[ALTA]** §18bis riga 557 + ogni `~/.oracode`: → `~/oracode-engine/focus/...` (+ nota migrazione U1, symlink compat).
- **[ALTA]** §14/§18.4/Riferimenti riga 688: EGI-DOC registry presentato come canonico unico → riformulare (L3 per-istanza; L2 HUB consolidato; EGI-DOC = caso accoppiato legacy IT).
- **[ALTA]** §18 + §14: aggiungere nota ponte automatico L1→L3 (M-OS3-025 U3); sostituire descrizione popolamento manuale.
- **[MEDIA]** §18.1 FASE 0/1: `tipo_missione→type`, `organi_coinvolti→organs` (allineare al blocco §18.4 già EN).
- **[MEDIA]** §18: aggiungere sottosez "Flusso operativo Nexus" (/discovery → /project → /mission, context-aware).
- **[BASSA]** Tabella Riferimenti righe 681-696: path doc paradigma `EGI-DOC/docs/oracode/...` → `oracode/docs/paradigm/...`; mantenere EGI-DOC solo per artefatti istanza marcati L3.

### `padmin/PADMIN_INDEX.md`
- **[ALTA]** §5bis righe 177-200: `~/.oracode/` → `~/oracode-engine/` (focus per-session, legacy focus.json); + nota cartella visibile L1.
- **[ALTA]** Header §5bis riga 179/192: rimuovere "workaround manuale pre-DOC-SYNC sistemico" → ponte L1→L3 automatico in produzione (M-OS3-025 U3). Scorporare gc-focus manuale se ancora vero.
- **[MEDIA]** §5 tabella riga 152 + §2 step 10: MISSION_REGISTRY → aggiungere livello L3, auto-popolato via ponte; statistiche/numerazione = HUB L2.
- **[MEDIA]** Riga 3 vs 255: versione header 1.0.0 vs §9 1.1.0 — allineare (bump 1.2.0); aggiornare nota versione.

### `padmin/PADMIN_ONBOARDING.md`
- **[ALTA]** §5 AP-5 righe 243-245: "naming inglese vietato" → invertire: chiavi nuovi SSOT in INGLESE, italiano EGI-DOC = legacy. Citare ORACODE_NEXUS_3_TIER.md §Livello 3.
- **[MEDIA]** §8: aggiungere voce 8.7 (avvento Oracode Nexus 3-livelli + ponte L1→L3).
- **[BASSA]** §3.5/AP-10: nota disambiguazione 4 livelli SEMANTICI vs 3 livelli OPERATIVI Nexus.

### `padmin/PADMIN_AI_IDENTITY.md`
- **[BASSA]** §3.5 righe 189-191: aggiungere riga flusso reale (bin/mission/`/mission` auto-registra L1→L3; numerazione = HUB L2; /discovery→/project→/mission). Opzionale dato taglio portabile.

### `standards/NAMING_STANDARD_CODE.md`
- **[ALTA]** "Organ Index — Generazione": `python3 /home/fabio/oracode/bin/organ_index.py` → `os3-matrix/bin/organ_index/` (verificare invocazione esatta alla fonte, non dedurre).
- **[MEDIA]** "Verifica Pre-Creazione" + cross-ref: `EGI-DOC/docs/ecosistema/ORGAN_INDEX.json` → pattern generico ("per FlorenceEGI: ... — caso HUB/istanza accoppiato"); ogni istanza risolve via `.oracode/project.json`.
- **[BASSA]** Front-matter/footer: aggiungere riga inquadramento "Standard di paradigma Oracode Nexus (L1), vale per ogni istanza L3/HUB L2".

### `standards/WEB_PAGE_QUALITY_GATE.md`
- **[ALTA]** §4.2: aggiungere riferimento a tool reale `os3-matrix/bin/web_quality_gate.py` (90 criteri, 12 categorie); snippet bash = logica di riferimento. Verificare firma argparse alla fonte.
- **[MEDIA]** Sez 0 Trigger: `tipo_missione` → `type`.
- **[BASSA]** Sez 0: agganciare al flusso Nexus /mission context-aware; mission auto-registrata L3 via `.oracode/project.json`.

### `standards/LEGACY_STACK_POLICY.md`
- **[MEDIA]** Sez 5/6: distinguere POLICY (ban Alpine/Livewire/Filament = L1 paradigma) da TABELLE/path EGI-DOC (istanza L2/L3). Cross-ref come "esempio FlorenceEGI". Aggiungere boot context `oracode/docs/paradigm/` + `CLAUDE_ORACODE_CORE.md` accanto a `CLAUDE_ECOSYSTEM_CORE.md`.
- **[BASSA]** Titolo/impostazione: aggiungere riga "Policy di paradigma Oracode Nexus (L1), ereditabile da ogni HUB/istanza".

### `tech-specs/READ_TRACKING_TECH_SPEC.md`
- **[ALTA]** §2: chiavi `stato→status` (valori allineati a state machine grezza `planned/executing/auditing`), `data_apertura→date_open`. Nota: chiavi EN canoniche (SSOT 3-TIER §108).
- **[ALTA]** §2/§3: registry+read-log hardcoded EGI-DOC → risolvere via `<progetto>/.oracode/project.json` (`registry_path`, `read_log_path`) CWD-resolved. EGI-DOC = esempio legacy. Citare M-OS3-025.
- **[MEDIA]** §3/§8: M-158/M-159/M-162 → marcare riferimenti storici EGI; namespace paradigma = M-OS3-NNN; numerazione globale = HUB L2.
- **[MEDIA]** Aggiungere box "Inquadramento Oracode Nexus" (read-tracking = sottosistema motore L1; aggregazione cross-istanza = HUB L2 differita).

### `tech-specs/RETROSPECTIVE_TECH_SPEC.md`
- **[ALTA]** §1/§2: `/home/fabio/oracode/bin/mission_retrospective.py` → `os3-matrix/bin/mission_retrospective.py`; nota: enforcement os3-matrix, invocato in finalize via `.oracode/project.json`.
- **[ALTA]** §1/§3/§4: `tipo_missione→type`, `organi_coinvolti→organs`; sostituire normalizzazione hardcoded `EGI-DOC/` con `instance_root` da project.json.
- **[MEDIA]** §2/§11: retrospective = step AUTOMATICO di `mission finalize` (best_effort), non comando manuale. M-159 = riferimento storico EGI.
- **[MEDIA]** Aggiungere box "Inquadramento Oracode Nexus" (step finalize L1; aggregazione statistica = HUB L2 differita).

### `doc-sync/DOC-SYNC_v2_STATO_DELLARTE.md`
- **[ALTA]** §5 riga "dual-tracking sync manuale": severità Media → "Risolto/Storico". Riscrivere come SUPERATO (M-OS3-025 U3, `syncToRepoRegistry`, lockfile). Correggere "M-OS3-014 candidato" → "M-OS3-025 Unità 3 FATTO". Caso "mission fantasma Poli M-002" = chiuso.
- **[MEDIA]** §5: `~/.oracode/missions/<ID>/state.json` → `~/oracode-engine/...`.
- **[MEDIA]** Aggiungere dopo §1 riquadro "Collocazione Oracode Nexus" (DOC-SYNC = meccanismo L3; EGI-DOC = istanza accoppiata caso unico).

### `doc-sync/DOC-SYNC_v2_SPECIFICA_OPERATIVA.md`
- **[BASSA]** §1.2: agganciare schema stati allo state machine grezzo bin/mission (`planned/executing/auditing/closing/closed/aborted`), registrato L3 via ponte. §6: path audit `EGI-DOC/...` → `<istanza-DOC>/...` (EGI-DOC = riferimento legacy).

### `doc-sync/DOC-SYNC_v2_PIANO_IMPLEMENTATIVO.md`
- **[MEDIA]** §6 SQL `language 'it'`: nota "direzione paradigma = inglese, parametrizzare per lingua istanza". §1.1: trigger orchestrato da bin/mission (os3-matrix) + /mission globale (U2); auto-registrazione via ponte L1→L3 (U3).
- **[BASSA]** §8/App. A: `CLAUDE_ECOSYSTEM_CORE.md` → `CLAUDE_ORACODE_CORE.md` (o annotare EGI legacy).

### `roadmap/ROADMAP_ORACODE.md`
- **[ALTA]** §5 riga 97: riscrivere "sync manuale / propagazione candidata a mission futura" → avanzamento CHIUSO (ponte L1→L3 risolto, parallel-safe). Aggiungere data 2026-05-31.
- **[MEDIA]** STEP A riga 33: inquadrare Magicsoft 2.0 come primo Livello 2 HUB di Oracode Nexus. Link ORACODE_NEXUS_3_TIER.md.

### `roadmap/ORACODE_PARADIGM_v2_draft.md`
- **[ALTA]** Macroarea 4 §10 riga 718: `~/.oracode/missions/...` → `~/oracode-engine/...`; "sync esplicita manuale / futura mission" → AUTOMATICA (ponte L1→L3 implementato).
- **[MEDIA]** §10 riga 716: MISSION_REGISTRY come unica fonte → framing 3-livelli (L3 istanza chiavi EN + L2 HUB consolidato + L1 non-registro). Campi IT → EN.
- **[MEDIA]** Macroarea 3 §1 riga 412: estendere nota disambiguazione con terza tassonomia operativa Nexus (L1/L2/L3).
- **[BASSA]** Macroarea 2 §1/§2: aggiungere /discovery prima di /project; /project scaffolda `.oracode/project.json`; /mission = globale context-aware.

### `index/Oracode-Nexus-index.md`
- **[ALTA]** Header riga 4: path canonical `/home/fabio/oracode/docs/Oracode-Nexus-index.md` (INESISTENTE) → `docs/paradigm/index/Oracode-Nexus-index.md`; M-OS3-022 COMPLETATA.
- **[ALTA]** Righe 72 vs 633-640: risolvere auto-contraddizione path `rag_natan_*` — verificare con `ls`, fissare path unico, rimuovere "come pensavo/discrepanza".
- **[ALTA]** Riga 194 + CONVERGENZE 611-617: dual-tracking RISOLTO da ponte L1→L3 (M-OS3-025 U3); rimuovere "M-OS3-014 candidato / manuale oggi".
- **[MEDIA]** TIER 7 riga 447: bin/mission → aggiungere ORACODE_HOME=`~/oracode-engine` + ponte project.json. Verificare versione reale.
- **[MEDIA]** READ_TRACKING riga 155 + TIER 8: scratch runtime `~/oracode-engine/{missions,focus,audit}` (L1); registry via project.json (L3); EGI-DOC = istanza FlorenceEGI.
- **[MEDIA]** Righe 149/520/522/530: `tipo_missione→type`, `organi_coinvolti→organs`.
- **[MEDIA]** "LEGGI PER PRIMO" righe 11-18: espandere con definizione Nexus + stato FATTO (U1 migrazione, U2 /mission globale, U3 ponte) + HUB aggregator DIFFERITO (U4/U5).
- **[MEDIA]** Cross-Reference: aggiungere flusso /discovery → /project → /mission; linkare `~/.claude/commands/mission.md`.
- **[BASSA]** TIER 6/8: aggiungere voce `~/.claude/commands/mission.md` e voce `~/oracode-engine` (L1 scratch).
- **[BASSA]** Header riga 5-6 vs footer 592-606: versione doppia 0.1.0/0.4.0 → riconciliare (bump 0.5.0, date 2026-05-31); aggiornare TODO/stati lettura.

### `README.md` (root, MIT entrypoint)
- **[ALTA]** Albero `.oracode/` righe 84-119: rimuovere `ssot-registry.json`/`mission-registry.json` (NON esistono) → `project.json` (descrittore-ponte, `registry_path`); registry reale in `docs/missions/MISSION_REGISTRY.json`, auto-registrato da bin/mission.
- **[ALTA]** Intro/How it works/Multi-project: aggiungere sezione "Oracode Nexus — 3 livelli" (L1 `~/oracode-engine` / L2 HUB / L3 istanza). Riformulare "Multi-project ecosystems" come livello HUB L2. Link ORACODE_NEXUS_3_TIER.md.
- **[MEDIA]** Mission protocol righe 241-252: JSON `"mission_id": "M-042"` → `"id"`; allineare schema EN (`id,title,type,organs,status,date_open,date_close,files_modified,stats`); numerazione/stat = HUB L2.
- **[BASSA]** Riga 299: definire esplicitamente "Oracode Nexus = sistema completo" così che il nome dell'index abbia senso.

### `education/OS4_FOUNDATION_DOCUMENT.md`
- **[MEDIA]** Dopo §1 (riga 21): box framing Nexus (OS4 = tier EDUCATION, triade OSZ→OS3→OS4, vive in L1 GLOBALE). §10: citare triade OSZ/OS3/OS4 accanto a lineage OS1→OS2→OS3→OS4. (Nota fuori-scope: cita NATAN_LOC/Comune di Firenze — genericizzabile per purezza MIT, ma esula dall'audit.)

---

## 4. INTRODUZIONE "ORACODE NEXUS" — punti di ancoraggio

Definizione canonica unica da usare ovunque:
> **Oracode Nexus = il sistema completo: paradigma + gerarchia operativa a 3 livelli (L1 GLOBALE motore+paradigma `~/oracode-engine` / L2 HUB softwarehouse acquirente / L3 ISTANZA LSO) + ecosistema HUB/istanze.** SSOT-legge: `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`.

| # | Doc | Dove | Cosa introdurre |
|---|-----|------|-----------------|
| 1 | `kernel/00_OSZ...` | dopo "COS'È OSZ" | OSZ = kernel del paradigma dentro Nexus; triade OSZ/OS3/OS4; generalizzare "ecosistema FlorenceEGI" → istanza/HUB di riferimento |
| 2 | `ssot/00_ORACODE_SYSTEM_SSOT.md` | nuova §1bis | sezione completa 3-livelli; disambiguare i 3 usi di "livelli" (autorità OSZ/OS3/OS4, architettura L0-L11, scope L1/L2/L3) |
| 3 | `index/Oracode-Nexus-index.md` | "LEGGI PER PRIMO" + Cross-Reference | rafforzare framing già presente; stato FATTO U1/U2/U3; flusso /discovery→/project→/mission |
| 4 | `nomenclature/LSO_NOMENCLATURE_INDEX.md` | nuova §1bis | glossario always-loaded: 3 livelli operativi accanto ai 4 concettuali (ortogonali) |
| 5 | `nomenclature/LSO_NOMENCLATURE_v2.md` | §1 | asse concettuale (4) vs operativo Nexus (3) |
| 6 | `missions/MISSION_PROTOCOL.md` | header + Sez 1, 7-8 | registry L2 HUB + L3 istanza; bin/mission = motore L1; ponte automatico |
| 7 | `README.md` | dopo "How it works" + "Multi-project" | sezione 3 livelli; HUB = L2 |
| 8 | `execution/OS3/00_Executive_Summary.md` | apertura | riquadro "OS3 dentro Nexus" (strato Execution della triade) |
| 9 | `execution/OS3/04_Modulo_3...` | nuova sez | P0-P3 + Trigger Matrix + L0-L11 |
| 10 | `lso/00_LSO...` | dopo "Cos'è LSO" | un LSO = istanza L3; FlorenceEGI prima istanza |
| 11 | `lso/MANIFESTO_LSO.md` | paragrafo | collegamento nominale LSO↔L3 (no path) |
| 12 | `education/OS4_FOUNDATION...` | dopo §1 + §10 | OS4 = tier EDUCATION in L1; triade |
| 13 | `doc-sync/STATO_DELLARTE` | dopo §1 | DOC-SYNC = meccanismo L3 |
| 14 | `roadmap/ROADMAP` + `PARADIGM_v2_draft` | STEP A / Macroarea 3-4 | Magicsoft = primo HUB L2; terza tassonomia |
| 15 | `tech-specs/READ_TRACKING` + `RETROSPECTIVE` | box in testa | sottosistemi motore L1; aggregazione = HUB L2 |
| 16 | `standards/*` (3 doc) | riga inquadramento in testa | standard L1, FlorenceEGI = esempio HUB/istanza |
| 17 | `padmin/INDEX` + `ONBOARDING` | §5bis/§5 + §8 | registry/focus a livelli; nota disambiguazione 4-sem vs 3-op |

**Doc che NON richiedono framing Nexus** (paradigma puro o memoria istanza): `padmin/PADMIN_IDENTITY_OS3_*` (CORE/P1/P2/P3/INDEX/INTEGRATION), `padmin/padmin_partner_memory.md`, `padmin/PDTDP`, `execution/OS3/{02_Modulo_1_Pilastri, 03_Modulo_2_REGOLA_ZERO}`, i due Guard Testing (solo coerenza-lingua).

---

## 5. ORDINE DI ESECUZIONE CONSIGLIATO

Razionale: prima la LEGGE e le FONTI (per non propagare); poi i consumatori in ordine di dipendenza; framing-only per ultimi.

### Fase 0 — Pre-requisiti / decisioni CEO (BLOCCANTI, REGOLA ZERO)
Da risolvere PRIMA di toccare i doc, perché tre modifiche dipendono da info mancante:
1. `00_ECOSISTEMA.md` — esiste/deprecato? (blocca kernel)
2. `OS3_OS4_REFERENCE_GUIDE.md` — rilocato dove? (blocca kernel)
3. Path reale `rag_natan_*.py` — `ls` os3-matrix/bin vs oracode/bin (blocca LSO + index)
4. Invocazione esatta `organ_index` e firma `web_quality_gate.py` — verificare alla fonte (blocca standards)
5. Email maintainer `fabio@oracode.com` — confermare/sostituire (TOON)

### Fase 1 — FONTI dei drift propagati (sbloccano CROSS-A e CROSS-B)
6. `execution/OS3/04_Modulo_3...` — FONTE del "7→13" (poi propaga a Summary, Manifesto, OSZ, TOON)
7. `lso/LSO_GUARD_TESTING_PROTOCOL_v1.md` — FONTE policy lingua (poi INDEX, ONBOARDING AP-5)

### Fase 2 — LEGGE confermata + SSOT consolidato (riferimento per tutti)
8. `ssot/00_ORACODE_SYSTEM_SSOT.md` (§1bis Nexus + drift) — diventa il riferimento citato dagli altri
9. `nomenclature/LSO_NOMENCLATURE_INDEX.md` (glossario always-loaded)
10. `nomenclature/LSO_NOMENCLATURE_v2.md`

### Fase 3 — Mission Engine: path + ponte (CROSS-C, CROSS-D, CROSS-E)
Toccano lo stesso sottosistema, fare insieme per coerenza:
11. `missions/MISSION_PROTOCOL.md`
12. `tech-specs/RETROSPECTIVE_TECH_SPEC.md` + `READ_TRACKING_TECH_SPEC.md`
13. `doc-sync/DOC-SYNC_v2_STATO_DELLARTE.md` (+ SPECIFICA + PIANO)
14. `padmin/PADMIN_INDEX.md`

### Fase 4 — Doc che propagano da fonti già sistemate
15. `execution/OS3/00_Executive_Summary.md`, `01_Manifesto.md`, `05_TOON.md`
16. `kernel/00_OSZ...` (dipende da Fase 0 #1,#2 + numero P0)
17. `lso/LSO_GUARD_TESTING_PROTOCOL_INDEX.md`, `padmin/PADMIN_ONBOARDING.md` (AP-5)

### Fase 5 — Standards + roadmap + entrypoint pubblico
18. `standards/NAMING_STANDARD_CODE.md`, `WEB_PAGE_QUALITY_GATE.md`, `LEGACY_STACK_POLICY.md`
19. `roadmap/ROADMAP_ORACODE.md`, `ORACODE_PARADIGM_v2_draft.md`
20. `README.md` (entrypoint MIT — toccare quando il resto è coerente)

### Fase 6 — Index navigazione (per ultimo: indicizza tutti gli altri)
21. `index/Oracode-Nexus-index.md` — deve riflettere lo stato finale dei doc già sistemati; riconciliare versione/TODO.

### Framing-only (in coda, nessuna dipendenza, no rischio)
22. `education/OS4_FOUNDATION_DOCUMENT.md`, `lso/MANIFESTO_LSO.md`, `padmin/PADMIN_AI_IDENTITY.md`, `nomenclature/proposals/M-NOMENCL-OSMX-002_DELTA.md` (nota superseded o archivia).

**Dipendenze chiave**: #6 sblocca #15-16 · #7 sblocca #17 · #8 è citato da quasi tutti (fare presto) · #21 va per ultimo (indicizza lo stato finale) · Fase 0 BLOCCA kernel/standards/LSO/index finché le 5 verifiche non sono chiuse.

---

> **Soglie Git Safety**: diversi doc (OSZ, SSOT consolidato, MISSION_PROTOCOL, index) supereranno R1 (>100 righe) o R4 (>500 righe totali) per intervento. Richiesta approvazione CEO esplicita per bypass su quei file, o split in mission separate per documento.
> **Trigger Matrix**: questo è intervento tipo 5 (Naming, grep cross-progetto su chiavi IT→EN) + tipo 3 (Architetturale, framing Nexus tocca boot context) → DOC-SYNC + approvazione CEO PRIMA.