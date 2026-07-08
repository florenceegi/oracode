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

**Q6b: Ruolo nel Nexus → determina lo `scope`** (M-OS3-141). Il livello (sopra) è un asse; il **ruolo** è un altro,
ed è quello da cui il routing RAG di fine-mission si deduce. Determinalo ora (fluisce a `/oracode-scaffold`):
- **Paradigma** — il progetto È il motore/le regole (`oracode`→`paradigm`, `os3-matrix`→`engine`). Raro: solo i due tool-radice.
- **Strumento del Nexus** (`nexus-tool`) — attrezzatura operativa del Nexus (Fucina, DeepDebug, il cockpit…). SSOT → `rag_nexus`.
- **Organismo/Progetto** (`organism`) — un progetto/organismo vero (mono, hub, o organo). Default per i progetti-cliente.

Triage: *"È attrezzatura del Nexus, o è un organismo/progetto a sé?"* → `nexus-tool` vs `organism`.
Se **Organismo multi-organo (hub)**: sarà la radice dei suoi organi → allo scaffold dichiarerà il suo store RAG
(`rag_store` + `rag_engine_writes`). Un mono senza RAG non dichiara nulla (→ nessun RAG). Output: `scope` in config.

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

**Q8: Profilo difesa Egida (`egida_profile`)** — solo se Matrix presente (livello 2+).

L'asse difesa Egida è **costitutivo** (CORE §Asse Difesa Costitutivo): un LSO si difende e lo prova,
in proporzione al rischio. `/project` installa la difesa di default — qui si sceglie il **profilo**
(lo starter di invarianti). Determina `egida_profile` ∈ `{"L1","L2-L3","L3-L4"}` così
(EGIDA_INSTALL_CONTRACT §6):

- default dal livello: `1 → L1`, `2 → L2-L3`, `3 → L2-L3`, `4 → L2-L3`;
- **upgrade a `L3-L4`** se l'organo tratta **denaro / PII / blockchain**. Questo segnale NON è deducibile
  dal solo livello: chiedilo (o leggilo dal discovery). REGOLA ZERO — non assumere.
  Domanda: "Questo organo tratta denaro, dati personali (PII) o blockchain?" (sì → `L3-L4`).

> **Prerequisito Matrix (G2).** Il tooling Egida (starter, `bin/collaudo`, `fortino-check`) vive in
> os3-matrix/FORTINO → esiste solo con Matrix licenziato. Un **livello 1 paradigm-only (senza Matrix)**
> NON riceve Egida-by-default (nessun `egida_profile`, nessun `egida_gate`): coerente con "dove ha senso".
> Un livello 1 *con* Matrix riceve `L1` leggero.

`egida_profile` entra nella config (input di `/oracode-scaffold`). Se Matrix assente: ometti (no Egida).
Nessun sistema circolatorio. CLAUDE.md include solo paradigma + P0. Niente DOC-SYNC v2,
niente RAG, niente Helping. Spiegare al CEO che alcune features Oracode (es. retrospective
mission, propriocezione documentale) richiedono livello 3+.

Per tutti i livelli:
- Stack bannati
- Valori immutabili
- P0 dominio-specifiche

<!-- Fase 3 sara espansa con step aggiuntivi futuri -->

**Output**: la config raccolta (nome, INSTANCE_NAME, societa, CEO, CTO, dominio, stack, repo GitHub, lingue, livello, Q7.*, `egida_profile` se Matrix presente) —
pre-compilata da `DISCOVERY_REPORT.json` dove disponibile — è l'input di `/oracode-scaffold`. Nessun placeholder template resta non risolto.
