---
title: Pattern Anello di Auto-Miglioramento
slug: pattern-anello-automiglioramento
doc_type: pattern
version: 1.0.0
status: DRAFT
date: '2026-06-17'
author: Padmin D. Curtis for Fabio Cherici
mission: M-NEXUS-000
scope:
  - oracode
priority: high
visibility: public
rag: public
---

# Pattern: Anello di Auto-Miglioramento (LSO)

> @purpose Definire il pattern dell'anello errore→fix→apprendimento dell'organismo LSO
> nella sua VERSIONE AUTONOMA auto-innescata, dichiarando dove l'agente si ferma e
> dove solo l'umano agisce. Non duplica il metodo gated di Fucina: lo referenzia come
> metodo-padre e ne è la specializzazione auto-innescata.

## 0. Status e scopo

- **Status**: DRAFT (mission M-NEXUS-000, decisioni CEO ratificate 2026-06-16).
- **Cosa operazionalizza**: questo pattern è la **realizzazione concreta di L9 — Riflessione,
  Gamba B (Autocorrezione operativa)** (`docs/paradigm/nomenclature/LSO_NOMENCLATURE_v2.md:699`).
  NON è L10 (riproduzione) né L11 (auto-governance costituzionale).
- **Soglia**: realizza l'attraversamento della **Soglia 2** (L8→L9: da organismo reattivo a
  riflessivo — `LSO_NOMENCLATURE_v2.md:672-677`), la soglia attuale del paradigma. Non la eccede.

## 1. Definizione

L'**anello di auto-miglioramento** è il ciclo:

```
errore osservato → diagnosi → fix in sandbox → prova → ratifica umana → propagazione → apprendimento
```

Precisazioni vincolanti (grounded):

- **"Propagare nei SSOT"** = **allineamento codice↔documentazione (L9 Gamba B)**, NON divisione
  di istanza (L10) né modifica del genoma costituzionale (L11).
