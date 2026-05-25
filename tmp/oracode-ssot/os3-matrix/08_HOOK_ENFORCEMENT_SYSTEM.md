---
title: Oracode — Hook Enforcement System
slug: oracode-audit-08-hook-enforcement-system
doc_type: guide
version: 1.2.0
status: current
date: '2026-03-25'
updated_at: '2026-05-15'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- oracode
supersedes:
- /home/fabio/EGI-DOC/docs/_archive/oracode/audit/08_HOOK_ENFORCEMENT_SYSTEM_v1.0.0_20260325.md
superseded_by: null
rag_indexed: true
priority: normal
---

# Oracode — Hook Enforcement System

<!-- Documento operativo: descrive il sistema di enforcement meccanico PreToolUse -->
<!-- Versione: 1.1.0 | Data: 2026-03-25 | Riscrittura OS3-RAG -->
<!-- @author Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici -->

---

## Scopo del documento

Questo documento descrive il sistema di hook PreToolUse che blocca meccanicamente le violazioni delle regole P0-4 e P0-6 in Claude Code, impedendo modifiche a file senza le verifiche preventive richieste.

---

## Prerequisiti

Questa sezione elenca le dipendenze necessarie per installare e operare gli hook.

| Prerequisito | Dettaglio |
|---|---|
| Claude Code | Installato con supporto hook PreToolUse |
| `jq` | Disponibile nel PATH della macchina di sviluppo |
| Python 3 | Per il modulo `check-method-exists.py` (H-02) |
| Accesso filesystem locale | Gli hook vivono solo sulla macchina di sviluppo, non si deployano su EC2 |
| `.claude/settings.json` | File di configurazione hook nella root di ogni progetto (non committato in git) |

---

## Perché gli hook, non solo le regole

Questa sezione spiega la motivazione progettuale alla base dell'enforcement meccanico.

Le regole in CLAUDE.md sono istruzioni. Claude le conosce e di solito le rispetta. Ma sotto pressione contestuale — una task complessa, uno stato di conversazione profondo, una richiesta implicita — le regole si perdono. Non per cattiva fede: per statistica.

**L'incidente del 2026-03-23** ha reso concreto il rischio:
Claude ha modificato `routes/web.php` aggiungendo il middleware `superadmin` alla route `/admin/config` senza leggere `AdminConfigController.php`. Il controller aveva già `hasAnyRole(['admin','superadmin','pa_entity_admin'])` via Spatie. Il middleware ha ristretto l'accesso al solo ruolo `superadmin`, escludendo `admin` e `pa_entity_admin` legittimi. Risultato: regressione silenziosa in produzione.

La causa non era ignoranza della regola P0-6. Era che P0-6 è una dichiarazione di intento. Un `exit 2` è definitivo.

**Gli hook PreToolUse sono blocchi meccanici.** Non si discutono. Non si "capiscono ma poi". Non si aggirano senza `--no-verify` esplicito e approvazione Fabio.

---

## Architettura tecnica

Questa sezione descrive la configurazione, il protocollo di esecuzione e la struttura dei file hook.

### Configurazione

Gli hook sono definiti in `.claude/settings.json` nella root di ogni progetto. Questo file **non è committato in git** — vive solo sulla macchina di sviluppo locale.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "/home/fabio/NATAN_LOC/.claude/hooks/check-routes-read-controller.sh"
          },
          {
            "type": "command",
            "command": "/home/fabio/NATAN_LOC/.claude/hooks/check-method-exists.sh"
          }
        ]
      }
    ]
  }
}
```

### Protocollo di esecuzione

| Parametro | Valore |
|---|---|
| Evento | `PreToolUse` — intercetta PRIMA dell'esecuzione del tool |
| Matcher | `Edit\|Write` — ogni modifica a file |
| Tipo | `command` — script bash eseguito come processo |
| Input | JSON su stdin con `tool_name`, `tool_input.file_path`, `tool_input.new_string`, `transcript_path` |
| Exit 0 | Consenti l'operazione |
| Exit 2 | Blocca l'operazione — il messaggio su stderr viene mostrato a Claude |

### Struttura dei file hook per progetto

```
.claude/
├── settings.json           ← configurazione hook (non in git)
└── hooks/
    ├── check-routes-read-controller.sh   ← Hook 1 (P0-6)
    ├── check-method-exists.sh            ← Hook 2 shell layer (P0-4)
    └── check-method-exists.py            ← Hook 2 analisi Python (P0-4)
