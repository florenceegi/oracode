# Oracode Nexus — Gerarchia a 3 Livelli (SSOT)

> **Status:** 🔒 LOCKED.
> **Natura:** trascrizione delle **direttive di Fabio Cherici**. Padmin trascrive le parole del CEO, NON interpreta, NON aggiunge. Dove il CEO non ha dettato, è marcato `[CEO: da dettare]` — mai riempito d'invenzione.
> **Fonti:** `SESSION_3_HANDOFF_TO_NEXT.md` §1/§3 (decisioni CEO registrate, righe 112/114/169) + direttive CEO in chat 2026-05-30.
> **Lettura obbligatoria PRIMA di ogni mission strutturale.**

---

## Principio — parole del CEO

> "I livelli sono **TRE**." — CEO, 2026-05-30

> "Oracode Nexus 3-livelli logico: paradigma (oracode + os3-matrix) + HUB softwarehouse acquirente + istanze LSO con doc-sync proprio." — handoff §3, riga 112

I tre livelli, mai due, mai mescolati:

```
LIVELLO 1 — GLOBALE       (paradigma / macchina)
LIVELLO 2 — HUB           (softwarehouse acquirente)
LIVELLO 3 — ISTANZA LSO   (singolo progetto)
```

---

## Livello 1 — GLOBALE

**Direttiva CEO (verbatim, 2026-05-30):**

> "La cartella globale deve esserci ma NON deve essere nascosta. Deve essere visibile. Io devo capire cosa succede, devo leggerla, devo sapere dov'è. Io sono un io oggettivo: posso essere un cliente che ha appena comprato Oracode e deve sapere dove si trovano le cose."

**Cosa comprende (handoff §3):** il paradigma — `oracode` + `os3-matrix`.

**Direttiva CEO sul path (2026-05-30):**

> "Il path è lo **stesso** della cartella nascosta, solo che è una cartella **visibile**."

**Distinzione chiave:** il repo `oracode` è il **paradigma (la legge: regole, docs, templates)**. La cartella globale è lo **stato operativo dell'engine (la sala di controllo: mission in corso, focus, audit, licenza)**. Sono due cose diverse — per questo non possono avere lo stesso nome.

**🔒 CHIARIMENTO CRITICO (CEO 2026-05-31): L1 NON è un registro di mission.**

L1 è **il software + il motore**: le regole (`oracode`) + l'enforcement (`os3-matrix`) + il motore che *fa girare* le mission (`~/oracode-engine`). Il motore tiene solo lo **scratch operativo** (chi lavora su cosa adesso, lock, stato in volo) — **non un archivio versionato**. È lo **strumento**, non i libri contabili.

> Analogia (CEO): L1 è il **ponte sollevatore con l'auto sopra adesso** (operativo, transitorio). L2 è il **registro di tutte le riparazioni fatte, con tempi e costi** (permanente, versionato).

Il **primo vero MISSION_REGISTRY è L2** (il HUB). Era l'errore di mettere "stato di tutte le mission della macchina" come se fosse un registro L1 a rendere L1 e L2 indistinguibili: corretto. L1 = motore acceso (*"cosa gira adesso?"*); L2 = libri contabili (*"cosa ha prodotto la softwarehouse nel tempo?"*).

**🔒 NOME FISSATO (CEO 2026-05-30):** la cartella globale visibile si chiama **`~/oracode-engine/`**.

**Cosa contiene** (oggi in `~/.oracode/`, DA SPOSTARE in `~/oracode-engine/`): `missions/` (stato runtime per-mission), `focus/` (focus per-session, M-OS3-016), `audit/` (task-invocations.jsonl spawn fingerprint), `state/`, `license.json`.

**Stato migrazione (DA IMPLEMENTARE):** lo spostamento `~/.oracode/` → `~/oracode-engine/` tocca `bin/mission` (costante `ORACODE_HOME` + tutti i path derivati) e ~19 file (hook + agent + tool) che referenziano `~/.oracode/`. **Rompe le sessioni Claude Code attualmente vive** (3 focus attivi) se fatto mentre lavorano. Va eseguito come operazione dedicata e controllata, non a caldo.

---

## Livello 2 — HUB

**Direttive CEO (handoff §3, righe 112/114/169):**

