---
title: Oracode Audit — Compliance Scoring Sheet
slug: oracode-audit-05-scoring-sheet
doc_type: guide
version: 2.0.0
status: current
date: '2026-03-25'
updated_at: '2026-03-25'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- oracode
supersedes:
- /home/fabio/EGI-DOC/docs/_archive/oracode/audit/05_SCORING_SHEET_v1.0.0_20260325.md
superseded_by: null
rag_indexed: true
priority: normal
---

# Oracode Audit — Compliance Scoring Sheet

> **Scopo:** fornire il foglio di calcolo ufficiale per lo scoring di conformità Oracode, dalla compilazione per area al verdetto finale.

---

## Prerequisiti

Prima di compilare questo foglio, verificare di avere:

| # | Requisito | Dove trovarlo |
|---|-----------|---------------|
| 1 | Evidence Pack compilato per il target sotto audit | `oracode/audit/03_EVIDENCE_PACK_TEMPLATE.md` |
| 2 | Target Matrix con lista controlli applicabili | `oracode/audit/01_TARGET_MATRIX.md` |
| 3 | Trigger Matrix con contesto dell'audit | `oracode/audit/02_TRIGGER_MATRIX.md` |
| 4 | Report template pronto per ricevere score e verdict | `oracode/audit/04_AUDIT_REPORT_TEMPLATE.md` |

<!-- Fonte normativa: ../oracode_compliance_audit_v_1.md §10 -->
<!-- Lo scoring supporta il verdetto, non lo sostituisce. P0 aperta = FAIL sempre. -->

---

## Steps di compilazione

### Step 1 — Compilare la tabella area per area

Compilare ogni area (A–F) utilizzando **solo evidenze raccolte nell'Evidence Pack**. Non inserire esiti senza evidenza corrispondente.

### Step 2 — Calcolare il punteggio parziale per area

Applicare le formule di calcolo indicate in fondo a ciascuna area.

### Step 3 — Sommare il totale

Riportare i punteggi parziali nella tabella "Score totale" (sezione dedicata in fondo).

### Step 4 — Applicare la regola assoluta P0

Se qualsiasi controllo P0 ha esito FAIL, il verdetto finale è **FAIL** indipendentemente dal punteggio totale.

### Step 5 — Trascrivere score e verdict nel Report

Copiare score totale e verdict nel documento `oracode/audit/04_AUDIT_REPORT_TEMPLATE.md`.

---

## Area A — P0 Compliance (peso: 40 punti su 100)

> **Scopo:** verificare la conformità a tutti i controlli P0 (bloccanti). Una sola P0 con esito FAIL azzera l'intera area e forza il verdetto finale a FAIL.

| Controllo | Verificato | Evidenza presente | Esito | Punteggio parziale |
|-----------|-----------|------------------|-------|--------------------:|
| P0-1 Regola Zero | sì/no | sì/no | PASS/FAIL | 5 o 0 |
| P0-2 Translation Keys | sì/no | sì/no | PASS/FAIL/N.A. | 5 o 0 |
| P0-3 Statistics Rule | sì/no | sì/no | PASS/FAIL/N.A. | 5 o 0 |
| P0-4 Anti-Method-Invention | sì/no | sì/no | PASS/FAIL | 5 o 0 |
| P0-5 UEM-First | sì/no | sì/no | PASS/FAIL/N.A. | 5 o 0 |
| P0-6 Anti-Service-Method | sì/no | sì/no | PASS/FAIL | 5 o 0 |
| P0-7 Anti-Enum-Constant | sì/no | sì/no | PASS/FAIL/N.A. | 5 o 0 |
| P0-8 Complete Flow Analysis | sì/no | sì/no | PASS/FAIL/N.A. | 5 o 0 |

**Gestione N/A:** se un controllo non è applicabile al target, il peso di 5 punti viene redistribuito proporzionalmente tra gli altri P0 applicabili. Documentare il motivo del N/A nell'Evidence Pack.

