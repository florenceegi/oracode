---
title: Standard dell'intestazione di un documento SSOT
slug: ssot-frontmatter-standard
doc_type: spec
version: 1.4.0
status: current
date: '2026-08-29'
updated_at: '2026-08-29'
author: Padmin D. Curtis (CTO-AI) for Fabio Cherici (CEO)
scope:
- oracode
supersedes: []
superseded_by: null
visibility: public
rag: public
priority: high
---

# Standard dell'intestazione di un documento SSOT

> **Questo è l'unico documento che definisce l'intestazione. Se un altro testo la descrive in
> modo diverso, vince questo.** Chi deve scrivere o correggere un'intestazione non deve cercare
> altrove, non deve dedurla da un documento vicino, e non deve chiederlo a nessuno.

## Perché esiste, detto senza attenuanti

Il CEO ne ha ordinato la creazione, e l'ordine **non è stato eseguito**. La definizione è rimasta
sparsa in tre posti che dicono ciascuno una parte: `SSOT_HEADER_CONVENTION.md` istituisce due campi
(`visibility`, `rag`) e dichiara di aggiungersi «al front-matter esistente» senza dire quale sia;
`oracode-doctype-frontmatter` sistema un campo solo; il registro SSOT ne censisce altri. Ognuno
vero, nessuno completo. Il risultato prevedibile: ogni volta che qualcuno deve scrivere
un'intestazione la ricostruisce a pezzi, e sbaglia.

**Misurato il 2026-08-29 sui soli SSOT CENSITI NEI REGISTRI** — non su tutti i file markdown dei
repository, che sono un'altra popolazione (handoff, report, appunti, template: quelli non sono SSOT
e non devono avere questa intestazione). Fonte: le schede di `docs/lso/SSOT_REGISTRY.json` di
`os3-matrix` e `EGI-DOC`, seguendo il percorso dichiarato da ogni scheda, con il metro dei
**quattordici campi**.

| | SSOT censiti | file che non esistono | senza intestazione | **con tutti e 14 i campi** |
|---|---|---|---|---|
| os3-matrix | 103 | 4 | 1 | **1** |
| EGI-DOC | 240 | 10 | 15 | **0** |
| **totale** | **343** | **14** | **16** | **1** |

**Un SSOT su trecentoquarantatré ha l'intestazione completa.** Ed è `docs/aws/infrastructure.md`,
cioè proprio il documento che il CEO ha indicato come esempio della forma corretta. Non è una
deriva progressiva: è uno standard che esisteva nella testa del CEO e in un solo file.

A quanti SSOT manca ciascuno dei quattordici:

| campo | manca a | |
|---|---|---|
| `visibility` | 303 | istituito il 2026-06-01, **mai applicato** |
| `rag` | 303 | idem |
| `supersedes` | 230 | |
| `superseded_by` | 230 | |
| `updated_at` | 198 | il campo che dice se stai leggendo roba vecchia |
| `priority` | 157 | |
| `author` | 148 | |
| `scope` | 146 | |
| `date` | 143 | |
| `version` | 143 | |
| `slug` | 142 | la chiave nel registro: 142 SSOT non la dichiarano nel file |
| `status` | 137 | |
| `title` | 127 | |
| `doc_type` | 17 | l'unico quasi a posto |

**`doc_type` è la prova che il rimedio funziona quando esiste**: è l'unico campo per cui è stato
scritto un comando (`oracode-doctype-frontmatter`, M-OS3-185), ed è l'unico presente quasi ovunque.
Gli altri tredici non hanno nessuno strumento, e infatti mancano a centinaia di documenti. Una
regola senza strumento non è una regola: è un auspicio.

**Campi NON ammessi trovati in circolazione** (i primi per diffusione): `rag_indexed` (164),
`mission` (57), `verificato_da` (14), `ratifica` (12), `ssot_id` (10), `organ` (10), più righe
`@package`/`@purpose` finite dentro il front-matter (9).
Il caso di `rag_indexed` merita una riga a parte: `SSOT_HEADER_CONVENTION.md` lo dichiara
**deprecato** dal 2026-06-01 e descrive la migrazione come «applicata da M-OS3-047». **Non è così**:
è ancora in 164 documenti. Una migrazione dichiarata conclusa e mai completata è più dannosa di una
non iniziata, perché nessuno la ricontrolla.