```

---

## Hook Registry

Questa sezione elenca tutti gli hook attivi con il loro stato di deployment.

| ID | File | Regola enforced | Trigger | Stato |
|---|---|---|---|---|
| H-01 | `check-routes-read-controller.sh` | P0-6 Anti-Service-Method (routes) | Edit/Write su `*/routes/*.php` | attivo su 3 progetti |
| H-02 | `check-method-exists.sh` + `.py` | P0-4 Anti-Method-Invention | Edit/Write su `.php` e `.py` | attivo su 3 progetti |
| H-SEO | `seo-public-content-guard.sh` | SEO_STANDARD enforcement | Write/Edit su contenuto pubblico (euristica) | attivo globale (M-190) |

### Stato deployment per progetto

| Progetto | P0-6 hook (H-01) | P0-4 hook (H-02) | SEO hook (H-SEO) | Path config locale |
|---|---|---|---|---|
| NATAN_LOC | attivo | attivo | attivo | `/home/fabio/NATAN_LOC/.claude/` |
| EGI-HUB | attivo | attivo | attivo | `/home/fabio/EGI-HUB/.claude/` |
| EGI | attivo | attivo | attivo | `/home/fabio/EGI/.claude/` |

**Nota:** `.claude/` e il suo contenuto sono in `.gitignore` in tutti i progetti. Gli hook vivono esclusivamente sulla macchina di sviluppo locale. Non si deployano su EC2.

**Nota H-SEO:** l'hook SEO e configurato globalmente in `~/.claude/settings.json` (posizione [7]), non nei settings.json di progetto. Si applica a tutti i progetti dell'ecosistema.

---

## Hook 1 — H-01: check-routes-read-controller (P0-6)

Questa sezione descrive la logica, i path e il messaggio di blocco dell'hook che enforce la regola P0-6.

**File:** `.claude/hooks/check-routes-read-controller.sh`

**Regola enforced:** Prima di modificare un file `routes/*.php` che referenzia un Controller, quel Controller deve essere stato letto (`Read`) nel transcript corrente della sessione.

### Logica di esecuzione

| Step | Azione | Risultato se non soddisfatto |
|---|---|---|
| 1 | Riceve JSON su stdin → estrae `file_path`, `new_string`, `transcript_path` | — |
| 2 | Guard: intercetta solo `*/routes/*.php` | exit 0 (non di competenza) |
| 3 | Estrae il primo `XxxController` dal `new_string` con pattern `grep -oP '[A-Z][a-zA-Z]+Controller'` | exit 0 (nessun controller, es. solo middleware/gruppi) |
| 4 | Cerca il file fisico del controller con `find` nel path Controllers del progetto | exit 0 (controller non trovato nel filesystem = controller nuovo, non ancora creato → lascia passare) |
| 5 | Controlla se `"$CONTROLLER"` appare nel transcript JSONL con `grep -q` | exit 0 (il controller è stato letto) |
| 6 | Controller esistente ma non letto nel transcript | **exit 2** con messaggio P0-6 |

### Path controller per progetto

| Progetto | Path ricerca controller |
|---|---|
| NATAN_LOC | `laravel_backend/app/Http/Controllers/` |
| EGI-HUB | `backend/app/Http/Controllers/` |
| EGI | `app/Http/Controllers/` + `packages/ultra/egi-module/src/Http/Controllers/` |

### Messaggio di blocco (stderr)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  P0-6 VIOLATION — CONTROLLER NON LETTO PRIMA DI MODIFICARE LA ROUTE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  File route:   [file modificato]
  Controller:   [NomeController]
  File fisico:  [path assoluto del controller]

  PROBLEMA: Stai modificando una route che referenzia [Controller]
            ma NON hai ancora letto [Controller].php in questa sessione.

  COSA FARE ORA:
    1. Leggi il controller: [path]
    2. Verifica cosa già fa (Spatie, Gate, abort, policy)
    3. Mappa il flusso completo (P0-8: route → middleware → controller → auth)
    4. Solo DOPO torna a modificare la route
```

---

## Hook 2 — H-02: check-method-exists (P0-4)

Questa sezione descrive la logica, l'architettura a due livelli e le limitazioni dell'hook che enforce la regola P0-4.

**File:** `.claude/hooks/check-method-exists.sh` + `.claude/hooks/check-method-exists.py`

**Regola enforced:** I metodi chiamati su Service/Repository/Manager/Handler devono esistere nel file della classe corrispondente prima di essere scritti nel codice.

### Architettura a due livelli

Lo shell script gestisce i guard iniziali e la detection del progetto. Delega tutta l'analisi al modulo Python per evitare problemi di escaping con codice PHP/Python nel `new_string` (caratteri speciali, apici, regex embedded).

```
stdin (JSON)
    ↓
check-method-exists.sh
    ├── Guard: vendor/, .history/, migrations/, tests/ → exit 0
    ├── Guard: estensione non .php/.py → exit 0
    ├── Detection project root (NATAN_LOC / EGI-HUB / EGI)
    └── Delega a check-method-exists.py
            ↓
        stdout: violations (vuoto = nessuna)
            ↓
    .sh: vuoto → exit 0 | presente → exit 2 con messaggio
```

### Analisi PHP

**Pattern intercettato:** `$this->varName->methodName(`

**Suffissi riconosciuti:** `Service`, `Repository`, `Manager`, `Handler`, `Helper`, `Factory`

| Step | Azione | Risultato se non soddisfatto |
|---|---|---|
| 1 | Estrae coppie `(varName, methodName)` dal `new_string` | — |
| 2a | Skip se `methodName` è in FRAMEWORK_WHITELIST | exit 0 (metodo framework) |
| 2b | Cerca il tipo di `varName` nel file corrente (già su disco) tramite pattern di dichiarazione proprietà o parametro costruttore | skip (safe by default — nessun falso positivo) |
| 2c | Trova il file fisico della classe con `find project_root -name "TypeName.php"` (escluso `vendor`, `.git`, `node_modules`) | skip (file non trovato) |
| 2d | Verifica `function methodName(` nel file della classe | **VIOLATION** se non trovato |

**Pattern di ricerca tipo (step 2b):**
- Pattern 1: `private|protected|public|readonly TypeName $varName`
- Pattern 2: `TypeName $varName` nei parametri del costruttore

### Analisi Python

**Pattern intercettato:** `self.xyz_service.method_name(`

**Suffissi riconosciuti:** `_service`, `_generator`, `_analyzer`, `_retriever`, `_pipeline`, `_handler`

| Step | Azione | Risultato se non soddisfatto |
|---|---|---|
| 1 | Estrae coppie `(svc_name, method_name)` dal `new_string` | — |
| 2a | Skip se `method_name` è in FRAMEWORK_WHITELIST | exit 0 (metodo framework) |
| 2b | Cerca `def method_name(` in tutto il progetto Python (escluso `vendor`, `.git`, `node_modules`, `__pycache__`, `.venv`, `venv`) | **VIOLATION** se non trovato in nessun file |

### Whitelist framework (mai verificati)

```python
# Laravel Eloquent / Query Builder
'handle', 'log', 'execute', 'dispatch', 'fire', 'call', 'run', 'boot',
'register', 'make', 'bind', 'resolve', 'get', 'post', 'put', 'patch',
'delete', 'where', 'find', 'create', 'update', 'save', 'all', 'first',
'latest', 'oldest', 'paginate', 'with', 'has', 'whereHas', 'orderBy',
'groupBy', 'count', 'sum', 'pluck', 'toArray', 'toJson', 'fresh',
'refresh', 'load', 'append', 'fill', 'setAttribute', 'getAttribute',
'getKey', 'getTable', 'query', 'table', 'select', 'join', 'leftJoin',
'insert', 'truncate', 'transaction', 'commit', 'rollback', 'listen',
'publish', 'subscribe', 'emit', 'push', 'pull', 'increment', 'decrement',
'touch', 'replicate', 'forceDelete', 'restore', 'withTrashed',
'onlyTrashed', 'cursor', 'lazy', 'chunk', 'tap', 'pipe', 'via',
'info', 'warning', 'error', 'debug', 'critical', 'alert', 'notice',
# Python common
'close', 'open', 'read', 'write', 'connect', 'disconnect', 'send',
'receive', 'format', 'encode', 'decode', 'strip', 'split', 'join',
'append', 'extend', 'items', 'keys', 'values', 'copy', 'update'
```

### Limitazioni note e degradazione sicura

| Limitazione | Descrizione | Comportamento |
|---|---|---|
| Tipo non tracciabile da costruttore | Il service viene ereditato da una classe parent o injettato tramite trait: il tipo non è visibile nel file corrente | skip (non blocca) — safe by default |
| Python cerca `def method` globalmente | Non verifica che il metodo appartenga alla classe specifica del service. Se il metodo esiste in qualsiasi file Python del progetto, viene considerato valido | Produce raramente falsi negativi, mai falsi positivi |

**Principio guida:** un falso negativo (lascia passare codice potenzialmente sbagliato) è preferibile a un falso positivo (blocca codice corretto). Gli hook non sostituiscono la review — la assistono.

### Messaggio di blocco (stderr)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  P0-4 VIOLATION — METODI CHE NON ESISTONO RILEVATI
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  File: [file modificato]

  METODI NON TROVATI:
    • PHP: ClassName::methodName()
      File verificato: /path/to/ClassName.php
      Metodi disponibili: grep "public function" "/path/to/ClassName.php"

    • Python: svc_name.method_name()
      Nessun 'def method_name' trovato nel progetto
      Cerca: grep -rn "def method_name" [project_root] --include='*.py'

  COSA FARE ORA:
    1. Verifica i metodi disponibili nella classe/service
    2. Usa solo metodi esistenti — MAI inventarli
    3. Se il metodo manca, aggiungilo PRIMA nella classe, poi usalo qui

  P0-4: grep verifica esistenza metodo PRIMA di usarlo.
```

---

## Come aggiungere un nuovo progetto

Questa sezione descrive i passi per installare gli hook su un nuovo progetto.

### Step 1 — Creare la struttura directory

```bash
mkdir -p /home/fabio/NUOVO_PROGETTO/.claude/hooks
```

### Step 2 — Copiare i 3 file hook da NATAN_LOC

```bash
cp /home/fabio/NATAN_LOC/.claude/hooks/check-routes-read-controller.sh \
   /home/fabio/NATAN_LOC/.claude/hooks/check-method-exists.sh \
   /home/fabio/NATAN_LOC/.claude/hooks/check-method-exists.py \
   /home/fabio/NUOVO_PROGETTO/.claude/hooks/
```

### Step 3 — Rendere eseguibili

```bash
chmod +x /home/fabio/NUOVO_PROGETTO/.claude/hooks/*.sh \
         /home/fabio/NUOVO_PROGETTO/.claude/hooks/*.py
```

### Step 4 — Creare settings.json

Creare `/home/fabio/NUOVO_PROGETTO/.claude/settings.json` con il blocco `PreToolUse` (formato JSON nella sezione Architettura tecnica di questo documento), aggiornando i path dei comandi al nuovo progetto.

### Step 5 — Modificare gli script copiati

| File | Modifica necessaria |
|---|---|
| `check-routes-read-controller.sh` | Aggiornare il path `find` alla riga `CONTROLLER_FILE=$(find ...)` con il path corretto dei Controller nel nuovo progetto |
| `check-method-exists.sh` | Aggiungere il blocco `elif` per il nuovo project root nella sezione "Determina project root". Aggiornare il path assoluto a `check-method-exists.py` se differisce |
| `check-method-exists.py` | Nessuna modifica necessaria: riceve `project_root` come argomento dalla shell |

### Step 6 — Test rapido dopo l'installazione

**Test P0-6** — deve bloccare (controller esiste, non letto):

```bash
echo '{"tool_input":{"file_path":"/path/routes/web.php","new_string":"NomeController::class"}}' \
  | /home/fabio/NUOVO_PROGETTO/.claude/hooks/check-routes-read-controller.sh
```

**Test P0-4 PHP** — deve bloccare (metodo inesistente):

```bash
echo '{"tool_input":{"file_path":"/path/al/Controller.php","new_string":"$this->myService->metodoCheCertamenteNonEsiste123()"}}' \
  | /home/fabio/NUOVO_PROGETTO/.claude/hooks/check-method-exists.sh
```

---

## Come aggiungere un nuovo hook

Questa sezione descrive il pattern da seguire per creare e registrare un nuovo hook PreToolUse.

### Step 1 — Creare lo script bash con la struttura base

```bash
#!/bin/bash
set -euo pipefail

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
NEW_STRING=$(echo "$INPUT" | jq -r '.tool_input.new_string // empty')

# Guard: escludi contesti irrilevanti
if [[ "$FILE_PATH" == */vendor/* ]] || [[ non_di_competenza ]]; then
    exit 0
fi

# Logica: estrai → verifica → blocca o passa
# ...

# Se violazione:
cat >&2 <<EOF
[messaggio chiaro: cosa è bloccato, perché, cosa fare]
EOF
exit 2
```

### Step 2 — Applicare le regole di design

| Regola | Dettaglio |
|---|---|
| Guard iniziali generosi | Escludere `vendor`, `.git`, `tests`, `migrations`, file irrilevanti |
| Exit 0 su qualsiasi dubbio | Mai falso positivo che blocca codice corretto |
| Messaggio stderr strutturato | Cosa è bloccato + perché + i passi esatti da fare |
| Logica complessa → Python | Se la logica richiede parsing codice o escaping, delegare a Python come H-02 |

### Step 3 — Registrare il nuovo hook

1. Aggiungere il comando in `settings.json` sotto il blocco `PreToolUse` appropriato
2. Aggiungere una riga nella tabella Hook Registry di questo documento (sezione Hook Registry)

---

## Errori comuni e soluzioni

Questa sezione raccoglie i problemi noti durante l'installazione e l'uso degli hook.

| Errore | Causa | Soluzione |
|---|---|---|
| Hook non si attiva su Edit/Write | `settings.json` non presente nella root del progetto o matcher errato | Verificare che `.claude/settings.json` esista nella root del progetto e che il matcher sia `"Edit\|Write"` |
| `jq: command not found` | `jq` non installato o non nel PATH | Installare `jq` con il package manager del sistema |
| `Permission denied` sullo script hook | File `.sh` o `.py` non eseguibile | Eseguire `chmod +x` sui file hook |
| H-01 blocca un controller che non esiste ancora | Il controller è stato trovato nel filesystem ma non nel transcript | Questo non dovrebbe accadere: se il controller non è nel filesystem, l'hook fa exit 0. Verificare che il path `find` punti alla directory corretta |
| H-02 falso negativo su metodo inesistente | Il tipo della variabile non è tracciabile nel file corrente (ereditarietà, trait) | Limitazione nota. L'hook fa skip (safe by default). La review manuale resta necessaria |
| H-02 blocca un metodo che esiste | Il file della classe non è nella directory cercata da `find` | Verificare che `project_root` sia configurato correttamente in `check-method-exists.sh` |

---

## Relazione con le regole P0 in CLAUDE.md

Questa sezione mappa ogni regola P0 al suo tipo di enforcement.

Gli hook non sostituiscono le regole — le rendono non aggirabili per i casi più critici.

| Regola | Tipo enforcement | Copertura |
|---|---|---|
| P0-4 Anti-Method-Invention | Meccanico (H-02) | PHP Service/Repository + Python service |
| P0-6 Anti-Service-Method (routes) | Meccanico (H-01) | Tutti i file `routes/*.php` |
| P0-1 REGOLA ZERO | Comportamentale | Dipende da Claude |
| P0-8 Complete Flow Analysis | Comportamentale | Dipende da Claude |
| P0-11 DOC-SYNC | PostToolUse reminder | Reminder automatico post-commit |
| P0-2 Translation keys | Comportamentale | Dipende da Claude |

Il PostToolUse su `git commit` emette un reminder DOC-SYNC (non bloccante) per ricordare l'obbligo P0-11 dopo ogni commit NATAN_LOC.

---

## Hook 3 — H-SEO: seo-public-content-guard (SEO_STANDARD)

Questa sezione descrive la logica e il comportamento dell'hook che enforce il SEO_STANDARD su contenuto pubblico.

**File:** `~/.claude/hooks/seo-public-content-guard.sh`

**Regola enforced:** SEO_STANDARD (`ecosistema/SEO_STANDARD_FLORENCEEGI.md`) — meta tags, canonical, JSON-LD, security headers, a11y attributes su contenuto pubblico.

**Comportamento:** ASK (non BLOCK). L'hook segnala potenziali violazioni e chiede conferma, ma non impedisce l'operazione. Scelta deliberata: il riconoscimento di "contenuto pubblico" e euristico (PROVVISORIO) e l'hook non deve bloccare falsi positivi.

**Deployment:** globale in `~/.claude/settings.json` (posizione [7]). Si applica a tutti i progetti.

### Logica di esecuzione

| Step | Azione | Risultato se non soddisfatto |
|---|---|---|
| 1 | Riceve JSON su stdin, estrae `tool_name`, `file_path`, `new_string` | exit 0 (dati insufficienti) |
| 2 | Guard: intercetta solo `Write` e `Edit` | exit 0 (tool non di competenza) |
| 3 | Detection euristica contenuto pubblico: verifica estensione (`.blade.php`, `.tsx`, `.astro`, `.html`, `.vue`) e pattern indicatori (layout, head, meta, page, route) | exit 0 (non contenuto pubblico) |
| 4 | Esegue 7 check SEO (meta tags, canonical, og:image, JSON-LD, hreflang, robots, title) | — |
| 5 | Esegue 1 check security headers (CSP, HSTS, X-Frame-Options dichiarativi) | — |
| 6 | Esegue 2 check a11y (aria-label, alt attributes) | — |
| 7 | Se trovate violazioni: output JSON con `decision: ask` e lista violazioni | ASK all'operatore |
| 8 | Se nessuna violazione: exit 0 silenzioso | — |

### Detection euristica contenuto pubblico (PROVVISORIO)

La detection di "contenuto pubblico" e basata su euristica cross-stack, non su un attributo formale. Funziona con:
- **Astro**: `.astro` files con `<head>` o layout
- **React/Next.js**: `.tsx` files con pattern `metadata`, `generateMetadata`, `Head`
- **Laravel Blade**: `.blade.php` files con layout/head
- **HTML/Vue**: `.html`, `.vue` files

Questa euristica e marcata PROVVISORIO in attesa della formalizzazione di `output_category` nel paradigma Oracode (Lacuna 1). Quando `output_category` sara disponibile, l'euristica verra sostituita da un check deterministico.

### Architettura enforcement a 2 livelli

L'hook H-SEO rappresenta il livello dev-time (statico, ASK). Il livello CI/CD (runtime, BLOCK) e implementato dal template `lighthouse-ci.yml` (vedi `oracode/templates/lighthouse-ci.yml`). I due livelli sono complementari: l'hook verifica che il codice sorgente **dichiari** i requisiti; il gate CI verifica che il sito deployato li **implementi effettivamente**.

### Limitazioni note

| Limitazione | Descrizione | Comportamento |
|---|---|---|
| Euristica file publici | Potrebbe non riconoscere tutti i file pubblici o includere file non-pubblici | Falsi negativi possibili, falsi positivi gestiti da ASK (non bloccante) |
| Verifica dichiarativa | Controlla solo che i tag siano presenti nel codice, non che producano il risultato corretto in produzione | Complementato dal gate Lighthouse CI |

**Origine:** Mission M-190 — Lacuna 2: SEO/Security/A11y enforcement infrastructure (2026-05-15)

---

## Riferimenti

| Risorsa | Path relativo a `EGI-DOC/docs/` |
|---|---|
| Oracode System Manifesto (IT) | `oracode/ORACODE_SYSTEM_MANIFESTO_IT_v1.0.0.md` |
| Oracode System Manifesto (EN) | `oracode/ORACODE_SYSTEM_MANIFESTO_EN_v1.0.0.md` |
| Claude Code Enforcement | `oracode/audit/06_CLAUDE_CODE_ENFORCEMENT.md` |
| Audit Runbook | `oracode/audit/07_RUNBOOK.md` |
| SEO Standard | `ecosistema/SEO_STANDARD_FLORENCEEGI.md` |
| Lighthouse CI Template | `oracode/templates/lighthouse-ci.yml` |
| Lighthouse CI README | `oracode/templates/LIGHTHOUSE_CI_README.md` |

---

*Versione: 1.2.0 — Aggiunto H-SEO (M-190): 2026-05-15 — Riscrittura OS3-RAG: 2026-03-25 — Originale: 2026-03-23*
*Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici*
*Oracode OS3.0 — FlorenceEGI Organismo Software*