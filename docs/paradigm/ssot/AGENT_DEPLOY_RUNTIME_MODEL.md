# Agent Deploy & Runtime-Root Model

```
@package  oracode/paradigm/ssot
@author   Padmin D. Curtis (CTO-AI) for Fabio Cherici (CEO)
@version  1.0.0
@date     2026-06-01
@purpose  SSOT del modello di deploy degli agenti e della risoluzione dei root
          a runtime: dove vive la fonte, come si genera la copia operativa,
          come gli agenti risolvono i path senza accoppiarsi a un organismo.
@status   PRODUCTION — istituito da M-OS3-030/031, esteso da M-OS3-032/033/034.
```

> Licenza: MIT. Parte del paradigma Oracode pubblico.

---

## 1. Single-source: sorgente vs deploy

```
FONTE (versionata):   os3-matrix/agents/*.md      ← si edita QUI
DEPLOY (generato):    ~/.claude/agents/*.md        ← MAI editato a mano
```

`~/.claude/agents` è una **proiezione generata** della sorgente, prodotta da
`os3-matrix/bin/deploy-agents`. Editare direttamente il deploy crea divergenza
silenziosa (era il difetto risolto da M-OS3-030). Regola: **si tocca la sorgente,
si ri-esegue il deploy.**

## 2. deploy-agents — copia pura + guardia

`bin/deploy-agents` copia la sorgente nel deploy in modo:
- **copia pura**: nessuna sostituzione (dopo M-OS3-031 non esistono più placeholder
  deploy-time `@@`); il deploy è byte-identico alla sorgente.
- **atomico per-file**: render in staging temp, la guardia anti-`@@` gira PRIMA di
  toccare `$DEST` (un deploy bloccato dalla guardia lascia `$DEST` intatto), poi `mv`
  file-per-file. Non è un `mv` atomico dell'intera directory.
- **senza prune**: copia/aggiorna ma NON rimuove i file presenti in `$DEST` e assenti
  in sorgente → possibili **orfani** (vedi §5). `$DEST ⊇ sorgente`, non `==`.
- **con guardia anti-regressione**: se ricompare un placeholder `@@KEY@@` (path
  organismo tornato deploy-time invece che runtime), il deploy ABORTISCE.

## 3. Risoluzione root a runtime

Gli agenti **non** contengono path assoluti né d'organismo baked. Usano placeholder
risolti **a runtime** dall'agente stesso, dichiarati nel blocco "Risoluzione root":

| Placeholder | = | Risolto da |
|-------------|---|------------|
| `{{instance_root}}` | progetto attivo | `.oracode/project.json` da CWD, risalendo i parent |
| `{{paradigm_root}}` | docs paradigma | `~/oracode-engine/projects.json` → entry con `anchor == "paradigm"` `.root` + `/docs/paradigm` (fallback: name-match "oracode") |
| `{{engine_root}}` | os3-matrix engine | `~/oracode-engine/projects.json` → entry con `anchor == "engine"` `.root` (fallback: name-match "OS3 Matrix") |

Da **M-OS3-034** la risoluzione di `{{paradigm_root}}`/`{{engine_root}}` avviene per
**anchor stabile** (campo `anchor` `paradigm`/`engine` nel descrittore `.oracode/project.json`,
propagato in `projects.json` da `registerProject`), con **fallback al match-by-display-name**
("oracode"/"OS3 Matrix") quando l'anchor non è seedato. L'anchor è più robusto del
display-name (rinominabile). Dettaglio e limite fresh-clone in §5.

Se un root non si risolve (descrittore assente, anchor E name-match mancanti): **REGOLA ZERO** —
l'agente chiede, non assume. Conseguenza: lo stesso agente opera su **qualsiasi
organismo** senza modifiche (organism-agnostic).

Distinzione dottrina vs organo: la **dottrina universale** (P0, pilastri) vive nella
skill `oracode-doctrine` (vedi `ORACODE_AGENT_SKILL.md`); il **kernel d'organo**
(mappa organi, regole locali) si risolve a runtime via `{{instance_root}}/CLAUDE_ECOSYSTEM_CORE.md`.

## 4. Storia evolutiva

| Mission | Cosa |
|---------|------|
| M-OS3-029 | skill `oracode-doctrine` (dottrina single-source) — pilota oracode-specialist |
| M-OS3-030 | `bin/deploy-agents` — single-source sorgente↔deploy (modello B, root `@@` baked) |
| M-OS3-031 | decoupling runtime (modello A): root risolti a runtime, deploy = copia pura |
| M-OS3-032 | skill estesa ai 6 agenti dottrina-pesanti |
| M-OS3-033 | SSOT istituito; remediation accuratezza (atomico per-file, no-prune, orfani) |
| M-OS3-034 | robustezza risoluzione root: anchor stabile (`paradigm`/`engine`) + fallback name; §3 allineata, limite fresh-clone in §5 |

## 5. Debito noto (robustezza risoluzione)

La risoluzione di `{{paradigm_root}}`/`{{engine_root}}` poggia su
`~/oracode-engine/projects.json`, artefatto runtime non versionato, popolato
all'apertura mission. Fragilità tracciate in `os3-matrix/docs/design/BACKLOG.md`:
- anchor non seedati (macchina nuova → non risolvono finché non si apre una mission);
- match-by-name (`name == "OS3 Matrix"`) invece che per chiave stabile.
Mitigazione attuale: fallback REGOLA ZERO nel blocco + test che asserisce gli anchor.
Saldo strutturale = mission dedicata.

**Anchor stabile (M-OS3-034) + limite fresh-clone.** La risoluzione di
`{{paradigm_root}}`/`{{engine_root}}` usa ora un campo `anchor` (`paradigm`/`engine`)
nei descrittori, propagato in `projects.json` da `registerProject` (più robusto del
match-by-display-name). **Limite dichiarato:** il descrittore di `oracode` è gitignored
(convenzione `.oracode/` locale), quindi su fresh clone l'anchor `paradigm` non è
versionato; il template `/project` generico non può portarlo (sarebbe errato per un
progetto non-paradigma). Fino al primo `/project`/open che lo rigenera, la risoluzione
di `{{paradigm_root}}` **degrada al fallback name-match "oracode"** (correttezza
garantita, robustezza parziale). Decisione su come versionare l'anchor paradigm
(es. descrittore oracode tracked) = mission/CEO.

**No-prune → orfani.** `deploy-agents` copia/aggiorna ma non rimuove i file di `$DEST`
non presenti in sorgente. Orfani osservati in `~/.claude/agents` (2026-06-01): 3 —
`egili-blood-keeper.md`, `m093-remediation-tracker.md` (deployati per altra via) e
`AGENT_EPISTEMOLOGY_PROTOCOL.md` (asset paradigma, NON da rimuovere senza verifica).
Decidere se `deploy-agents` debba fare prune = mission separata.

---

*Oracode System — SSOT paradigma. Istituito da M-OS3-030/031. Licenza MIT.*
