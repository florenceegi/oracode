---
title: Mission Protocol
slug: mission-protocol
doc_type: protocol
version: 4.1.0
status: current
date: '2026-05-27'
updated_at: '2026-06-01'
author: Padmin D. Curtis for Fabio Cherici
scope:
- oracode
rag_indexed: true
priority: high
---

# Mission Protocol

> **Inquadramento Oracode Nexus.** Questo protocollo è il **pattern L1/Oracode-universale** del lavoro a mission. Vive dentro **Oracode Nexus** — il sistema completo (paradigma + gerarchia operativa a 3 livelli L1 GLOBALE / L2 HUB / L3 ISTANZA + ecosistema). La gerarchia dei livelli è legge: vedi `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md` (SSOT LOCKED). Il motore di riferimento `bin/mission` è componente L1 (in `os3-matrix`, `ORACODE_HOME=~/oracode-engine`) e propaga automaticamente lo stato della state machine al `MISSION_REGISTRY` dell'istanza (L3) via il descrittore `.oracode/project.json`.

> **Livello (vedi `LSO_NOMENCLATURE_v1.md`)**: Oracode (universale, trasferibile a qualsiasi istanza LSO)
> **Sostituisce**: `MISSION_PROTOCOL.md` v2.0.0 (2026-05-08)
> **Cambio minore v4.1.0 (M-OS3-026, 2026-06-01)**: bootstrap mirato (FASE 1) **cablato all'open** — `bin/mission` emette automaticamente la lista moduli calibrata per `type`+`organs` (`emitBootstrap`); prima era design non implementato. Additivo, retro-compatibile.
> **Cambio maggiore v4.0.0 (M-OS3-025, 2026-05-31)**: ingresso in **Oracode Nexus** con la gerarchia a 3 livelli. Cambiamenti strutturali: (1) **ponte L1→L3 AUTOMATICO** — `bin/mission` auto-registra le mission nel `MISSION_REGISTRY` dell'istanza via `.oracode/project.json` (fine della sincronizzazione manuale / "mission fantasma"); (2) **chiavi registry in INGLESE** (`id/title/type/organs/status/date_open/date_close`); (3) **cartella globale visibile** `~/oracode-engine/` (`ORACODE_HOME`); (4) statistiche/numerazione = responsabilità **HUB (L2)**, non istanza. Compatibile concettualmente con v3 (FASE 0-6 preservate); major perché cambiano schema-chiavi e meccanismo di propagazione.
>
> **Cambio maggiore v3.0.0 (M-OS3-018)**: codifica della state machine a 7 stati, introduzione del CLI di riferimento `bin/mission`, multi-mission concurrency (M-OS3-012), multi-write per session_id (M-OS3-016), spawn fingerprint (M-OS3-005), test-red whitelist `tests/**` in stato `planned`, scope hash anti-drift, pattern AMENDMENT CEO, ESITO A/B/C verification pre-close. La parte narrativa Oracode-universale (FASE 0-6) della v2.0.0 è preservata.

---

## 0. Cosa è il Mission Protocol

Il Mission Protocol è il sistema operativo del lavoro in Oracode. Ogni unità di lavoro è una **mission** con stati definiti e ciclo di vita prescritto. Il protocollo governa l'apertura, l'esecuzione e la chiusura di ogni mission.

Tre proprietà costitutive nella v2.0.0:

- **Tracciabilità** — ogni mission lascia traccia in `MISSION_REGISTRY` con stato, organi coinvolti, deliverable
- **Calibrazione mirata** — il bootstrap di apertura mission carica solo i moduli rilevanti per `type` e `organs`, non tutto il contesto possibile
- **Apprendimento dal proprio uso** — alla chiusura mission, il retrospective osserva quali moduli sono stati effettivamente consultati e produce proposte di aggiornamento al bootstrap futuro

La proprietà 3 è ciò che rende il Mission Protocol *vivente* — non solo una procedura, ma un protocollo che impara da come viene usato.

---

## 1. Stratificazione e scope

Il Mission Protocol è di livello **Oracode** (universale, L1). Il **pattern** descritto in questo documento deve poter essere applicato a qualsiasi istanza LSO senza modifiche concettuali. La gerarchia operativa di riferimento è la legge **Oracode Nexus a 3 livelli** (`docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`).

Il `MISSION_REGISTRY.json` esiste a **due livelli** della gerarchia:

- **L2 HUB** — il **primo vero MISSION_REGISTRY**: file unico che raduna tutto, con **statistiche consolidate** cross-istanza e **numerazione globale unica**. Versionato nel repo `<HUB>-DOC` della softwarehouse acquirente.
- **L3 ISTANZA LSO** — il registry **proprio del progetto**, nel suo repo (es. `<istanza>-DOC/docs/missions/`). Traccia le mission dell'istanza; le statistiche e la numerazione globale NON vivono qui (sono responsabilità L2 HUB).

| Componente | Livello | Sede tipica |
|---|---|---|
| `MISSION_REGISTRY.json` (consolidato) | L2 HUB | `<HUB>-DOC/docs/missions/` (file unico, stats + numerazione globale) |
| `MISSION_REGISTRY.json` (per-istanza) | L3 Istanza | `<istanza>-DOC/docs/missions/` (es. EGI-DOC = istanza accoppiata legacy) |
| `MISSION_BOOTSTRAP_INDEX.json` | L3 Istanza | `<istanza>-DOC/docs/missions/` |
| `BOOTSTRAP_DRIFT_LOG.md` | L3 Istanza | `<istanza>-DOC/docs/missions/` |
| Tipi di mission specifici (es. "guard", "feature", "doc-sync") | L3 Istanza | Tassonomia derivata dall'esperienza |

