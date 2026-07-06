---
title: Oracode OS3 — Code Naming Standard
slug: oracode-naming-standard-code
doc_type: standard
version: 1.0.0
status: current
date: '2026-04-10'
updated_at: '2026-04-10'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- ecosystem
supersedes: []
superseded_by: null
priority: critical
visibility: public
rag: public
---

> ⛔ **DEPRECATO — clausole di stato (M-OS3-138, 2026-07-06).** Le affermazioni «FlorenceEGI/EGI-DOC = HUB+istanza *accoppiato* / *caso unico*; L2/HUB *differito* finché non ci sono 2+ clienti» in questo documento sono **superate**: il disaccoppiamento è fatto, **L2 = Florence EGI S.R.L.** (software house acquirente con licenza Nexus) *esiste*, e le istanze L3-clienti sono già molte (FlorenceEGI, Capasso, LeVespe, DeepDebug). Stato corrente autoritativo → **oracode: docs/paradigm/nomenclature/NEXUS_HIERARCHY_CURRENT_STATE.md**. Le *definizioni core* L1/L2/L3 restano valide.


# Oracode OS3 — Code Naming Standard

> Standard di naming del paradigma **Oracode Nexus** (Livello 1 GLOBALE). Si applica a ogni
> istanza LSO (L3) generata via `/project` e all'HUB softwarehouse (L2). Gli esempi sono tratti
> dall'ecosistema FlorenceEGI (HUB/istanza accoppiato, "caso unico").

> Prima di scrivere un metodo, una classe, una variabile — si verifica se esiste già un pattern nel codebase.
> Se esiste, si estende. Non si reinventa.
> Strategia Delta: file legacy restano invariati. Standard valido per ogni file nuovo.

---

## Principi Fondamentali

### 1. Naming da Oracode System
Tutto segue le convenzioni già esistenti nell'ecosistema di riferimento (caso esemplare: FlorenceEGI). Prima di creare qualsiasi
identificatore — metodo, classe, variabile — si verifica nel codebase e nell'Organ Index.
Se esiste un pattern, si estende. Non si reinventa.

### 2. Organi prima di arti
Prima di creare qualsiasi componente nuovo: **esiste già da qualche parte nell'ecosistema?**
ULM, UEM, UTM, e tutti gli strumenti Ultra sono candidati naturali.
L'organismo non porta organi duplicati — porta funzioni nuove su infrastruttura esistente.

### 3. Interfacce prima di implementazioni
Ogni strumento viene definito come interfaccia — input, output, dipendenze — prima che
si scriva una riga di codice. L'AI lavora su contratti chiari, non deduce.

---

## PHP (Laravel)

### Classi

| Tipo | Pattern | Esempio | Directory |
|------|---------|---------|-----------|
| Controller | `<Domain>Controller` | `NatanChatController` | `app/Http/Controllers/` |
| Service | `<Domain>Service` | `NatanEgiliService` | `app/Services/` |
| Model | `<Entity>` (singolare) | `NatanChatMessage` | `app/Models/` |
| Trait | `Has<Capability>` | `HasGdprData` | `app/Traits/` |
| Interface | `<Concept>Interface` | `PaymentServiceInterface` | `app/Contracts/` |
| Enum | `<Concept>Enum` | `OrderStatusEnum` | `app/Enums/` |
| DTO | `<Concept>Dto` o `<Concept>Data` | `ConsentTypeDto` | `app/DataTransferObjects/` |
| Form Request | `<Action><Entity>Request` | `SigilloApiCertifyRequest` | `app/Http/Requests/` |
| Event | `<Action><Entity>` (passato) | `PriceUpdated` | `app/Events/` |
| Exception | `<Concept>Exception` | `DuplicateIbanException` | `app/Exceptions/` |
| Job | `<Action><Entity>Job` | `ProcessDocumentJob` | `app/Jobs/` |
| Middleware | `<Action>Middleware` | `EnsureTenantMiddleware` | `app/Http/Middleware/` |

### Metodi e proprietà

```
metodi pubblici    → camelCase          → getUserBalance()
metodi privati     → camelCase          → calculateDiscount()
proprietà          → camelCase          → $egiliBalance
colonne DB         → snake_case         → egili_amount, created_at
costanti di classe → UPPER_SNAKE_CASE   → MAX_RETRY_COUNT
membri enum        → UPPER_SNAKE_CASE   → PENDING, COMPLETED
```

### Convenzioni specifiche

