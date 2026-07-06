---
visibility: public
rag: public
---

> ⛔ **DEPRECATO — clausole di stato (M-OS3-138, 2026-07-06).** Le affermazioni «FlorenceEGI/EGI-DOC = HUB+istanza *accoppiato* / *caso unico*; L2/HUB *differito* finché non ci sono 2+ clienti» in questo documento sono **superate**: il disaccoppiamento è fatto, **L2 = Florence EGI S.R.L.** (software house acquirente con licenza Nexus) *esiste*, e le istanze L3-clienti sono già molte (FlorenceEGI, Capasso, LeVespe, DeepDebug). Stato corrente autoritativo → **oracode: docs/paradigm/nomenclature/NEXUS_HIERARCHY_CURRENT_STATE.md**. Le *definizioni core* L1/L2/L3 restano valide.


# M-NOMENCL-OSMX-002 — DELTA Proposal v2

> **Mission:** Introduzione di OS3 Matrix (OSMx) come articolazione interna di Oracode (§1.1)
> **Sorgente:** LSO_NOMENCLATURE_v1-1-0.md (v1.1.0, 22 maggio 2026)
> **Target:** LSO_NOMENCLATURE_v2.md (v2.0.0)
> **Data:** 2026-05-22
> **Autore:** Padmin Supervisor per Fabio Cherici
> **Status:** IN ATTESA APPROVAZIONE CEO
> **Sostituisce:** DELTA v1 (archiviato in `proposals/archived/`, collocazione sbagliata)

