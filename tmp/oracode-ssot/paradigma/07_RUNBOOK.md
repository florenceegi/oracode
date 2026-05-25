---
title: Oracode Audit — Runbook Operativo
slug: oracode-audit-07-runbook
doc_type: guide
version: 1.1.0
status: current
date: '2026-03-25'
updated_at: '2026-03-25'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- oracode
supersedes:
- /home/fabio/EGI-DOC/docs/_archive/oracode/audit/07_RUNBOOK_v1.0.0_20260325.md
superseded_by: null
rag_indexed: true
priority: normal
---

# Oracode Audit — Runbook Operativo

Sequenza operativa completa per eseguire un audit Oracode dall'inizio alla fine, con comandi esatti, tempi stimati e criteri di scoring.

<!-- Fonte normativa: ../oracode_compliance_audit_v_1.md §7, §12, §15 -->

---

## Prerequisiti

Questa sezione elenca le condizioni necessarie prima di avviare qualsiasi tipo di audit Oracode.

| # | Requisito | Dove verificare |
|---|-----------|-----------------|
| 1 | Target identificato | `oracode/audit/01_TARGET_MATRIX.md` |
| 2 | Branch e commit range definiti | Chiedere a Fabio se non noti |
| 3 | Accesso al repository target | Verificare clone locale e permessi |
| 4 | Accesso a EGI-DOC | Verificare che `/home/fabio/EGI-DOC/` sia raggiungibile |
| 5 | Tempo disponibile | 2–4h (audit completo), 30–60min (audit leggero) |

---

## Tipo di audit — scegli prima di iniziare

Questa sezione definisce i tre tipi di audit disponibili e il loro scope.

| Tipo | Quando si usa | Scope |
|------|---------------|-------|
| **Audit completo** | Prima di release importanti | Tutti gli 8 controlli P0, tutti i flussi critici |
| **Audit leggero** | Milestone significativa | P0 + P1-2 + CCA + mismatch documentali |
| **Audit mirato** | Dopo refactor/cambio policy/cambio SSOT | Solo area impattata + P0-8 se applicabile |

| Tipo audit | Tempo stimato |
|------------|---------------|
| Audit completo | 2–4 ore |
| Audit leggero | 45–90 min |
| Audit mirato (solo P0) | 30–45 min |

---

## FASE 0 — Setup (5–10 min)

Questa fase prepara i file di lavoro e raccoglie i documenti normativi necessari.

### Step 0.1 — Crea i file di lavoro

Copiare i template nella cartella `audit/reports/`:

```bash
cp /home/fabio/EGI-DOC/docs/oracode/audit/03_EVIDENCE_PACK_TEMPLATE.md \
   /home/fabio/EGI-DOC/docs/oracode/audit/reports/EVIDENCE_[TARGET-ID]_[DATA].md

cp /home/fabio/EGI-DOC/docs/oracode/audit/04_AUDIT_REPORT_TEMPLATE.md \
   /home/fabio/EGI-DOC/docs/oracode/audit/reports/REPORT_[TARGET-ID]_[DATA].md
```

Sostituire `[TARGET-ID]` con l'identificativo del target da `01_TARGET_MATRIX.md` e `[DATA]` con la data corrente in formato `YYYY-MM-DD`.

### Step 0.2 — Compila Sezione 1 (Identificazione target) nell'Evidence Pack

1. Leggere il record del target in `oracode/audit/01_TARGET_MATRIX.md`
2. Copiare le informazioni nel campo Metadati dell'Evidence Pack

### Step 0.3 — Leggi i documenti normativi

| Documento | Path relativo a `EGI-DOC/docs/` | Scopo |
|-----------|----------------------------------|-------|
| Documento madre | `oracode/oracode_compliance_audit_v_1.md` | Normativa di riferimento |
| SSOT locale del progetto target | `[path_progetto]/CLAUDE.md` | Regole e stato corrente del progetto |
| Documentazione EGI-DOC del target | Vedi colonna path in `oracode/audit/01_TARGET_MATRIX.md` | Contesto progetto |

---

## FASE 1 — Ricognizione iniziale (15–20 min)

Questa fase raccoglie lo stato corrente del progetto target prima di eseguire i controlli.

### Step 1.1 — Verifica stato SSOT locale

```bash
# Leggi il CLAUDE.md del progetto
Read [path_progetto]/CLAUDE.md
```

Verificare che sia aggiornato: data, versione, contenuto.

### Step 1.2 — Verifica stato SSOT centrale

```bash
# Leggi il documento EGI-DOC pertinente
ls /home/fabio/EGI-DOC/docs/[area_progetto]/
# Leggi i file rilevanti
```

### Step 1.3 — Ricognizione codebase

```bash
# Struttura generale
find [path_progetto] -maxdepth 3 -type f \
  -name "*.php" -o -name "*.ts" -o -name "*.tsx" \
  | grep -v vendor | grep -v node_modules | head -30

# File più grandi (candidati LEGACY)
find [path_progetto]/app -name "*.php" \
  | xargs wc -l 2>/dev/null | sort -rn | head -15

# Git log recente (ultimi 10 commit)
git -C [path_progetto] log --oneline -10
```

