---
title: Oracode — Claude Code Enforcement Guide
slug: oracode-audit-06-claude-code-enforcement
doc_type: guide
version: 1.1.0
status: current
date: '2026-03-25'
updated_at: '2026-03-25'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- oracode
supersedes:
- /home/fabio/EGI-DOC/docs/_archive/oracode/audit/06_CLAUDE_CODE_ENFORCEMENT_v1.0.0_20260325.md
superseded_by: null
rag_indexed: true
priority: normal
---

# Oracode — Claude Code Enforcement Guide

> Questo documento definisce il comportamento operativo obbligatorio di Claude Code durante qualsiasi sessione di lavoro sull'ecosistema FlorenceEGI. Contiene regole operative con trigger espliciti, non descrizioni teoriche.

<!-- Fonte normativa: ../oracode_compliance_audit_v_1.md §9 + ../index.md REGOLA ZERO -->
<!-- Documento operativo: dice a Claude Code COME comportarsi durante audit e modifiche -->
<!-- Questo file è letto da Claude Code nelle sessioni di audit. È normativo, non descrittivo. -->

---

## Prerequisiti

Questa sezione elenca le conoscenze e i documenti necessari prima di operare sotto questo enforcement.

| Prerequisito | Documento di riferimento | Scopo |
|---|---|---|
| Conoscere la Trigger Matrix (tipi di modifica 1-6) | `oracode/audit/02_TRIGGER_MATRIX.md` | Classificare ogni modifica per determinare obblighi DOC-SYNC |
| Conoscere il sistema di hook enforcement | `oracode/08_HOOK_ENFORCEMENT_SYSTEM.md` | Comprendere i blocchi automatici PreToolUse su Edit/Write |
| Accesso ai SSOT locali di ogni organo | CLAUDE.md di ogni progetto (NATAN_LOC, EGI-HUB, EGI) | Verificare stato documentale prima di ogni modifica |
| Accesso a EGI-DOC come fonte autoritativa centrale | `docs/` nella root di EGI-DOC | Risolvere conflitti tra fonti |

---

## REGOLA ZERO — Il settimo pilastro (non negoziabile)

Questa sezione definisce il principio fondamentale che governa ogni azione di Claude Code nell'ecosistema.

```
MAI DEDURRE.
MAI COMPLETARE LACUNE CON "LA COSA PIÙ LOGICA".
SE NON SAI, CHIEDI.
```

### Step 1 — Riconoscere i trigger di attivazione della Regola Zero

Claude Code deve fermarsi e dichiarare il limite quando si verifica una delle seguenti situazioni.

| Situazione | Azione corretta |
|---|---|
| Il metodo che vuole usare non è stato verificato con grep | STOP — grep prima |
| Il file che cerca non è stato trovato | STOP — dichiarare e chiedere path |
| Il nome di un'entità/service/enum non è stato confermato | STOP — grep o Read prima |
| Il comportamento atteso di un componente non è documentato | STOP — leggere SSOT prima |
| Sta per assumere il valore di una costante | STOP — leggere il file enum/config |
| Il flusso non è stato mappato e la modifica è su area critica | STOP — P0-8 prima |

### Anti-pattern proibiti

Questi pattern indicano violazione della Regola Zero e non devono mai comparire nell'output di Claude Code.

```
❌ "Probabilmente usa il metodo X"
❌ "Di solito in Laravel si fa così..."
❌ "Assumo che la tabella si chiami..."
❌ "Il service dovrebbe avere questo metodo"
❌ "Completare il codice basandosi su ciò che ha senso"
```

### Pattern corretti

Questi pattern dimostrano compliance con la Regola Zero.

```bash
grep -r "function nomeMetodo" app/ --include="*.php"
```

```
Read file per vedere i metodi reali prima di usarli
```

```
"Non ho trovato questo metodo — vuoi che cerchi in modo diverso o hai il path esatto?"
```

```
"La SSOT dice X ma il codice fa Y — quale è la verità?"
```

---

## Step 2 — Verifica prima dell'azione (P0-4, P0-6, P0-7)

Questa sezione definisce le verifiche obbligatorie prima di qualsiasi operazione su metodi, service, enum o costanti.

> **Enforcement meccanico attivo:** Le regole P0-4 e P0-6 sono enforced da PreToolUse hooks in tutti i progetti dell'ecosistema (NATAN_LOC, EGI-HUB, EGI). Gli hook intercettano ogni `Edit`/`Write` e bloccano con `exit 2` prima dell'esecuzione se la regola è violata. Dettagli tecnici, deployment e estensione a nuovi progetti: `oracode/08_HOOK_ENFORCEMENT_SYSTEM.md`.

### Step 2a — Prima di usare un metodo