**Calcolo Area A:**

```text
Controlli PASS: N / N_applicabili
Punteggio: (N_PASS / N_applicabili) × 40 = __/40

⚠️ Se qualsiasi P0 = FAIL → Punteggio Area A = 0/40 e verdetto finale = FAIL
```

---

## Area B — P1 Compliance (peso: 25 punti su 100)

> **Scopo:** verificare la conformità ai controlli P1 (importanti, non bloccanti). I controlli P1 ammettono esito parziale (PARZ) con punteggio dimezzato.

| Controllo | Verificato | Evidenza presente | Esito | Punteggio parziale |
|-----------|-----------|------------------|-------|--------------------:|
| P1-1 Docblock obbligatori | sì/no | sì/no | PASS/PARZ/FAIL | 5 o 2.5 o 0 |
| P1-2 SSOT update obligation | sì/no | sì/no | PASS/PARZ/FAIL | 5 o 2.5 o 0 |
| P1-3 Zero placeholder/TODO | sì/no | sì/no | PASS/FAIL | 5 o 0 |
| P1-4 Testing minimo | sì/no | sì/no | PASS/PARZ/FAIL | 5 o 2.5 o 0 |
| P1-5 GDPR/security/a11y | sì/no | sì/no | PASS/FAIL/N.A. | 5 o 0 |

**Calcolo Area B:** __/25

---

## Area C — SSOT Alignment (peso: 15 punti su 100)

> **Scopo:** verificare che la documentazione SSOT (locale e centrale) sia allineata al codice effettivo.

| Criterio | Esito | Punteggio |
|----------|-------|----------:|
| SSOT locale (CLAUDE.md) esiste e è aggiornata | OK/PARTIAL/FAIL | 5 o 2 o 0 |
| SSOT centrale EGI-DOC è aggiornata per le modifiche rilevanti | OK/PARTIAL/FAIL | 5 o 2 o 0 |
| Nessun mismatch critico tra codice e documentazione | OK/PARTIAL/FAIL | 5 o 2 o 0 |

**Calcolo Area C:** __/15

---

## Area D — Claude Code Enforcement (peso: 10 punti su 100)

> **Scopo:** verificare che le regole di comportamento Claude Code dell'ecosistema siano configurate e rispettate.

| Controllo | Esito | Punteggio |
|-----------|-------|----------:|
| CCA-1 Identità ecosistemica | OK/FAIL | 1.25 o 0 |
| CCA-2 Gerarchia SSOT nota | OK/PARTIAL/FAIL | 1.25 o 0.5 o 0 |
| CCA-3 Obbligo SSOT update | OK/FAIL | 1.25 o 0 |
| CCA-4 Anti-assunzione | OK/FAIL | 1.25 o 0 |
| CCA-5 Escalation corretta | OK/FAIL | 1.25 o 0 |
| CCA-6 Flow-before-fix | OK/FAIL | 1.25 o 0 |
| CCA-7 Produzione evidenze | OK/PARTIAL/FAIL | 1.25 o 0.5 o 0 |
| CCA-8 Conflitto fonti gestito | OK/PARTIAL/FAIL | 1.25 o 0.5 o 0 |

**Calcolo Area D:** __/10

---

## Area E — Semantic Consistency (peso: 5 punti su 100)

> **Scopo:** verificare la coerenza terminologica tra codice, business logic e documentazione.

| Criterio | Esito | Punteggio |
|----------|-------|----------:|
| Naming business = naming tecnico = naming documentale | OK/PARTIAL/FAIL | 2.5 o 1 o 0 |
| Terminologia coerente tra file dello stesso progetto | OK/PARTIAL/FAIL | 2.5 o 1 o 0 |

**Calcolo Area E:** __/5

---

## Area F — Evidence Quality (peso: 5 punti su 100)

> **Scopo:** verificare che ogni controllo sia supportato da evidenze verificabili e riproducibili.