- **Nessun prefisso "I" sulle interfacce** — si usa il suffisso `Interface`
- **Nessun prefisso "Abstract"** — si usa il namespace per distinguere
- **Prefisso organo** su Service/Controller cross-dominio: `Natan*`, `Sigillo*`, `Egi*`
- **Broadcast channel**: `snake.case` con punto separatore — `price.{$egiId}`
- **Broadcast event**: `'domain.action'` — `'price.updated'`

---

## Python (FastAPI)

### File

```
moduli/file        → snake_case         → advisory_generator.py, use_pipeline.py
package (__init__) → snake_case         → rag_fortress/
test file          → test_<module>.py   → test_advisory_generator.py
config file        → snake_case         → ai_policies.yaml
```

### Classi e funzioni

| Tipo | Pattern | Esempio |
|------|---------|---------|
| Classe | PascalCase | `AdvisoryGenerator` |
| Exception | `<Concept>Error` | `InsufficientFundsError` |
| Enum | `<Concept>Type` o PascalCase | `APIErrorType` |
| Pydantic Model | PascalCase | `QueryRequest`, `ChatResponse` |
| Router | snake_case (file) | `skill_extract.py` |

### Funzioni, metodi, variabili

```
funzioni pubbliche → snake_case         → generate_advisory()
funzioni private   → _snake_case        → _build_claims_map()
metodi async       → async def snake    → async def generate()
variabili locali   → snake_case         → query_result, chunk_count
costanti modulo    → UPPER_SNAKE_CASE   → INSUFFICIENT_FUNDS, MAX_RETRIES
parametri          → snake_case         → tenant_id, query_text
```

### Convenzioni specifiche

- **Router prefix**: nome dominio plurale — `/documents`, `/embeddings`, `/chat`
- **Endpoint function**: verbo + risorsa — `extract_skills()`, `search_documents()`
- **DB factory**: sempre `get_db_service()` — mai istanziazione diretta (P0-10)
- **Underscore leading** per metodi interni — `_generate_internal()`, `_parse_json()`

---

## TypeScript

### File

```
componenti/classi  → PascalCase         → ChatInterface.ts, ResponsePanel.ts
servizi            → PascalCase         → ProjectService.ts, ApiService.ts
hook               → camelCase con use  → useSigilloAuth.ts
utility            → kebab-case         → prompt-builder.ts
tipi               → PascalCase         → projects.ts (se contiene solo tipi)
```

### Classi, interfacce, tipi

| Tipo | Pattern | Esempio |
|------|---------|---------|
| Classe | PascalCase | `ChatInterface`, `ProjectService` |
| Interface | PascalCase (no prefisso) | `SigilloUser`, `ProjectSettings` |
| Type | PascalCase (no prefisso) | `DocumentProcessingMetadata` |
| Enum | PascalCase | `CertificationStatus` |
| Hook (React) | `use<Concept>` | `useSigilloAuth()` |
| Component (React) | PascalCase | `CertificationFlow` |

### Funzioni, metodi, variabili

```
funzioni esportate → camelCase          → executeCommand(), getCsrfToken()
metodi pubblici    → camelCase          → getProjects(), sendMessage()
metodi privati     → _camelCase         → _getCsrfToken()
proprietà private  → _camelCase         → _isLoading
variabili locali   → camelCase          → tabSessionId, chunkCount
costanti modulo    → UPPER_SNAKE_CASE   → POLL_INTERVAL_MS, AUTH_EVENT
parametri          → camelCase          → confirmedUuid, queryText
```

### Convenzioni specifiche

- **Nessun prefisso "I" o "T"** su interfacce e tipi — solo PascalCase pulito
- **Props type**: `<Component>Props` — `CertificationFlowProps`
- **Return type hook**: `<Hook>Return` — `UseSigilloAuthReturn`
- **Storage keys**: snake_case — `auth_token`, `natan_current_conversation_${id}`
- **Event constant**: snake_case con namespace — `sigillo:auth-change`
- **ARIA**: sempre presente su elementi interattivi — `aria-label`, `aria-live`, `aria-expanded`

---

## Convenzioni Cross-Linguaggio

### Prefisso organo

Quando un componente è specifico di un organo, il nome dell'organo è prefisso:

```
PHP:    NatanChatService, SigilloApiCertifyRequest, EgiliService
Python: natan_chat_router (file), NatanQueryAnalyzer (classe)
TS:     useSigilloAuth (hook), NatanProjectService (classe)
```

### Suffissi universali

