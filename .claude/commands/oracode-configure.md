# /oracode-configure — Raccogli i parametri del progetto (ruolo, dominio, stack)

Micro-skill del ciclo `/project`. Dopo che l'infrastruttura è installata (`/oracode-install`), raccoglie le
risposte che definiscono il progetto, a partire dal suo ruolo. Produce la **config** che è input di
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

**Q0 (già Q6c): Che cosa stiamo creando?** — la PRIMA domanda, prima di ogni altra che dipenda dalla risposta.

Alla nascita di ogni repository la prima domanda è una sola, e si formula piana: *«Che cosa stiamo creando?»*
Dalla risposta discende tutto il resto — l'instradamento dei documenti, il corredo operativo, la difesa, e le
domande che seguono. Documento umano autoritativo: `oracode/docs/paradigm/nomenclature/RUOLI_E_CONTENITORI.md`
(ratifica CEO 2026-08-31, M-OS3-215).

Le risposte NON si trascrivono qui: **si LEGGONO dal contratto** `os3-matrix/contracts/role-enum.json` — è la
fonte unica, e una copia in prosa drifterebbe (M-OS3-215). Procedura:

```
jq -r '.roles[]' <matrix>/contracts/role-enum.json          # l'elenco canonico
jq -r '.topology' <matrix>/contracts/role-enum.json         # chi è unico-già-creato, chi appartiene a chi
```

Presenta come **selezionabile** ogni ruolo la cui voce in `topology` NON lo dichiara *unico, già creato*: quelli
lo sono per costruzione e non si ricreano mai più, quindi non compaiono fra le scelte di un progetto nuovo.
Presenta le risposte **per parola**, mai per numero (canone M-FUC-040): la parola è la risposta, il numero
fingerebbe un ordine che non c'è. Se un ruolo non è nel contratto non esiste: non inventarlo (REGOLA ZERO).

Chi conduce la raccolta spiega ogni risposta con la definizione che il contratto e il documento autoritativo già
portano — non con una definizione riscritta qui.

Esito della domanda: `role` in config (fluisce a `/oracode-scaffold`, `{{ROLE}}`, e finisce nel campo `role`
della carta d'identità `.oracode/project.json`). `bin/mission` lo valida all'open e lo mostra in `status`.
I due contenitori Softwarehouse e Customer NON sono valori di questo campo: stanno sull'asse proprietà
(chi possiede), non su quello della produzione (cosa il repo è).

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

> **La domanda sul «Livello di applicazione» non si pone più** (ratifica CEO 2026-08-31, M-OS3-216).
> Quel numero da 1 a 4 mescolava due domande diverse — *quanta attrezzatura ricevi* e *che forma hai* —
> e produceva carte d'identità che si contraddicevano da sole. Ciò che serviva sapere discende ora dal
> ruolo raccolto in Q0 e dalla domanda sull'LSO. Il campo `oracode_level` sopravvive nella carta
> d'identità solo come **annotazione derivata**: si scrive, non si chiede, e non decide più nulla.
> Motivazione integrale: `oracode/docs/paradigm/nomenclature/RUOLI_E_CONTENITORI.md`, sezione «La
> domanda livello muore».

**Q6b: Ruolo nel Nexus → determina lo `scope`** (M-OS3-141). Il **ruolo** raccolto in Q0 è un asse;
questo ne è un altro, ed è quello da cui il routing RAG di fine-mission si deduce. Determinalo ora
(fluisce a `/oracode-scaffold`):
- **Paradigma** — il progetto È il motore/le regole (`oracode`→`paradigm`, `os3-matrix`→`engine`). Raro: solo i due tool-radice.
- **Strumento del Nexus** (`nexus-tool`) — attrezzatura operativa del Nexus (Fucina, DeepDebug, il cockpit…). SSOT → `rag_nexus`.
- **Organismo/Progetto** (`organism`) — un progetto/organismo vero (mono, hub, o organo). Default per i progetti-cliente.

Triage: *"È attrezzatura del Nexus, o è un organismo/progetto a sé?"* → `nexus-tool` vs `organism`.
Se **Organismo multi-organo (hub)**: sarà la radice dei suoi organi → allo scaffold dichiarerà il suo store RAG
(`rag_store` + `rag_engine_writes`). Un mono senza RAG non dichiara nulla (→ nessun RAG). Output: `scope` in config.

> **Il ruolo è già stato raccolto**: è la prima domanda del questionario (Q0, già Q6c). Non ri-chiederlo qui.

**Domande condizionali per livello:**

Se livello 3+ (LSO mono-organo o multi-organo) — SISTEMA CIRCOLATORIO completo richiesto:

Conferma con CEO che il progetto sara setuppato con sistema circolatorio mono-organo
completo (per §1.1.A LSO_NOMENCLATURE_v3: Mission Protocol + DOC-SYNC v2 + RAG + AI Helping):

- **Q7.1: Backend runtime per RAG**
  Chiedi: "Quale stack runtime puo ospitare RAG (PostgreSQL+pgvector / managed vector DB / nessuno)?"
  Se nessuno (es. progetti static): segnala "LSO ridotto" (§2.6) — infrastruttura completa
  ma RAG resta inattivo finche non c'e runtime. Procedi comunque con registry + audit + agent.

- **Q7.2: Schema RAG name** (solo se Q7.1 ha runtime)
  Default: `rag_<nome_progetto_normalizzato>`. CEO conferma o overrida.

- **Q7.3: AI Helping conversazionale**
  Conferma intenzione di esporre RAG via interfaccia conversazionale (sidebar AI, chat).
  Pattern documentato in `LSO_NOMENCLATURE_v3 §1.1.A`. Implementazione e mission separata
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

Il profilo **NON si sceglie a mano e non si deduce**: lo deriva l'engine dal fatto raccolto col
cliente (M-OS3-194, capacità `rischio-si-raccoglie-parlando-col-cliente`).

```
os3-matrix/bin/egida-profilo-da-rischio <DISCOVERY_REPORT.json>   # → L1 | L2-L3 | L3-L4
```

- **esce 0** → usa quel profilo, senza ri-chiedere nulla: il fatto è già stato raccolto al punto
  1.1bis di `/discovery` e vive nel rapporto come `rischio: {denaro, pii, blockchain}`;
- **esce 4** → il fatto manca, o tace su uno dei tre. Il comando **rifiuta di scegliere** e dice
  quale manca: chiedilo al cliente e registralo nel rapporto, poi rilancia. Un profilo dedotto è
  peggio di un profilo assente, perché sembra una decisione (REGOLA ZERO, qui meccanica e non prosa).

Se non esiste alcun rapporto di discovery (progetto senza raccolta), poni tu la domanda —
"Questo organo tratta denaro, dati personali (PII) o blockchain?" (sì → `L3-L4`) — e **scrivila**
in un rapporto minimo, così la scelta resta verificabile da chi la leggerà dopo.

La regola che il comando applica: uno solo dei tre vero → `L3-L4` a prescindere dalla maturità;
nessuno dei tre → il profilo scende dal livello (`1 → L1`, `2/3/4 → L2-L3`).

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

**Output**: la config raccolta (`role` da Q0, nome, INSTANCE_NAME, societa, CEO, CTO, dominio, stack, repo GitHub, lingue, Q7.*, `egida_profile` se Matrix presente) —
pre-compilata da `DISCOVERY_REPORT.json` dove disponibile — è l'input di `/oracode-scaffold`. Nessun placeholder template resta non risolto.
