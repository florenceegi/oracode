# OS3 Matrix — Enforcement Template

> Strumento di enforcement per il piano OS3 di Oracode.
> Prodotto commerciale. Non è il paradigma — è il software che lo fa rispettare.
> Richiede: @CLAUDE_ORACODE_CORE.md (paradigma) già caricato.

---

## Cos'è OS3 Matrix

OS3 Matrix (alias OSMx) è l'insieme dei componenti software che fanno rispettare
le regole di Oracode-paradigma al piano OS3, dove l'AI opera come co-autore a
velocità non verificabile dall'umano in tempo reale.

Senza il paradigma, Matrix non ha regole da far rispettare.
Senza Matrix, le regole restano indicazioni interpretabili — fragili sotto la pressione
di un LLM che produce a 100x la velocità dell'umano.

Il paradigma prescrive. Matrix enforcea.

---

## Quando serve OS3 Matrix

- **Livello 1 (senza Matrix):** disciplina sola. L'LLM segue le regole leggendole dal boot context. Funziona per progetti dove il CEO può verificare manualmente. Rischio: degradazione di sessione.
- **Livello 2+ (con Matrix):** enforcement meccanico. Le regole sono enforced da hook che bloccano l'azione AI prima che venga eseguita. Necessario quando velocità o complessità rendono la verifica manuale impossibile.

---

## Componenti

### Hook Bloccanti (PreToolUse / PostToolUse)

Gate fail-closed che intercettano l'azione AI prima o dopo l'esecuzione.

```
PreToolUse:  si attiva PRIMA dell'azione. Può BLOCK, ASK, o WARN.
PostToolUse: si attiva DOPO l'azione. Registra, segnala, propone correzioni.

Design: fail-closed dove serve, fail-open dove non serve.
```

**Hook attivi in questo progetto:**

<!-- COMPILARE: elenco hook del progetto con regola P0 associata -->
```
{{HOOKS_LIST}}
Esempio:
  check-no-legacy-stack.sh    → P0 stack bannati       → BLOCK
  check-method-exists.sh      → P0-4 Anti-Method       → BLOCK
  check-file-size.sh          → Git Safety R1/R4        → BLOCK/WARN
  check-i18n-complete.sh      → P0-9 i18n              → BLOCK
```

### Gate Validator

```
Gate pre-push:  verifica conformità OS3 prima del push. Emette PASS/WARN/BLOCK.
Gate CI/CD:     Lighthouse (Performance ≥ {{LIGHTHOUSE_PERF}}, Accessibility ≥ {{LIGHTHOUSE_A11Y}}).
Gate coverage:  test coverage minima per nuovo codice.
```

### Mission Registry Enforcement

```
SSOT:    {{MISSION_REGISTRY_PATH}}
Report:  {{MISSION_REPORT_PATH}}

FASE 0: leggi counter → counter+1 → verifica no collision → aggiungi entry → commit+push SUBITO
FASE 1: compila titolo/tipo/organi/data/stato → commit+push
FASI 2-5: analisi, piano, esecuzione, chiusura
FASE 6: data_chiusura + stato + report + DOC-SYNC + commit+push

Counter prenotazione anti-collisione: obbligatorio.
Enforcement fasi: obbligatorio — non si salta da FASE 1 a FASE 5.
```

### DOC-SYNC v2 Runtime

```
Drift detection:  {{DOC_SYNC_MODE}} (autonoma via cron / manuale a chiusura mission)
Coverage check:   nativa — segnala SSOT non coperti da watch
Analisi semantica: a chiusura mission, confronta diff con SSOT impattati
Re-indexing RAG:  sincrono con sanity check bloccante
Audit trail:      ogni sync registrato con timestamp, file toccati, esito

SSOT Registry:    {{SSOT_REGISTRY_PATH}}
Agent:            doc-sync-v2 (invocato a chiusura mission, FASE 6)
```

### Agenti Specializzati (software)

<!-- COMPILARE: agenti attivi nel progetto -->
```
{{AGENTS_LIST}}
Esempio:
  doc-sync-v2                → sync SSOT a chiusura mission
  os3-audit-specialist       → audit conformità OS3
  os3-gate                   → gate validator pre-push
  ssot-living-agent          → drift detection autonoma
  oracode-alignment-interpreter → diagnostica allineamento kernel
  organ-gap-scout            → gap evolutivi organo
```

### Infrastruttura SSOT (L0 Mielina)

```
SSOT_REGISTRY.json: mappa esplicita doc SSOT → file codebase.
Watches:           copertura con segnalazione automatica di perdita.
Segnalazione:      quando un file watchato cambia senza DOC-SYNC, il sistema segnala.
```

### Organ Index (se multi-organo)

```
Path:    {{ORGAN_INDEX_PATH}}
Uso:     verifica esistenza classe/service PRIMA di creare (P0-4, P0-6, P0-13)
Comando: {{ORGAN_INDEX_COMMAND}}
```

---

## Git Safety — Enforcement

Le soglie sono definite nel paradigma (CLAUDE_ORACODE_CORE.md).
Qui si definisce l'enforcement automatico:

```
Hook:    {{GIT_SAFETY_HOOK_PATH}}
R1 >100 righe/file:     → exit 1 (BLOCK)
R2 50-100 righe/file:   → echo WARNING (WARN)
R3 >50% file rimosso:   → exit 1 (BLOCK)
R4 >500 righe totali:   → exit 1 (BLOCK)

Bypass: --no-verify SOLO con approvazione esplicita CEO.
MAI `git clean -fd` su server.
```

---

## Protocollo Epistemologico — Enforcement

Il pattern è definito nel paradigma. Qui si definisce dove vivono gli agenti:

```
Specifica completa: {{EPISTEMOLOGY_PROTOCOL_PATH}}
Agenti:             {{AGENTS_DIR}}
```

---

## Placeholder da compilare

```
{{HOOKS_LIST}}                  — elenco hook attivi con P0 e livello (BLOCK/ASK/WARN)
{{AGENTS_LIST}}                 — elenco agenti attivi con scope
{{MISSION_REGISTRY_PATH}}       — path assoluto MISSION_REGISTRY.json
{{MISSION_REPORT_PATH}}         — path pattern report mission (M-NNN_TITOLO.md)
{{SSOT_REGISTRY_PATH}}          — path assoluto SSOT_REGISTRY.json
{{DOC_SYNC_MODE}}               — "autonoma" (cron) o "manuale" (a chiusura mission)
{{ORGAN_INDEX_PATH}}            — path organ index (vuoto se mono-organo)
{{ORGAN_INDEX_COMMAND}}         — comando per interrogare organ index
{{GIT_SAFETY_HOOK_PATH}}        — path hook git safety
{{EPISTEMOLOGY_PROTOCOL_PATH}}  — path protocollo epistemologico
{{AGENTS_DIR}}                  — directory agenti .md
{{LIGHTHOUSE_PERF}}             — soglia minima Lighthouse Performance (es. 95)
{{LIGHTHOUSE_A11Y}}             — soglia minima Lighthouse Accessibility (es. 100)
```

---

*OS3 Matrix — Enforcement per Oracode al piano OS3.*
*Prodotto commerciale di {{COMPANY_NAME}}.*
*Versione template: 1.0.0 — Data: 2026-05-25*