**Rilievo separato, non di forma:** 14 schede del registro puntano a **file che non esistono**. È il
registro che descrive documenti spariti; va sanato a parte, e finché resta così ogni conteggio
sugli SSOT è gonfiato di 14.

**Limite dichiarato:** il registro di `oracode` censisce 20 documenti le cui schede non espongono il
percorso nella forma letta qui: **non sono stati misurati**. Non sono «a posto», sono «non
misurati».

## Il blocco, da copiare così com'è

```yaml
---
title: AWS Infrastructure — FlorenceEGI Ecosystem
slug: aws-infrastructure
doc_type: architecture
version: 2.3.0
status: current
date: '2026-03-24'
updated_at: '2026-08-29'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- ecosystem
supersedes:
- /home/fabio/EGI-DOC/docs/_archive/aws/infrastructure_v1.0.0_20260324.md
superseded_by: null
visibility: private
rag: private
priority: normal
---
```

**Quattordici campi, tutti obbligatori, in quest'ordine.** Non dodici, non due: quattordici, e
`supersedes`/`superseded_by` sono **dentro** l'obbligatorio — si dichiarano sempre, anche vuoti
(`superseded_by: null` finché il documento è vivo). L'ordine non è estetica: un'intestazione sempre
uguale si legge a colpo d'occhio e si confronta con `diff`.

L'esempio qui sopra è l'intestazione reale di `docs/aws/infrastructure.md`, indicata dal CEO il
2026-08-29 come la forma corretta. **Questa, e non una sua sintesi.**

## Cosa contiene ciascun campo

| Campo | Cosa contiene | Chi lo tocca e quando |
|---|---|---|
| `title` | Il titolo in lingua leggibile. Non il nome del file | alla creazione; se cambia l'oggetto del documento |
| `slug` | Identificativo stabile in kebab-case. **È la chiave nel registro SSOT**: non si cambia mai dopo la creazione | alla creazione, poi mai |
| `doc_type` | Una parola del vocabolario chiuso (§ sotto) | alla creazione |
| `version` | Versione del documento, tre numeri. Sale a ogni modifica sostanziale | a ogni modifica sostanziale |
| `status` | Stato di vita del documento (§ sotto) | quando cambia stato |
| `date` | Data di **creazione**. Non si tocca più | alla creazione, poi mai |
| `updated_at` | Data dell'**ultima modifica sostanziale** | **a ogni modifica sostanziale, sempre** |
| `author` | Chi lo mantiene, e per conto di chi | alla creazione |
| `scope` | Lista: a quale ambito appartiene (`oracode`, `ecosystem`, nome dell'organo…) | alla creazione |
| `supersedes` | Lista dei percorsi dei documenti che questo rimpiazza. Vuota se non rimpiazza nulla | quando assorbe un documento precedente |
| `superseded_by` | Percorso di chi lo rimpiazza; **`null` finché è vivo** | quando viene rimpiazzato — insieme a `status: superseded` |
| `visibility` | `public` (paradigma MIT) o `private` (implementazione/organismo) | alla creazione — vedi `SSOT_HEADER_CONVENTION.md` |
| `rag` | `exclude`, `public` o `private` — se e dove viene indicizzato | alla creazione — vedi `SSOT_HEADER_CONVENTION.md` |
| `priority` | Quanto pesa se è sbagliato o vecchio | alla creazione |

**Regola dell'`updated_at`, che è quella violata più spesso:** un documento che cambia senza dirlo
nella testata è peggio di uno vecchio. Chi lo apre crede di avere l'ultima versione e non ha modo
di accorgersi che quella letta ieri era diversa. **Si cambia il contenuto, si cambia `updated_at`.
Sempre, nello stesso commit.**

### Non esistono campi facoltativi

I quattordici ci sono **tutti**, sempre. Un campo che in questo documento non c'è (`source`,
`mission`, `last_updated`, `rag_indexed`, `tipo_missione`…) **non è ammesso**: o si aggiunge qui con
una decisione del CEO, o si toglie dal documento che lo porta. Un'intestazione a geometria variabile
non è verificabile a macchina, e ciò che non è verificabile a macchina è ciò che è successo finora.

## I valori ammessi, campo per campo

Un campo senza un elenco di valori è testo libero, e il testo libero non si verifica a macchina.
Qui sotto, per ognuno dei quattordici: **la forma** e **da quali valori si sceglie**. Accanto, cosa
si trova oggi in circolazione — misurato il 2026-08-29 sui 343 SSOT censiti.