### Step 1.4 — Identifica modifiche recenti da auditare

```bash
# Diff rispetto a commit range definito nel prerequisito 2
git -C [path_progetto] diff --name-only [commit_start]..[commit_end]
```

Documentare i file modificati nella Sezione 1 dell'Evidence Pack.

---

## FASE 2 — Verifica P0 (30–60 min — non comprimere)

Questa fase esegue tutti i controlli P0. Ogni controllo richiede evidenza specifica nell'Evidence Pack. Nessun P0 è saltabile.

### Step 2.1 — P0-1 Regola Zero

Per ogni file modificato recentemente:

```bash
# Cerca metodi usati senza verifica documentata
grep -n "->.*(" [file_modificato] | head -20

# Per ogni metodo trovato → verifica che esista nel service/class chiamata
grep -n "function nomeMetodo" [path_service].php
```

### Step 2.2 — P0-2 Translation Keys

Per progetti PHP/Blade:

```bash
grep -rn "'" resources/views/ --include="*.blade.php" \
  | grep -v "__\|trans\|@lang\|\/\/" \
  | grep -v "class=\|href=\|id=\|src=\|action=" \
  | head -20
```

Per progetti React/TypeScript:

```bash
grep -rn '"[A-Z][a-z]' src/ --include="*.tsx" \
  | grep -v "import\|type\|interface\|//\|className" \
  | head -20
```

### Step 2.3 — P0-3 Statistics Rule

```bash
grep -rn "->take(\|->limit(\| LIMIT [0-9]" app/ \
  --include="*.php" \
  | grep -v "config\|test\|vendor" \
  | head -20
```

### Step 2.4 — P0-4 Anti-Method-Invention

Per ogni file modificato, per ogni chiamata a service:

```bash
grep -n "Service->\|Repository->" [file_modificato]

# Per ogni metodo trovato → verifica esistenza
grep -n "function [nomeMetodo]" [path_service]
```

### Step 2.5 — P0-5 UEM-First

```bash
grep -rn "catch\b" app/ --include="*.php" -A 3 \
  | grep -v "errorManager\|handle\|UEM" \
  | head -20

grep -rn "Log::error\|Log::warning" app/ --include="*.php" \
  | grep -v "errorManager" \
  | head -10
```

### Step 2.6 — P0-6 Anti-Service-Method

Evidenza richiesta: traccia che il service sia stato letto prima di essere usato nelle modifiche recenti.

Se non verificabile: annotare come `NON VERIFICABILE` nell'Evidence Pack.

### Step 2.7 — P0-7 Anti-Enum-Constant

```bash
# Trova enum usate nelle modifiche recenti
grep -rn "Enum::\|::class" [file_modificato]

# Per ogni enum trovata → verifica che la costante esista
grep -n "case\|const" app/Enums/NomeEnum.php
```

### Step 2.8 — P0-8 Complete Flow Analysis

Per ogni fix/refactor critico nelle modifiche recenti:

1. Recuperare la flow map prodotta durante quel fix
2. Se la flow map non esiste → P0-8 FAIL

Aree critiche che richiedono P0-8:

| Area |
|------|
| Pagamenti |
| Auth |
| Blockchain |
| GDPR |
| Multi-tenancy |
| Schema core (EGI-HUB) |
| AI layer |

---

## FASE 3 — Verifica P1 (20–30 min)

Questa fase esegue i controlli di priorità P1, obbligatori per audit completo e leggero.

### Step 3.1 — P1-1 Docblock

```bash
# Verifica presenza firma OS3 nei file nuovi/modificati
grep -n "@purpose\|@author\|@package" [file_modificato]
```

### Step 3.2 — P1-2 SSOT update obligation

Per ogni modifica di Tipo 2+ nelle modifiche recenti:

```bash
# Verifica che ci sia stato un commit DOC-SYNC corrispondente
git -C /home/fabio/EGI-DOC log --oneline --since="[data_prima_modifica]" | grep "DOC"
```

### Step 3.3 — P1-3 Zero placeholder/TODO

```bash
grep -rn "TODO\|FIXME\|TBD\|\[da completare\]\|placeholder" \
  [path_progetto]/app [path_progetto]/resources [path_progetto]/src \
  --include="*.php" --include="*.tsx" --include="*.ts" \
  | grep -v vendor | grep -v node_modules
```

### Step 3.4 — P1-4 Testing

```bash
# Verifica esistenza test per aree critiche modificate
ls [path_progetto]/tests/Feature/
ls [path_progetto]/tests/Unit/
```

### Step 3.5 — P1-5 GDPR / security / accessibilità

Verifica spot che le modifiche non abbiano rimosso:

| Controllo | Cosa cercare |
|-----------|-------------|
| Audit trail GDPR | Logging presente dove era attivo prima delle modifiche |
| Auth checks | Sanctum/RBAC non rimosso o bypassato |
| Sanitizzazione input | Validazione input non rimossa |

