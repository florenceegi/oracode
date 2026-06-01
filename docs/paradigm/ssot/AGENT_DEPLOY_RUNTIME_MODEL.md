# Agent Deploy & Runtime-Root Model

```
@package  oracode/paradigm/ssot
@author   Padmin D. Curtis (CTO-AI) for Fabio Cherici (CEO)
@version  1.2.0
@date     2026-06-01
@purpose  SSOT del modello di deploy degli agenti E degli hook, e della risoluzione
          dei root a runtime: dove vive la fonte, come si genera la copia operativa,
          come agenti e hook risolvono i path senza accoppiarsi a un organismo.
@status   PRODUCTION — istituito da M-OS3-030/031, esteso da M-OS3-032/033/034/035/036/038.
```

> Licenza: MIT. Parte del paradigma Oracode pubblico.

---

## 1. Single-source: sorgente vs deploy

Il modello vale per **due classi di artefatto deployato** — agenti e hook:

```
AGENTI  FONTE (versionata):  os3-matrix/agents/*.md   ← si edita QUI
        DEPLOY (generato):   ~/.claude/agents/*.md     ← MAI editato a mano

HOOK    FONTE (versionata):  os3-matrix/hooks/*.sh    ← si edita QUI
        DEPLOY (generato):   ~/.claude/hooks/*.sh      ← MAI editato a mano
```

Entrambi i deploy sono una **proiezione generata** della sorgente, prodotta
rispettivamente da `os3-matrix/bin/deploy-agents` e `os3-matrix/bin/deploy-hooks`.
Editare direttamente il deploy crea divergenza silenziosa (difetto risolto per gli
agenti da M-OS3-030, per gli hook da M-OS3-035). Regola unica: **si tocca la sorgente,
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

### 2b. deploy-hooks — stesso modello, sugli hook (M-OS3-035)

`bin/deploy-hooks` è il **mirror di `deploy-agents`** sulla classe hook. Copia
`os3-matrix/hooks/*.sh` → `~/.claude/hooks/*.sh` con le stesse proprietà:
- **copia pura** byte-identica (nessuna sostituzione);
- **atomico per-file** (staging temp → `mv` file-per-file, `nullglob`);
- **senza prune** (stessa semantica `$DEST ⊇ sorgente`, possibili orfani come §5);
- **`+x` preservato** (`chmod +x` su ogni file nel deploy).

Motivazione (Q-002): alcuni hook erano *live in `~/.claude/hooks` ma non versionati*
in os3-matrix, mentre il settings-snippet li referenziava → in un setup nuovo il path
puntava a un hook assente dalla sorgente (P0-4 landmine "hook assente"). Versionando i
9 hook mancanti, **tutti gli hook referenziati dallo snippet esistono in sorgente** e
sono deployabili ovunque. Lo stesso difetto sorgente↔deploy degli agenti (M-OS3-030),
risolto sugli hook.

**Differenza dagli agenti (no guardia `@@`):** gli hook non usano placeholder
deploy-time `@@`, quindi `deploy-hooks` non ha guardia anti-regressione.

**Decoupling runtime degli hook (M-OS3-036 — risolto).** Il debito sopra è chiuso,
mirror di M-OS3-031 sugli agenti. I 6 hook organism-coupled
(`coverage-check-precheck`, `doc-sync-v2-guard`, `m094-supervisor-reminder`,
`mission-read-tracker`, `organ-index-guard`, `install-gitleaks-hooks`) **non hanno più
path d'organismo baked**: risolvono il root del progetto attivo **a runtime** con la
stessa risalita degli agenti (CWD → `.oracode/project.json` → `instance_root`; root non
risolto → **graceful exit 0**, nessun crash della tool-call). `install-gitleaks-hooks`
esternalizza la lista repo in `$HOME/.claude/gitleaks-repos.conf` (template
`etc/gitleaks-repos.conf.example`), niente lista baked nell'hook. Il `settings-snippet.json`
usa `$HOME/.claude/hooks/...` (shell-form, espanso a runtime) invece di path
Fabio-specifici → generico per `/project` su qualsiasi macchina. Safety verificata: tutti
gli hook escono 0 da ogni CWD. **Residuo (follow-up, non drift):** classificazione degli
hook generic vs FlorenceEGI-specifici dentro lo snippet (logica di selezione, non path) =
BACKLOG os3-matrix.