### Regola che vale per tutti: niente virgolette

I valori si scrivono **nudi**. L'unica eccezione sono le due date, che vanno fra **apostrofi
singoli** (in YAML una data non quotata diventa un oggetto data e non una stringa).

Perché è una regola e non un vezzo: oggi `current` compare 134 volte nudo e **46 volte come
`"current"`**; `high` 30 volte nudo e 46 volte come `"high"`. Sono lo **stesso valore scritto in due
modi**, e per una macchina sono due valori diversi. Metà del disordine misurato è solo questo.

### Campi a elenco chiuso

| Campo | Valori ammessi | Cosa c'è oggi |
|---|---|---|
| `status` | `current` · `draft` · `superseded` · `archived` | **11 valori**. Oltre ai due nudi/quotati: `planned`, `active`, `approved`, `proposed`, e **due righe di prosa intera** al posto di una parola (una di 96 caratteri che racconta una ratifica). Chi deve dire «bozza in attesa del CEO» lo scrive **nel corpo**, non nello stato |
| `visibility` | `public` · `private` | **3 valori**: c'è `internal` (7 volte), che non esiste. Va deciso se è `private` o `public` — non è la stessa cosa: `private` significa che il contenuto non può stare nel repo pubblico |
| `rag` | `exclude` · `public` · `private` | **4 valori**: c'è `rag_nexus` (6) e `internal` (1). `rag_nexus` è il **nome di un archivio**, non un livello: sta rispondendo a un'altra domanda |
| `priority` | `critical` · `high` · `medium` · `low` (dallo schema) | ⚠️ **contraddizione aperta**: `normal` è il più usato (62) e sta nel documento-modello, ma non è nello schema. Vedi sotto |
| `scope` | Lista. Valori: `oracode` · `os3-matrix` · `ecosystem` · **o il nome di un organo** (`egi`, `egi-hub`, `egi-credential`, `natan-loc`, `la-bottega`, `dimostralo`, `egi-info`, `egi-sigillo`, …) | **21 valori**, e uno è scritto male 45 volte: `scope: [dimostralo]` in linea invece che con il trattino a capo. In più `aws` e `nexus-cockpit`, che non sono organi: il primo è un fornitore, il secondo un componente |
| `doc_type` | `guide` · `spec` · `concept` · `architecture` · `registry` · `procedure` · `decision` · `capability` · `stub` — ratificati dal CEO il 2026-07-31, fonte `ssot-registry-schema.json` | 47 valori in giro |

**Vincolo di coerenza fra `visibility` e `rag`** (da `SSOT_HEADER_CONVENTION.md`): `rag: public`
richiede `visibility: public`. Un contenuto privato non entra nell'indice pubblico. Combinazioni
valide: `(public,exclude)`, `(public,public)`, `(public,private)`, `(private,exclude)`,
`(private,private)`.

### Campi a forma vincolata

| Campo | Forma | Cosa c'è oggi |
|---|---|---|
| `slug` | kebab-case: `^[a-z0-9][a-z0-9-]*$`. **Unico nel registro, immutabile dopo la creazione** | è la chiave che lega file e registro |
| `version` | Tre numeri: `X.Y.Z`, nudi | 122 corretti, 55 con le virgolette |
| `date` · `updated_at` | `'YYYY-MM-DD'`, **fra apostrofi singoli** | 123 corretti, ~50 con le virgolette doppie |
| `author` | `Nome Cognome (ruolo) for Fabio Cherici (CEO)` | **13 forme diverse** della stessa persona: `for` e `per`, con e senza `(CEO)`, con e senza virgolette, `(AI Partner OS3.0)` e `(Supervisor-CTO)`. Va scelta **una** forma |
| `supersedes` | Lista di percorsi assoluti. Vuota se non rimpiazza nulla | |
| `superseded_by` | Percorso assoluto, oppure `null` | `null` finché il documento è vivo |
| `title` | Testo leggibile. **Non** il nome del file, **non** uno slug | |

### `doc_type` — le nove parole, ratificate dal CEO il 2026-07-31

`guide` · `spec` · `concept` · `architecture` · `registry` · `procedure` · `decision` ·
`capability` · `stub`