**Vincolo di coerenza.** Il PATTERN del Mission Protocol è Oracode-universale: nessuna parte di questo documento deve accoppiarsi a path o componenti di un'istanza specifica. I riferimenti a FlorenceEGI/EGI-DOC che compaiono nel testo sono **esempi di istanza accoppiata legacy** (oggi caso unico HUB+istanza), non parte normativa del paradigma.

---

## 2. Ciclo a 6 fasi

```
FASE 0 — Apertura ID (bin/mission open, ponte L1→L3 automatico) [Supervisor]
   ↓
FASE 1 — Apertura mission + bootstrap mirato      [Supervisor + CEO]
   ↓
FASE 2 — Analisi                                  [Supervisor]
   ↓
FASE 3 — Piano (proposta architetturale)          [Supervisor → Watchdog → CEO]
   ↓
FASE 4 — Esecuzione                               [Supervisor, dopo approvazione CEO]
   ↓
FASE 5 — Review deliverable                       [Watchdog → CEO]
   ↓
FASE 6 — Chiusura: DOC-SYNC + retrospective       [Supervisor]
```

Le fasi 2-5 seguono il pattern in 10 step descritto in `PADMIN_ONBOARDING.md` § 2 — questo documento non lo duplica. Le fasi 0, 1, 6 hanno specifiche dedicate (sezioni 3, 4, 6).

---

## 3. FASE 0 — Apertura ID anti-collisione

Sessioni Claude Code parallele possono aprire mission contemporaneamente. L'apertura tramite il motore previene collisioni.

**Flusso (attuale):**

L'ID si apre con il motore:

```
bin/mission open <ID> --title="..." --trigger=N [--scope="..."]
```

La registrazione nel `MISSION_REGISTRY.json` dell'istanza (L3) è **automatica** via **Ponte L1→L3** (M-OS3-025 Unità 3): `bin/mission` risolve il `MISSION_REGISTRY` del progetto dal descrittore `<progetto>/.oracode/project.json` (risolto risalendo dal CWD) e fa **upsert idempotente** dell'entry. L'operazione è **parallel-safe** (registry lock) — più sessioni possono aprire mission diverse senza collisione, e niente "mission fantasma".

La **numerazione globale unica** anti-collisione cross-istanza è responsabilità centralizzata del **HUB (L2)**, non più di un "leggi counter → incrementa" eseguito a mano nell'istanza.

**Blocco mission-fantasma — A1 (decisione CEO 2026-06-01, M-OS3-025).** `bin/mission open` **BLOCCA** se nel CWD non esiste `.oracode/project.json`: una mission senza progetto vivrebbe solo nel runtime globale (`~/oracode-engine/`) e NON sarebbe versionata ("mission fantasma"). Per una mission **globale intenzionale** (es. lavoro sul motore stesso) serve il flag esplicito `--global`. I comandi non distruttivi (`advance`, `close`, `status`) restano fail-soft.

**Convenzione ID prefissato per progetto (decisione CEO 2026-06-01, M-OS3-025).** Il runtime globale `~/oracode-engine/missions/` è condiviso e chiavato sul solo ID → gli ID devono essere **globalmente unici**. Convenzione: prefisso per progetto — `M-POLI-001`, `M-OS3-025`, `M-NEXUS-001`, ecc. La numerazione globale automatica anti-collisione è compito del **HUB (L2)** (Unità 4, da costruire); fino ad allora il prefisso garantisce unicità.

Una mission può essere aperta anche solo per riservare uno slot (`draft`) mentre la specifica è ancora discussa con il CEO.

---

## 4. FASE 1 — Apertura mission con bootstrap mirato

### 4.1 Raccolta requisiti

Il CEO definisce intent. Supervisor riceve l'intent, identifica `type` (tipo di mission) e `organs` (organi coinvolti), e compila l'entry del registry.

**Esempio entry FASE 1 (chiavi in INGLESE — decisione CEO 2026-05-30):**

```json
{
  "id": "M-019",
  "title": "Titolo della missione",
  "date_open": "2026-05-08",
  "status": "planned",
  "type": "feature",
  "organs": ["<ORGAN_A>"],
  "cross_organ": false
}
```

> **Nota chiavi.** Le chiavi del `MISSION_REGISTRY` sono in **INGLESE** (`id`, `title`, `date_open`, `date_close`, `status`, `type`, `organs`, `cross_organ`, `scope_hash`, `priority`) — come scritte dal motore (`bin/mission`, funzione `syncToRepoRegistry`) e fissate dalla legge `ORACODE_NEXUS_3_TIER.md`. Le chiavi italiane (`tipo_missione`, `organi_coinvolti`, `data_apertura`, `stato`) sono **legacy di un'istanza accoppiata (es. EGI-DOC)**, non modello per istanze nuove.

### 4.2 Bootstrap mirato

**Principio.** Una nuova sessione VSCode che apre una mission **non carica tutto il contesto possibile**. Carica un sottoinsieme calibrato su `type` + `organs`. Questo:

- Riduce il carico cognitivo dell'istanza Padmin Supervisor
- Riduce i token consumati al boot
- Aumenta l'attention sui contenuti rilevanti

