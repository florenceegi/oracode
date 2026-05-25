---
title: Oracode Audit — Evidence Pack Template
slug: oracode-audit-03-evidence-pack-template
doc_type: guide
version: 1.1.0
status: current
date: '2026-03-25'
updated_at: '2026-03-25'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- oracode
supersedes:
- /home/fabio/EGI-DOC/docs/_archive/oracode/audit/03_EVIDENCE_PACK_TEMPLATE_v1.0.0_20260325.md
superseded_by: null
rag_indexed: true
priority: normal
---

# Oracode Audit — Evidence Pack Template

> **Scopo:** Template operativo per la raccolta strutturata delle evidenze durante un audit Oracode. Ogni sezione documenta un aspetto specifico della verifica; una regola non provata è considerata non soddisfatta.

**Fonte normativa:** `oracode/oracode_compliance_audit_v_1.md` §7.3 e §4.5

---

## Prerequisiti

| # | Requisito | Dettaglio |
|---|-----------|-----------|
| 1 | Accesso al repository target | Branch e commit range definiti prima dell'avvio |
| 2 | SSOT locale letta | `CLAUDE.md` del progetto target |
| 3 | SSOT centrale letta | Documentazione in `oracode/audit/01_TARGET_MATRIX.md` |
| 4 | Conoscenza dei controlli P0–P2 | Riferimento: `oracode/oracode_compliance_audit_v_1.md` |
| 5 | Template report disponibile | `oracode/audit/04_AUDIT_REPORT_TEMPLATE.md` |

---

## Step 1 — Creazione del file Evidence Pack

Copiare questo template in `audit/reports/` con naming convention:

```
EVIDENCE_[TARGET-ID]_[YYYY-MM-DD].md
```

**Esempio:**

```
audit/reports/EVIDENCE_T-001_2026-03-25.md
```

---

## Step 2 — Compilazione metadati

Compilare la tabella metadati **all'inizio dell'audit**, non a posteriori.

| Campo | Valore | Note |
|-------|--------|------|
| **Target ID** | T-00N | Riferimento: `oracode/audit/01_TARGET_MATRIX.md` |
| **Repository/Progetto** | | Nome completo del repository |
| **Branch analizzato** | | Branch oggetto dell'audit |
| **Commit / Range** | | Singolo commit SHA o range `abc123..def456` |
| **Data audit** | YYYY-MM-DD | Data di esecuzione |
| **Auditor** | Padmin D. Curtis / Fabio Cherici | Chi esegue l'audit |
| **Ambiente** | local / staging / production | Ambiente di verifica |
| **Scope** | Completo / Parziale | Se parziale, specificare cosa è escluso |

---

## Step 3 — Registrazione SSOT di riferimento

Documentare quali SSOT sono state lette prima di iniziare i controlli.

| SSOT | Path | Stato al momento dell'audit |
|------|------|-----------------------------|
| SSOT locale | `CLAUDE.md` del progetto | Letto / Non letto |
| SSOT centrale | `EGI-DOC/docs/[area]/` | Letto / Non letto |
| Altro documento rilevante | | |

---

## Step 4 — File analizzati

> Scopo: tracciare ogni file letto durante l'audit con il motivo della lettura e la rilevanza rispetto ai controlli.

| File | Motivo lettura | Rilevante per | Nota |
|------|---------------|---------------|------|
| | | P0-N / P1-N / CCA-N | |
| | | | |

**Comandi usati per l'analisi:**

```bash
# Incollare qui i grep/find/wc effettivamente eseguiti
```

---

## Step 5 — Flussi verificati

> Scopo: per ogni flusso critico analizzato, descrivere il percorso verificato e l'esito.

### Flusso N: [Nome flusso]

```
User action: [...]
    ↓
Entry point: [file:riga]
    ↓
Processing: [Controller → Service → Model]
    ↓
Exit point: [response/view]
    ↓
Verifica: COMPLETA / PARZIALE / NON ESEGUITA
```

