# /oracode-install — Proponi opzioni e installa l'infrastruttura Oracode

Micro-skill del ciclo `/project`. Dato il report di `/oracode-detect`, presenta le opzioni e installa
paradigma / OS3 Matrix (se licenziato) / librerie LSO scelte. Non rileva (→ `/oracode-detect`), non genera lo
scaffold del progetto (→ `/oracode-scaffold`).

## Fase 1 — Proposta
In base a cosa è stato rilevato, presenta le opzioni.

**1.1 Paradigma solo (disponibile a tutti)**
"Con il paradigma Oracode puoi: disciplina AI, regole P0, pilastri, Strategia Delta, mission protocol, DOC-SYNC. L'AI segue le regole leggendo il boot context. Nessun enforcement automatico."

**1.2 Paradigma + OS3 Matrix (richiede licenza)**
"Con OS3 Matrix aggiungi: hook bloccanti, gate validator, agenti specializzati, enforcement automatico delle regole. Per progetti dove velocita o complessita rendono la verifica manuale impossibile."

Se l'utente non ha licenza Matrix e la vuole: indica come ottenerla (placeholder — da formalizzare).

**1.3 Librerie LSO**
"Quali librerie LSO vuoi installare nel progetto?"
Presenta la lista delle librerie disponibili (tabella `/oracode-detect` 0.3).
L'utente puo scegliere quali installare. Tutte sono opzionali individualmente.

Chiedi conferma scelte prima di procedere.

## Fase 2 — Licenza e Installazione infrastruttura

**2.1 Se OS3 Matrix selezionato**
Rileggi `~/oracode-engine/license.json`. Se licenza valida:
- Usa il campo `repo` per clonare os3-matrix in una directory temporanea
- Se il clone fallisce (credenziali, rete): segnala e chiedi se procedere senza Matrix

Se licenza non presente o scaduta: "Licenza OS3 Matrix non valida. Procedi senza Matrix o inserisci il path di un file di licenza valido."

**2.2 Installa paradigma**
Copia `CLAUDE_ORACODE_CORE.md` dal repo oracode nella root del futuro progetto.

**2.3 Se Matrix: installa enforcement**

Chiedi all'utente: "Installare hook/agenti a livello progetto (`.claude/`) o globale (`~/.claude/`)?"
Chiama la destinazione scelta `<CLAUDE_DIR>` (`<project>/.claude` oppure `~/.claude`).

