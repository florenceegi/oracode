---
title: Read Tracking Tech Spec
slug: read-tracking-tech-spec
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
source: docs/oracode/MISSION_PROTOCOL.md § 4.2, § 6.2
---

# Read Tracking — Specifica Tecnica

> Prerequisito tecnico per il retrospective auto-migliorante di Mission Protocol v2.0.0.
> Il tracking cattura accessi al filesystem durante mission per il confronto
> empirico caricato-vs-usato di FASE 6 (§ 6.2).

---

## Inquadramento Oracode Nexus

Il read-tracking è un **sottosistema del motore (Livello 1)** di Oracode Nexus.
Opera sullo **scratch runtime** dell'engine (`~/oracode-engine/`) per identificare
la mission corrente, e produce un **read-log d'istanza (Livello 3)** risolto via il
descrittore `<progetto>/.oracode/project.json` (campo `read_log_path`), CWD-resolved
come fa `bin/mission`.

L'**aggregazione e la statistica cross-istanza** non sono responsabilità di questo
sottosistema: appartengono al **HUB (Livello 2)** (aggregator `mission-hub-aggregate.py`,
differito finché non ci sono 2+ clienti).

Per la gerarchia completa dei tre livelli vedi
`docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`.

---

## 1. Architettura

**Hook**: `~/.claude/hooks/mission-read-tracker.sh`
**Tipo**: PostToolUse (cattura solo cio che e realmente accaduto)
**Matcher**: `Read|Bash|Write|Edit`
**Behavior**: non-bloccante (exit 0 sempre), failure silenzioso
**Timeout**: 5 secondi

Il hook e registrato in `~/.claude/settings.json` sotto `hooks.PostToolUse`.

---

## 2. Identificazione mission corrente

**Strategia**: lettura del `MISSION_REGISTRY.json` dell'istanza a ogni invocazione.

Il registry NON è hardcoded: si risolve via il descrittore
`<progetto>/.oracode/project.json` (campo `registry_path`), CWD-resolved
risalendo dal working directory come fa `bin/mission` (ponte L1→L3, M-OS3-025).
Il path `EGI-DOC/docs/missions/MISSION_REGISTRY.json` è solo un **esempio legacy**
dell'istanza accoppiata FlorenceEGI, non il path universale del paradigma.

Logica:
1. Risolve e legge il `MISSION_REGISTRY.json` dell'istanza (via `registry_path`
   in `.oracode/project.json`)
2. Filtra mission con `status` in stato grezzo non-terminale
   (`planned`/`executing`/`auditing`, decisione CEO 2026-05-31 punto 4)
3. Ordina per `date_open` decrescente
4. Prende la prima (piu recente)

> **Chiavi inglesi canoniche** (SSOT 3-TIER §108). Le chiavi italiane
> (`stato`/`data_apertura`) sopravvivono solo nell'hook EGI-DOC legacy, da migrare.
> Il registry `oracode` reale usa già chiavi inglesi
> (`id`/`title`/`type`/`organs`/`status`/`date_open`/`date_close`).

Questa strategia copre la finestra tra FASE 0 (entry minima, stato `planned`)
e FASE 1 (stato `executing`), catturando le Read di raccolta requisiti.

**Limitazione parallel sessions**: se due sessioni hanno mission in stati
non-terminali contemporaneamente, il tracking confluisce nella mission
con `date_open` piu recente. Falso positivo accettabile — il retrospective
lavora su statistiche aggregate, non su forensic analysis.

---

## 3. Sede del log

**Path**: risolto via `<progetto>/.oracode/project.json` (campo `read_log_path`),
CWD-resolved dal working directory. Per l'istanza `oracode` reale vale
`/home/fabio/oracode/audit/MISSION_READ_LOG.jsonl`. Il path
`EGI-DOC/audit/MISSION_READ_LOG.jsonl` è solo un **esempio legacy** dell'istanza
accoppiata FlorenceEGI, non un path universale del paradigma.

Il read-log è un **dato d'istanza (L3)** (oppure scratch dell'engine L1 quando
si lavora fuori da un'istanza con descrittore), append-only. Ogni entry contiene
`mission` come campo per filtraggio. Creato automaticamente dal hook al primo accesso.