| Concetto | PHP | Python | TypeScript |
|----------|-----|--------|------------|
| Servizio | `*Service` | `*Service` o `*Generator` | `*Service` |
| Errore | `*Exception` | `*Error` | `Error` (nativo) |
| Enum/Costanti | `*Enum` | `*Type` | `*Status` / `*Type` |
| Contratto | `*Interface` | Protocol / ABC | `interface *` |
| Trasferimento dati | `*Dto` / `*Data` | Pydantic model | `interface *` |
| Richiesta | `*Request` | `*Request` | `*Params` / `*Request` |
| Risposta | `*Response` | `*Response` | `*Response` |

### Colonne DB e chiavi JSON

```
Sempre snake_case: egili_amount, created_at, tenant_id, query_text
Mai camelCase nel DB: ❌ egiliAmount, ❌ createdAt
```

### Variabili d'ambiente

```
Sempre UPPER_SNAKE_CASE: DB_HOST, VOYAGE_API_KEY, VITE_PORT
Prefisso per scope: VITE_* (frontend), DB_* (database), AWS_* (infra)
```

---

## Anti-Pattern — Cosa NON fare

| Anti-pattern | Perché è sbagliato | Corretto |
|---|---|---|
| `IPaymentService` | Prefisso "I" non usato nell'ecosistema | `PaymentServiceInterface` |
| `TUserData` | Prefisso "T" non usato nell'ecosistema | `UserData` |
| `AbstractBaseService` | Prefisso "Abstract" non necessario | Namespace per distinguere |
| `handleClick` | Nome generico senza dominio | `handleCertificationSubmit` |
| `data`, `result`, `item` | Nomi generici — non dicono nulla | `queryResult`, `chunkData` |
| `doStuff()`, `process()` | Verbi generici | `extractMetadata()`, `generateAdvisory()` |
| `utils.py`, `helpers.ts` | Borse generiche | File per dominio: `cost_calculator.py` |
| `egiliAmount` (in DB) | camelCase nel DB | `egili_amount` |

---

## Verifica Pre-Creazione (P0-4 esteso)

Prima di creare qualsiasi nuovo identificatore:

```
1. Consultare l'Organ Index del proprio ecosistema
   (es. istanza FlorenceEGI: EGI-DOC/docs/ecosistema/ORGAN_INDEX.json — caso HUB/istanza accoppiato)
   → Esiste già un metodo/classe con questo scopo?

2. grep cross-organo sul nome proposto
   → È già usato con significato diverso?

3. Verificare il suffisso/prefisso corretto dalla tabella sopra
   → Coerente con i pattern esistenti?

4. Se è un Service/Controller — esiste già in un altro organo?
   → Riusare l'esistente, non duplicare
```

Se la risposta a (1) o (4) è sì → **non creare, riusare**.

> Nessun path documentale è canonico universale: ogni istanza LSO (L3) risolve i propri path
> dal suo repo (via `.oracode/project.json`), l'HUB (L2) dal suo `HUB-DOC`. I path `EGI-DOC/...`
> citati sono il caso FlorenceEGI (HUB/istanza accoppiato), non lo standard per tutte le istanze.

---

## Organ Index — Catalogo Vivente

L'Organ Index è un catalogo auto-generato di tutti i simboli pubblici (classi, metodi,
funzioni, interfacce) di tutti gli organi dell'ecosistema.

- **Generazione**: package Python `organ_index` nell'**enforcement commerciale (OS3 Matrix, repo privato, Livello 1 motore)**. NON è un binario in `oracode/bin/` (che contiene solo `cli.js`).
  L'invocazione esatta va verificata dalla fonte nell'enforcement prima di citarla
  (P0-12 Anti-Infra-Invention): mai dedurre il comando.
- **Output JSON**: es. istanza FlorenceEGI `EGI-DOC/docs/ecosistema/ORGAN_INDEX.json` (caso HUB/istanza accoppiato);
  ogni ecosistema risolve il proprio path di output.
- **Output leggibile**: `ORGAN_INDEX_SUMMARY.md` accanto al JSON (es. istanza FlorenceEGI:
  `EGI-DOC/docs/ecosistema/ORGAN_INDEX_SUMMARY.md`)
- **Frequenza**: rigenerato ad ogni cambio significativo o prima di creare nuovi componenti

Vedi le convenzioni di naming dei file di documentazione del proprio ecosistema (es. istanza FlorenceEGI:
`EGI-DOC/docs/ecosistema/NAMING_CONVENTIONS.md`) — complementari a questo standard.

---

*v1.0.0 — 2026-04-10 — Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici*
*Oracode Nexus — standard di paradigma (L1 GLOBALE). Esempi da FlorenceEGI (HUB/istanza accoppiato).*