```bash
# Verifica obbligatoria
grep -n "function nomemetodo" percorso/al/file.php
# Se non trovato → NON usare il metodo. Dichiarare e chiedere.
```

### Step 2b — Prima di usare un service

```bash
# 1. Leggi il service per capire cosa esiste realmente
Read percorso/al/NomeService.php
# 2. Verifica il metodo specifico
grep -n "function nomemetodo" percorso/al/NomeService.php
# Se non trovato → NON chiamare il metodo
```

### Step 2c — Prima di usare un'enum o costante

```bash
# Verifica che la costante esista nel file enum
grep -n "case NOME\|const NOME" app/Enums/NomeEnum.php
# Se non trovata → NON usarla. Usare solo i valori verificati.
```

---

## Step 3 — Complete Flow Analysis (P0-8)

Questa sezione definisce quando e come eseguire la mappatura completa del flusso prima di un fix.

### Aree che richiedono P0-8 obbligatoria

Claude Code deve eseguire P0-8 PRIMA di qualsiasi fix sulle seguenti aree.

| Area | P0-8 obbligatoria |
|---|---|
| Flussi di pagamento (Stripe, PayPal, Egili) | SÌ |
| Autenticazione e autorizzazione (Sanctum, RBAC) | SÌ |
| Blockchain (Algorand, ASA, minting) | SÌ |
| GDPR e dati personali | SÌ |
| Multi-tenancy e tenant isolation | SÌ |
| Schema `core` condiviso (EGI-HUB) | SÌ |
| AI layer (AnthropicService, RAG) | SÌ |
| Bug report con sintomi multipli o non lineari | SÌ |
| Qualsiasi refactor su file >500 LOC | SÌ |

### Formato flow map obbligatorio

```
FLOW MAP — [Nome flusso]:
User action: [...]
    ↓
Entry point: [file:riga]
    ↓
Processing: [Controller → Service → Model → ...]
    ↓
[Blockchain/AI/Payment se applicabile]
    ↓
Database: [schema.tabella, search_path]
    ↓
Response: [formato atteso]

Type tracing: [variabile X: tipo A → tipo B → tipo C]
All occurrences: grep "[simbolo]" — trovate in N file
Context: [dipendenze rilevanti]
```

---

## Step 4 — Gestione conflitto tra fonti

Questa sezione definisce il protocollo quando Claude Code trova discordanza tra fonti documentali o tra documentazione e codice.

| Caso | Azione |
|---|---|
| Codice reale ≠ SSOT locale (CLAUDE.md) | Dichiarare il mismatch. Chiedere quale è aggiornato. Non assumere. |
| SSOT locale ≠ EGI-DOC | Dichiarare il mismatch. EGI-DOC è autoritativo — ma chiedere conferma prima di aggiornare SSOT locale. |
| EGI-DOC ≠ realtà del codebase | Dichiarare. Non correggere autonomamente. Portare a Fabio. |
| Due documenti EGI-DOC si contraddicono | Dichiarare. Identificare quale è più recente. Chiedere a Fabio. |

### Formato dichiarazione mismatch

```
MISMATCH TROVATO:
- SSOT locale dichiara: [X]
- Codice reale mostra: [Y]
- EGI-DOC dice: [Z]
Quale è la verità? Non procedo finché non è chiarito.
```

---

## Step 5 — Obbligo di aggiornamento SSOT (P0-11)

Questa sezione definisce l'obbligo di aggiornamento documentale al completamento di ogni task.

### Regola

Ogni task che supera la soglia di Tipo 2+ (vedi `oracode/audit/02_TRIGGER_MATRIX.md`) **non può essere dichiarata completata** senza aver aggiornato la SSOT corretta.

### Sequenza operativa obbligatoria

```
1. Implementazione completata
2. Verifica tipo modifica → vedi 02_TRIGGER_MATRIX.md
3. Se Tipo 2 o superiore:
   a. Identificare SSOT da aggiornare (locale e/o centrale)
   b. Aggiornare il documento
   c. Commit con formato [DOC] [organo] — [area]: [descrizione]
4. Dichiarare esplicitamente il DOC-SYNC completato
5. Solo ora la task può essere dichiarata chiusa
```

### Dichiarazioni obbligatorie di DOC-SYNC

Al termine di ogni task che NON richiede DOC-SYNC:

```
DOC-SYNC: non richiesto — modifica Tipo 1 (locale, non cambia comportamento visibile)
```

Al termine di ogni task che richiede DOC-SYNC:

```
DOC-SYNC: completato — aggiornato [path file in EGI-DOC]
```

---

## Step 6 — Produzione evidenze minime

Questa sezione definisce le evidenze obbligatorie da includere nel messaggio finale di ogni task P1 o superiore.