> Risoluzione coerente con il ponte L1→L3 (M-OS3-025): registry e read-log
> non sono hardcoded nel paradigma, ma derivati dal descrittore
> `.oracode/project.json` dell'istanza corrente.

**Trade-off consapevole**: con un ritmo empirico sostenuto di mission/giorno
e 50-100 entry/mission, il file cresce a multi-MB entro mesi. Questa scelta è
temporanea — chiude il sistema end-to-end nel modo più semplice. Migration a
SQLite prevista quando il volume diventerà scomodo per parsing/diff git: SQLite
con JSON1 extension per schema ibrido (campi strutturati indicizzabili + payload
JSON flessibile).

> *Origine storica EGI*: la genesi del sottosistema (read-log + retrospective)
> proviene dall'istanza accoppiata FlorenceEGI, dove era tracciata dalle mission
> M-158 → M-159 (e la migration SQLite da M-162). Quei numeri appartengono allo
> schema EGI globale storico, **non** al paradigma `oracode`. Nel Nexus la
> numerazione è ora responsabilità del **HUB (L2, numerazione globale unica)** e
> l'istanza `oracode` usa il namespace `M-OS3-NNN`.

---

## 4. Schema JSONL

Ogni riga e un oggetto JSON autonomo (JSONL, append-only).

### Read tool
```json
{"ts":"2026-05-08T14:32:11Z","tool":"Read","path":"oracode/docs/paradigm/padmin/PADMIN_INDEX.md","action":"read","mission":"M-158"}
```

### Edit tool
```json
{"ts":"2026-05-08T14:35:21Z","tool":"Edit","path":"oracode/docs/paradigm/missions/MISSION_PROTOCOL.md","action":"read+write","mission":"M-158"}
```

### Write tool
```json
{"ts":"2026-05-08T14:36:00Z","tool":"Write","path":"EGI-DOC/docs/oracode/NEW_FILE.md","action":"write","mission":"M-158"}
```

### Bash con accesso filesystem rilevato
```json
{"ts":"2026-05-08T14:33:02Z","tool":"Bash","cmd":"grep -r bootstrap docs/oracode/MISSION_PROTOCOL.md","paths":["oracode/docs/paradigm/missions/MISSION_PROTOCOL.md"],"action":"read","mission":"M-158"}
```

### Bash senza accesso filesystem
```json
{"ts":"2026-05-08T14:37:00Z","tool":"Bash","cmd":"npm run build","paths":null,"action":"no_fs","mission":"M-158"}
```

**Campi**:
| Campo | Tipo | Descrizione |
|-------|------|-------------|
| `ts` | string | ISO 8601 UTC |
| `tool` | string | Read, Bash, Write, Edit |
| `path` | string | Path relativo (Read/Write/Edit) |
| `paths` | array/null | Path rilevati (Bash) — null se nessuno |
| `cmd` | string | Comando Bash troncato a 200 char |
| `action` | string | read, write, read+write, no_fs, parse_failed |
| `mission` | string | Mission ID corrente |

**Distinzione action per il retrospective**:
- `read` e `read+write` → file consultato (usato per decisioni)
- `write` → file creato/sovrascritto (non implica lettura)
- `no_fs` → comando senza accesso filesystem rilevato
- `parse_failed` → parsing Bash fallito (non usato nella v1)

---

## 5. Pattern parsing Bash

### Comandi catturati

| Comando | Regex | Copertura |
|---------|-------|-----------|
| `cat` | `cat\s+(-flags\s+)*(\S+)` | Buona — cattura primo file dopo flags |
| `head` | `head\s+(-[n0-9]+\s+)*(\S+)` | Buona |
| `tail` | `tail\s+(-[n0-9]+\s+)*(\S+)` | Buona |
| `less` | `less\s+(\S+)` | Buona |
| `grep` | `grep\s+.*\s+(file.ext)` | Parziale — cattura file con estensione nota |
| `grep -r` | `grep\s+-r\s+.*\s+(dir/)` | Parziale — cattura directory target |
| `jq` | `jq\s+.*\s+(file.json)` | Buona — cattura file .json |
| `python3 -m json.tool` | `python3\s+-m\s+json.tool\s+(\S+)` | Buona |