| Campo | Valore |
|-------|--------|
| **Esito** | Conforme / Non conforme / Non verificabile |
| **Note** | [Osservazioni specifiche] |

Ripetere il blocco per ogni flusso verificato.

---

## Step 6 — Test verificati

> Scopo: elencare i test presenti, se sono stati eseguiti e il loro esito.

| Test | Path | Tipo | Eseguito | Esito |
|------|------|------|----------|-------|
| | | unit / feature / integration | sì / no | pass / fail / non eseguito |

**Test mancanti identificati:**

- [Aree senza test che le richiederebbero]

---

## Step 7 — Configurazione Claude Code verificata

> Scopo: verificare che il progetto target abbia la configurazione Claude Code conforme al framework Oracode.

| Controllo | Presenza | Qualità | Note |
|-----------|----------|---------|------|
| CLAUDE.md esiste | sì / no | | |
| `doc-sync-guardian` agente presente | sì / no | | |
| Regola Zero dichiarata esplicitamente | sì / no | | |
| Obbligo SSOT update dichiarato | sì / no | | |
| Checklist pre-risposta presente | sì / no | | |
| settings.json con permessi corretti | sì / no | | |
| Agenti specifici per stack presenti | sì / no | | |

---

## Step 8 — Controlli P0 (Blocking)

> Scopo: verificare i controlli P0 con evidenza obbligatoria. Un controllo dichiarato PASS senza evidenza verificabile non è valido.

### P0-1 — Regola Zero

**Evidenza:** [Cosa hai trovato che dimostra che il contributore/Claude non ha dedotto]

```bash
# Esempi di evidenza valida:
# - grep "function metodo_usato" — metodo verificato prima dell'uso
# - commit message che cita verifica preventiva
# - assenza di nomi inventati
```

| Campo | Valore |
|-------|--------|
| **Esito** | PASS / FAIL / NON VERIFICABILE |
| **Se FAIL** | [Descrizione della violazione specifica — file, riga, contesto] |

---

### P0-2 — Translation Keys Only

**Evidenza:**

```bash
# Comando eseguito:
grep -r "'" resources/views/ --include="*.php" | grep -v "__\|trans\|Lang::" | head -20
# Risultato:
```

| Campo | Valore |
|-------|--------|
| **Esito** | PASS / FAIL / NON APPLICABILE |
| **Se NON APPLICABILE** | [Specificare perché] |
| **Se FAIL** | [File con testo hardcoded — path:riga] |

---

### P0-3 — Statistics Rule

**Evidenza:**

```bash
# Comando eseguito:
grep -rn "->take(\|->limit(\|LIMIT " app/ --include="*.php" | grep -v "config\|test"
# Risultato:
```

| Campo | Valore |
|-------|--------|
| **Esito** | PASS / FAIL / NON APPLICABILE |
| **Se FAIL** | [Occorrenza specifica — file:riga] |

---

### P0-4 — Anti-Method-Invention

**Evidenza:**

```bash
# Per ogni metodo usato in modifiche recenti — verificare esistenza:
grep -n "function metodo_verificato" app/Services/NomeService.php
# Risultato:
```

**Metodi verificati:**

| Metodo | Trovato a riga | Stato |
|--------|---------------|-------|
| `NomeService::metodo()` | riga N | ✅ verificato |
| `AltroService::metodo()` | riga N | ✅ verificato |

| Campo | Valore |
|-------|--------|
| **Esito** | PASS / FAIL |
| **Se FAIL** | [Metodo usato che non esiste] |

---

### P0-5 — UEM-First Rule

**Evidenza:**

```bash
# Verifica catch vuoti o log-only:
grep -n "catch\|Log::" app/Http/Controllers/ --include="*.php" -r | grep -v "errorManager\|UEM"
# Risultato:
```

