---
title: Oracode Audit — Report Template
slug: oracode-audit-04-audit-report-template
doc_type: audit
version: 1.1.0
status: current
date: '2026-03-25'
updated_at: '2026-03-25'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- oracode
supersedes:
- /home/fabio/EGI-DOC/docs/_archive/oracode/audit/04_AUDIT_REPORT_TEMPLATE_v1.0.0_20260325.md
superseded_by: null
rag_indexed: true
priority: normal
---

# Oracode Audit — Report Template

Scopo: template standard per la produzione di report di audit Oracode, compilabile a partire dall'Evidence Pack.

---

## Sezione 0 — Istruzioni d'uso

Scopo: definire il flusso operativo per la compilazione del report.

| Passo | Azione | Dettaglio |
|------:|--------|-----------|
| 1 | Copia il template | Destinazione: `audit/reports/REPORT_[TARGET-ID]_[YYYY-MM-DD].md` |
| 2 | Compila dall'Evidence Pack | Fonte dati: Evidence Pack compilato (`oracode/audit/03_EVIDENCE_PACK_TEMPLATE.md`) — non dal codice direttamente |
| 3 | Applica regola verdict | P0 aperta = FAIL (regola assoluta, §10 doc madre `oracode/ORACODE_SYSTEM_MANIFESTO_IT_v1.0.0.md`) |
| 4 | Distingui i livelli di pubblicazione | Il report è il documento pubblico. L'Evidence Pack è la prova sottostante |

Fonte normativa: `oracode/ORACODE_SYSTEM_MANIFESTO_IT_v1.0.0.md` §11

Prerequisito: Evidence Pack compilato — ref. `oracode/audit/03_EVIDENCE_PACK_TEMPLATE.md`

---

# Audit Report — [TARGET-ID]: [Nome Target]

---

## Sezione 1 — Identificazione target

Scopo: identificare univocamente il target, l'auditor, il perimetro temporale e il collegamento all'Evidence Pack.

| Campo | Valore |
|-------|--------|
| **Repository** | [DA COMPLETARE] |
| **Progetto** | [DA COMPLETARE] |
| **Owner** | [DA COMPLETARE] |
| **Branch analizzato** | [DA COMPLETARE] |
| **Commit / Range** | [DA COMPLETARE] |
| **Ambiente** | [DA COMPLETARE] |
| **Auditor** | [DA COMPLETARE] |
| **Data** | YYYY-MM-DD |
| **Evidence Pack** | `audit/reports/EVIDENCE_[TARGET-ID]_[YYYY-MM-DD].md` |

---

## Sezione 2 — Scope reale

Scopo: dichiarare esattamente cosa è stato analizzato, cosa è stato escluso e quali fonti SSOT sono state consultate.

### 2.1 — Perimetro di analisi

| Categoria | Contenuto |
|-----------|-----------|
| **Incluso nell'audit** | [DA COMPLETARE — cosa è stato realmente analizzato] |
| **Escluso dall'audit** | [DA COMPLETARE — cosa è stato escluso e perché] |

### 2.2 — Flussi verificati

- [DA COMPLETARE — elenco flussi]

### 2.3 — SSOT rilevanti

| Tipo SSOT | Path |
|-----------|------|
| SSOT locale | [DA COMPLETARE — `path`] |
| SSOT centrale EGI-DOC | [DA COMPLETARE — `path`] |
| Altri documenti letti | [DA COMPLETARE — lista] |

---

## Sezione 3 — Evidenze (sintesi)

Scopo: fornire una sintesi quantitativa delle evidenze raccolte. Il dettaglio completo è nell'Evidence Pack.

| Tipo evidenza | Quantità | Qualità |
|---------------|----------|---------|
| File letti | [N] | sufficiente / insufficiente |
| Flussi verificati | [N] | completi / parziali |
| Test verificati | [N] | presenti / assenti / parziali |
| Config Claude Code | verificata / non verificata | [DA COMPLETARE] |

Riferimento dettaglio: Evidence Pack `audit/reports/EVIDENCE_[TARGET-ID]_[YYYY-MM-DD].md`

---

## Sezione 4 — Controlli P0 (Blocking)

Scopo: verificare i controlli bloccanti. Una singola P0 FAIL determina verdict FAIL indipendentemente dal punteggio totale.