- Con la ratifica del fondatore su OGNI azione (invariante #4), l'organismo che esegue questo
  anello è nello **Stato Riflessivo (L1-L10)** — vive, si pensa, si autocorregge, ma **dipende dal
  fondatore** (`LSO_NOMENCLATURE_v2.md:683`). NON è Stato Stabile di Specie (L1-L11).

- **Ordine ratifica→propagazione**: la propagazione è PREPARATA come patch proposto (DOC-SYNC ESITO C); la scrittura nei SSOT avviene SOLO dopo la ratifica umana. Niente entra nel genoma prima della ratifica del fondatore (corregge l'ordine fuorviante del riassunto a freccette).

## 2. I due anelli annidati e la barriera dura (doppia linea L8/L9)

L'anello esiste in due forme annidate, separate dalla **doppia linea tra L8 e L9** che divide i
layer reattivi dai layer evolutivi (`LSO_NOMENCLATURE_v2.md:628`):

| | Anello INTERNO (reattivo) | Anello ESTERNO (evolutivo) |
|---|---|---|
| **Layer (maturità)** | L1-L8 + Mission Protocol | L9 (Riflessione) |
| **Oggetto** | codice di un organo (tier T3 ISTANZA) | SSOT del paradigma / OSZ |
| **Reversibilità** | reversibile (git revert, test, mission) | irreversibile (genoma documentale) |
| **Potere dell'agente** | fino a "**proponi**" (mai merge/push autonomo) | solo "**proponi**" — mai scrittura |
| **Ratifica** | umana, su ogni esito (ESITO C → CEO) | umana, sempre (invariante #4) |

> **Invariante portante #4** (`LSO_NOMENCLATURE_v2.md:712`): *"L9 non ha potere di azione diretta
> — può solo produrre interpretazione. Solo gli umani convertono interpretazione in azione."*
> L'anello è progettato attorno a questo invariante: l'agente propone, l'umano ratifica TUTTO
> (decisione CEO D2).

### 2bis. La barriera è ENFORCED-BY-CONSTRUCTION (R-3, sign-off engineer-architecture)

La barriera L8/L9 **non è una convenzione di processo** ("l'agente solo propone") ma un **controllo
d'accesso meccanico**: il working-set scrivibile dell'agente dell'anello interno **esclude
fisicamente** i file SSOT del paradigma e le clausole Tier 0. Una barriera che dipendesse dalla
buona condotta dell'agente non sarebbe una barriera dura. L'elenco di ciò che è fuori dal write-set
e i suoi enforcer sono in `docs/paradigm/kernel/TIER0_CLAUSOLE_IMMUTABILI_v1.0.0.md` (W2). Fondamento:
le asimmetrie di velocità/degradazione dell'LLM richiedono "hook fail-closed, non istruzioni
interpretabili" (`LSO_NOMENCLATURE_v2.md:107`).

## 3. Trigger applicativo (PUSH, da UEM a Nexus)

Il segnale parte dall'organo e viene **spinto** (PUSH) verso il Nexus:

```
UEM ErrorManager::handle(...)
    → NexusNotificationHandler                  [NUOVO — gemello di
       EGI/app/ErrorManager/Handlers/TelegramNotificationHandler.php]
    → segnale strutturato autenticato → https://nexus.florenceegi.com   [riceve il segnale]
```

- **Trigger = PUSH** (decisione CEO D6): l'handler UEM invia attivamente il segnale.
- **error_logs = store durevole + rete di recupero (pull)**: se il PUSH si perde, lo storico errori
  resta la fonte recuperabile via cron-pull. Il PUSH è il nervo veloce; error_logs è la memoria.
- **Canale autenticato**: il segnale verso il Nexus viaggia su canale autenticato (no endpoint aperto).
- **Dove si fixa**: il fix è prodotto sul **workbench `code.florenceegi.com`** (sandbox dev/
  code-server), non sul Nexus. Disambiguazione D5: `nexus.florenceegi.com` = interfaccia/identità che
  RICEVE il segnale; `code.florenceegi.com` = ambiente di SVILUPPO dove gli agenti fixano.

### 3bis. Chiave di idempotenza — convivenza PUSH + pull (R-1, sign-off engineer-architecture)

PUSH-event e pull-backstop sono due produttori della stessa coda: l'idempotenza è proprietà del
**receiver**, non del trasporto. Per evitare doppio-dispatch dello stesso bug:

- **Chiave di dedup = error fingerprint** = `error_code` + hash del contesto sanitizzato. Riusa la
  logica già esistente `ErrorLog::getSimilarErrors()` (`ultra/ultra-error-manager/src/Models/ErrorLog.php:274`).
- **Dedup all'INGRESSO in coda** (UPSERT su `nexus_fix_queue` per fingerprint), non solo al claim in
  uscita: così PUSH e pull che vedono lo stesso errore **non creano due righe**.
- Il **claim atomico** `queued→claimed` resta il lock contro due worker sullo stesso bug.
- La coda porta un **riferimento** (claim-check), non il payload: la verità resta in `error_logs`.
- [da validare] deriva del fingerprint: se un fix cambia il messaggio d'errore, il fingerprint può
  cambiare → dedup degrada nel tempo (rischio Q7-adiacente, vedi §5).

> **La coda NON garantisce ordine** (G-2): dipendenze causali fra fix si risolvono a livello mission
> (Mission Protocol), non assumendo ordinamento globale degli eventi.

## 4. I quattro punti-di-stop dell'agente + GATE ANTI-SOPPRESSIONE (Q6)

L'agente si ferma OBBLIGATORIAMENTE in quattro punti:

1. **Causa-radice non verificabile → STOP** (REGOLA ZERO, `OSZ:147` — "mai dedurre").
2. **Test-first (P0-13)**: nessun fix senza un test RED che riproduce l'errore, poi GREEN.
3. **Interpretazione → azione = ratifica umana** (invariante #4, `:712`): l'agente propone; il merge
   è atto umano.
4. **Tensione con un contratto L7 → STOP**: vince il contratto, non il fix (invariante #3,
   `LSO_NOMENCLATURE_v2.md:711`).

### GATE ANTI-SOPPRESSIONE (Q6) — NUOVO (decisione CEO D9)

> Un fix **NON supera la QUARANTENA** finché non dimostra **CAUSA-RIMOSSA**, non "segnale-assente".

La QUARANTENA è lo stato in cui un fix attende ratifica. Per uscirne, l'evidenza deve mostrare che il
**path d'errore ri-eseguito esercita la logica corretta** (causa rimossa), NON che l'allarme ha
smesso di suonare (sintomo zittito). Un fix che fa solo sparire il segnale — silenziando il log,
ampliando un catch, abbassando una soglia — **fallisce Q6**. È un gate **nuovo** (non esiste nel loop
protocol di Fucina): è la difesa dell'anello applicativo contro l'auto-soppressione del proprio
sistema immunitario (L5/UEM). Fondamento end-to-end: la correttezza si verifica all'END applicativo
(path eseguito), non al livello-segnale (assenza di log).

## 5. Guardrail asimmetrici + GATE ANTI-COLLAPSE (Q7)

- **Anello-su-codice (OS3, reversibile)**: git + test + Mission Protocol come rete. Errore recuperabile.
- **Anello-su-SSOT (OSZ, irreversibile)**: tocca il genoma → invariante #6 (`:714`). Guardrail duri.

Il breaker per-recidiva (R-2) si apre sulla **recidiva post-fix** (l'errore torna DOPO un fix
propagato, finestra post-merge), non sulla frequenza grezza dell'errore (che alimenta solo la coda).

### GATE ANTI-COLLAPSE (Q7) — gate duro (decisione CEO D10)

Prima di propagare QUALSIASI auto-modifica d'agente sull'anello esterno, sono obbligatori e bloccanti:

1. **Stop-al-plateau enforced**: a convergenza non si lima (anti-Goodhart); la leva diventa espandere
   il dominio, su gate CEO.
2. **Ri-derivazione da fonte primaria**: la modifica si ancora alla fonte primaria, non all'output di
   un giro precedente (anti model-collapse).
3. **Misura esterna obbligatoria**: un verifier esterno (non auto-giudizio) misura PRIMA della
   propagazione. NO self-preference.

> **Provenienza (REGOLA ZERO, no duplicazione)**: questi tre principi sono già nel metodo-padre
> **`/home/fabio/Fucina/docs/ssot/SSOT_LOOP_PROTOCOL.md`**: stop-al-plateau (`:47`), ri-derivazione
> da fonte primaria / anti model-collapse (`:45`), reward esterno / verifier non auto-giudizio
> (`:44`, `:51`). Lì sono principi del loop gated. Questo pattern li **PROMUOVE a gate duri**
> dell'anello autonomo (Q7), perché qui l'innesco è automatico (UEM→Nexus) invece che manuale
> (open-CEO): senza gate duro, un anello auto-innescato collasserebbe su se stesso.

## 6. Collocazione nello stack

Realizzazione attesa della **Soglia 2** (L8→L9). **Non eccede** la soglia: non implementa L10 né L11.
La ratifica umana su ogni azione (invariante #4) mantiene l'organismo in **Stato Riflessivo (L1-L10)**.

## 7. Esistente vs nuovo

**Già esistente (riusare, non reinventare — REGOLA ZERO):**

- L9 Gamba B / DOC-SYNC v2 (allineamento codice↔SSOT autonomo).
- Retrospective → drift-log (apprendimento mission).
- Mission Protocol + spawn-fingerprint (tracciamento, anti-azione-a-freddo).
- `error_logs` + `TelegramNotificationHandler.php` (gemello del nuovo handler).
- Canary `AI_CANARY_FAILED` (rilevazione regressione, riusabile come kill-switch globale).

**Nuovo (da costruire in mission successive):**

- `NexusNotificationHandler` (handler UEM PUSH verso `nexus.florenceegi.com`).
- Dispatcher del segnale + coda `nexus_fix_queue` (dedup per error fingerprint, §3bis).
- Tre circuit-breaker (per-bug / per-recidiva post-fix / global kill-switch).
- Triage agent (classifica il segnale in arrivo).
- **GATE Q6 anti-soppressione** (nuovo, non derivato dal loop protocol).

## 8. Cross-reference

- `docs/paradigm/kernel/TIER0_CLAUSOLE_IMMUTABILI_v1.0.0.md` (W2 — Tier 0; invarianti #4/#6 cablati).
- `/home/fabio/Fucina/docs/ssot/SSOT_LOOP_PROTOCOL.md` (Fucina — **metodo-padre** gated; questo
  pattern ne è la versione autonoma auto-innescata).
- `docs/paradigm/missions/MISSION_PROTOCOL.md:326-336` (DOC-SYNC ESITO A/B/C — ratifica umana su patch SSOT).
- mission **W3** (os3-matrix — chiusura falla scope-drift, precondizione di attivazione) / mission
  **W4** (EGI — verifica isolamento `error_logs`↔prod, precondizione di attivazione).

## 9. Precondizioni di ATTIVAZIONE (il pattern si firma; l'autonomia non si accende finché)

- **W4**: `error_logs` (trigger) NON deve condividere il DB di produzione del sandbox, altrimenti
  injection-del-segnale + sandbox-escape collassano in un'unica catena verso prod.
- **W3**: la ri-verifica scope-drift dev'essere attiva a ogni transizione (`MISSION_PROTOCOL.md:473-478`),
  altrimenti la Strategia Delta non è enforced per un agente autonomo.

## [da validare]
- Stesso EC2 per `nexus.` e `code.` o macchine distinte (rete/credenziali) — confluisce in W4.
- Soglie dei 3 circuit-breaker (parametri, da fissare dal CEO).
- Deriva del fingerprint d'errore nel tempo (§3bis).