| Campo | Valore |
|-------|--------|
| **Esito** | PASS / FAIL / NON APPLICABILE |
| **Se FAIL** | [File con error handling non conforme] |

---

### P0-6 — Anti-Service-Method

**Evidenza:** [Traccia di read_file + grep prima di usare service in modifiche recenti]

| Campo | Valore |
|-------|--------|
| **Esito** | PASS / FAIL / NON VERIFICABILE |

---

### P0-7 — Anti-Enum-Constant

**Evidenza:**

```bash
# Enum usate nelle modifiche recenti:
grep -n "NomeEnum::" app/ --include="*.php" -r | head -10
# Enum reali verificate:
grep -n "case\|const" app/Enums/NomeEnum.php
```

| Campo | Valore |
|-------|--------|
| **Esito** | PASS / FAIL / NON APPLICABILE |

---

### P0-8 — Complete Flow Analysis

**Evidenza:** [Flow map prodotta PRIMA del fix — se presente, allegarla qui]

```
User action: [...]
Entry point: [...]
Processing: [...]
Exit point: [...]
```

| Campo | Valore |
|-------|--------|
| **Esito** | PASS / FAIL / NON APPLICABILE |
| **Se NON APPLICABILE** | Nessun fix critico nel periodo |
| **Se FAIL** | [Fix critico eseguito senza flow map] |

---

## Step 9 — Controlli P1 (Must)

> Scopo: verificare i controlli P1 obbligatori ma non bloccanti.

### P1-1 — Documentazione minima (docblock)

**Evidenza:**

```bash
grep -c "@purpose\|@author\|@package" [file_modificati] | head -20
```

| Campo | Valore |
|-------|--------|
| **Esito** | PASS / FAIL / PARZIALE |
| **File senza docblock** | [lista] |

---

### P1-2 — SSOT update obligation

**Evidenza:** [Commit message o file EGI-DOC aggiornati per le modifiche rilevanti]

| Campo | Valore |
|-------|--------|
| **Modifiche rilevanti del periodo** | [lista] |
| **SSOT aggiornate** | [lista] |
| **SSOT mancanti** | [lista] |
| **Esito** | PASS / FAIL / PARZIALE |

---

### P1-3 — Zero placeholder/TODO in consegna

**Evidenza:**

```bash
grep -rn "TODO\|FIXME\|TBD\|placeholder\|lorem ipsum" app/ resources/ --include="*.php" --include="*.tsx" --include="*.ts"
```

| Campo | Valore |
|-------|--------|
| **Esito** | PASS / FAIL |
| **Se FAIL** | [file:riga con placeholder] |

---

### P1-4 — Testing minimo

**Evidenza:** [Elenco test presenti per logica critica modificata]

| Campo | Valore |
|-------|--------|
| **Esito** | PASS / FAIL / PARZIALE |

---

### P1-5 — GDPR / security / accessibilità

**Evidenza:** [Verifica che le modifiche non abbiano introdotto regressioni]

| Campo | Valore |
|-------|--------|
| **Esito** | PASS / FAIL / NON APPLICABILE |

---

## Step 10 — Controlli P2/P3 (Should/Reference)

> Scopo: verificare raccomandazioni e best practice non bloccanti.

### P2-1 — Coerenza semantica cross-layer

**Evidenza:** [Verifica naming business = naming tecnico = naming documentale]

| Campo | Valore |
|-------|--------|
| **Esito** | CONFORME / NON CONFORME / PARZIALE |
| **Mismatch trovati** | [lista] |

---

### P2-2 — Pattern extraction

| Campo | Valore |
|-------|--------|
| **Osservazione** | [Soluzioni duplicate che avrebbero potuto diventare pattern] |
| **Raccomandazione** | backlog / non necessario |

---

### P2-3 — Logging strutturato

**Evidenza:**

```bash
grep -rn "Log::\|logger\." app/ --include="*.php" | head -10
```

