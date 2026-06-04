# /dry-run-skill — Valida uno skill in prosa senza eseguirlo in produzione

Quando ricevi questo comando (con il nome di uno skill, es. `/dry-run-skill project`), esegui un **dry-run
sorvegliato** di quello skill: lo lanci in una sandbox usa-e-getta con input fissi, ne verifichi gli INVARIANTI
dell'output, e riferisci PASS/FAIL — **senza toccare aree reali**.

> Perché esiste: gli skill in prosa (`/project`, `/discovery`, generatori di scaffold/file) li esegue l'LLM —
> non hanno un test runtime nativo. Rifattorizzarli o modificarli "al buio" rompe in silenzio. Questa è la rete.
> Dettaglio e fondamento: SSOT `DRYRUN_PROTOCOL` e `KNOW_HOW_TRANSFER_PROTOCOL` (paradigma).

## Quando usarlo
- PRIMA di modificare/rifattorizzare uno skill che genera **artefatti verificabili** (file, scaffold, descrittori, config).
- Per validare uno **split/refactor** (es. `/project` monolitico → micro-skill): si confronta il nuovo output col **golden**.
- Come test di accettazione di uno skill **nuovo** generatore.
- NON serve per skill conversazionali/consulenziali (niente output deterministico da snapshottare).

## Il "kit" di dry-run di uno skill (convenzione)
Ogni skill validabile ha un kit con tre pezzi (è la convenzione da seguire/creare se manca):
- `golden_inputs.json` — risposte canoniche FISSE, scelte **deterministiche e senza side-effect**
  (per `/project`: paradigma-solo, niente librerie, RAG offline).
- `verify.sh <dir>` (o `verify_scaffold.sh`) — verifier degli **INVARIANTI strutturali** (NON byte-diff):
  placeholder risolti, campi-chiave corretti, schema atteso, ecc. Deve essere una **rete vera** (bocciare un albero rotto).
- `golden/<...>` — snapshot dell'output dello skill ATTUALE con quegli input (riferimento d'oro).

Kit di riferimento esistente per `/project`: `os3-matrix/docs/tests/m-os3-065/`.

## Procedura (eseguila così)
1. **Localizza il kit** dello skill richiesto (`golden_inputs.json` + `verify*.sh` + `golden/`). Se manca, dillo
   e proponi di crearlo (non inventare input).
2. **Sandbox**: crea una dir usa-e-getta `/tmp/dryrun-<skill>-<n>`. Lavora SOLO lì.
3. **Esecuzione sorvegliata**: spawna un agente (o esegui tu) con istruzione di ESEGUIRE lo skill target (leggi il
   suo `.md`) contro la sandbox usando SOLO `golden_inputs`, in modalità **non-interattiva** (non chiedere nulla)
   e **senza side-effect** (NON clonare, NON installare, NON toccare aree reali).
4. **Verifica**: lancia `verify*.sh <albero-prodotto>` → exit 0 atteso. Se è un refactor, confronta anche
   i file chiave col `golden/` (match semantico, non byte).
5. **Riferisci**: PASS (zero violazioni) o FAIL con l'elenco esatto degli scostamenti.
6. **Teardown**: rimuovi la sandbox.

## Esito
- **PASS** = lo skill (o la sua versione rifattorizzata) produce un output conforme agli invarianti e allineato al golden.
- **FAIL** = scostamenti da spiegare e correggere PRIMA di attivare/spedire la modifica. Mai attivare al buio.

> Vedi anche: agente `skill-dryrun-guardian` (si auto-attiva quando stai per toccare uno skill in prosa e ti
> ricorda di usare questa rete), `KNOW_HOW_TRANSFER_PROTOCOL` (perché questa capacità è nel prodotto, non in memoria privata).