**Fonte unica, ed è codice, non prosa:** `os3-matrix/nervous-system/ssot-registry-schema.json`,
campo `doc_type.enum`. È lo stesso file che legge `oracode-doctype-check`
(`jq '..|objects|select(has("doc_type"))|.doc_type.enum'`): il vocabolario **non si ricopia** qui
dentro come verità parallela — questo documento lo cita, lo schema lo definisce. La mappa dalle 36
parole vecchie alle 9 sta in `os3-matrix/contracts/doctype-migration-map.json` (M-OS3-185), scritta
per non ricostruire a mente perché un documento è passato da `concept-fondativo` a `concept`.

> **Nota di metodo, e vale la pena leggerla.** Prima di trovare lo schema avevo scritto qui un
> elenco «delle nove più frequenti» — `guide, spec, architecture, concept, capability, overview,
> checklist, audit, stub` — dichiarandolo candidato da ratificare. **Tre erano sbagliate**
> (`overview`, `checklist`, `audit` non sono nel vocabolario) e **tre mancavano** (`registry`,
> `procedure`, `decision`). La frequenza d'uso non è l'autorità: la frequenza misura anche gli
> errori, e più un errore è diffuso più sembra la regola.

## Lo stesso vale per gli altri campi: l'elenco sta nello SCHEMA

Il vincolo che rende `doc_type` verificabile è che il suo elenco vive in uno schema JSON letto da un
comando. **Deve valere per tutti e quattordici.** Oggi non è così: lo schema dichiara l'elenco solo
per `doc_type` e `priority` (più `check_frequency`, che è del registro).

| Campo | Elenco nello schema? | |
|---|---|---|
| `doc_type` | ✅ `enum` a 9 valori | verificabile |
| `priority` | ✅ `enum`: `critical` · `high` · `medium` · `low` | ⚠️ vedi sotto |
| `status` | ❌ assente | 11 valori in giro, incluse righe di prosa |
| `visibility` | ❌ assente | 3 valori: c'è `internal`, che non esiste |
| `rag` | ❌ assente | 4 valori: c'è `rag_nexus`, che è il nome di un archivio |
| `scope` | ❌ assente | 21 valori |
| `version` · `date` · `updated_at` · `slug` | ❌ nessun `pattern` | forma libera, virgolette a caso |
| `author` | ❌ assente | 13 forme della stessa persona |

**Debito da sanare, ed è il vero rimedio:** aggiungere allo schema l'`enum` (o il `pattern`) dei
dodici campi che non ce l'hanno. Non serve inventare un meccanismo nuovo — il comando che li
leggerebbe **esiste già** e funziona: è così che `doc_type` è l'unico campo quasi ovunque corretto.

### ⚠️ Una contraddizione da sciogliere, e non la sciolgo io

Lo schema ammette per `priority` i valori `critical` · `high` · `medium` · `low`. **`normal` non c'è**
— ma è il valore più usato (62 volte), ed è quello che porta `docs/aws/infrastructure.md`, cioè il
documento che il CEO ha indicato come forma corretta.

Delle due l'una: o lo schema aggiunge `normal`, o quei 62 documenti passano a `medium`. **Decide il
CEO.** Non la scelgo io, e finché non è decisa `priority` non è verificabile senza produrre 62 falsi
allarmi — che è il modo più rapido per far disattivare un controllo.

## Come si verifica

Un'intestazione conforme si controlla a macchina, non a occhio. Finché il comando dedicato non
esiste, il controllo minimo è: i dodici campi presenti, nell'ordine, con `status` nel vocabolario e
`updated_at` non più vecchio dell'ultimo commit che ha toccato il file.

**Debito dichiarato:** manca il comando che lo verifica e il gancio che blocca un commit su un
documento con intestazione non conforme. Senza quelli, questo standard vale quanto la buona volontà
di chi scrive — cioè quanto è valso finora.

## Cosa fare dei 601 documenti senza intestazione

Non si aggiungono in blocco con uno script: mettere un blocco `---` in cima a un file che non ce
l'ha **cambia la forma del documento**, e per 601 file cambierebbe in blocco senza che nessuno
guardi. Si fa per lotti, per repository, ognuno una mission con la sua verifica. Il primo lotto è
una decisione del CEO, non di chi scrive questo documento.

**La regola vale da oggi per tutto ciò che nasce o si tocca**: un documento nuovo nasce conforme, e
un documento che si modifica esce conforme. Così il numero scende senza un'operazione di massa.