| Campo | Valore |
|-------|--------|
| **Esito** | CONFORME / NON CONFORME / PARZIALE |

---

### P2-4 — Riutilizzabilità architetturale

| Campo | Valore |
|-------|--------|
| **Osservazione** | [Varianti one-off identificate] |

---

## Step 11 — Mismatch documentali

> Scopo: registrare divergenze trovate tra codice e documentazione. Compilare SOLO se trovati mismatch.

| # | Tipo mismatch | Codice (reale) | Documentazione (dichiarato) | Gravità | Azione |
|---|---------------|---------------|----------------------------|---------|--------|
| 1 | codice vs SSOT locale | | | P0 / P1 / P2 | |
| 2 | SSOT locale vs EGI-DOC | | | P0 / P1 / P2 | |
| 3 | naming business vs naming tecnico | | | P2 | |
| 4 | flusso reale vs flusso dichiarato | | | P0 / P1 | |

---

## Step 12 — Riepilogo findings

> Scopo: quadro sinottico di tutti i controlli con esito finale.

| Controllo | Esito | Gravità | Note sintetiche |
|-----------|-------|---------|-----------------|
| P0-1 Regola Zero | | P0 | |
| P0-2 Translation Keys | | P0 | |
| P0-3 Statistics Rule | | P0 | |
| P0-4 Anti-Method-Invention | | P0 | |
| P0-5 UEM-First | | P0 | |
| P0-6 Anti-Service-Method | | P0 | |
| P0-7 Anti-Enum-Constant | | P0 | |
| P0-8 Complete Flow Analysis | | P0 | |
| P1-1 Docblock | | P1 | |
| P1-2 SSOT update | | P1 | |
| P1-3 Zero placeholder | | P1 | |
| P1-4 Testing | | P1 | |
| P1-5 GDPR/security | | P1 | |
| P2-1 Coerenza semantica | | P2 | |
| CCA-1..8 Claude Code | | vari | |

| Contatore | Valore |
|-----------|--------|
| **P0 aperte** | N |
| **P1 aperte** | N |
| **P2 aperte** | N |

---

## Errori comuni e soluzioni

| # | Errore | Conseguenza | Soluzione |
|---|--------|-------------|----------|
| 1 | Dichiarare PASS senza evidenza verificabile | Controllo considerato non soddisfatto (§4.5) | Allegare sempre comando eseguito + risultato |
| 2 | Compilare il pack a posteriori (dopo l'audit) | Evidenze ricostruite a memoria, non affidabili | Compilare ogni sezione durante l'esecuzione del controllo |
| 3 | Scrivere "EVIDENZA NON RACCOLTA" senza motivazione | Finding non actionable | Specificare perché l'evidenza non è stata raccolta |
| 4 | Omettere il range di commit analizzato | Audit non riproducibile | Compilare sempre il campo Commit/Range nei metadati |
| 5 | Non leggere le SSOT prima dei controlli | Mismatch documentali non rilevati | Completare Step 3 prima di procedere con Step 4+ |

---

## Riferimenti

| Documento | Path | Relazione |
|-----------|------|-----------|
| Oracode Compliance Audit v1 | `oracode/oracode_compliance_audit_v_1.md` | Fonte normativa (§7.3, §4.5) |
| Target Matrix | `oracode/audit/01_TARGET_MATRIX.md` | Elenco target auditabili |
| Trigger Matrix | `oracode/audit/02_TRIGGER_MATRIX.md` | Condizioni di attivazione audit |
| Audit Report Template | `oracode/audit/04_AUDIT_REPORT_TEMPLATE.md` | Output finale — richiede questo Evidence Pack come prerequisito |
| Scoring Sheet | `oracode/audit/05_SCORING_SHEET.md` | Calcolo punteggio audit |
| Claude Code Enforcement | `oracode/audit/06_CLAUDE_CODE_ENFORCEMENT.md` | Dettaglio controlli CCA |