| # | Controllo | Esito | Evidenza |
|---|-----------|-------|----------|
| P0-1 | Regola Zero | ✅ PASS / ❌ FAIL | [riferimento evidence pack] |
| P0-2 | Translation Keys Only | ✅ PASS / ❌ FAIL / N/A | [riferimento evidence pack] |
| P0-3 | Statistics Rule | ✅ PASS / ❌ FAIL / N/A | [riferimento evidence pack] |
| P0-4 | Anti-Method-Invention | ✅ PASS / ❌ FAIL | [riferimento evidence pack] |
| P0-5 | UEM-First Rule | ✅ PASS / ❌ FAIL / N/A | [riferimento evidence pack] |
| P0-6 | Anti-Service-Method | ✅ PASS / ❌ FAIL | [riferimento evidence pack] |
| P0-7 | Anti-Enum-Constant | ✅ PASS / ❌ FAIL / N/A | [riferimento evidence pack] |
| P0-8 | Complete Flow Analysis | ✅ PASS / ❌ FAIL / N/A | [riferimento evidence pack] |

### P0 aperte

- [ ] Nessuna
- [ ] [Descrizione P0 aperta #1 — file/area/violazione]

Criteri di definizione P0: ref. `oracode/audit/01_TARGET_MATRIX.md`

---

## Sezione 5 — Controlli P1 (Must)

Scopo: verificare i controlli obbligatori non bloccanti. Le P1 aperte richiedono remediation prima del rilascio oppure eccezione formalizzata.

| # | Controllo | Esito | Note |
|---|-----------|-------|------|
| P1-1 | Docblock obbligatori | ✅ PASS / ❌ FAIL / ⚠️ PARZIALE | [DA COMPLETARE] |
| P1-2 | SSOT update obligation | ✅ PASS / ❌ FAIL / ⚠️ PARZIALE | [DA COMPLETARE] |
| P1-3 | Zero placeholder/TODO | ✅ PASS / ❌ FAIL | [DA COMPLETARE] |
| P1-4 | Testing minimo | ✅ PASS / ❌ FAIL / ⚠️ PARZIALE | [DA COMPLETARE] |
| P1-5 | GDPR/security/a11y | ✅ PASS / ❌ FAIL / N/A | [DA COMPLETARE] |

### P1 aperte

- [ ] Nessuna
- [ ] [Descrizione P1 aperta #1]

---

## Sezione 6 — Controlli P2/P3

Scopo: verificare i controlli di qualità (P2 — backlog) e i controlli di eccellenza (P3 — raccomandazioni).

| # | Priorità | Controllo | Esito | Note |
|---|----------|-----------|-------|------|
| P2-1 | P2 | Coerenza semantica | ✅ / ⚠️ / ❌ | [DA COMPLETARE] |
| P2-2 | P2 | Pattern extraction | ✅ / ⚠️ / ❌ | [DA COMPLETARE] |
| P2-3 | P2 | Logging strutturato | ✅ / ⚠️ / ❌ | [DA COMPLETARE] |
| P2-4 | P2 | Riutilizzabilità | ✅ / ⚠️ / ❌ | [DA COMPLETARE] |
| P3-1 | P3 | Chiarezza didattica | ✅ / ⚠️ | [DA COMPLETARE] |
| P3-2 | P3 | Eleganza semantica | ✅ / ⚠️ | [DA COMPLETARE] |

### P2 aperte (backlog)

- [ ] [Descrizione P2 — da inserire in `debiti_tecnici.md` del progetto se significativa]

---

## Sezione 6B — Audit Claude Code Config (CCA)

Scopo: verificare la configurazione Claude Code del target. Obbligatoria se il target ha Claude Code configurato.

| # | Controllo | Criterio | Esito | Note |
|---|-----------|----------|-------|------|
| CCA-1 | Identità ecosistemica dichiarata | Presente nel config | ✅ / ❌ | [DA COMPLETARE] |
| CCA-2 | Gerarchia documentale SSOT nota | Definita e coerente | ✅ / ❌ / ⚠️ | [DA COMPLETARE] |
| CCA-3 | Obbligo aggiornamento SSOT presente | Istruzione esplicita nel config | ✅ / ❌ | [DA COMPLETARE] |
| CCA-4 | Anti-assunzione configurata | Regola attiva | ✅ / ❌ | [DA COMPLETARE] |
| CCA-5 | Escalation corretta (stop + chiedi) | Comportamento verificato | ✅ / ❌ | [DA COMPLETARE] |
| CCA-6 | Flow-before-fix configurato | Regola attiva | ✅ / ❌ | [DA COMPLETARE] |
| CCA-7 | Produzione evidenze indotta | Comportamento verificato | ✅ / ❌ / ⚠️ | [DA COMPLETARE] |
| CCA-8 | Conflitto fonti gestito | Procedura definita | ✅ / ❌ / ⚠️ | [DA COMPLETARE] |

---

## Sezione 7 — Mismatch documentali

Scopo: registrare ogni divergenza tra stato reale del codice e stato dichiarato nella documentazione.

| # | Tipo | Reale (codice) | Dichiarato (doc) | Gravità | Azione richiesta |
|---|------|----------------|------------------|---------|------------------|
| 1 | [DA COMPLETARE] | [DA COMPLETARE] | [DA COMPLETARE] | P0 / P1 / P2 | [DA COMPLETARE] |

---

## Sezione 8 — Verdict e Remediation

Scopo: calcolare il punteggio, emettere il verdetto finale e definire il piano di remediation.

### 8.1 — Scoring

| Area | Peso (punti) | Punti ottenuti | Note |
|------|-------------:|---------------:|------|
| P0 Compliance | 40 | /40 | 0 se almeno una P0 aperta |
| P1 Compliance | 25 | /25 | [DA COMPLETARE] |
| SSOT Alignment | 15 | /15 | [DA COMPLETARE] |
| Claude Code Enforcement | 10 | /10 | [DA COMPLETARE] |
| Semantic Consistency | 5 | /5 | [DA COMPLETARE] |
| Evidence Quality | 5 | /5 | [DA COMPLETARE] |
| **TOTALE** | **100** | **/100** | |

### 8.2 — Interpretazione score

| Range punteggio | Classificazione |
|-----------------|-----------------|
| 95–100 | Conforme forte |
| 85–94 | Conforme con correzioni minori |
| 70–84 | Conforme fragile |
| < 70 | Non conforme |

### 8.3 — Verdict finale

```text
⚠️ REGOLA ASSOLUTA: Se P0 aperte > 0 → FAIL, indipendentemente dal score.
```

| Campo | Valore |
|-------|--------|
| **Verdict** | `PASS` / `PASS WITH CONDITIONS` / `FAIL` / `SUSPENDED` |
| **Motivazione** | [DA COMPLETARE — spiegazione sintetica del verdetto, 2-3 frasi] |

### 8.4 — Remediation Plan

| # | Violazione | Gravità | Owner | Azione richiesta | Scadenza |
|---|-----------|---------|-------|------------------|----------|
| 1 | [DA COMPLETARE] | P0 / P1 / P2 | [DA COMPLETARE] | [DA COMPLETARE] | YYYY-MM-DD |
| 2 | [DA COMPLETARE] | [DA COMPLETARE] | [DA COMPLETARE] | [DA COMPLETARE] | YYYY-MM-DD |

### 8.5 — Regole di remediation per gravità

| Gravità | Azione | Conseguenza |
|---------|--------|-------------|
| P0 | Blocco merge/deploy raccomandato → correzione immediata | Ri-audit obbligatorio |
| P1 | Remediation prima del rilascio | Oppure eccezione formalizzata con owner e scadenza |
| P2 | Aggiungere a `debiti_tecnici.md` del progetto | Tracciamento in backlog |

---

## Allegato B — Compliance Summary

Scopo: riepilogo compatto dello stato di compliance, utilizzabile per dashboard e reporting aggregato.

```text
### Oracode Compliance Summary
- Target: [DA COMPLETARE]
- Data: YYYY-MM-DD
- Stato: PASS / PASS WITH CONDITIONS / FAIL / SUSPENDED
- P0 aperte: [N]
- P1 aperte: [N]
- Score: [NN]/100
- SSOT alignment: OK / PARTIAL / FAIL
- Claude Code enforcement: OK / PARTIAL / FAIL
- Note finali: [DA COMPLETARE — una riga]
```