> "HUB softwarehouse acquirente."
> "HUB **centrale per statistiche** (vista consolidata cross-istanza, aggregator da N istanze)."
> "Aggregator `mission-hub-aggregate.py` per HUB → consolidato cross-istanza."

**Direttiva CEO (chat, 2026-05-30):**

> "Occorreva un **file unico** in cui riportare il lavoro frastagliato in decine di file, e poi **le statistiche andavano calcolate su decine di cartelle**."

> "**MISSION_REGISTRY.json deve esserci anche a Livello 2**, CON LE **STATISTICHE** E LA **NUMERAZIONE DELLE MISSION**. Non capisco quale sia il problema di avere anche un file unico dove radunare tutto quanto per far sì che la gestione delle stat sia **semplice, ordinata e veloce**."

→ Il Livello 2 HUB ha il **proprio `MISSION_REGISTRY.json`** = il **file unico** che raduna tutto:
  - le **statistiche consolidate** (calcolate aggregando le decine di cartelle delle istanze);
  - la **numerazione delle mission** (il HUB è il punto centrale dei numeri → niente collisioni quando si lavora su N mission in parallelo).

→ Le statistiche si calcolano **qui**, non nel singolo progetto.

---

## Livello 3 — ISTANZA LSO

**Direttive CEO (handoff §3):**

> "Istanze LSO con doc-sync proprio."
> "MISSION_REGISTRY canonical **per istanza LSO**."
> "Un'istanza LSO **deve avere il proprio MISSION_REGISTRY** per essere un LSO."

**Dove vive:** `<progetto>-DOC/docs/missions/MISSION_REGISTRY.json`, versionato col repo del progetto.

**Cosa memorizza — schema PROVATO** (riferimento CEO: EGI-DOC accoppiato, **209 mission, counter 213, funzionato benissimo per oltre 200 mission**). Per ogni mission:

```
mission_id, titolo, data_apertura, data_chiusura, stato,
tipo_missione, organi_coinvolti, cross_organo,
report_tecnico, report_esteso, files_modified, stats
```

Dentro `stats`:

```
total_commits, lines_added, lines_deleted, lines_net, lines_touched,
files_touched, weighted_commits, cognitive_load, productivity_index,
tags_breakdown, commit_hashes, by_repo_day, calculated_at
```

Top-level registry: `counter, last_updated, _nervous_system, missions[]`.

> Questo è lo schema (i **campi**) che ha retto 200+ mission in FlorenceEGI accoppiato. È il riferimento canonico per *cosa* memorizzare, non da reinventare.

**🔒 LINGUA CHIAVI — DECISO (CEO 2026-05-30): INGLESE.**

> "Fino ad ora si usa italiano, ma per iniziare a conformarmi per eleggere Oracode come paradigma occorrerà passare gradualmente all'inglese. Quindi per ora iniziamo: crea le chiavi in **inglese**."

Quindi:
- I **campi** sono quelli provati in EGI-DOC (sopra), ma con **chiavi in inglese**: `id, title, date_open, date_close, status, tipo_missione→type, organi_coinvolti→organs, report_tecnico→report_technical, report_esteso→report_extended, files_modified, stats{...}`.
- **EGI-DOC** (chiavi italiane) = **legacy**, migra gradualmente all'inglese. Non è il modello per le istanze nuove.
- Il registry `oracode` aveva entry MISTE (alcune chiavi italiane: `tipo_missione`, `organi_coinvolti`). **DECISIONE CEO 2026-05-31: convertire ORA a inglese** le entry M-OS3-022/023/024. Dopo la conversione il registry oracode è interamente inglese.

---

## Riepilogo livelli (dopo direttive CEO 2026-05-30)

| Livello | Cos'è | MISSION_REGISTRY | Statistiche | Numerazione |
|---|---|---|---|---|
| **1 — GLOBALE** | il **motore + software** (paradigma + matrix + `~/oracode-engine`) | **NO** — solo scratch runtime del motore (lock, focus, stato in volo). NON un archivio. | — | — |
| **2 — HUB** | softwarehouse acquirente | **SÌ — primo vero registro**: file unico che raduna tutto, versionato nel `HUB-DOC` repo della softwarehouse | **calcolate qui** (su decine di cartelle) | **GLOBALE UNICA** (contatore centrale, no ripetizioni cross-istanza) |
| **3 — ISTANZA LSO** | singolo progetto/cliente | **SÌ — proprio**, nel repo del progetto (schema EGI-DOC provato) | no (solo dati grezzi) | no |