### 2c. Hook event-driven di enforcement — guard + gate (M-OS3-038)

Oltre agli hook deployati come copia pura (§2b), il modello prevede una classe di
**hook di enforcement event-driven** wirati nel `settings-snippet.json` su eventi del
tool-runtime. Istituita da M-OS3-038 con la coppia che attiva `oracode-lint` (il linter
degli artefatti Oracode — agent/skill/hook — che vive in `engine_root/bin/oracode-lint`;
specifica completa di regole e scopo in `ORACODE_LINT.md`. Qui si descrive solo il loro
innesto deploy/runtime):

- **`oracode-lint-guard.sh`** — evento **PostToolUse** su `Write|Edit`. Linta l'artefatto
  appena editato (`*/agents/*.md`, `*/skills/*.md`, `*/hooks/*.sh`) e segnala il drift
  **subito** su stderr. **Non bloccante** (exit 0 sempre): l'edit è già avvenuto, è solo
  feedback immediato.
- **`oracode-lint-gate.sh`** — evento **PreToolUse** su `Bash` con comando `git push`.
  Lancia il lint completo e **blocca il push** (exit 2) se trova drift di severità
  `ERROR`; solo `WARN` → passa. Il drift non shippa.

Proprietà comuni, coerenti col resto del modello:
- **risoluzione a runtime** del binario: `oracode-lint` risolto via engine anchor
  (`~/oracode-engine/projects.json` → `anchor == "engine"` → `bin/oracode-lint`),
  override testabile `ORACODE_LINT_BIN`. Nessun path d'organismo baked (§3);
- **graceful se assente**: lint non risolto/non eseguibile → exit 0, nessun blocco né
  crash della tool-call;
- **dipendenza runtime** `python3` + `jq` (parsing input hook): assente → graceful exit 0;
- **wiring** nel `settings-snippet.json` in shell-form `$HOME/.claude/hooks/...` (come §2b),
  generico per `/project` su qualsiasi macchina.

Questo completa Q-001 (BACKLOG os3-matrix): `oracode-lint` passa da linter on-demand a
**enforcement attivo event-driven**. Distinzione di severità del gate: blocca su `ERROR`,
lascia passare `WARN`. Discriminante anti-cry-wolf del guard: il finding reale è una riga
`^- [ERROR]/[WARN]` (non il footer descrittivo del report).

## 3. Risoluzione root a runtime

Gli agenti **non** contengono path assoluti né d'organismo baked — e da **M-OS3-036**
neppure i 6 hook organism-coupled (vedi §2b): entrambe le classi risolvono il root del
progetto attivo **a runtime** con la stessa risalita CWD → `.oracode/project.json` →
`instance_root`. Gli agenti usano placeholder dichiarati nel blocco "Risoluzione root":

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
| M-OS3-035 | `bin/deploy-hooks` — stesso modello sugli hook (Q-002): 9 hook live-non-versionati ora versionati; settings-snippet senza più hook-assente; decoupling hook coupled = debito M-OS3-036 |
| M-OS3-036 | decoupling runtime degli hook (mirror M-OS3-031): 6 hook coupled risolvono il root a runtime (no path organismo baked); `install-gitleaks-hooks` con lista repo esternalizzata; settings-snippet `$HOME`-based generico. §2b/§3 aggiornate. Residuo: classificazione hook generic vs FlorenceEGI = BACKLOG |
| M-OS3-038 | hook event-driven di enforcement (§2c): `oracode-lint-guard.sh` (PostToolUse, segnala non-bloccante) + `oracode-lint-gate.sh` (PreToolUse git push, blocca su drift ERROR). Completa Q-001 — `oracode-lint` ora enforcement attivo. Binario risolto via engine anchor a runtime, graceful se assente (dip. `python3`+`jq`) |

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

*Oracode System — SSOT paradigma. Istituito da M-OS3-030/031, esteso agli hook da M-OS3-035, hook decoupled a runtime da M-OS3-036. Licenza MIT.*
