---
title: Retrospective Tech Spec
slug: retrospective-tech-spec
doc_type: tech-spec
version: 1.0.0
status: current
date: '2026-05-08'
updated_at: '2026-05-08'
author: Padmin D. Curtis for Fabio Cherici
scope:
- oracode
rag_indexed: true
priority: high
source: docs/oracode/MISSION_PROTOCOL.md § 6.2
---

# Retrospective Auto-Migliorante — Specifica Tecnica

> Consumatore del tracking accessi filesystem (M-158).
> Confronta moduli pre-allocati con moduli usati e genera proposte
> per il BOOTSTRAP_DRIFT_LOG.

---

## 1. Architettura

**Script**: `/home/fabio/oracode/bin/mission_retrospective.py`
**Invocazione**: `python3 mission_retrospective.py [--mission M-NNN]`
**Trigger**: comando esplicito in FASE 6 (non hook automatico)
**Dipendenze**: Python 3.10+ (stdlib only, zero pip install)

Input:
- `MISSION_REGISTRY.json` → tipo_missione, organi_coinvolti
- `MISSION_BOOTSTRAP_INDEX.json` → moduli pre-allocati
- `MISSION_READ_LOG.jsonl` → accessi reali (da M-158)

Output:
- Entry in `BOOTSTRAP_DRIFT_LOG.md` (se drift rilevato)
- `retrospective_executed: true` in `MISSION_REGISTRY.json`

---

## 2. Ordine di esecuzione in FASE 6

Il retrospective viene eseguito **PRIMA** della chiusura stato a "completed".

```
FASE 6 — Chiusura mission (ordine obbligatorio):
  1. DOC-SYNC (allineamento codice ↔ SSOT)
  2. Retrospective bootstrap (mission ancora in_progress)
     python3 /home/fabio/oracode/bin/mission_retrospective.py
  3. Aggiornamento stato → "completed"
  4. retrospective_executed: true nel registry
  5. Mission report (tecnico + esteso)
  6. Commit + push
```

**Vincolo**: se il retrospective viene eseguito dopo la chiusura stato,
il comando non trovera la mission corrente e operera sulla mission
in_progress piu recente (comportamento errato). L'ordine e obbligatorio.

---

## 3. Logica di calcolo diff

### Step 1 — Expected (moduli pre-allocati)

```
expected = by_mission_type[tipo_missione] + by_organ[organo] per ogni organo
```

I moduli `always_loaded` sono ESCLUSI da expected (vincolo M-158 R1).

### Step 2 — Actual (moduli usati)

Dal `MISSION_READ_LOG.jsonl`, filtrato per:
- `mission == mission_id`
- `action` contiene "read" (include "read" e "read+write")

Path normalizzati: prefisso `/home/fabio/` e `EGI-DOC/` rimossi.

Solo path che passano il filtro pool SSOT (§4) sono candidati per `used_unloaded`.

### Step 3 — Diff

```
loaded_unused = expected - actual    (pre-allocati mai consultati)
used_unloaded = actual - expected    (consultati ma non pre-allocati)
```

---

## 4. Filtro pool SSOT

Il filtro determina quali file dal read_log sono candidati per `used_unloaded`.

**Pattern hardcoded** (v1.0.0):

```python
SSOT_CANDIDATE_PATTERNS = [
    "docs/",                        # SSOT documentali
    "CLAUDE.md",                    # binding organo
    "CLAUDE_ECOSYSTEM_CORE.md",     # core condiviso
]
```

Un path e candidato se contiene almeno uno di questi pattern.

**Esclusi automaticamente**: file sorgente (`.py`, `.php`, `.ts`), hook (`.sh`),
audit log, registry JSON operativi, file di configurazione.

**Limitazione**: il filtro e hardcoded. Quando emergono nuovi tipi di SSOT
in path nuovi (es. `oracode/templates/`, `egi-c/specs/`), il filtro va
aggiornato manualmente nel codice dello script.

**Raffinamento futuro** (fuori scope M-159): auto-adattivita derivando il pool
dai path gia presenti nel `MISSION_BOOTSTRAP_INDEX.json`. Implementabile
quando il volume di proposte rivela pattern di esclusione sistematica.

---

## 5. Esclusione always_loaded

I 5 file `always_loaded` di `MISSION_BOOTSTRAP_INDEX.json` vengono esclusi
sia da `expected` che da `actual` prima del calcolo diff.

