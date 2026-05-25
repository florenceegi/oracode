# /project — Bootstrap nuovo progetto Oracode

Quando ricevi questo comando, guida l'utente attraverso il bootstrap di un nuovo progetto Oracode.
Il flusso ha fasi sequenziali. Non saltare fasi. Non procedere senza risposte.

---

## Fase 0 — Detection

Verifica cosa l'utente ha gia installato sul sistema.

**0.1 Oracode Paradigma**
Cerca `CLAUDE_ORACODE_CORE.md` in:
- `~/.oracode/CLAUDE_ORACODE_CORE.md`
- CWD e parent directories
- Path noti (es. `/home/*/oracode/templates/`)

Se trovato: "Oracode paradigma rilevato in [path]."
Se non trovato: "Oracode paradigma non rilevato. Vuoi installarlo ora?" → procedi a Fase 2.

**0.2 OS3 Matrix**
Cerca file di licenza OS3 Matrix in:
- `~/.oracode/license` (path convenzionale — da formalizzare)
- Variabile ambiente `ORACODE_LICENSE_PATH`

Se trovato: "OS3 Matrix con licenza valida rilevato."
Se non trovato: segnala assenza ma non bloccare — l'utente potrebbe voler operare solo con paradigma.

**0.3 Librerie LSO installate**
Cerca librerie LSO gia presenti nel sistema. Librerie note:

| Libreria | Sigla | Funzione | Fonte |
|----------|-------|----------|-------|
| Ultra Error Manager | UEM | Gestione errori centralizzata | Florence EGI (pubblica) |
| Ultra Log Manager | ULM | Logging strutturato, GDPR-aware | Florence EGI (pubblica) |
| Ultra Translation Manager | UTM | i18n, chiavi atomiche | Florence EGI (pubblica) |
| Ultra Config Manager | UCM | Configurazioni centralizzate | Florence EGI (pubblica) |
| Ultra Upload Manager | UUM | Upload, validazione, scan | Florence EGI (pubblica) |

Metodo di rilevamento: controlla package manager del progetto (composer.json, package.json), o path convenzionali. Se nessun progetto esiste ancora, segna "nessuna libreria rilevata".

Mostra report detection all'utente prima di procedere.

---

## Fase 1 — Proposta

In base a cosa e stato rilevato, presenta le opzioni.

**1.1 Paradigma solo (disponibile a tutti)**
"Con il paradigma Oracode puoi: disciplina AI, regole P0, pilastri, Strategia Delta, mission protocol, DOC-SYNC. L'AI segue le regole leggendo il boot context. Nessun enforcement automatico."

**1.2 Paradigma + OS3 Matrix (richiede licenza)**
"Con OS3 Matrix aggiungi: hook bloccanti, gate validator, agenti specializzati, enforcement automatico delle regole. Per progetti dove velocita o complessita rendono la verifica manuale impossibile."

Se l'utente non ha licenza Matrix e la vuole: indica come ottenerla (placeholder — da formalizzare).

**1.3 Librerie LSO**
"Quali librerie LSO vuoi installare nel progetto?"
Presenta la lista delle librerie disponibili (tabella Fase 0.3).
L'utente puo scegliere quali installare. Tutte sono opzionali individualmente.

Chiedi conferma scelte prima di procedere.

---

## Fase 2 — Licenza e Installazione infrastruttura

**2.1 Se OS3 Matrix selezionato**
Verifica licenza. Se non presente: "Licenza OS3 Matrix non trovata. Inserisci il path del file di licenza o procedi senza Matrix."
<!-- Formato licenza e validazione: da formalizzare -->

**2.2 Installa paradigma**
Copia `CLAUDE_ORACODE_CORE.md` nella root del futuro progetto.

**2.3 Se Matrix: installa enforcement**
Copia/configura:
- Hook bloccanti base in `.claude/hooks/`
- Agent definitions base in `.claude/agents/`
- Template OS3 Matrix compilato

