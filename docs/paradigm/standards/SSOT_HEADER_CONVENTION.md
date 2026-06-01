---
title: Convenzione header SSOT — visibility + rag + mono-confine
slug: ssot-header-convention
doc_type: standard
version: 1.0.0
date: '2026-06-01'
visibility: public
rag: public
priority: high
scope:
- oracode
---

# Convenzione header SSOT — visibility, rag, mono-confine

```
@package  oracode/paradigm/standards
@author   Padmin D. Curtis (CTO-AI) for Fabio Cherici (CEO)
@version  1.0.0
@date     2026-06-01
@purpose  Separare nettamente cosa è paradigma pubblico (MIT) da cosa è implementazione
          privata (OS3 Matrix / organismo), e dichiararlo nell'header di OGNI SSOT.
@status   PRODUCTION — istituito da M-OS3-046.
```

> Licenza: MIT. Parte del paradigma Oracode pubblico. **Questo standard è esso stesso public.**

---

## 1. Perché

Oracode-paradigma è **pubblico** (repo `oracode`, MIT). OS3 Matrix è **privato** (commerciale,
Florence EGI S.R.L.). Un SSOT che mescola modello pubblico e implementazione privata, se sta nel
repo pubblico, **rivela come è sviluppato OS3 Matrix** (dai doc si ricostruisce l'enforcement).
Questa convenzione impedisce il leak per costruzione: ogni SSOT dichiara il proprio confine e
non li mescola.

## 2. Due campi obbligatori nel front-matter

Ogni SSOT dichiara **due campi indipendenti**:

```yaml
visibility: public | private
rag:        exclude | public | private
```

### `visibility`
| Valore | Significato | Repo |
|--------|-------------|------|
| `public` | Paradigma Oracode (modello, principi, regole concettuali) — MIT | `oracode` (pubblico) |
| `private` | Implementazione OS3 Matrix o contenuto d'organismo (FlorenceEGI) | `os3-matrix` / istanza (privati) |

### `rag` (indipendente da `visibility`)
| Valore | Significato |
|--------|-------------|
| `exclude` | NON indicizzato in alcun RAG |
| `public` | Entra nell'indice RAG **pubblico** |
| `private` | Entra nella sezione RAG **privata** (ad uso dev) — riservata, futura |

**Perché due campi e non uno:** `visibility` è una proprietà di *licenza/repo*; `rag` è una
proprietà di *indicizzazione*. Non coincidono: un SSOT `private` può essere `rag: private`
(interrogabile dai dev) **o** `rag: exclude`; un SSOT `public` può essere `rag: public` **o**
`rag: exclude` (pubblico ma non si vuole sia recuperato). In futuro il DB RAG avrà una sezione
privata per i dev: il campo `rag` la prevede già.

**Vincolo di coerenza:** `rag: public` richiede `visibility: public` (non si indicizza nel RAG
pubblico un contenuto privato). `visibility: private` ⇒ `rag ∈ {exclude, private}`.

**Combinazioni valide** (2×3 meno l'unica vietata `private,public`):
`(public,exclude)`, `(public,public)`, **`(public,private)`** (paradigma pubblico ma indicizzato
solo nel RAG dev — valido), `(private,exclude)`, `(private,private)`.

**I 2 campi si AGGIUNGONO** al front-matter esistente (`scope`, `priority`, `doc_type`, …) — non
li sostituiscono.

### Migrazione da `rag_indexed` (campo deprecato)
Alcuni SSOT hanno il vecchio booleano `rag_indexed: true|false`. È **deprecato** da questo
standard. Mappa di migrazione (applicata da M-OS3-047):
`rag_indexed: true → rag: public` · `rag_indexed: false → rag: exclude`.
Il vecchio campo `rag_indexed` viene rimosso quando si aggiunge `rag`.

## 3. Regola mono-confine

**Ogni SSOT appartiene a UN SOLO confine.** Un SSOT è *o* paradigma (`public`) *o* implementazione
OS3 Matrix / organismo (`private`) — **mai entrambi nello stesso file**. Se un argomento ha sia un
livello-modello sia un livello-implementazione, si **spezza in due SSOT** distinti, con cross-ref:
- il SSOT `public` descrive il **modello/principi** (cosa, perché) — astratto, riusabile;
- il SSOT `private` descrive l'**implementazione concreta** (come: codice, path `os3-matrix/bin/...`,
  layout file, regole esatte) — vive nel repo privato.

## 3.1 Dove vive l'entry di registro di un SSOT private

Il `SSOT_REGISTRY.json` di `oracode` è **pubblico**: contiene SOLO entry `visibility: public`.
Un SSOT `visibility: private` ha la sua entry in un **registry privato** dedicato in
`os3-matrix/docs/lso/SSOT_REGISTRY.json` (da istituire al primo SSOT private classificato) —
applicando la regola mono-confine **anche al registro**: nessun `ssot_id`/`title`/`path` che
riveli l'implementazione OS3 Matrix finisce nel registry pubblico. *(Decisione architetturale
cross-project — confermare con CEO prima di M-OS3-048.)*

## 4. Criterio di classificazione

| È `public` (paradigma) se descrive… | È `private` (OS3 Matrix/organismo) se descrive… |
|---|---|
| principi, pilastri, P0, modello concettuale | codice/script concreti (`bin/...`, hook), layout file |
| il *cosa* e il *perché* di un meccanismo | il *come* esatto (algoritmo implementato, comandi) |
| convenzioni riusabili da chiunque adotti Oracode | scelte d'implementazione specifiche di OS3 Matrix |
| — | dettagli d'organismo (FlorenceEGI: MiCA, Egili, organi) |

Dubbio tra public e private → **tratta come private** (il leak è irreversibile; il contrario no).

## 5. Applicazione (mission successive)
- **M-OS3-047**: classifica tutti gli SSOT esistenti + aggiunge i 2 header.
- **M-OS3-048**: spezza i misti (es. `AGENT_DEPLOY_RUNTIME_MODEL`, `ORACODE_LINT`,
  `ORACODE_AGENT_SKILL` mescolano modello+implementazione) → modello in `oracode`,
  implementazione in `os3-matrix`.
- RAG: re-istituito rispettando il campo `rag` (sezione pubblica subito; privata-dev poi).
- (Futuro) `oracode-lint` R7: ogni SSOT DEVE avere `visibility` + `rag` coerenti (enforcement).

---

*Oracode System — standard paradigma. Istituito da M-OS3-046. Licenza MIT.*