**Chi installa cosa (softwarehouse acquirente):** installa **L1** (motore+software, una volta) + **L2** (il suo `HUB-DOC`, il suo libro contabile) e **genera L3** (un'istanza per cliente, via `/project`). HUB-DOC separato quando ha 2+ clienti; accoppiato HUB+istanza finché ne ha uno (come FlorenceEGI oggi, "caso unico").

---

## Decisioni CEO 2026-05-30

1. ~~Nome cartella globale visibile~~ → **RISOLTO: `~/oracode-engine/`**.
2. ~~Lingua chiavi registry~~ → **RISOLTO: INGLESE** (italiano EGI-DOC = legacy, migrazione graduale).

## Decisioni CEO 2026-05-31 (post-audit roadmap — emerse dal doppio audit del team)

3. **Chiavi entry M-OS3-022/023/024** → **convertire ORA a inglese** (il registry oracode era misto; la riga sopra "già inglese" era falsa, corretta).
4. **Status mission in corso nel registry repo (L3)** → **stato grezzo 1:1** dall'engine (`planned`/`executing`/`auditing`/...), non collassato. Il registry rispecchia fedelmente lo stato della state machine.
5. **Numerazione mission (L2 HUB)** → **GLOBALE UNICA**: contatore centrale al HUB, nessun numero si ripete mai tra istanze. ⚠ Implica riconciliare la numerazione storica esistente (es. M-005 esiste sia in EGI sia in fabiocherici) — lavoro di Unità 4 HUB.
6. **Path del file unico HUB (L2)** → **RISOLTO (CEO 2026-05-31)**: vive nel **`HUB-DOC` repo della softwarehouse**, versionato in git (es. `Magicsoft-HUB-DOC/docs/missions/`). NON in `~/oracode-engine/` (che è L1, motore, non un archivio). Risolto chiarendo che L1 non è un registro: il HUB è il primo registro, ed è patrimonio versionato della softwarehouse.

## Decisione CEO 2026-05-31 — chiarimento L1 vs L2 (vedi sezione Livello 1)

7. **L1 NON è un registro di mission.** L1 = motore+software (scratch runtime). Il primo registro vero è L2 (HUB). Questo scioglie sia l'indistinguibilità L1/L2 sia il path HUB (punto 6).

L'SSOT (le **decisioni**) è **completo**. Resta l'**implementazione**.

---

## Implementazione — backlog DA IMPLEMENTARE (unità ordinate)

Ogni unità passa per il ciclo esecutore → doppio audit (os3-audit + alignment) → DOC-SYNC. Nessuna avanza senza verde.

| # | Unità | Livello | SSOT clausola | Stato |
|---|---|---|---|---|
| 1 | Migrazione `~/.oracode/` → **`~/oracode-engine/`** (cartella globale visibile) | L1 | "globale visibile, non nascosta" | DA FARE |
| 2 | **`/mission` slash command GLOBALE** (`~/.claude/commands/mission.md`) — wrapper di `bin/mission`, context-aware (rileva istanza da CWD) | L1 | "io devo sapere dove sono le cose / accesso globale all'engine" | DA FARE |
| 3 | Ponte automatico **L1→L3** via `.oracode/project.json` (bin/mission propaga state→registry del progetto) | L1→L3 | "istanza ha registry proprio, sync automatico" | DA FARE |
| 4 | **Aggregator HUB** (`mission-hub-aggregate.py`) — file unico con statistiche + numerazione cross-istanza | L2 | "HUB centrale per statistiche e numerazione" | DA FARE |
| 5 | Ricollocare `finalize`/stats: calcolo a livello **HUB**, non istanza | L2 vs L3 | "statistiche = HUB" | DA CORREGGERE |

> ⚠ La migrazione (1) **rompe le sessioni Claude Code vive** se fatta a caldo. CEO 2026-05-30: M-008/M-213 (altre chat) migrano **as-is**, idle. Eseguire come operazione controllata.

---

*Oracode Nexus — gerarchia a 3 livelli — SSOT direttive CEO — 2026-05-30 / 2026-05-31 (aggiunto backlog implementazione + /mission globale).*