**Meccanismo (cablato all'open — M-OS3-026).** Quando `bin/mission open` crea la mission, l'engine **emette automaticamente** (funzione `emitBootstrap` in `cmdOpen`) un blocco `📦 BOOTSTRAP MIRATO`: legge il `MISSION_BOOTSTRAP_INDEX.json` del progetto (risolto dal descrittore `.oracode/project.json`, campo `bootstrap_index_path`) e stampa la **lista calibrata** dei moduli per `type` + `organs` — emette **path, non contenuto** (token-light: ~0 al modello). Il Supervisor poi **legge (Read)** solo quei file, calibrando il context sulla mission invece di caricare tutto. Fail-soft (mai blocca l'open): nessun descrittore `.oracode/project.json` / `bootstrap_index_path` assente / index assente o illeggibile (JSON malformato) / 0 moduli risolti per `type`+`organs` → nessun blocco emesso. I moduli sono stratificati secondo `LSO_NOMENCLATURE_v1.md`:

- **Sempre caricati** (Oracode-puri ed essenziali per ogni mission):
  - `PADMIN_INDEX.md` (briefing executive)
  - `LSO_NOMENCLATURE_INDEX.md` (vocabolario sintetico — vedi nota sotto)
  - `MISSION_PROTOCOL.md` (questo documento)
  - Memoria-CEO specifica dell'istanza
  - Documento di binding dell'istanza

- **Caricati per `type`**: per esempio mission di tipo "guard" carica anche `LSO_GUARD_TESTING_PROTOCOL_v1.md`

- **Caricati per `organs`**: per ogni organo, il suo `CLAUDE.md` e la documentazione specifica

- **On-demand durante esecuzione**: documenti più lunghi (es. `LSO_NOMENCLATURE_v1.md` integrale, `PADMIN_ONBOARDING.md`, specifiche tecniche estese) si consultano solo quando serve approfondire

**Nota sui documenti grandi.** Documenti estesi come `LSO_NOMENCLATURE_v1.md` non vengono caricati integralmente al bootstrap. Esiste una versione INDEX da 1-2 pagine (`LSO_NOMENCLATURE_INDEX.md`) che fornisce vocabolario sintetico sempre disponibile. La versione integrale si carica on-demand quando emerge ambiguità di vocabolario o serve dettaglio architetturale. Lo stesso pattern si applica progressivamente ad altri documenti grandi mano a mano che emergono problemi di attention.

**Tracciamento.** Durante l'esecuzione mission, Supervisor traccia quali moduli sono effettivamente consultati (Read sul filesystem, cat in bash, accesso via grep). Questo tracking è input al retrospective di FASE 6.

### 4.3 MISSION_BOOTSTRAP_INDEX come SSOT

`MISSION_BOOTSTRAP_INDEX.json` è il SSOT che dichiara, per ogni combinazione (`type`, `organs`), quali moduli caricare al bootstrap.

**Format proposto (JSON, coerente con MISSION_REGISTRY):**

```json
{
  "always_loaded": [
    "docs/oracode/PADMIN_INDEX.md",
    "docs/lso/LSO_NOMENCLATURE_INDEX.md",
    "docs/oracode/MISSION_PROTOCOL.md",
    "docs/<istanza>/<ISTANZA>_INSTANCE.md"
  ],
  "by_mission_type": {
    "guard": [
      "docs/lso/LSO_GUARD_TESTING_PROTOCOL_v1.md"
    ],
    "doc-sync": [
      "docs/lso/DOC-SYNC_v2_SPECIFICA_OPERATIVA.md",
      "docs/lso/SSOT_REGISTRY.json"
    ],
    "feature": []
  },
  "by_organ": {
    "<ORGAN_A>": [
      "<ORGAN_A>/CLAUDE.md",
      "<ORGAN_A>/CLAUDE_ECOSYSTEM_CORE.md"
    ],
    "<ORGAN_B>": [
      "<ORGAN_B>/CLAUDE.md",
      "<ORGAN_B>/CLAUDE_ECOSYSTEM_CORE.md"
    ]
  }
}
```

**Update.** `MISSION_BOOTSTRAP_INDEX.json` si aggiorna **solo via approvazione esplicita CEO**. Le proposte di update emergono dal retrospective (FASE 6) ma non vengono applicate automaticamente.

---

## 5. FASI 2-5 — Analisi, piano, esecuzione, review

Le fasi intermedie seguono il pattern in 10 step descritto in `PADMIN_ONBOARDING.md` § 2. Sintesi:

- **FASE 2 (Analisi)**: Supervisor analizza il problema, identifica file e componenti rilevanti, prepara base per il piano.
- **FASE 3 (Piano)**: Supervisor produce proposta architetturale. Watchdog reviewa. Eventuali revisioni iterative. **Approvazione esplicita CEO obbligatoria** prima di procedere.
- **FASE 4 (Esecuzione)**: Supervisor implementa. Tracciamento moduli consultati continua durante esecuzione.
- **FASE 5 (Review deliverable)**: Watchdog reviewa il deliverable. **Approvazione esplicita CEO obbligatoria** prima di FASE 6.

Per dettaglio del pattern e degli anti-pattern correlati, vedere `PADMIN_ONBOARDING.md`.

---

## 6. FASE 6 — Chiusura: DOC-SYNC + retrospective

### 6.1 DOC-SYNC v2 alla chiusura

Trigger: transizione mission da `review` a `closing`. DOC-SYNC v2 opera al layer L8 (propriocezione documentale, allineamento codice ↔ SSOT). È meccanismo distinto dal retrospective.

**Invocazione.** Supervisor spawna agent `doc-sync-v2` con:
- `mission_id`: ID della mission corrente
- `files_modified`: lista file di codebase modificati (dal campo `files_modified` del registry)
- `diff`: output di `git diff <primo_commit>^..<ultimo_commit>` (da `stats.commit_hashes` del registry)

L'agent esegue 6 step (analisi semantica, SSOT diretti, discovery laterale, generazione/applicazione, RAG reindex, audit trail) e restituisce un `doc_sync_log` JSON strutturato che Supervisor scrive nel campo `doc_sync_log` della mission nel registry.

Se `outcome = "success"` → procedi a retrospective. Se `outcome = "failed"` → mission resta in `closing`, segnala a CEO. Se outcome richiede approvazione sostitutiva → presenta patch, attendi decisione CEO.

Per la specifica completa vedere `DOC-SYNC_v2_SPECIFICA_OPERATIVA.md`. Per il piano implementativo vedere `DOC-SYNC_v2_PIANO_IMPLEMENTATIVO.md`.

Output: SSOT e RAG allineati al codice modificato dalla mission, `doc_sync_log` strutturato nel registry, audit trail in `<istanza>-DOC/audit/doc_sync/<id>/` (`EGI-DOC/...` è l'esempio dell'istanza accoppiata legacy).

### 6.2 Retrospective auto-migliorante

**Principio.** Alla chiusura mission, Supervisor confronta:

- **Caricato**: lista moduli pre-allocati al bootstrap (FASE 4.2)
- **Usato**: lista moduli effettivamente consultati durante mission (tracking di FASI 1-5)

**Differenze:**

- *Moduli caricati e mai usati* → candidati a essere rimossi dal bootstrap per quel tipo di mission
- *Moduli usati ma non caricati* → candidati a essere aggiunti al bootstrap per quel tipo di mission

**Output.** Una proposta strutturata di aggiornamento a `MISSION_BOOTSTRAP_INDEX.json`. Format:

```json
{
  "mission_id": "M-019",
  "bootstrap_evaluation": {
    "loaded_unused": [
      "docs/oracode/SOME_DOC.md"
    ],
    "used_unloaded": [
      "docs/lso/SOME_OTHER_DOC.md"
    ],
    "proposal": {
      "by_mission_type.<tipo>": {
        "remove": ["docs/oracode/SOME_DOC.md"],
        "add": ["docs/lso/SOME_OTHER_DOC.md"]
      }
    },
    "reasoning": "Breve motivazione operativa della proposta."
  }
}
```

**Vincolo statistico-empirico.** Il retrospective è basato su **tracking di Read**, non su interpretazione semantica. Non richiede LLM per funzionare. Lo distingue strutturalmente da L9 (Riflessione, vedi `LSO_NOMENCLATURE_v1.md`), che richiede disaccoppiamento dagli LLM esterni. Il retrospective vive nel Mission Protocol (Oracode 3.1.x), non in L9.

**Caso "no_changes".** Se nessuna differenza emerge tra caricato e usato, il retrospective dichiara `no_changes` e la mission chiude.

**Invocazione.** Il retrospective si esegue come passo esplicito di FASE 6, dopo DOC-SYNC e prima della chiusura stato. È orchestrato da `bin/mission finalize` (M-OS3-025, POST-COMMIT), che invoca in sequenza `enrich_registry.py` + `mission_retrospective.py`:

```
bin/mission finalize <ID>   # orchestra enrich_registry.py + mission_retrospective.py (POST-COMMIT)
```

Lo script `mission_retrospective.py` vive nel motore di enforcement (`os3-matrix/bin/mission_retrospective.py`), non nel repo `oracode` (paradigma). Identifica automaticamente la mission corrente, calcola il diff, e genera eventuali proposte nel `BOOTSTRAP_DRIFT_LOG.md`.

**Ordine obbligatorio FASE 6** (aggiornato da M-160a per attivazione runtime DOC-SYNC v2 — sequenza era 6 step da M-159, diventa 8 step):

1. Mission report (tecnico + esteso) — 6a
2. Aggiornamento MISSION_REGISTRY (compila `files_modified`) — 6b
3. Stats (calcola `commit_hashes` via `enrich_registry.py`) — 6c
4. **DOC-SYNC v2** (spawn agent `doc-sync-v2`, scrive `doc_sync_log`) — 6d
5. **Retrospective bootstrap** (mission ancora in `in_progress`) — 6e
6. Aggiornamento stato → `completed`, `doc_sync_executed: true`, `retrospective_executed: true`
7. Commit + push — 6f
8. LOG Supervisor + Triage queue — 6g/6h

Il retrospective al punto 5 trova la mission corrente perché lo stato è ancora `in_progress`. Se eseguito dopo la chiusura stato, il comando troverà una mission diversa. DOC-SYNC v2 al punto 4 usa `files_modified` (punto 2) e `commit_hashes` (punto 3) — dipendenze sequenziali.

### 6.3 Stati DOC-SYNC (transitori)

Durante FASE 6, DOC-SYNC v2 può portare la mission in stati transitori:

| Stato | Quando | Transizioni ammesse |
|---|---|---|
| `closing` | FASE 6 in corso, DOC-SYNC v2 in esecuzione | → `completed`, `awaiting_doc_sync_approval`, `doc_sync_failed_*` |
| `awaiting_doc_sync_approval` | Patch sostitutiva in attesa decisione CEO | → `closing` (dopo risoluzione) → `completed` |
| `doc_sync_failed_semantic_analysis` | Agent Step 1 fallito | → `closing` (retry manuale) |
| `doc_sync_failed_rag_reindex` | Agent Step 5 fallito | → `closing` (retry da Step 5, idempotente) |
| `doc_sync_failed_user_rejected` | Rifiuto senza risoluzione | → `closing` (risoluzione obbligatoria) |

**Nessuna mission chiude con SSOT incoerente.** Se DOC-SYNC v2 fallisce, la mission resta in `closing` fino a risoluzione.

### 6.4 BOOTSTRAP_DRIFT_LOG e approvazione

**Vincolo procedurale.** Le proposte del retrospective NON aggiornano automaticamente `MISSION_BOOTSTRAP_INDEX.json`. Si accumulano in `BOOTSTRAP_DRIFT_LOG.md`.

Periodicamente, su decisione del CEO, Watchdog rivede il drift log con CEO. Le proposte solide vengono approvate e applicate al `MISSION_BOOTSTRAP_INDEX.json`.

**Razionale.** Aggiornamento automatico di SSOT da meccanismo interno è anti-pattern: AI che modifica le proprie istruzioni operative senza supervisione umana. Il retrospective produce **dati**, il CEO produce **decisione**.

**Frequenza review.** All'inizio (fase di calibrazione), review ad-hoc su decisione CEO. Quando il sistema sarà stabile, si potrà passare a frequenza fissa (ogni N mission o tempo cadenzato).

### 6.5 ESITO A/B/C — verifica pre-close

DOC-SYNC v2 produce tre esiti possibili. La mission NON può transitare a `closed` finché l'esito non è classificato e gestito.

| Esito | Significato | Azione |
|---|---|---|
| **ESITO A** | SSOT già allineati, nessuna patch necessaria | Procedi a `closed` |
| **ESITO B** | Patch additiva applicata (nessuna info perduta, solo aggiunte) | Procedi a `closed` con `doc_sync_log` strutturato |
| **ESITO C** | Patch sostitutiva proposta (rimuove o riscrive contenuto SSOT) | Mission in `awaiting_doc_sync_approval` → CEO decide |

**Principio.** ESITO C è anti-frode documentale: AI non sostituisce contenuto SSOT senza approvazione esplicita umana. Pattern coerente con AP-MP-3 (no aggiornamento automatico di SSOT da meccanismo interno).

**Tracciamento.** L'esito viene scritto nel campo `doc_sync_log.esito` della mission. Su `closed_with_debt`, anche `doc_sync_log.debt_reason` è obbligatorio.

---

## 7. State machine codificata — 7 stati operativi

Le fasi narrative di Sez 2 (FASE 0-6) sono il **piano logico**. La state machine codificata è la **realtà operativa** — ogni mission attraversa stati discreti enforced dal CLI di riferimento (Sez 8).

```
┌──────┐      ┌─────────┐      ┌───────────┐      ┌──────────┐      ┌────────┐
│draft │ ───► │planned  │ ───► │executing  │ ───► │auditing  │ ───► │closed  │
└──────┘      └─────────┘      └───────────┘      └──────────┘      └────────┘
                                                        │
                                                        ▼
                                                 ┌──────────────────┐
                                                 │auditing_failed   │ ───► closed_with_debt
                                                 └──────────────────┘
                                                        │
                                                        ▼
                                                  ┌─────────┐
                                                  │aborted  │
                                                  └─────────┘
```

| Stato | Significato | Transizioni ammesse | Vincoli |
|---|---|---|---|
| `draft` | Prenotazione FASE 0, scope ancora discusso con CEO | → `planned` (dopo approvazione scope) → `aborted` | Solo Read consentito |
| `planned` | Piano approvato dal CEO, test red baseline scritto | → `executing` (con `--test-file` obbligatorio) | Whitelist Write su `tests/**` (vedi Sez 12) |
| `executing` | Esecuzione FASE 4, patch in corso | → `auditing` (test green + diff coerente) → `aborted` | Write libero in scope dichiarato |
| `auditing` | FASE 6 in corso, DOC-SYNC v2 spawn, ESITO classificato | → `closed` (ESITO A/B + DOC-SYNC success) → `auditing_failed` → `awaiting_doc_sync_approval` (ESITO C) | No Write a codebase fino a esito |
| `auditing_failed` | DOC-SYNC fallita o test red post-patch | → `closed_with_debt` (con approvazione CEO + `debt_reason`) → `executing` (retry) | — |
| `closed` | Mission completata, DOC-SYNC eseguita, retrospective scritta | terminale | — |
| `closed_with_debt` | Mission chiusa con debito tecnico documentato | terminale | `debt_reason` obbligatorio |
| `aborted` | Mission abbandonata prima di executing | terminale | — |

**Invariante.** Nessuna mission può saltare stati. Il CLI di riferimento blocca transizioni non ammesse.

**Origine.** State machine v0.1 introdotta da M-OS3-001 (Mission State Machine non-aggirabile). Stati `auditing_failed` e `closed_with_debt` aggiunti da M-OS3-006 (Test Quality Gate). Stato `aborted` da M-OS3-009 (Mission Timeout + Auto-Suspend).

---

## 8. CLI di riferimento — `bin/mission`

L'implementazione di riferimento del Mission Protocol è il CLI `bin/mission` (livello Oracode-tooling). È stato implementato e progressivamente esteso attraverso la serie M-OS3.

### 8.1 Evoluzione

| Versione | Mission | Cambiamento maggiore |
|---|---|---|
| v0.1 | M-OS3-001 | State machine 7 stati non-aggirabile, scope hash, lock globale single-mission |
| v0.2 | M-OS3-012 | Multi-mission concurrency: rimosso global lock, focus-based isolation |
| v0.3 | M-OS3-016 | Multi-write per `session_id`: focus per-session via env, N chat parallele zero collision |
| **v4.0.0** | **M-OS3-025** | **Oracode Nexus 3 livelli**: ponte L1→L3 automatico (`syncToRepoRegistry` via `.oracode/project.json`, parallel-safe), chiavi registry INGLESE, `~/oracode-engine` visibile, stats/numerazione al HUB. Subcomando `finalize`. Slash command globale `/mission`. + blocco mission-fantasma A1 (`open` BLOCCA fuori da un progetto, `--global` override) e convenzione ID prefissato (CEO 2026-06-01). |
| **v4.1.0** | **M-OS3-026** | **Bootstrap mirato cablato all'open**: `emitBootstrap` (in `cmdOpen`) emette la lista moduli calibrata per `type`+`organs` da `MISSION_BOOTSTRAP_INDEX.json` (path, non contenuto → token-light). La FASE 1 §4.2 ora è eseguita dal motore, non più manuale. |

### 8.2 Subcomandi principali

```
open <ID> --title="..." --trigger=N [--scope="..."]
advance --to=<state> --mission=<ID> [--test-file=...]
status [--mission=<ID> | --all]
suspend [--mission=<ID>] [--reason="..."]
resume <ID>
focus <ID>          # set focus per session corrente
unfocus             # rimuove focus per session corrente
focused             # mostra mission focused per session corrente
close               # advance --to=closed con check auditing
gc-focus            # cleanup file focus/ orfani
check-timeout       # auto-suspend mission stagnanti
```

### 8.3 Indipendenza dall'istanza LSO — collocazione Nexus

Il CLI è **Oracode-universale** ed è il **motore L1** di Oracode Nexus: vive in `os3-matrix` con `ORACODE_HOME=~/oracode-engine` (cartella globale visibile), tiene lo **scratch runtime** del motore (focus, lock, stato in volo) e **non** è un archivio versionato.

Nessun riferimento hardcoded a path di un'istanza specifica. Il registro mission dell'istanza (L3) risiede in path relativo all'installazione dell'istanza, **risolto dal descrittore `.oracode/project.json` dal CWD** (es. `<istanza>-DOC/docs/missions/` — `EGI-DOC/...` per FlorenceEGI, `Poli-Doc/...` per Poli). Il motore **auto-propaga** lo stato della state machine al registry L3 via il **Ponte L1→L3** (M-OS3-025 Unità 3, parallel-safe). Statistiche consolidate e **numerazione globale unica** sono responsabilità del **HUB (L2)**, non del motore né dell'istanza.

---

## 9. Multi-mission concurrency (M-OS3-012)

**Problema risolto.** v0.1 imponeva un global lock single-mission: una sola mission `executing` per volta in tutto l'ecosistema. Bloccava lavoro parallelo su organi indipendenti.

**Soluzione v0.2.** Rimosso global lock. Introdotto **focus mechanism**: una mission "focused" per sessione (file `focus.json`). I comandi distruttivi (`advance`, `close`) richiedono `--mission=<ID>` esplicito quando >1 mission attiva, per prevenire cross-mission accidentale.

**Conseguenza diretta.** N mission possono coesistere in stato `executing` purché operino su file disgiunti. Verifica diff coerente è responsabilità della FASE 6 audit.

---

## 10. Multi-write per session_id (M-OS3-016)

**Problema residuo v0.2.** `focus.json` era single-slot per macchina. Due sessioni Claude Code parallele competevano per lo stesso slot → Write paralleli bloccati o cross-contamination.

**Soluzione v0.3.** Focus per-session via environment variable. Ogni sessione AI agent ha env univoca (in Claude Code: `CLAUDE_CODE_SESSION_ID`). Il focus è scritto in `~/oracode-engine/focus/<session_id>.json`. N sessioni = N focus paralleli, zero collisione.

> **Nota path (M-OS3-025 Unità 1).** La cartella globale del motore è `~/oracode-engine/` — **visibile**, non nascosta (direttiva CEO: "deve esserci ma non deve essere nascosta"). `~/.oracode` resta solo come **symlink di compat** verso `~/oracode-engine`.

**Fallback terminale standalone.** Quando l'env non è presente (terminale interattivo umano senza sessione AI), si usa il file legacy `focus.json` + `active-mission.lock` (in `~/oracode-engine/`).

**AMENDMENT 1 CEO (invariante anti-eredità).** Se l'env di sessione è presente MA il file `focus/<session_id>.json` è assente → il CLI deve restituire BLOCK. **Mai** ereditare focus dal legacy `focus.json`. Motivazione: una sessione AI agent che non ha esplicitamente fatto `focus <ID>` non deve agire su mission altrui.

---

## 11. Spawn fingerprint (M-OS3-005)

Quando una mission delega lavoro a un sub-agent (es. `doc-sync-v2`, `os3-audit-specialist`), il CLI registra una **fingerprint dello spawn**: hash dell'input + timestamp + tool_use_id + path file letti dal sub-agent.

**Scopo.** Verificare che il sub-agent sia stato effettivamente invocato (anti-allucinazione: AI che dichiara "ho spawned X" senza averlo fatto). La fingerprint è verificabile cross-session.

**Output.** Campo `spawn_fingerprint` nel mission state, contenente: `{agent_name, input_hash, timestamp, tool_use_id, evidence_files_read[]}`.

**Origine.** Incidente in cui Supervisor riportava esiti di audit non eseguiti. Pattern di reflexive validation.

---

## 12. Test-red whitelist `tests/**` in stato `planned`

P0-13 (Test-First Discipline) richiede test red prima di `executing`. Ma scrivere il test richiede `Write` su `tests/**`, che lo stato `planned` (in cui Write a codebase è proibito) blocca per default.

**Whitelist.** Nello stato `planned`, le operazioni Write sono ammesse **solo** se il path matcha il pattern `tests/**` (configurabile per istanza). Questo permette di:

1. Aprire mission (`open` → `draft`)
2. Avanzare a `planned` con scope approvato
3. Scrivere il test red **dentro `planned`**
4. Eseguire test red (deve fallire — exit ≠ 0)
5. Avanzare a `executing` con `--test-file=<path>` puntando al test red appena scritto

**Origine.** M-OS3-012 ha codificato la whitelist per non costringere a violazioni P0-13 al boot della mission.

---

## 13. Scope hash anti-drift

Al momento di `open`, il CLI calcola `SHA256(scope)` e lo memorizza in `state.scope_hash`. Ogni transizione di stato verifica che lo scope non sia stato modificato silenziosamente.

**Output esempio:** `Scope hash: 6c61d27e126b7d0efb384d44eee5bd4243be4b1ed212ee0a191a8c8260b4cee4`

**Conseguenza.** Una mission con scope modificato post-approvazione CEO viene rilevata come scope drift e bloccata. Per modificare lo scope serve un AMENDMENT esplicito (Sez 14).

---

## 14. Pattern AMENDMENT CEO

Durante l'esecuzione di una mission emergono spesso correzioni o estensioni di scope decise dal CEO. Modificare direttamente il design originale è un anti-pattern (revisionismo, perdita di tracciabilità).

**Pattern AMENDMENT.** Quando il CEO interviene post-approvazione su una decisione architetturale di una mission:

```
design v1.0
   │
   ├── AMENDMENT 1 — <data> — <motivazione CEO> — <decisione>
   ├── AMENDMENT 2 — <data> — <motivazione CEO> — <decisione>
   └── ...
   ▼
design v1.1 (consolidata dopo N amendments, alla chiusura mission)
```

**Vincoli:**

- Ogni AMENDMENT è additivo, mai sostitutivo del design originale
- Numerati progressivi nella mission (AMENDMENT 1, 2, ...)
- Citano la motivazione CEO esplicita (no inference)
- Consolidamento a `v.1` avviene alla chiusura mission, mai durante

**Esempio reale (M-OS3-016).** AMENDMENT 1: env presente + file assente = BLOCK, no eredità legacy. Decisione CEO post-spec originale.

---

## 15. Anti-pattern

### AP-MP-1 — Bootstrap fisso uguale per tutte le mission

Caricare lo stesso set di moduli a ogni apertura mission, indipendentemente da `type` e `organs`. Annulla il valore del bootstrap mirato.

### AP-MP-2 — Retrospective dichiarativo

Retrospective basato su autopercezione di Supervisor (*"mi sembra di non aver usato X"*) invece che su tracking empirico delle Read. Anti-pattern perché ricade nella deduzione (REGOLA ZERO).

### AP-MP-3 — Aggiornamento automatico di MISSION_BOOTSTRAP_INDEX

Sistema che applica direttamente le proposte del retrospective senza review umana. AI che modifica le proprie istruzioni operative senza supervisione.

### AP-MP-4 — Tracciamento incompleto

Tracking dei moduli consultati che salta forme indirette di accesso (es. `cat` in bash, accesso via grep, lettura tramite altri tool). Tracking deve coprire tutte le forme di accesso al filesystem.

### AP-MP-5 — Bootstrap accoppiato a istanza specifica

`MISSION_BOOTSTRAP_INDEX.json` con riferimenti hardcoded a path assoluti di un'istanza (es. `/home/fabio/EGI-DOC/...`). Il file deve usare riferimenti relativi alla sede dell'istanza, perché il pattern del Mission Protocol è di livello Oracode anche se l'istanza del registry è specifica.

---

## 16. Stratificazione vs LSO_NOMENCLATURE

Per chiarire l'appartenenza di ogni componente menzionato in questo documento:

| Componente | Livello | Note |
|---|---|---|
| Mission Protocol (questo documento) | Oracode (L1) | Universale |
| Pattern bootstrap mirato | Oracode (L1) | Universale |
| Pattern retrospective auto-migliorante | Oracode (L1) | Universale |
| `MISSION_REGISTRY.json` (consolidato + stats + numerazione globale) | HUB (L2) | File unico nel `<HUB>-DOC` della softwarehouse |
| `MISSION_REGISTRY.json` (per-istanza) | Istanza (L3) | Sede `<istanza>-DOC/docs/missions/` (EGI-DOC = istanza accoppiata legacy) |
| `MISSION_BOOTSTRAP_INDEX.json` | Istanza (L3) | Sede `<istanza>-DOC/docs/missions/` |
| `BOOTSTRAP_DRIFT_LOG.md` | Istanza (L3) | Sede `<istanza>-DOC/docs/missions/` |
| Tipi di mission specifici | Istanza (L3) | Tassonomia derivata dall'esperienza dell'istanza |

---

## 17. Versionamento e firma

**Versione**: 4.1.0
**Data**: 2026-06-01
**Sostituisce**: v3.0.0 (2026-05-27)

**Cambio minore (v4.0.0 → v4.1.0) — M-OS3-026**: bootstrap mirato (FASE 1) cablato all'open (`emitBootstrap`); + blocco mission-fantasma A1 e convenzione ID prefissato (CEO 2026-06-01).

**Cambio maggiore (v3.0.0 → v4.0.0) — M-OS3-025**: ingresso in **Oracode Nexus** (gerarchia 3 livelli L1/L2/L3). Ponte L1→L3 automatico (`syncToRepoRegistry` via `.oracode/project.json`), chiavi registry INGLESE, `~/oracode-engine` visibile, stats/numerazione al HUB, subcomando `finalize`, slash command globale `/mission`. + blocco mission-fantasma A1 e convenzione ID prefissato (decisioni CEO 2026-06-01). Dettaglio: front-matter + Sez 3 (FASE 0) + tabella evoluzione (riga changelog v4.0.0).

**Cambio maggiore (v2.0.0 → v3.0.0) — M-OS3-018**:
- Codifica della state machine a 7 stati operativi (Sez 7)
- Introduzione del CLI di riferimento `bin/mission` v0.3 (Sez 8)
- Multi-mission concurrency M-OS3-012 (Sez 9)
- Multi-write per `session_id` M-OS3-016 + AMENDMENT 1 CEO (Sez 10)
- Spawn fingerprint M-OS3-005 (Sez 11)
- Test-red whitelist `tests/**` in stato `planned` (Sez 12)
- Scope hash anti-drift (Sez 13)
- Pattern AMENDMENT CEO formalizzato (Sez 14)
- ESITO A/B/C verification pre-close (Sez 6.5)
- Aggiunto changelog M-OS3 sessioni 1+2+3 (Sez 18)

**Cambio maggiore (v1.1.0 → v2.0.0)** [storico, da v2.0.0]:
- Estensione FASE 1 con bootstrap mirato
- Estensione FASE 6 con retrospective auto-migliorante
- Introduzione di `MISSION_BOOTSTRAP_INDEX.json` e `BOOTSTRAP_DRIFT_LOG.md` come SSOT del Mission Protocol
- Codifica di 5 anti-pattern specifici al protocollo
- Esplicitazione della stratificazione vs LSO_NOMENCLATURE

Il ciclo a 6 fasi e la prenotazione ID anti-collisione sono mantenuti da v1.1.0.

**Documento scritto da**: Padmin Watchdog (Claude Opus 4.7)
**Approvato da**: Fabio Cherici (CEO)
**Data approvazione**: 2026-05-27

---

## 18. Changelog M-OS3 — Sessioni 1+2+3 (riferimento)

| Mission | Sessione | Cambiamento al Mission Protocol |
|---|---|---|
| M-OS3-001 | 1 | State machine 7 stati non-aggirabile, scope hash, lock globale |
| M-OS3-002 | 1 | Ultra Provenance Guard UEM+ULM+UTM (collaterale) |
| M-OS3-003 | 1 | Organ Index pre-Write TS+JS (collaterale) |
| M-OS3-005 | 1 | Spawn fingerprint — verifica spawn agente reale |
| M-OS3-006 | 1 | Test Quality Gate — stati `auditing_failed`, `closed_with_debt` |
| M-OS3-007 | 1 | Package Reality Check (collaterale) |
| M-OS3-008 | 2 | Trigger Matrix Auto-Classification |
| M-OS3-009 | 2 | Mission Timeout + Auto-Suspend, stato `aborted` |
| M-OS3-011 | 2 | SSOT-Code Consistency Guard (collaterale) |
| M-OS3-012 | 2 | Multi-mission concurrency, rimozione global lock, test-red whitelist `tests/**` in `planned` |
| M-OS3-013 | 3 | Hardening hook OS3 Matrix S2-14/15/18/19/21 + S2-23 uem-code-validation (collaterale) |
| M-OS3-016 | 3 | Multi-write per `session_id`, focus per-session, AMENDMENT 1 anti-eredità |
| M-OS3-017 | 3 | Cross-organism SSOT tracking (concept, design pending) |
| M-OS3-018 | 3 | **Questo documento — SSOT Oracode realignment v3.0.0** |
| M-OS3-025 | 4 | Ponte automatico L1→L3 (`bin/mission` + `.oracode/project.json`), migrazione `~/.oracode`→`~/oracode-engine` (visibile), `finalize` orchestra enrich+retrospective. + **blocco mission-fantasma A1** (`open` BLOCCA fuori da un progetto, `--global` override) e **convenzione ID prefissato** (CEO 2026-06-01). **Bump v4.0.0** |
| M-OS3-026 | 4 | **Bootstrap mirato cablato all'open** — `emitBootstrap` in `cmdOpen` emette la lista moduli calibrata per `type`+`organs` da `MISSION_BOOTSTRAP_INDEX.json` (path, non contenuto → token-light). FASE 1 ora eseguita dal motore. **Bump v4.1.0** |

> **DOC-SYNC Oracode Nexus 3-tier (2026-05-31).** Allineamento alla legge `ORACODE_NEXUS_3_TIER.md`: stratificazione su 3 livelli (L1 motore / L2 HUB / L3 istanza), chiavi registry in **INGLESE**, FASE 0 via ponte automatico L1→L3, path motore `~/oracode-engine`, path retrospective `os3-matrix/bin/`. Bump a **v4.0.0 approvato dal CEO** (2026-05-31, M-OS3-025).
