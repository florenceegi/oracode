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
Dal clone temporaneo di os3-matrix, copia nel progetto:
- `hooks/` → `.claude/hooks/` del progetto (o `~/.claude/hooks/` se globale)
- `agents/` → `.claude/agents/` del progetto (o `~/.claude/agents/` se globale)
- `CLAUDE_OS3_MATRIX_TEMPLATE.md` → root del progetto
- `bin/` → `.oracode/bin/` del progetto
- `mission/` → `.oracode/mission/` del progetto
- `nervous-system/` → `.oracode/nervous-system/` del progetto

Chiedi all'utente: "Installare hook/agenti a livello progetto o globale (~/.claude/)?"
Rimuovi il clone temporaneo dopo la copia.

**2.4 Installa librerie LSO selezionate**
Per ogni libreria scelta, installa tramite package manager appropriato allo stack:
- PHP: `composer require autobooknft/ultra-error-manager` (ecc.)
- Node/TS: `npm install @autobooknft/ultra-error-manager` (ecc.)
- Se il package manager non e ancora inizializzato, segnala che sara installabile dopo la creazione del progetto