**2.3.a — Scegli il set di hook (NON copiare l'intera `hooks/`)**
L'install copia SOLO gli hook del set giusto, mai tutti. La fonte di verità è `etc/settings-snippet.*.json`:
- **Progetto generico (default, ogni cliente)** → set **core**: solo gli hook referenziati in
  `etc/settings-snippet.core.json` (universali / risolti a runtime, nessun path organismo-specifico).
- **Organismo FlorenceEGI** (solo se il descrittore dichiara `organism: florenceegi`) → core **+** overlay
  `etc/settings-snippet.florenceegi.json` (hook con logica di dominio EGI/MiCA/Egili).

> ⚠️ Gli 8+ hook overlay FlorenceEGI (mica-guard, organ-index-guard, cross-project-guard,
> deploy-pipeline-guard, doc-sync-v2-guard, mission-stats-guard, ...) NON vanno MAI in un progetto cliente.
> Copiare l'intera `hooks/` è un BUG (M-OS3-077): porta logica di dominio e path privati nel repo cliente.

Per ogni hook del set scelto, copia `hooks/<nome>.sh` → `<CLAUDE_DIR>/hooks/<nome>.sh`.

**2.3.b — Wira gli hook in `settings.json` (senza questo, gli hook NON scattano)**
Claude Code esegue gli hook SOLO se dichiarati in `settings.json`. Quindi:
- Se `<CLAUDE_DIR>/settings.json` NON esiste → crealo copiando `etc/settings-snippet.core.json`
  (+ merge di `settings-snippet.florenceegi.json` se organismo FlorenceEGI).
- Se esiste già → fai il **merge** della chiave `hooks` degli snippet in quella esistente (non sovrascrivere
  altre chiavi). I path negli snippet sono `$HOME`-based (generici): non sostituirli con path assoluti.

Verifica finale (invariante M-OS3-077): `<CLAUDE_DIR>/settings.json` ha `hooks` popolati; in
`<CLAUDE_DIR>/hooks/` nessun hook overlay e nessun path `/home/...`/dominio baked
(`docs/tests/m-os3-077/verify_install.sh <project-dir>` deve uscire 0).

**2.3.c — Agenti e bin: gate anti-leak (NON copiare wholesale)**
Come per gli hook, `agents/` e `bin/` NON si copiano interi in un progetto cliente: molti agenti/bin
sono FlorenceEGI-coupled (path privati, logica di dominio Egili/NATAN/MiCA). Regola:
- **Organismo FlorenceEGI** (descrittore `organism: florenceegi`) → copia `agents/` e `bin/` interi.
- **Progetto generico (default)** → copia da `agents/` e `bin/` SOLO i file che passano il gate canonico
  `bin/install-leak-gate.sh <file>` (exit 0 = client-clean: nessun path privato né nome-dominio).
  I file che NON passano si SALTANO (REGOLA ZERO: non versare nel cliente ciò che è organism-specific).

Per ogni file di `agents/*.md` e `bin/*`:
```
bash <clone>/bin/install-leak-gate.sh "<file>" && cp "<file>" "<dest>"   # salta se exit≠0
```
> Nota: oggi solo pochi agenti passano il gate (es. doc-sync-v2, web-quality-gate, skill-dryrun-guardian)
> e l'engine `bin/mission`. Il decoupling del resto è tracciato come **R-DECOUPLE**: man mano che un
> agente/bin viene ripulito, entra automaticamente nell'install generico (nessuna lista da aggiornare).

**2.3.d — Resto (sempre)**
- `CLAUDE_OS3_MATRIX_TEMPLATE.md` → root del progetto
- `mission/` → `.oracode/mission/` del progetto
- `nervous-system/` → `.oracode/nervous-system/` del progetto
- `etc/settings-snippet.core.json` → `.oracode/etc/` (riferimento per re-wiring/audit futuri)

**2.3.e — Persisti gli starter Egida (difesa-by-default, G1 EGIDA_INSTALL_CONTRACT §4.2/§6.3)**

L'asse difesa Egida è costitutivo (CORE §Asse Difesa Costitutivo). Gli starter di invarianti vivono
nel clone Matrix (`templates/egida/`), che però viene rimosso a fine install; `/oracode-scaffold` gira
dopo. Quindi qui — **mentre il clone è ancora vivo** — copia gli starter nel progetto perché sopravvivano:

```
<clone>/templates/egida/SECURITY_INVARIANTS.starter.{L1,L2-L3,L3-L4}.json  →  .oracode/etc/egida/
```

`/oracode-scaffold` poi copierà lo starter del profilo scelto (`egida_profile`) → `<repo>/SECURITY_INVARIANTS.json`.
Gli starter sono prodotti da os3-matrix (M-OS3-101), conformi a `FORTINO/SECURITY_INVARIANTS.schema.json`,
cumulativi (L1 ⊂ L2-L3 ⊂ L3-L4), con target `<PLACEHOLDER>` generici. **NON** deployare `fortino-check`
(vive in FORTINO; è un concern di runtime, fuori scope `/project` — G3).

> Se Matrix NON è installato (livello 1 paradigm-only): salta questo step — niente tooling Egida, niente
> `egida_gate` (l'hook enforcement tratta il flag assente come zero requisito: "dove ha senso").

Rimuovi il clone temporaneo dopo la copia.
Verifica finale: `docs/tests/m-os3-077/verify_install.sh <project-dir>` esce 0 (settings wirato +
nessun leak in hooks/agents/bin + hook ⊆ set core canonico).

**2.4 Installa librerie LSO selezionate**
Per ogni libreria scelta, installa tramite package manager appropriato allo stack:
- PHP: `composer require autobooknft/ultra-error-manager` (ecc.)
- Node/TS: `npm install @autobooknft/ultra-error-manager` (ecc.)
- Se il package manager non e ancora inizializzato, segnala che sara installabile dopo la creazione del progetto