Per ogni task P1 o superiore, Claude Code deve produrre:

| # | Evidenza | Descrizione |
|---|---|---|
| 1 | Riferimento al metodo verificato | grep o Read con risultato |
| 2 | Riferimento al SSOT letto | quale file, quale sezione |
| 3 | Dichiarazione tipo modifica | Tipo 1-6 secondo Trigger Matrix |
| 4 | DOC-SYNC status | completato / non richiesto / in sospeso |

Queste evidenze devono comparire nel messaggio finale della task, non solo nella conversazione intermedia.

---

## Condizioni di stop e di escalation

Questa sezione elenca le condizioni in cui Claude Code deve fermarsi o chiedere istruzioni esplicite.

### Quando fermarsi

| Condizione | Motivo |
|---|---|
| Manca il path di un file che dovrebbe esistere | Regola Zero |
| Sta per toccare un file [LEGACY] non previsto dalla task | Strategia Delta |
| Sta per fare una migration su schema condiviso | Rischio cross-organo |
| Sta per modificare un'Interface stabile | Richiede approvazione Fabio |
| Trova un conflitto tra SSOT locale e EGI-DOC | Deve essere esplicitato, non risolto unilateralmente |
| Score di confidence sulla causa root è < alta | P0-8: completare la mappa prima del fix |
| Sta per modificare file critico GDPR/MiCA/blockchain senza flow map | P0-8 obbligatorio |

### Quando chiedere

Claude Code deve chiedere esplicitamente quando:

- Non sa quale SSOT aggiornare per una modifica
- Il codice reale differisce dalla documentazione e non sa quale ha ragione
- Il flusso da analizzare supera i file accessibili senza indicazioni
- Sta per fare un'azione con effetti su altri organi (cross-project)
- Il tipo di modifica ricade in Tipo 4 (contrattuale/compliance) → approvazione Fabio

---

## Errori comuni e soluzioni

Questa sezione raccoglie gli errori operativi più frequenti e le relative correzioni.

| Errore | Conseguenza | Soluzione |
|---|---|---|
| Usare un metodo senza grep preventivo | Possibile invocazione di metodo inesistente; hook PreToolUse blocca con `exit 2` | Eseguire sempre Step 2a/2b/2c prima di Edit/Write |
| Dichiarare task completata senza DOC-SYNC su modifica Tipo 2+ | Violazione P0-11; SSOT diverge dal codice | Seguire la sequenza di Step 5 prima di chiudere la task |
| Risolvere un mismatch tra fonti senza chiedere | Possibile sovrascrittura di decisione di merito | Seguire il protocollo Step 4: dichiarare e attendere istruzione |
| Operare su area critica senza flow map | Fix incompleto o regressione su flusso non mappato | Eseguire P0-8 (Step 3) prima del fix |
| Assumere il valore di una costante o enum | Codice con riferimenti inesistenti; errore runtime | Eseguire Step 2c: grep sul file enum/config |
| Toccare file [LEGACY] non previsto dalla task | Modifica fuori scope; rischio regressione | Fermarsi, dichiarare, proporre piano separato |

---

## Checklist pre-risposta (P0-11 compliant)

Questa checklist deve essere verificata prima di rispondere o consegnare il lavoro.

```
1. Ho TUTTE le info necessarie?                      → NO = STOP → CHIEDI
2. Ogni metodo è stato verificato con grep/Read?     → NO = STOP → VERIFICA
3. Esiste pattern simile nel codebase?               → ?  = STOP → CERCA
4. Sto assumendo qualcosa?                           → SÌ = STOP → DICHIARA e CHIEDI
5. Sto toccando file [LEGACY]?                       → SÌ = STOP → DICHIARA + piano
6. Il tipo di modifica richiede DOC-SYNC?            → SÌ = STOP → AGGIORNA prima di chiudere
7. Esiste mismatch tra fonti?                        → SÌ = STOP → DICHIARA prima di procedere
8. Sto operando su area critica senza flow map?      → SÌ = STOP → P0-8 prima
```

---

## Riferimenti

| Documento | Path relativo a EGI-DOC/docs/ | Relazione |
|---|---|---|
| Oracode Compliance Audit (§9) | `oracode/oracode_compliance_audit_v_1.md` | Fonte normativa di questo documento |
| Oracode Index — REGOLA ZERO | `oracode/index.md` | Definizione della Regola Zero |
| Trigger Matrix | `oracode/audit/02_TRIGGER_MATRIX.md` | Classificazione tipi di modifica (1-6) |
| Hook Enforcement System | `oracode/08_HOOK_ENFORCEMENT_SYSTEM.md` | Dettagli tecnici hook PreToolUse, deployment, estensione |