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
Cerca file di licenza OS3 Matrix in questo ordine:
1. Variabile ambiente `ORACODE_LICENSE_PATH` (se definita, usa quel path)
2. `~/.oracode/license.json` (path convenzionale)

Se trovato, leggi il file JSON e verifica:
- `product` deve essere `"os3-matrix"`
- `expires` deve essere una data futura (non scaduta)
- `repo` contiene l'URL del repo da cui clonare Matrix

Se licenza valida: "OS3 Matrix — licenza valida (scade [data]). Licensee: [name], [company]."
Se licenza scaduta: "OS3 Matrix — licenza SCADUTA il [data]. Rinnova per utilizzare Matrix."
Se non trovato: "OS3 Matrix non rilevato. Puoi operare con il paradigma (livello 1) o acquistare una licenza su [URL]."

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
Rileggi `~/.oracode/license.json`. Se licenza valida:
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

Se livello 3+ (LSO mono-organo o multi-organo) — SISTEMA CIRCOLATORIO completo richiesto:

Conferma con CEO che il progetto sara setuppato con sistema circolatorio mono-organo
completo (per §1.1.A LSO_NOMENCLATURE_v2: Mission Protocol + DOC-SYNC v2 + RAG + AI Helping):

- **Q7.1: Backend runtime per RAG**
  Chiedi: "Quale stack runtime puo ospitare RAG (PostgreSQL+pgvector / managed vector DB / nessuno)?"
  Se nessuno (es. progetti static): segnala "LSO ridotto" (§2.6) — infrastruttura completa
  ma RAG resta inattivo finche non c'e runtime. Procedi comunque con registry + audit + agent.

- **Q7.2: Schema RAG name** (solo se Q7.1 ha runtime)
  Default: `rag_<nome_progetto_normalizzato>`. CEO conferma o overrida.

- **Q7.3: AI Helping conversazionale**
  Conferma intenzione di esporre RAG via interfaccia conversazionale (sidebar AI, chat).
  Pattern documentato in `LSO_NOMENCLATURE_v2 §1.1.A`. Implementazione e mission separata
  per istanze nuove (impl. di riferimento ancora in maturazione su FlorenceEGI).

Se livello 4:
- Mappa organi (nomi, funzioni, URL)
- Sistema circolatorio cross-organo (organ index, contracts)
- Database condiviso

Se livello 1 o 2 (NON-LSO):
Nessun sistema circolatorio. CLAUDE.md include solo paradigma + P0. Niente DOC-SYNC v2,
niente RAG, niente Helping. Spiegare al CEO che alcune features Oracode (es. retrospective
mission, propriocezione documentale) richiedono livello 3+.

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
   Include automaticamente: `docs/missions/MISSION_BOOTSTRAP_INDEX.json`,
   `docs/missions/BOOTSTRAP_DRIFT_LOG.md`, `audit/doc_sync/.gitkeep`.
3. **Compila CLAUDE.md**: sostituisci tutti i placeholder `{{...}}` con le risposte raccolte
4. **Compila MISSION_REGISTRY.json**: inserisci dati progetto, counter=0
5. **Compila SSOT_REGISTRY.json**: inserisci dati progetto, documents vuoto
6. **Se livello 2+**: includi configurazione OS3 Matrix nel boot context
7. **Se livello 3+ (LSO mono-organo)**: sistema circolatorio completo
   - Crea `docs/missions/MISSION_TYPES.json` che estende
     `/home/fabio/oracode/templates/MISSION_TYPES_BASE.json` (tassonomia ibrida — Opzione 3)
   - Compila `docs/missions/MISSION_BOOTSTRAP_INDEX.json` sostituendo placeholder
     `{{DATE}}`, `{{INSTANCE_NAME}}`, `{{CEO_NAME}}`, `{{CTO_NAME}}`
   - Inserisci nel CLAUDE.md istanza la convenzione `instance_root` (path assoluto)
     usata da agent `doc-sync-v2`
   - Se Q7.1 ha runtime RAG: prepara `bin/apply-rag-schema.sh` che applica
     `/home/fabio/os3-matrix/nervous-system/rag-schema-template.sql` con
     placeholder risolti (`{{RAG_SCHEMA}}` da Q7.2, `{{TS_LANGUAGE}}` mappato da
     locale principale Q5, `{{LANGUAGES_CHECK}}` derivato da Q5,
     `{{EMBEDDING_DIM}}=1536`, `{{IVFFLAT_LISTS}}=100`)
   - Se Q7.1 = nessuno runtime: annota `LSO ridotto — RAG offline` nel CLAUDE.md
8. **Se livello 4**: includi sezione organi e sistema circolatorio cross-organo
9. **Registra librerie installate**: nel boot context, sezione dipendenze

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
