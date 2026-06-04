# /oracode-configure — Raccogli i parametri del progetto (dominio, stack, livello)

Micro-skill del ciclo `/project`. Dopo che l'infrastruttura è installata (`/oracode-install`), raccoglie le
risposte che definiscono il progetto e ne determina il livello. Produce la **config** che è input di
`/oracode-scaffold`. Non installa infra (→ `/oracode-install`), non crea file (→ `/oracode-scaffold`).

## Fase 3 — Configurazione progetto

**3.0 Pre-fill da discovery (handoff deterministico)**
PRIMA di chiedere Q1, scopri se esiste un report discovery: elenca `~/.oracode/discovery/*.json`.
- **0 file** → nessun discovery: chiedi tutto come sotto.
- **1 file** → usalo: è il `DISCOVERY_REPORT.json` del progetto.
- **>1 file** → chiedi a quale progetto ci si riferisce (mostra i `project` dei JSON) e usa quello.
Dal file scelto **pre-compila** tutte le risposte presenti. Per ogni campo valorizzato (non `null`): NON ri-chiederlo,
mostralo come "già definito in discovery: <valore>" e procedi. Chiedi SOLO i campi `null` o assenti.
REGOLA ZERO: mai inventare un campo mancante — chiedilo.

**Q1: Nome progetto**
Chiedi il nome del progetto (diventa il prefisso: `NOME-DOC/`). Da questo si deriva `INSTANCE_NAME` (es. `<nome>-DOC`).

**Q2: Societa, CEO e CTO**
Chiedi nome societa, nome CEO/founder e nome del CTO (partner tecnico/AI). Il CTO popola `{{CTO_NAME}}` nei template:
non dedurlo né usare un default — se non noto, chiedilo.

**Q3: Dominio**
Chiedi una descrizione del dominio in una riga.

**Q4: Stack tecnologico**
Chiedi backend, frontend, database, infrastruttura.

> **Infra deploy — NON ASSUMERE (P0-12).** Se l'istanza si innesta su un ecosistema esistente,
> non dedurre il pattern di hosting (DNS, load balancer, compute, docroot, certificati, pipeline di deploy):
> verificalo dalla **infra SSOT dell'ecosistema** e replica esattamente quello già in uso. Mai assumere
> "tanto sarà S3/CloudFront" o pattern plausibili. Cicatrice tipica: deploy assunto ≠ deploy reale → corretto a runtime.
> *(Gli organismi con infra propria mantengono i dettagli — endpoint, account, path — nella loro SSOT privata, non qui.)*

**Q4b: Repo GitHub**
Chiedi il repository GitHub del progetto (`owner/repo`) — popola `{{GITHUB_REPO}}` in REPO_MAP.json.
Se il progetto non ha ancora un repo remoto: registra `null` (NON inventare un nome plausibile, P0-12).

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

**Output**: la config raccolta (nome, INSTANCE_NAME, societa, CEO, CTO, dominio, stack, repo GitHub, lingue, livello, Q7.*) —
pre-compilata da `DISCOVERY_REPORT.json` dove disponibile — è l'input di `/oracode-scaffold`. Nessun placeholder template resta non risolto.