Razionale (da READ_TRACKING_TECH_SPEC.md §6): i file always_loaded vengono
caricati via `@` include di CLAUDE.md, non via tool Read. Non appaiono nel
read_log per limitazione strutturale del meccanismo PostToolUse hook.
Escluderli previene falso positivo strutturale sistematico.

---

## 6. Calcolo severity

| Criterio | Severity |
|----------|----------|
| 1 file in loaded_unused OR used_unloaded | `minor` |
| 2-4 file totali | `moderate` |
| 5+ file totali OR drift bidirezionale | `major` |

Severity e campo informativo nell'entry DRIFT_LOG. Non filtra la generazione
della proposta (qualsiasi differenza genera entry).

---

## 7. Format entry DRIFT_LOG

```markdown
### M-NNN — YYYY-MM-DD — tipo / organi

**Severity**: minor | **Stato**: pending
**always_loaded esclusi**: N file

**loaded_unused** (pre-allocati mai consultati):
- `path/to/file.md`

**used_unloaded** (consultati ma non pre-allocati):
- `path/to/other/file.md`

**Proposta**:
- `by_mission_type.tipo`: consider removing/adding N file

**Reasoning**: drift empirico rilevato su M-NNN (tipo/organi).
Singola osservazione — CEO valuta se pattern ricorrente o specifico.
```

**Stati delle proposte**: `pending` → `approved` (applicato) | `rejected` (con motivazione)

---

## 8. Come interpretare le proposte del DRIFT_LOG

Le proposte sono generate dopo **singola osservazione**. Molte saranno
specifiche di una mission, non pattern ricorrenti del tipo.

**Linee guida per CEO/Watchdog**:

| Segnale | Interpretazione | Azione |
|---------|-----------------|--------|
| File in 1 sola mission | Specifico di quella mission | Ignorare (reject con nota) |
| File in 3+ mission stesso tipo | Pattern ricorrente reale | Considerare apply a by_mission_type |
| File in mission di tipi diversi | Candidato always_loaded | Considerare promozione a always_loaded |
| File sempre in loaded_unused | Pre-allocato mai utile per quel tipo | Considerare rimozione da by_mission_type |

**Filtraggio statistico cross-mission** (es. "proporre solo se file apparso
in N mission dello stesso tipo") e raffinamento futuro. Per ora il volume di
dati e insufficiente per derivare soglie statistiche significative. Il sistema
si auto-rivelera: dopo 50+ mission, i pattern ricorrenti emergeranno
naturalmente dal DRIFT_LOG.

---

## 9. Casi edge

| Caso | Comportamento |
|------|---------------|
| `tipo_missione` non in BOOTSTRAP_INDEX | `expected` = solo by_organ |
| `organi_coinvolti` vuoto o `["oracode"]` | `expected` = solo by_mission_type |
| Organo non in by_organ | Organo ignorato |
| Mission senza entry nel read_log | `actual` vuoto → tutti i pre-allocati in loaded_unused |
| Path non normalizzabili | Esclusi da used_unloaded |
| `no_changes` (diff vuoto) | `retrospective_executed: true`, nessuna entry in DRIFT_LOG |

---

## 10. Limitazioni note

1. **Singola osservazione**: propone dopo 1 mission, non pattern statistici
2. **Filtro pool hardcoded**: nuovi path SSOT richiedono aggiornamento manuale
3. **always_loaded invisibili**: caricati via @ include, non tracciabili
4. **Bash parsing ereditato**: copertura ~60-70% (limitazione di M-158)
5. **No apply automatico**: proposte solo in DRIFT_LOG, apply manuale CEO
6. **Session continuation**: quando Claude Code compatta il context e riprende, le Read della prima parte di sessione non sono piu visibili al hook. Il retrospective di mission lunghe (1-2 compaction) vedra solo 30-50% delle Read reali. Bias negativo sistematico. Pattern utili emergeranno dopo 30-50 mission su organi reali, non 10-20 (finding M-159)

---

## 11. Versionamento

**Versione**: 1.0.0
**Data**: 2026-05-08
**Mission di riferimento**: M-159
**Prerequisito**: M-158 (tracking accessi filesystem)
**Consumato da**: MISSION_PROTOCOL.md FASE 6 (§ 6.2)

*Per il tracking accessi: `docs/oracode/READ_TRACKING_TECH_SPEC.md`*
*Per il protocollo completo: `docs/oracode/MISSION_PROTOCOL.md` § 6.2-6.3*