### Falsi negativi documentati (NON catturati)

| Pattern | Motivo |
|---------|--------|
| `xargs cat < list.txt` | Pipe indiretta, file nella pipe |
| `python3 script.py` (che legge file) | Accesso filesystem dentro script |
| `$(cat file)` in subshell | Subshell non parsata |
| `while read f; do cat "$f"; done` | Variabile nel path |
| `cat $FILE` | Variabile non espansa |
| `find ... -exec cat {} \;` | Path placeholder non risolvibile |
| `sort < file.txt` | Redirect input |
| Comandi con path in variabili d'ambiente | Nessun accesso alla shell environment |

**Copertura stimata**: ~60-70% dei pattern reali di accesso filesystem via Bash. Sufficiente per il retrospective che lavora su statistiche aggregate.

### Comandi filtrati (no log)

Comandi noti come non-filesystem-access vengono ignorati silenziosamente:
`git`, `npm`, `node`, `echo`, `cd`, `pwd`, `ls`, `mkdir`, `chmod`, `date`, `sleep`.

---

## 6. Limitazione strutturale: always_loaded e auto-load

**Questa sezione definisce un vincolo contrattuale per M-159 (retrospective).**

I file in `always_loaded` di `MISSION_BOOTSTRAP_INDEX.json` vengono caricati
automaticamente da Claude Code tramite il meccanismo `@` include di CLAUDE.md,
**non via tool Read**. Di conseguenza:

1. I 5 file always_loaded non appaiono mai nel `read_log.jsonl`
2. Senza correzione, il retrospective vedrebbe sempre questi 5 file in
   "loaded_unused" e proporrebbe sistematicamente di rimuoverli
3. Questo sarebbe un falso positivo strutturale, non un segnale reale

**Vincolo per M-159**: il retrospective deve escludere `always_loaded` dal
diff caricato-vs-usato. Lavora SOLO su `by_mission_type` e `by_organ`.

**Razionale**: always_loaded sono baseline necessaria per definizione.
Il retrospective non deve ottimizzarli — sono il minimo comune denominatore
per qualsiasi mission. La loro presenza nel bootstrap non e discrezionale.

Questa e limitazione strutturale accettata del meccanismo PostToolUse hook,
non bug da risolvere.

---

## 7. Altre limitazioni note

1. **Parallel sessions**: tracking confluisce nella mission piu recente
   per `date_open` se multiple mission in stato non-terminale
   (`planned`/`executing`/`auditing`)
2. **Agent subagent**: tool call dentro subagent non triggerano hook del parent
3. **Overhead I/O**: ~10ms per invocazione (jq parse MISSION_REGISTRY + append)
4. **Path relativi**: i path vengono relativizzati rimuovendo il prefisso
   `/home/fabio/`. Path fuori da `/home/fabio/` restano assoluti
5. **Bash multi-comando**: `cmd1 && cmd2` — il parsing cattura path da
   entrambi i comandi senza distinguere quale ha effettivamente letto il file
6. **grep con directory**: `grep -r pattern dir/` cattura la directory come path,
   non i file specifici letti dal grep — falso positivo benigno

---

## 8. Versionamento

**Versione**: 1.0.0
**Data**: 2026-05-08
**Mission di riferimento (origine storica EGI)**: M-158 — riferimento storico
dell'istanza accoppiata EGI-DOC, non mission del paradigma `oracode`.
**Prerequisito storico per (EGI)**: M-159 (implementazione retrospective).

> Nel paradigma `oracode` la numerazione mission usa il namespace `M-OS3-NNN`,
> e la numerazione globale unica è responsabilità del HUB (L2). Il ponte
> automatico L1→L3 (registry/read-log via `.oracode/project.json`) è realizzato
> in **M-OS3-025** (vedi `bin/mission` `syncToRepoRegistry`, parallel-safe).

*Per il protocollo completo del bootstrap retrospective: `docs/oracode/MISSION_PROTOCOL.md` § 6.2*
