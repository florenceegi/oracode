# /project — Bootstrap nuovo progetto Oracode

Quando ricevi questo comando, guida l'utente attraverso il bootstrap di un nuovo progetto Oracode.

## Fase 1 — Domande diagnostiche

Poni queste domande una alla volta usando AskUserQuestion. Non procedere senza risposte.

**Q1: Nome progetto**
Chiedi il nome del progetto (diventa il prefisso: `NOME-DOC/`).

**Q2: Societa e CEO**
Chiedi nome societa e nome CEO/founder.

**Q3: Dominio**
Chiedi una descrizione del dominio in una riga (es. "piattaforma e-commerce per artigiani").

**Q4: Stack tecnologico**
Chiedi backend, frontend, database, infrastruttura (es. "Laravel, React, PostgreSQL, AWS").

**Q5: Lingue i18n**
Chiedi le lingue target (es. "it en de es fr pt"). Default: "it en".

**Q6: Livello di applicazione**
Presenta i 4 livelli e chiedi quale si applica:

- **Livello 1 — Disciplina**: paradigma solo, l'LLM segue le regole leggendo il boot context. Nessun enforcement software. Per progetti dove il CEO verifica manualmente.
- **Livello 2 — Enforcement**: aggiunge OS3 Matrix (hook bloccanti, gate validator). Per progetti dove velocita o complessita rendono la verifica manuale impossibile.
- **Livello 3 — LSO mono-organo**: organismo software vivente con un solo organo. Aggiunge mission protocol, SSOT tracking, DOC-SYNC.
- **Livello 4 — LSO multi-organo**: organismo con piu organi. Aggiunge Organ Index, sistema circolatorio, contracts cross-organo.

Se l'utente non sa, aiutalo con queste domande di triage:
- "Il tuo progetto ha interazione continua con utenti?" (si -> livello 2+)
- "Hai bisogno di esperienza accumulabile tra sessioni?" (si -> livello 3+)
- "Hai piu applicazioni che condividono dati?" (si -> livello 4)

## Fase 2 — Domande condizionali

**Se livello 2+:**
- Chiedi se vogliono hook bloccanti predefiniti o personalizzati
- Chiedi se hanno agenti specializzati da configurare

**Se livello 3+:**
- Conferma che mission protocol e DOC-SYNC saranno attivi

**Se livello 4:**
- Chiedi la mappa degli organi (nomi, funzioni, URL)
- Chiedi se esiste un sistema circolatorio (crediti interni, token, punti)
- Chiedi il database condiviso

**Se qualsiasi livello:**
- Chiedi stack bannati (se esistono)
- Chiedi valori immutabili (decisioni non negoziabili)
- Chiedi P0 dominio-specifiche (regole assolute del dominio)

## Fase 3 — Generazione scaffold

Dopo tutte le risposte:

1. **Copia lo scaffold**: copia `/home/fabio/oracode/templates/PROJECT-DOC/` in `<CWD>/NOME-DOC/`
2. **Compila CLAUDE.md**: sostituisci tutti i placeholder `{{...}}` con le risposte raccolte
3. **Compila MISSION_REGISTRY.json**: sostituisci placeholder con dati progetto
4. **Compila SSOT_REGISTRY.json**: sostituisci placeholder con dati progetto
5. **Se livello 2+**: aggiungi sezione OS3 Matrix in CLAUDE.md con riferimento a CLAUDE_OS3_MATRIX_TEMPLATE.md
6. **Se livello 4**: aggiungi sezione organi e sistema circolatorio in CLAUDE.md

## Fase 4 — Riepilogo

Mostra all'utente:
- Struttura creata (tree)
- Livello determinato e perche
- Prossimi passi consigliati:
  - Livello 1: "Apri il progetto, CLAUDE_ORACODE_CORE.md guida l'LLM"
  - Livello 2+: "Configura hook in .claude/hooks/ usando OS3 Matrix template"
  - Livello 3+: "La prima mission e M-001. Usa /mission per avviarla"
  - Livello 4: "Configura Organ Index e contracts/ per le interfacce cross-organo"

## Note operative

- MAI inventare risposte. Se l'utente non risponde, usa placeholder espliciti `[DA COMPILARE]`.
- La data nei file generati e la data corrente (non placeholder).
- Se il CWD non e il posto giusto, chiedi conferma del path di destinazione.
- Lo scaffold e minimale di proposito. Il progetto cresce con le mission, non con lo scaffold.