| Criterio | Esito | Punteggio |
|----------|-------|----------:|
| Ogni controllo ha evidenza verificabile | OK/PARTIAL/FAIL | 2.5 o 1 o 0 |
| Comandi/grep/read documentati nell'Evidence Pack | OK/PARTIAL/FAIL | 2.5 o 1 o 0 |

**Calcolo Area F:** __/5

---

## Score totale

> **Scopo:** riepilogo dei punteggi parziali per area e calcolo del totale su 100 punti.

| Area | Peso | Punteggio |
|------|-----:|----------:|
| A — P0 Compliance | 40 | __/40 |
| B — P1 Compliance | 25 | __/25 |
| C — SSOT Alignment | 15 | __/15 |
| D — Claude Code Enforcement | 10 | __/10 |
| E — Semantic Consistency | 5 | __/5 |
| F — Evidence Quality | 5 | __/5 |
| **TOTALE** | **100** | **__/100** |

---

## Interpretazione score → Verdict

> **Scopo:** mappare il punteggio numerico al verdetto qualitativo, secondo le soglie definite dal framework Oracode.

| Score | Interpretazione | Verdict suggerito |
|------:|----------------|-------------------|
| 95–100 | Conforme forte | PASS |
| 85–94 | Conforme con correzioni minori | PASS WITH CONDITIONS |
| 70–84 | Conforme fragile | PASS WITH CONDITIONS (con piano remediation) |
| < 70 | Non conforme | FAIL |

---

## Regola assoluta P0 (non negoziabile)

> **Scopo:** definire la regola di override che prevale su qualsiasi punteggio numerico.

```text
⛔ P0 APERTE > 0  →  VERDICT = FAIL
   Indipendentemente dal score totale.
   Indipendentemente dalla qualità del resto.
   Indipendentemente dall'urgenza del rilascio.

Score alto con P0 aperta = audit non credibile.
```

---

## Verdict finale

> **Scopo:** registrare il verdetto ufficiale da trascrivere nel Report.

**Score:** __/100
**P0 aperte:** N
**Verdict:** `PASS` / `PASS WITH CONDITIONS` / `FAIL` / `SUSPENDED`

---

## Errori comuni e soluzioni

| Errore | Conseguenza | Soluzione |
|--------|-------------|-----------|
| Compilare un controllo senza evidenza nel pack | Audit non verificabile, punteggio contestabile | Raccogliere l'evidenza prima di assegnare l'esito; lasciare il campo vuoto se l'evidenza non è disponibile |
| Assegnare N/A a un P0 senza documentare il motivo | Redistribuzione peso non giustificata | Scrivere nell'Evidence Pack il motivo specifico per cui il controllo non è applicabile al target |
| Calcolare lo score con P0 FAIL e non forzare FAIL | Verdetto incoerente con la regola assoluta | Applicare sempre Step 4 prima di Step 5: se P0 FAIL esiste, il verdict è FAIL |
| Dimenticare di trascrivere nel Report | Score calcolato ma non registrato nel documento ufficiale | Eseguire sempre Step 5: copiare score e verdict in `oracode/audit/04_AUDIT_REPORT_TEMPLATE.md` |

---

## Riferimenti

| Documento | Path | Relazione |
|-----------|------|-----------|
| Target Matrix | `oracode/audit/01_TARGET_MATRIX.md` | Lista dei controlli applicabili per tipo di target |
| Trigger Matrix | `oracode/audit/02_TRIGGER_MATRIX.md` | Condizioni che attivano l'audit |
| Evidence Pack Template | `oracode/audit/03_EVIDENCE_PACK_TEMPLATE.md` | Template per la raccolta evidenze |
| Audit Report Template | `oracode/audit/04_AUDIT_REPORT_TEMPLATE.md` | Destinazione finale di score e verdict |
| Oracode System Manifesto | `oracode/ORACODE_SYSTEM_MANIFESTO_IT_v1.0.0.md` | Fonte normativa del framework di audit |