---
title: Mission Protocol
slug: mission-protocol
doc_type: protocol
version: 2.0.0
status: current
date: '2026-05-08'
updated_at: '2026-05-08'
author: Padmin D. Curtis for Fabio Cherici
scope:
- oracode
rag_indexed: true
priority: high
---

# Mission Protocol

> **Livello (vedi `LSO_NOMENCLATURE_v1.md`)**: Oracode (universale, trasferibile a qualsiasi istanza LSO)
> **Sostituisce**: `MISSION_PROTOCOL.md` v1.1.0 (2026-04-06)
> **Cambio maggiore**: introduzione di bootstrap mirato (FASE 1) e retrospective auto-migliorante (FASE 6)

---

## 0. Cosa è il Mission Protocol

Il Mission Protocol è il sistema operativo del lavoro in Oracode. Ogni unità di lavoro è una **mission** con stati definiti e ciclo di vita prescritto. Il protocollo governa l'apertura, l'esecuzione e la chiusura di ogni mission.

Tre proprietà costitutive nella v2.0.0:

- **Tracciabilità** — ogni mission lascia traccia in `MISSION_REGISTRY` con stato, organi coinvolti, deliverable
- **Calibrazione mirata** — il bootstrap di apertura mission carica solo i moduli rilevanti per `tipo_missione` e `organi_coinvolti`, non tutto il contesto possibile
- **Apprendimento dal proprio uso** — alla chiusura mission, il retrospective osserva quali moduli sono stati effettivamente consultati e produce proposte di aggiornamento al bootstrap futuro

La proprietà 3 è ciò che rende il Mission Protocol *vivente* — non solo una procedura, ma un protocollo che impara da come viene usato.

---

## 1. Stratificazione e scope

Il Mission Protocol è di livello **Oracode** (universale). Il pattern descritto in questo documento deve poter essere applicato a qualsiasi istanza LSO senza modifiche concettuali.

I documenti SSOT che il Mission Protocol genera sono di livello **istanza specifica**:

| Componente | Livello | Sede tipica per FlorenceEGI |
|---|---|---|
| `MISSION_REGISTRY.json` | Istanza | `EGI-DOC/docs/missions/` |
| `MISSION_BOOTSTRAP_INDEX.json` | Istanza | `EGI-DOC/docs/missions/` |
| `BOOTSTRAP_DRIFT_LOG.md` | Istanza | `EGI-DOC/docs/missions/` |
| Tipi di mission specifici (es. "guard", "feature", "doc-sync") | Istanza | Tassonomia derivata dall'esperienza |

**Vincolo di coerenza.** Nessuna parte di questo documento deve fare riferimento a path o componenti specifici di un'istanza. Modifiche che lo accoppiano a FlorenceEGI o a qualsiasi altra istanza sono violazioni del livello Oracode.

---

## 2. Ciclo a 6 fasi