**2.4 Installa librerie LSO selezionate**
Per ogni libreria scelta, installa nel progetto tramite package manager appropriato allo stack.
<!-- Metodo di installazione per libreria: da formalizzare quando i package saranno pubblicati -->

---

## Fase 3 — Configurazione progetto

Ora che l'infrastruttura Oracode e installata, configura il progetto specifico.

**Q1: Nome progetto**
Chiedi il nome del progetto (diventa il prefisso: `NOME-DOC/`).

**Q2: Societa e CEO**
Chiedi nome societa e nome CEO/founder.

**Q3: Dominio**
Chiedi una descrizione del dominio in una riga.

**Q4: Stack tecnologico**
Chiedi backend, frontend, database, infrastruttura.

**Q5: Lingue i18n**
Chiedi le lingue target. Default: "it en".

**Q6: Livello di applicazione**
Presenta i 4 livelli e chiedi quale si applica:

- **Livello 1 — Disciplina**: paradigma solo. Per progetti dove il CEO verifica manualmente.
- **Livello 2 — Enforcement**: aggiunge OS3 Matrix. Per progetti dove la verifica manuale e impossibile.
- **Livello 3 — LSO mono-organo**: organismo vivente, un organo. Mission protocol, SSOT tracking, DOC-SYNC.
- **Livello 4 — LSO multi-organo**: piu organi. Organ Index, sistema circolatorio, contracts cross-organo.

Se l'utente non sa, triage:
- "Il tuo progetto ha interazione continua con utenti?" (si -> livello 2+)
- "Hai bisogno di esperienza accumulabile tra sessioni?" (si -> livello 3+)
- "Hai piu applicazioni che condividono dati?" (si -> livello 4)

Nota: se l'utente sceglie livello 2+ ma non ha OS3 Matrix installato, segnala l'incongruenza e chiedi come procedere.

**Domande condizionali per livello:**

Se livello 3+:
- Conferma mission protocol e DOC-SYNC attivi

Se livello 4:
- Mappa organi (nomi, funzioni, URL)
- Sistema circolatorio (se esiste)
- Database condiviso

Per tutti i livelli:
- Stack bannati
- Valori immutabili
- P0 dominio-specifiche

<!-- Fase 3 sara espansa con step aggiuntivi futuri -->

---

## Fase 4 — Generazione scaffold

Dopo tutte le risposte:

1. **Crea directory progetto**: `<CWD>/NOME-DOC/`
2. **Copia scaffold base**: da `/home/fabio/oracode/templates/PROJECT-DOC/`
3. **Compila CLAUDE.md**: sostituisci tutti i placeholder `{{...}}` con le risposte raccolte
4. **Compila MISSION_REGISTRY.json**: inserisci dati progetto, counter=0
5. **Compila SSOT_REGISTRY.json**: inserisci dati progetto, documents vuoto
6. **Se livello 2+**: includi configurazione OS3 Matrix nel boot context
7. **Se livello 4**: includi sezione organi e sistema circolatorio
8. **Registra librerie installate**: nel boot context, sezione dipendenze

<!-- Fase 4 sara espansa con step aggiuntivi futuri -->

---

## Fase 5 — Riepilogo

Mostra all'utente:
- Struttura creata (tree)
- Infrastruttura Oracode installata (paradigma, Matrix, librerie)
- Livello determinato e perche
- Prossimi passi consigliati per il livello scelto

<!-- Fase 5 sara espansa con step aggiuntivi futuri -->

---

## Note operative

- MAI inventare risposte. Se l'utente non risponde, usa placeholder espliciti `[DA COMPILARE]`.
- La data nei file generati e la data corrente.
- Se il CWD non e il posto giusto, chiedi conferma del path di destinazione.
- Lo scaffold e minimale di proposito. Il progetto cresce con le mission, non con lo scaffold.
- I commenti `<!-- da formalizzare -->` segnano punti che richiedono decisioni future del CEO.