> ⚠ **Superseded-context.** Questa proposal (2026-05-22) precede la gerarchia **Oracode Nexus a 3 livelli** (`../ORACODE_NEXUS_3_TIER.md`, decisioni CEO 2026-05-30/31) e il **Ponte L1→L3 automatico** (M-OS3-025 Unità 3, `bin/mission syncToRepoRegistry`, parallel-safe — già FATTO). La descrizione «Mission Protocol enforcement automatico / registry JSON come SSOT con commit+push immediato» va letta alla luce della separazione: **L1** = motore (scratch runtime in `~/oracode-engine`, NON un registro) / **L2 HUB** = primo vero `MISSION_REGISTRY` (statistiche + numerazione globale unica, versionato nel registry-DOC dell'istanza HUB, es. HUB-DOC su FlorenceEGI) / **L3 ISTANZA** = registry proprio del progetto (ponte L1→L3 automatico via `.oracode/project.json` risolto dal CWD; chiavi in INGLESE — `id/title/type/organs/status/date_open/date_close` —, l'italiano del registry d'istanza, es. EGI-DOC su FlorenceEGI, è legacy). Quando la proposal verrà applicata a `LSO_NOMENCLATURE_v2.md`, allineare a quella gerarchia.

---

## Correzione rispetto al DELTA v1

Il DELTA v1 trattava OS3 Matrix come sezione separata accanto ai 4 livelli (proponeva nuova §4). Sbagliato. OS3 Matrix vive **dentro** §1.1 (Oracode) come articolazione interna. La tassonomia a 4 livelli resta invariata. Nessuna nuova sezione di primo livello. Nessuna rinumerazione.

**Struttura corretta:**

```
§1.1 Oracode
  §1.1.A — Oracode-paradigma (pensiero puro)
  §1.1.B — OS3 Matrix / OSMx (strumento di enforcement)

§3.1 Componenti di Oracode
  §3.1.A — Componenti del paradigma (§3.1.A.1, §3.1.A.2, ...)
  §3.1.B — Componenti di OS3 Matrix
```

**Convenzione:** lettere maiuscole (A, B) per i piani interni, distinte otticamente dalle sotto-sezioni numerate.

---

## (a) Mappatura componente per componente

Principio guida invariato: **pattern resta in §1.1.A / §3.1.A, implementazione esecutiva va in §1.1.B / §3.1.B**.

### Componenti di §1.1 (Composizione Oracode, righe 49-58)

| # | Componente | Oggi (v1.1.0) | Proposto (v2.0.0) | Note |
|---|---|---|---|---|
| 1 | Regole epistemiche (REGOLA ZERO, 13 P0, anti-evasion) | §1.1 | **§1.1.A** | Disciplina concettuale pura |
| 2 | Sistema circolatorio — Mission Protocol (pattern) | §1.1 | **§1.1.A** | Pattern architetturale |
| 3 | Sistema circolatorio — DOC-SYNC (pattern) | §1.1 | **§1.1.A** | Pattern co-evoluzione codice↔doc |
| 4 | Sistema circolatorio — RAG interno (pattern) | §1.1 | **§1.1.A** | Pattern memoria operativa |
| 5 | Sistema circolatorio — Helping conversazionale (pattern) | §1.1 | **§1.1.A** | Pattern esposizione RAG |
| 6 | **Hook bloccanti** | §1.1 | **§1.1.B** | Software runtime |
| 7 | **Gate validator** | §1.1 | **§1.1.B** | Software runtime |
| 8 | **Drift detection** | §1.1 | **§1.1.B** | DOC-SYNC v2 nightly cron |
| 9 | **SSOT registry** | §1.1 | **§1.1.B** | Infrastruttura segnali (L0 Mielina) |
| 10 | Protocolli di handoff — mission registry (pattern) | §1.1 | **§1.1.A** | Pattern tracciamento |
| 11 | Protocolli di handoff — handoff AI-to-AI (pattern) | §1.1 | **§1.1.A** | Pattern continuita |
| 12 | Protocolli di handoff — partner memory (pattern) | §1.1 | **§1.1.A** | Pattern memoria persistente |
| 13 | Disciplina documentale | §1.1 | **§1.1.A** | Standard, non software |
| 14 | Disciplina di codice — Famiglia Ultra | §1.1 | **§1.1.A** | Librerie infrastrutturali paradigma |
| 15 | Standard SEO + Accessibility | §1.1 | **§1.1.A** | Standard, non enforcement |
| 16 | Infrastruttura GDPR strutturata | §1.1 | **§1.1.A** | Pattern compliance |

### Componenti di §3.1 (Componenti di Oracode, righe 217-664)

| # | Componente (sotto-sezione attuale) | Oggi | Proposto (v2.0.0) | Note |
|---|---|---|---|---|
| 17 | §3.1.1 Gerarchia OSZ → OS3 → OS4 | §3.1 | **§3.1.A.1** | Anatomia paradigma |
| 18 | §3.1.2 6+1 Pilastri Cardinali | §3.1 | **§3.1.A.2** | Concetti fondativi |
| 19 | §3.1.3 Sistema Priorita P0-P3 | §3.1 | **§3.1.A.3** | Tassonomia concettuale |
| 20 | §3.1.4 Le 13 Regole Sacre P0 | §3.1 | **§3.1.A.4** | Regole epistemiche |
| 21 | §3.1.4/P0-13 "Pattern di enforcement" (hook/gate concreti, righe 328-332) | §3.1 | **§3.1.B** (spostati) | Il *principio* resta in §3.1.A.4; gli hook/gate concreti migrano |
| 22 | §3.1.5 Strategia Delta | §3.1 | **§3.1.A.5** | Pattern gestione legacy |
| 23 | §3.1.6 Primitivi OSZ | §3.1 | **§3.1.A.6** | Livello kernel |
| 24 | §3.1.7 Famiglia Ultra | §3.1 | **§3.1.A.7** | Infrastruttura obbligatoria paradigma |
| 25 | §3.1.8 SEO obbligatorio | §3.1 | **§3.1.A.8** | Standard. Nota: il *gate CI/CD Lighthouse* (riga 403) va cross-referenziato come componente §3.1.B |
| 26 | §3.1.9 Schema.org / JSON-LD | §3.1 | **§3.1.A.9** | Standard |
| 27 | §3.1.10 Accessibility WCAG 2.1 AA | §3.1 | **§3.1.A.10** | Standard |
| 28 | §3.1.11 Compliance GDPR | §3.1 | **§3.1.A.11** | Pattern compliance |
| 29 | §3.1.12 Sistema circolatorio mono-organo (pattern) | §3.1 | **§3.1.A.12** | Pattern puri |
| 30 | §3.1.13 Hook Enforcement System (pattern) | §3.1 | **SDOPPIATO**: il *pattern universale* ("ogni P0 ha enforcement meccanico") resta in **§3.1.A.13**; l'*elenco hook concreti* (righe 489-492) migra in **§3.1.B** | Separazione netta pattern/implementazione |
| 31 | §3.1.14 Disciplina documentale | §3.1 | **§3.1.A.14** | Standard |
| 32 | §3.1.15 Layer Stack | §3.1 | **§3.1.A.15** | Architettura paradigma. L0 Mielina (riga 589-591) va cross-referenziato come componente §3.1.B |

### Componenti operativi non presenti nel v1.1.0 (da aggiungere in §1.1.B / §3.1.B)

| # | Componente | Dove vive oggi | Proposto |
|---|---|---|---|
| 33 | Agenti specializzati (doc-sync-v2, os3-gate, os3-audit, ssot-living-agent, etc.) | CLAUDE_ECOSYSTEM_CORE.md | **§1.1.B + §3.1.B** |
| 34 | DOC-SYNC v2 come software runtime (nightly cron, coverage check, re-indexing RAG) | Operativo, non in nomenclatura | **§1.1.B + §3.1.B** |
| 35 | Mission Protocol enforcement automatico (counter, prenotazione, fasi obbligatorie) | CLAUDE_ECOSYSTEM_CORE.md | **§1.1.B + §3.1.B** |

**Totale: 35 componenti mappati. 22 restano in §1.1.A / §3.1.A. 10 migrano in §1.1.B / §3.1.B. 3 nuovi aggiunti in §1.1.B / §3.1.B.**

---

## (b) Nuova struttura di §1.1

### Schema proposto

```markdown
### 1.1 Oracode

[Paragrafo introduttivo invariato: posizionamento storico, OOP → SOLID → Oracode]

[Paragrafo riformulato: dove oggi dice "hook che enforcano regole anti-deduzione"
come parte della cornice Oracode, riformulare separando la regola (paradigma)
dall'enforcement (Matrix)]

**Definizione operativa.** [invariata]

**Articolazione interna.** Dal 21 maggio 2026, Oracode si articola
formalmente in due piani interni:

- **Oracode-paradigma (§1.1.A)** — il pensiero puro: regole epistemiche,
  pilastri, triade OSZ/OS3/OS4, pattern architetturali (Mission Protocol,
  DOC-SYNC, RAG, Helping), standard (SEO, A11y, GDPR), disciplina
  documentale, Strategia Delta, layer stack L0-L11. Tutto cio che e
  trasferibile a qualsiasi dominio come metodologia.

- **OS3 Matrix (§1.1.B)** — lo strumento di enforcement: il software che
  fa rispettare le regole del paradigma al piano OS3, dove l'AI opera come
  co-autore a velocita non verificabile dall'umano in tempo reale. Hook
  bloccanti, gate validator, agenti specializzati, DOC-SYNC v2 come
  software runtime, drift detection, SSOT registry, Mission Protocol
  enforcement automatico.

Questa separazione non cambia cosa Oracode e. Cambia come lo si descrive:
il paradigma prescrive, la Matrix enforcea. Senza il paradigma, la Matrix
non ha regole da far rispettare. Senza la Matrix, le regole restano
indicazioni interpretabili — fragili sotto la pressione di un LLM che
produce a 100x la velocita dell'umano.

#### 1.1.A Oracode-paradigma

**Composizione.** Oracode-paradigma include:

- **Regole epistemiche** — REGOLA ZERO (mai dedurre, solo chiedere), 13
  regole P0, anti-evasion patterns
- **Sistema circolatorio mono-organo** — Mission Protocol (track record
  decisionale), DOC-SYNC (allineamento codice ↔ documentazione), RAG
  interno (memoria operativa che cresce con l'uso), Sistema di Helping
  conversazionale (ogni applicazione Oracode espone il proprio RAG via
  interfaccia conversazionale)
- **Protocolli di handoff** — mission registry, handoff AI-to-AI
  documentati, partner memory tra istanze AI
- **Disciplina documentale** — CLAUDE.md gerarchici, naming conventions,
  immutable values, manifesti
- **Disciplina di codice obbligatoria** — librerie infrastrutturali per
  gestione errori, log, traduzioni, configurazione, upload (Famiglia Ultra)
- **Standard SEO + Accessibility** per contenuto pubblico
- **Infrastruttura GDPR strutturata** come strato di prima classe
- **Layer Stack L0-L11** — stratificazione architetturale dell'organismo

Il sistema circolatorio mono-organo e la proprieta che rende *vivente*
qualsiasi applicazione costruita con Oracode [resto del paragrafo invariato
da riga 60].

**Distinzione pattern / implementazione.** [invariato, righe 62-71]

**Test di coerenza (vincolo spin-off).** [invariato, riga 73]

#### 1.1.B OS3 Matrix (OSMx)

**Definizione operativa.** OS3 Matrix e l'insieme dei componenti software
che fanno rispettare le regole di Oracode-paradigma al piano OS3, dove l'AI
opera come co-autore a velocita non verificabile dall'umano in tempo reale.
Alias breve: OSMx. Entrambi i nomi sono validi.

**Giustificazione filosofica — l'asimmetria umano/LLM.**

L'enforcement automatico non e burocrazia. E risposta strutturale a un
problema che non esisteva prima dell'era AI.

*Asimmetria di velocita.* Un LLM produce codice, documentazione, decisioni
architetturali a una velocita che rende impossibile la revisione umana in
tempo reale. In un'ora di lavoro, un LLM puo generare 50 file, 10
migration, 200 edit. L'umano non puo leggere 200 edit in tempo reale e
verificare che ciascuno rispetti REGOLA ZERO, P0-2, P0-5, DOC-SYNC, naming
convention. Servono gate che lo facciano meccanicamente.

*Asimmetria di degradazione.* Un LLM non "impara" dalle correzioni
precedenti nella stessa sessione in modo affidabile. Puo violare una regola
P0 al minuto 45 anche se e stato corretto per la stessa violazione al
minuto 12. La degradazione non e errore — e proprieta strutturale della
generazione statistica. L'umano, corretto una volta, raramente ripete lo
stesso errore nello stesso contesto. Servono gate che non "correggano" ma
impediscano — hook fail-closed, non istruzioni interpretabili.

Queste due asimmetrie — velocita e degradazione — sono il fondamento di
OS3 Matrix.

**Composizione.** OS3 Matrix comprende:

- **Hook bloccanti** (PreToolUse/PostToolUse) — gate fail-closed che
  intercettano l'azione AI prima o dopo l'esecuzione. Ogni hook enforcea
  una o piu regole P0.
- **Agenti specializzati** — software autonomo che opera su scope specifici
  dell'organismo (doc-sync-v2, os3-audit-specialist, os3-gate,
  ssot-living-agent, oracode-alignment-interpreter, organ-gap-scout,
  e agenti specifici dell'istanza, es. `egili-blood-keeper` su FlorenceEGI).
- **DOC-SYNC v2 come software runtime** — drift detection autonoma via
  nightly cron, coverage check nativa, analisi semantica del diff a
  chiusura mission, re-indexing RAG sincrono con sanity check bloccante,
  audit trail completo. Non il *pattern* DOC-SYNC (che resta in §1.1.A)
  ma il *software* che lo implementa.
- **Gate validator** — OS3 Gate pre-push (PASS/WARN/BLOCK), gate CI/CD
  Lighthouse, gate coverage test.
- **Infrastruttura SSOT (L0 Mielina)** — SSOT_REGISTRY.json come mappa
  esplicita doc SSOT → file codebase, watches di copertura con segnalazione
  automatica di perdita.
- **Mission Protocol enforcement automatico** — counter prenotazione
  anti-collisione, enforcement fasi obbligatorie (FASE 0 → FASE 6),
  registry JSON come SSOT con commit+push immediato.

**Rapporto con Oracode-paradigma.**

```
Oracode-paradigma (§1.1.A)     OS3 Matrix (§1.1.B)
───────────────────────        ─────────────────────────
Definisce regole P0            Implementa hook che le enforcano
Prescrive DOC-SYNC             Esegue drift detection runtime
Disegna Mission Protocol       Enforcea fasi e counter
Impone standard SEO/A11y       Esegue gate Lighthouse bloccante
Stabilisce naming              Verifica naming via agent
```

OS3 Matrix serve il piano OS3 della triade. Non lo sostituisce, non lo
estende, non lo modifica. Se una regola del paradigma cambia, OS3 Matrix si
aggiorna per riflettere il cambio. Se OS3 Matrix si rompe, le regole
restano valide — perdono solo l'enforcement automatico.

**Perche non esiste OS4 Matrix ne OSZ Matrix.**

- OS4 (Educazione) opera sull'umano a velocita umana, con giudizio. Non
  servono gate meccanici — servono pattern pedagogici.
- OSZ (Kernel) e costituzionale. I principi kernel non si "enforcano a
  runtime" — si *sono*. Un kernel che ha bisogno di un tool per far
  rispettare se stesso non e un kernel.
- L'enforcement automatico serve solo dove c'e un agente che produce a
  velocita incontrollabile con degradazione possibile — l'LLM, piano OS3.

Esiste solo OS3 Matrix.

**Test di coerenza.** Un componente appartiene a OS3 Matrix se e solo se:

1. E software eseguibile — non regola, non pattern, non standard
2. Opera sul piano OS3 — interazione AI-Human in esecuzione
3. Il suo scopo primario e far rispettare una regola/pattern/vincolo di
   Oracode-paradigma
4. Se rimosso, Oracode resta concettualmente integro ma perde enforcement
   automatico su uno o piu punti
```

---

## (c) Nuova struttura di §3.1

### Schema proposto

```markdown
### 3.1 Componenti di Oracode (trasferibili a qualsiasi dominio)

[Nota introduttiva invariata: convenzione fondamentale, precisione
fondamentale — righe 211-213]

#### 3.1.A Componenti del paradigma

##### 3.1.A.1 Gerarchia di autorita OSZ → OS3 → OS4
[contenuto invariato dall'attuale §3.1.1, inclusa annotazione Mission A]

##### 3.1.A.2 6+1 Pilastri Cardinali
[contenuto invariato dall'attuale §3.1.2]

##### 3.1.A.3 Sistema Priorita P0-P3
[contenuto invariato dall'attuale §3.1.3]

##### 3.1.A.4 Le 13 Regole Sacre P0
[contenuto invariato dall'attuale §3.1.4, TRANNE:]
  - P0-8 Complete Flow Analysis: invariato
  - P0-13 Test-First Discipline: il testo concettuale resta.
    I 3 bullet "Pattern di enforcement" (righe 328-332) vengono
    sostituiti con rimando: "L'enforcement meccanico di P0-13
    (hook e gate) e in §3.1.B."

##### 3.1.A.5 Strategia Delta
[invariato dall'attuale §3.1.5]

##### 3.1.A.6 Primitivi OSZ
[invariato dall'attuale §3.1.6]

##### 3.1.A.7 Famiglia Ultra
[invariato dall'attuale §3.1.7]

##### 3.1.A.8 SEO obbligatorio
[invariato dall'attuale §3.1.8, con nota: "gate CI/CD Lighthouse
come implementazione runtime: vedi §3.1.B"]

##### 3.1.A.9 Schema.org / JSON-LD
[invariato dall'attuale §3.1.9]

##### 3.1.A.10 Accessibility WCAG 2.1 AA
[invariato dall'attuale §3.1.10]

##### 3.1.A.11 Compliance GDPR
[invariato dall'attuale §3.1.11]

##### 3.1.A.12 Sistema circolatorio mono-organo (pattern)
[invariato dall'attuale §3.1.12]

##### 3.1.A.13 Hook Enforcement System (pattern)
[dall'attuale §3.1.13: mantenere SOLO il principio universale
("ogni regola P0 puo essere associata a hook meccanici")
e il "pattern universale" a riga 494.
RIMUOVERE l'elenco hook concreti (righe 489-492) e spostarli in §3.1.B.
Lasciare rimando: "Implementazioni concrete degli hook: vedi §3.1.B."]

##### 3.1.A.14 Disciplina documentale
[invariato dall'attuale §3.1.14]

##### 3.1.A.15 Layer Stack
[invariato dall'attuale §3.1.15, incluso vincolo L9 "le due gambe"
(Mission A). L0 Mielina (righe 589-591) resta qui come concetto di
layer; aggiungere cross-ref: "implementazione concreta SSOT_REGISTRY.json
come infrastruttura: vedi §3.1.B"]

#### 3.1.B Componenti di OS3 Matrix (OSMx)

Questi sono i componenti software che implementano l'enforcement
delle regole definite in §3.1.A. Non sono pattern — sono programmi
eseguibili. Nella terminologia del Layer Stack (§3.1.A.15), OS3
Matrix abita principalmente i layer L1-L4 e L8.

##### Hook bloccanti (PreToolUse/PostToolUse)

Gate fail-closed che intercettano l'azione AI. Ogni hook enforcea
una o piu regole P0. Elenco operativo (istanza FlorenceEGI):

- hook P0-6 (anti-service-method)
- hook P0-4 (anti-method-invention)
- hook P0-11 (DOC-SYNC)
- hook ban-stack
- *(in roadmap)* hook P0-13 (test obbligatori)
- Hook che blocca commit feat:/fix: senza file test (da P0-13, §3.1.A.4)
- Gate validator coverage (da P0-13, §3.1.A.4)

##### Agenti specializzati

- `doc-sync-v2` — sincronizzazione SSOT a chiusura mission
- `os3-audit-specialist` — audit conformita Oracode
- `os3-gate` — validazione pre-push
- `ssot-living-agent` — verifica autonoma drift SSOT↔codebase
- `oracode-alignment-interpreter` — diagnostica allineamento semantico
- `organ-gap-scout` — identificazione gap evolutivi
- `egili-blood-keeper` — protezione sistema circolatorio dell'istanza (es. Egili su FlorenceEGI)

##### DOC-SYNC v2 (software runtime)

Implementazione esecutiva del pattern DOC-SYNC (§3.1.A.12):
drift detection autonoma via nightly cron, coverage check nativa,
analisi semantica diff, re-indexing RAG sincrono con sanity check
bloccante, audit trail completo.

##### Gate validator

- OS3 Gate pre-push (PASS/WARN/BLOCK)
- Gate CI/CD Lighthouse (score bloccanti per deploy)
- Gate coverage test (soglia configurabile per dominio)

##### Infrastruttura SSOT (L0 Mielina)

Implementazione concreta del layer L0 (§3.1.A.15):
SSOT_REGISTRY.json, watches di copertura, segnalazione automatica
perdita coverage.

##### Mission Protocol enforcement automatico

Implementazione esecutiva del pattern Mission Protocol (§3.1.A):
counter prenotazione anti-collisione, enforcement fasi obbligatorie
(FASE 0 → FASE 6), registry JSON come SSOT con commit+push
immediato.

**Test di appartenenza a §3.1.B.** Un componente sta qui se:

1. E software eseguibile
2. Opera al piano OS3 (interazione AI-Human)
3. Lo scopo e far rispettare una regola/pattern di §3.1.A
4. Se rimosso, §3.1.A resta concettualmente integro
```

---

## (d) Sotto-sezioni impattate dalla ricollocazione

| Sezione | Tipo di modifica | Dettaglio |
|---|---|---|
| **§1.1** (righe 41-73) | **Ristrutturazione interna** | Si apre in §1.1.A + §1.1.B. Paragrafo storico (riga 45): riformulare "hook che enforcano regole anti-deduzione" separando regola da enforcement. Bullet "Infrastruttura di enforcement" (riga 53): spostato in §1.1.B. Paragrafo "Distinzione pattern/implementazione" (rige 62-71): estendere la distinzione anche all'enforcement. Test di coerenza (riga 73): invariato, si applica sia ad A che a B. |
| **§1.2** | Nessuna modifica | Libreria LSO resta indipendente |
| **§1.3** | Nessuna modifica | |
| **§1.4** | Nessuna modifica | |
| **§2.1** (riga 130) | Aggiunta 1-2 frasi | "validazione continua (gate — enforcement runtime in OS3 Matrix, §1.1.B)". Frase aggiuntiva: "Oracode si avvale di OS3 Matrix come strumento di enforcement del piano OS3." |
| **§2.7** (riga 200) | Aggiunta parentetica | "hook bloccanti" → "(hook bloccanti — implementazione OS3 Matrix, §1.1.B)" |
| **§3.1** (righe 217-664) | **Ristrutturazione interna** | Si apre in §3.1.A + §3.1.B. Tutte le sotto-sezioni attuali (§3.1.1 → §3.1.15) diventano §3.1.A.1 → §3.1.A.15. Nuova §3.1.B con componenti OS3 Matrix. |
| **§3.1.4/P0-13** (righe 328-332) | Spostamento 3 bullet | I 3 bullet "Pattern di enforcement" migrano in §3.1.B, sostituiti da rimando |
| **§3.1.8** (riga 403) | Nota parentetica | "Gate CI/CD Lighthouse" → aggiungere "(implementazione runtime: vedi §3.1.B)" |
| **§3.1.13** (righe 483-494) | Sdoppiamento | Pattern universale resta in §3.1.A.13. Elenco hook concreti (righe 489-492) migra in §3.1.B. Rimando aggiunto. |
| **§3.1.15** (righe 589-591) | Cross-reference | L0 Mielina: aggiungere "(implementazione concreta: vedi §3.1.B)" |
| **§3.1.1** (triade, righe 219-233) | **Nessuna modifica al contenuto** | Diventa §3.1.A.1. L'annotazione storica di Mission A ("ha separato Oracode-paradigma da OS3 Matrix") e ora completamente accurata + il rimando a M-NOMENCL-OSMX-002 puo essere sostituito con "(vedi §1.1.B)" |
| **§4.4** (riga 916) | Riformulazione 1 riga | "Il pattern di Hook Enforcement System con esempi di hook" → "Il pattern di Hook Enforcement System (implementazioni concrete come reference implementation di OS3 Matrix, §1.1.B, inclusa nello spin-off)" |
| **§4.4.1** (Roadmap, riga 942) | Nessuna modifica | La roadmap di disaccoppiamento non menziona enforcement — parla di aree strategiche |
| **§5.x** (Boundary cases) | Nessuna modifica | Nessun riferimento impattato |

**Totale: 12 punti di modifica. Di questi, 2 sono ristrutturazioni interne (§1.1, §3.1), 1 e sdoppiamento (§3.1.13), 1 e spostamento (P0-13 bullet), 8 sono aggiunte parentetiche / rimandi / rinumerazioni.**

---

## (e) Test di coerenza per OS3 Matrix

Un componente appartiene a OS3 Matrix (§1.1.B / §3.1.B) se e solo se:

1. E **software eseguibile** — non regola, non pattern, non standard
2. Opera sul **piano OS3** — interazione AI-Human in esecuzione
3. Il suo scopo primario e **far rispettare** una regola/pattern/vincolo di Oracode-paradigma (§1.1.A)
4. Se rimosso, Oracode-paradigma resta concettualmente integro ma perde enforcement automatico

**Protezione da errore per eccesso:** il RAG interno, l'AI Sidebar, le librerie Ultra NON sono OS3 Matrix — sono implementazioni di pattern Oracode, non strumenti di enforcement.

**Protezione da errore per difetto:** un hook bloccante NON e pattern Oracode — e software che enforcea un pattern. Se e nel repo come `.sh` o come agent `.md`, e OS3 Matrix.

---

## (f) Nota su OS4 Matrix e OSZ Matrix

- **OS4** (Educazione) opera sull'umano a velocita umana, con giudizio. Non servono gate meccanici — servono pattern pedagogici (onboarding, manifesti, formazione). Enforcement automatico su OS4 sarebbe paternalismo.
- **OSZ** (Kernel) e costituzionale e immutabile. I principi kernel non si "enforcano a runtime" — si *sono*. Un kernel che ha bisogno di un tool per far rispettare se stesso non e un kernel, e una policy.
- L'enforcement automatico serve solo dove c'e un agente che produce a **velocita incontrollabile con degradazione possibile** — l'LLM, che vive nel piano OS3.

Esiste solo OS3 Matrix.

---

## Riepilogo decisioni richieste al CEO

1. **Conferma collocazione:** OS3 Matrix come §1.1.B dentro Oracode (con specchio §3.1.B). La tassonomia a 4 livelli resta invariata.

2. **Conferma mappatura componenti:** 35 componenti mappati (tabella in §a). Segnalare disaccordi.

3. **Conferma bozza §1.1.B:** definizione operativa, giustificazione filosofica (asimmetria umano/LLM), composizione, rapporto con paradigma, test di coerenza, nota OS4/OSZ.

4. **Conferma struttura §3.1.A / §3.1.B:** le attuali §3.1.1-§3.1.15 diventano §3.1.A.1-§3.1.A.15. Nuova §3.1.B con componenti enforcement.

5. **Conferma 12 punti di modifica:** tabella in §d.

---

*FASE 1 BIS completata. In attesa approvazione CEO prima di FASE 2 (implementazione).*