---

## FASE 4 — Verifica CCA (Claude Code Audit) (10–15 min)

Questa fase verifica la configurazione Claude Code del progetto target.

```bash
# Step 4.1 — Verifica CLAUDE.md
Read [path_progetto]/CLAUDE.md

# Step 4.2 — Verifica presenza agenti
ls [path_progetto]/.claude/agents/

# Step 4.3 — Verifica presenza doc-sync-guardian
cat [path_progetto]/.claude/agents/doc-sync-guardian.md

# Step 4.4 — Verifica settings.json
cat [path_progetto]/.claude/settings.json

# Step 4.5 — Verifica comandi
ls [path_progetto]/.claude/commands/
```

Compilare Sezione 6B dell'Evidence Pack (CCA-1 → CCA-8).

---

## FASE 5 — Mismatch documentali (10–15 min)

Questa fase identifica discrepanze tra documentazione e stato reale del codebase.

Confronti da eseguire:

| # | Confronto |
|---|-----------|
| 1 | Cosa dichiara `CLAUDE.md` vs stato reale del codebase |
| 2 | Cosa dichiara EGI-DOC vs stato reale |
| 3 | Naming in documentazione vs naming nel codice |

```bash
# Cerca discrepanze naming
grep -r "[Termine_documentato]" [path_progetto]/app/ --include="*.php" | head -5
# Se il termine non compare → mismatch
```

---

## FASE 6 — Scoring e Verdict (15–20 min)

Questa fase produce il punteggio finale e il verdetto dell'audit.

### Step 6.1 — Compila il Scoring Sheet

Usare il template `oracode/audit/05_SCORING_SHEET.md`. Usare SOLO le evidenze raccolte nell'Evidence Pack. Non integrare a posteriori.

### Step 6.2 — Calcola il punteggio totale

Seguire la formula definita nello Scoring Sheet.

### Step 6.3 — Applica la regola assoluta P0

**P0 aperte > 0 → FAIL**, indipendentemente dal punteggio totale.

### Step 6.4 — Compila il Report

Usare il template `oracode/audit/04_AUDIT_REPORT_TEMPLATE.md` già copiato nello Step 0.1.

---

## FASE 7 — Output e remediation (10–15 min)

Questa fase finalizza l'audit e attiva eventuali azioni correttive.

### Step 7.1 — Compila Allegato B (Compliance Summary) nel Report

### Step 7.2 — Aggiorna `01_TARGET_MATRIX.md`

| Campo da aggiornare | Valore |
|---------------------|--------|
| Stato audit del target | PASS / FAIL / SUSPENDED |
| Data ultimo audit | Data corrente |
| Link al report | Path relativo al file REPORT generato |

### Step 7.3 — Se FAIL con P0

1. Comunicare a Fabio
2. Blocco merge/deploy raccomandato
3. Aprire remediation formale

### Step 7.4 — Se P2 trovate

Aggiungere voci a `debiti_tecnici.md` del progetto target.

### Step 7.5 — DOC-SYNC dell'audit

1. Commit su EGI-DOC con i nuovi file in `audit/reports/`
2. Formato commit:

```
[AUDIT] [TARGET-ID] — [PASS/FAIL/SUSPENDED]: [note sintetica]
```

---

## Errori comuni e violazioni

Questa sezione elenca le azioni che invalidano un audit Oracode.

| # | Violazione | Perché è grave |
|---|-----------|----------------|
| 1 | Compilare la checklist senza leggere i file | L'audit è basato su evidenze, non su assunzioni |
| 2 | Dichiarare PASS su un P0 senza evidenza specifica | P0 richiede evidenza esplicita per ogni controllo |
| 3 | Aggiornare la SSOT in modo cosmetico per far quadrare il report | Falsifica lo stato reale del progetto |
| 4 | Saltare la Fase 2 (P0) perché "probabilmente è tutto ok" | P0 non è comprimibile né saltabile |
| 5 | Usare "non applicabile" su P0-1 (Regola Zero) | Regola Zero è sempre applicabile, senza eccezioni |
| 6 | Dichiarare audit completato senza aver compilato Evidence Pack | Senza Evidence Pack l'audit non è verificabile |

---

## Riferimenti

| Documento | Path relativo a `EGI-DOC/docs/` |
|-----------|----------------------------------|
| Documento madre (normativa) | `oracode/oracode_compliance_audit_v_1.md` |
| Target Matrix | `oracode/audit/01_TARGET_MATRIX.md` |
| Trigger Matrix | `oracode/audit/02_TRIGGER_MATRIX.md` |
| Evidence Pack Template | `oracode/audit/03_EVIDENCE_PACK_TEMPLATE.md` |
| Audit Report Template | `oracode/audit/04_AUDIT_REPORT_TEMPLATE.md` |
| Scoring Sheet | `oracode/audit/05_SCORING_SHEET.md` |
| Claude Code Enforcement | `oracode/audit/06_CLAUDE_CODE_ENFORCEMENT.md` |