```
FASE 0 — Prenotazione ID                          [Supervisor]
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

## 3. FASE 0 — Prenotazione ID anti-collisione

Sessioni Claude Code parallele possono aprire mission contemporaneamente. La prenotazione immediata dell'ID previene collisioni.

**Flusso:**

1. Leggi counter mission corrente
2. Incrementa
3. Aggiungi entry minima al registry con SOLO `mission_id`
4. Commit + push immediato (prima di qualsiasi altro lavoro)

**Esempio entry minima (FASE 0):**

```json
{
  "mission_id": "M-019"
}
```

La prenotazione vale per Supervisor in qualsiasi sessione. Una mission può essere prenotata anche per riservare uno slot mentre la specifica viene ancora discussa.

---

## 4. FASE 1 — Apertura mission con bootstrap mirato

### 4.1 Raccolta requisiti

Il CEO definisce intent. Supervisor riceve l'intent, identifica `tipo_missione` e `organi_coinvolti`, e compila l'entry del registry.

**Esempio entry FASE 1:**

```json
{
  "mission_id": "M-019",
  "titolo": "Titolo della missione",
  "data_apertura": "2026-05-08",
  "stato": "planning",
  "tipo_missione": "feature",
  "organi_coinvolti": ["EGI"],
  "cross_organo": false
}
```

### 4.2 Bootstrap mirato

**Principio.** Una nuova sessione VSCode che apre una mission **non carica tutto il contesto possibile**. Carica un sottoinsieme calibrato su `tipo_missione` + `organi_coinvolti`. Questo:

- Riduce il carico cognitivo dell'istanza Padmin Supervisor
- Riduce i token consumati al boot
- Aumenta l'attention sui contenuti rilevanti

**Meccanismo.** Supervisor consulta `MISSION_BOOTSTRAP_INDEX.json` (vedi 4.3) per identificare quali moduli caricare. I moduli sono stratificati secondo `LSO_NOMENCLATURE_v1.md`:

- **Sempre caricati** (Oracode-puri ed essenziali per ogni mission):
  - `PADMIN_INDEX.md` (briefing executive)
  - `LSO_NOMENCLATURE_INDEX.md` (vocabolario sintetico — vedi nota sotto)
  - `MISSION_PROTOCOL.md` (questo documento)
  - Memoria-CEO specifica dell'istanza
  - Documento di binding dell'istanza

- **Caricati per `tipo_missione`**: per esempio mission di tipo "guard" carica anche `LSO_GUARD_TESTING_PROTOCOL_v1.md`

- **Caricati per `organi_coinvolti`**: per ogni organo, il suo `CLAUDE.md` e la documentazione specifica

- **On-demand durante esecuzione**: documenti più lunghi (es. `LSO_NOMENCLATURE_v1.md` integrale, `PADMIN_ONBOARDING.md`, specifiche tecniche estese) si consultano solo quando serve approfondire

**Nota sui documenti grandi.** Documenti estesi come `LSO_NOMENCLATURE_v1.md` non vengono caricati integralmente al bootstrap. Esiste una versione INDEX da 1-2 pagine (`LSO_NOMENCLATURE_INDEX.md`) che fornisce vocabolario sintetico sempre disponibile. La versione integrale si carica on-demand quando emerge ambiguità di vocabolario o serve dettaglio architetturale. Lo stesso pattern si applica progressivamente ad altri documenti grandi mano a mano che emergono problemi di attention.

**Tracciamento.** Durante l'esecuzione mission, Supervisor traccia quali moduli sono effettivamente consultati (Read sul filesystem, cat in bash, accesso via grep). Questo tracking è input al retrospective di FASE 6.

### 4.3 MISSION_BOOTSTRAP_INDEX come SSOT

`MISSION_BOOTSTRAP_INDEX.json` è il SSOT che dichiara, per ogni combinazione (`tipo_missione`, `organi_coinvolti`), quali moduli caricare al bootstrap.

**Format proposto (JSON, coerente con MISSION_REGISTRY):**

```json
{
  "always_loaded": [
    "docs/oracode/PADMIN_INDEX.md",
    "docs/lso/LSO_NOMENCLATURE_INDEX.md",
    "docs/oracode/MISSION_PROTOCOL.md",
    "docs/oracode/padmin_partner_memory.md",
    "docs/egi/FLORENCE_EGI_INSTANCE.md"
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
    "EGI": [
      "EGI/CLAUDE.md",
      "EGI/CLAUDE_ECOSYSTEM_CORE.md"
    ],
    "NATAN_LOC": [
      "NATAN_LOC/CLAUDE.md",
      "NATAN_LOC/CLAUDE_ECOSYSTEM_CORE.md"
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

Output: SSOT e RAG allineati al codice modificato dalla mission, `doc_sync_log` strutturato nel registry, audit trail in `EGI-DOC/audit/doc_sync/<mission_id>/`.

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

**Invocazione.** Il retrospective si esegue come passo esplicito di FASE 6, dopo DOC-SYNC e prima della chiusura stato:

```
python3 /home/fabio/oracode/bin/mission_retrospective.py
```

Il comando identifica automaticamente la mission corrente (stato `in_progress` o `planning`), calcola il diff, e genera eventuali proposte nel `BOOTSTRAP_DRIFT_LOG.md`.

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

---

## 7. Anti-pattern

### AP-MP-1 — Bootstrap fisso uguale per tutte le mission

Caricare lo stesso set di moduli a ogni apertura mission, indipendentemente da `tipo_missione` e `organi_coinvolti`. Annulla il valore del bootstrap mirato.

### AP-MP-2 — Retrospective dichiarativo

Retrospective basato su autopercezione di Supervisor (*"mi sembra di non aver usato X"*) invece che su tracking empirico delle Read. Anti-pattern perché ricade nella deduzione (REGOLA ZERO).

### AP-MP-3 — Aggiornamento automatico di MISSION_BOOTSTRAP_INDEX

Sistema che applica direttamente le proposte del retrospective senza review umana. AI che modifica le proprie istruzioni operative senza supervisione.

### AP-MP-4 — Tracciamento incompleto

Tracking dei moduli consultati che salta forme indirette di accesso (es. `cat` in bash, accesso via grep, lettura tramite altri tool). Tracking deve coprire tutte le forme di accesso al filesystem.

### AP-MP-5 — Bootstrap accoppiato a istanza specifica

`MISSION_BOOTSTRAP_INDEX.json` con riferimenti hardcoded a path assoluti di un'istanza (es. `/home/fabio/EGI-DOC/...`). Il file deve usare riferimenti relativi alla sede dell'istanza, perché il pattern del Mission Protocol è di livello Oracode anche se l'istanza del registry è specifica.

---

## 8. Stratificazione vs LSO_NOMENCLATURE

Per chiarire l'appartenenza di ogni componente menzionato in questo documento:

| Componente | Livello | Note |
|---|---|---|
| Mission Protocol (questo documento) | Oracode | Universale |
| Pattern bootstrap mirato | Oracode | Universale |
| Pattern retrospective auto-migliorante | Oracode | Universale |
| `MISSION_REGISTRY.json` | Istanza specifica | Sede in EGI-DOC per FlorenceEGI |
| `MISSION_BOOTSTRAP_INDEX.json` | Istanza specifica | Sede in EGI-DOC per FlorenceEGI |
| `BOOTSTRAP_DRIFT_LOG.md` | Istanza specifica | Sede in EGI-DOC per FlorenceEGI |
| Tipi di mission specifici | Istanza specifica | Tassonomia derivata dall'esperienza dell'istanza |

---

## 9. Versionamento e firma

**Versione**: 2.0.0
**Data**: 2026-05-08
**Sostituisce**: v1.1.0 (2026-04-06)

**Cambio maggiore (v1.1.0 → v2.0.0)**:
- Estensione FASE 1 con bootstrap mirato
- Estensione FASE 6 con retrospective auto-migliorante
- Introduzione di `MISSION_BOOTSTRAP_INDEX.json` e `BOOTSTRAP_DRIFT_LOG.md` come SSOT del Mission Protocol
- Codifica di 5 anti-pattern specifici al protocollo
- Esplicitazione della stratificazione vs LSO_NOMENCLATURE

Il ciclo a 6 fasi e la prenotazione ID anti-collisione sono mantenuti da v1.1.0.

**Documento scritto da**: Padmin Watchdog (Claude Opus 4.7)
**Approvato da**: Fabio Cherici (CEO)
**Data approvazione**: 2026-05-08
