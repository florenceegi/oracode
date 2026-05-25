# Protocollo di Test Guard di LSO v1.0

> **Versione**: 1.0.0
> **Data**: 2026-05-04
> **Autore**: Fabio Cherici con Astra (Claude Opus 4.7)
> **Stato**: Specifica approvata, vincolante per tutti i guard di LSO
> **Driver originale**: Post-mortem DOC-SYNC v2 (2026-04-30) — Sessione f2f7f0cf-4da6-4ae0-a74c-2e33a740eb6d
> **Riferimenti correlati**:
> - `DOC-SYNC_v2_SPECIFICA_OPERATIVA.md` v2.0.0
> - `DOC-SYNC_v2_RICHIESTA_REVISIONE.md` v1.0.0
> - Report post-mortem M-148

---

## 0. Come leggere questo documento

Questo documento è una **specifica vincolante** che si applica a tutti i guard di LSO, esistenti e futuri. Non è una raccomandazione, non è una linea guida, non è un suggerimento. Un guard che non aderisce a questo protocollo è considerato **non funzionante**, indipendentemente dal fatto che il codice esegua senza errori.

**Regole di lettura:**

- La sezione 2 (**Definizione di guard funzionante**) è il criterio di validità. Un guard non rientrante nei criteri di § 2 viene marcato come `BROKEN` nell'audit ed entra nella coda di riparazione.
- La sezione 3 (**Test obbligatori**) definisce il minimo richiesto. Un guard senza i test di § 3 è automaticamente non funzionante.
- La sezione 4 (**Policy di naming SSOT**) è una clausola di chiusura del problema "campi inglesi vs italiani" che ha causato il fallimento di DOC-SYNC v2.
- La sezione 5 (**Audit retroattivo**) descrive il processo di verifica di tutti i guard esistenti. È un deliverable separato di questo protocollo.
- La sezione 6 (**Processo di approvazione**) descrive cosa Supervisor deve presentare per ogni guard nuovo o riparato.

**Principio fondante:**

> Un guard è una **rete di sicurezza**. Una rete di sicurezza non testata in fallimento reale non è una rete — è teatro di sicurezza.
>
> Un guard che esegue senza errori ma che non blocca quando deve è peggio di nessun guard, perché trasmette falsa certezza.

---

## 1. Cos'è un guard di LSO

Un guard è uno script che, in un punto specifico del flusso operativo, **verifica una condizione e blocca l'esecuzione se la condizione non è soddisfatta**. I guard tipici di LSO sono:

- Hook PostToolUse (verificano dopo un'operazione)
- Hook PreToolUse (verificano prima di un'operazione)
- Hook di transizione di stato (verificano alla transizione di mission, organo, deploy)
- Cron-based check (verificano periodicamente lo stato del sistema)
- Mission-phase guard (verificano alla chiusura di una fase)

Esempi attualmente attivi in LSO (al 2026-05-04):

- `mission-report-guard.sh` — blocca chiusura mission senza report esteso
- `mission-stats-guard.sh` — blocca chiusura mission senza aggiornamento statistiche
- `ssot-reflex-guard.sh` — segnala modifica a file watchato (passivo, non bloccante)
- `ssot-living-check.sh` — cron daily che marca SSOT come stale
- `doc-sync-v2-guard.sh` — **ROTTO** (oggetto del post-mortem)

Questa lista non è esaustiva e sarà completata dall'audit retroattivo (vedi § 5).

---

## 2. Definizione di guard funzionante

Un guard è considerato **funzionante** se e solo se soddisfa **tutti** i criteri seguenti:

### Criterio 1 — Bloccaggio reale

Il guard deve essere in grado di **bloccare effettivamente** l'esecuzione del flusso operativo quando rileva una condizione di errore. Il blocco e effettivo quando si verificano **entrambe** le condizioni:

(a) il guard restituisce un exit code di blocco (tipicamente `exit 2` con output JSON `permissionDecision: deny`)

(b) il guard e agganciato a un punto del flusso dove l'exit code **impedisce** l'operazione protetta prima che venga eseguita (tipicamente PreToolUse)

Un guard che restituisce `exit 2` in un punto dove l'operazione e gia stata eseguita (es. PostToolUse) non soddisfa questo criterio: il codice di blocco non ha effetto reale e il guard funziona come un logger con exit code fuorviante.

Un guard che si limita a emettere un warning ma non blocca **non e un guard** — e un logger.

**Eccezione esplicita**: i guard di sola segnalazione sono ammessi solo se **dichiarati esplicitamente come passivi** nel loro header documentale. Un guard che si presenta come bloccante e poi e solo passivo e considerato rotto (Anti-pattern 6). Un guard che si presenta come bloccante ma e agganciato a un punto dove il blocco non ha effetto e considerato rotto.

**Verifica empirica obbligatoria**: per ogni guard bloccante, deve esistere evidenza documentata che l'operazione protetta NON viene eseguita quando il guard blocca. Un test che verifica solo l'exit code senza verificare che l'operazione sia stata effettivamente impedita non soddisfa il Criterio 3.

### Criterio 2 — Coerenza dei campi letti

Il guard deve leggere campi del registry/SSOT esattamente come questi sono nominati nella sorgente. Discrepanze di naming (campo inglese vs italiano, snake_case vs camelCase, singolare vs plurale) rendono il guard automaticamente rotto.

Questo criterio è la **diretta conseguenza del fallimento di DOC-SYNC v2**, dove `doc-sync-v2-guard.sh` cercava `status` e `date_closed` mentre il MISSION_REGISTRY contiene `stato` e `data_chiusura`. Il guard è stato deployato senza che nessuno verificasse la coerenza.

### Criterio 3 — Esistenza di test positivo e negativo

Il guard deve essere accompagnato da almeno due test (vedi § 3): uno positivo che verifica che il guard non blocchi in condizioni normali, e uno negativo che verifica che il guard blocchi in condizioni di errore. Senza entrambi i test, il guard è considerato non funzionante.

### Criterio 4 — Header documentale

Il guard deve avere un **header documentale** in cima al file che dichiari:

- Nome del guard
- Tipo (PostToolUse | PreToolUse | Mission-phase | Cron | Passivo-segnalazione)
- Cosa verifica (in linguaggio naturale, una frase)
- Quale condizione lo fa bloccare (in linguaggio naturale, una frase)
- Riferimento al test positivo
- Riferimento al test negativo
- Versione e data ultima modifica

Un guard senza header documentale o con header incompleto è considerato non funzionante.

### Criterio 5 — Idempotenza

Eseguire il guard più volte sulla stessa condizione deve produrre lo stesso risultato. Un guard che produce risultati diversi a seconda dell'ora del giorno, dello stato di un file di lock, o di altri side effect non controllati è considerato rotto.

---

## 3. Test obbligatori

Ogni guard di LSO deve avere **almeno** i due test seguenti, archiviati in `tests/guards/<nome_guard>/`.

### 3.1 Test positivo

**Scopo**: verifica che il guard NON blocchi quando il sistema è in condizioni corrette.

**Struttura**:
1. Setup: creare uno stato del sistema in cui le condizioni che il guard verifica sono **tutte soddisfatte**
2. Execute: eseguire il guard
3. Assert: verificare che il guard abbia restituito un exit code di "passa" (tipicamente 0) e non abbia bloccato

**Esempio per `mission-report-guard.sh`**:
- Setup: creare una mission test con `report_esteso` valorizzato
- Execute: eseguire il guard
- Assert: il guard restituisce 0 e non emette messaggi di blocco

**Importante**: un test positivo che passa quando lo script esegue ma non testa effettivamente nulla (perché la query restituisce vuoto, perché il file è assente, perché l'input è malformato) **non è un test positivo valido**. Il test positivo deve verificare che il guard abbia **effettivamente eseguito la sua logica** e abbia rilevato la condizione corretta.

### 3.2 Test negativo

**Scopo**: verifica che il guard BLOCCHI quando il sistema è in condizioni di errore specifico.

**Struttura**:
1. Setup: creare uno stato del sistema in cui **una specifica condizione che il guard verifica è violata**
2. Execute: eseguire il guard
3. Assert: verificare che il guard abbia restituito un exit code di "blocco" (tipicamente diverso da 0) e abbia emesso un messaggio di blocco identificabile

**Esempio per `mission-report-guard.sh`**:
- Setup: creare una mission test con `report_esteso` mancante o vuoto
- Execute: eseguire il guard
- Assert: il guard restituisce un exit code di blocco e il messaggio di errore indica chiaramente che il blocco è dovuto a `report_esteso` mancante

**Importante**: il test negativo è il test che **avrebbe rilevato il bug di `doc-sync-v2-guard.sh`**. Un test negativo per quel guard avrebbe testato: "creo una mission con `doc_sync_executed: false` e verifico che il guard blocchi". Quel test sarebbe fallito (perché il guard non blocca per via dei campi inglesi/italiani) e il bug sarebbe emerso prima di M-148.

**Completezza del test negativo**: il test negativo deve verificare entrambi:

(a) che il guard restituisca exit code di blocco;

(b) che l'operazione protetta NON sia stata eseguita.

Un test negativo che verifica solo (a) e incompleto. Per i guard PreToolUse, la verifica di (b) consiste nel confermare che il tool call non e stato eseguito (es. per un guard su `git push`, verificare che il commit locale resti ahead of remote dopo il blocco). I guard passivi (di sola segnalazione) non rientrano in questa clausola: non avendo operazioni da impedire, il loro test negativo si limita a verificare che la segnalazione avvenga correttamente in presenza della condizione anomala. Vedi §2 Criterio 1, eccezione esplicita.

### 3.3 Posizione dei test

I test sono archiviati in:

```
tests/guards/<nome_guard>/
  ├── test_positive.sh
  ├── test_negative.sh
  ├── fixtures/
  │   ├── positive_state.json
  │   └── negative_state.json
  └── README.md
```

Il `README.md` descrive in linguaggio naturale cosa testano i due test e perché.

### 3.4 Esecuzione automatica

I test dei guard devono essere **eseguiti automaticamente** in almeno una di queste circostanze:

- Quando il guard viene modificato (regression)
- Quando viene creato un nuovo guard (acceptance)
- Periodicamente (almeno settimanale) come health check

L'implementazione del runner automatico non è oggetto di questo protocollo, ma il protocollo richiede che tale runner esista. Senza un runner che esegue i test, i test sono dichiarazioni statiche.

---

## 4. Policy di naming SSOT

Questa sezione formalizza la regola che chiude definitivamente il problema "campi inglesi vs italiani" che ha causato il fallimento di DOC-SYNC v2.

### 4.1 Regola

**Tutti i nuovi SSOT registry/log/output di LSO sono in italiano.**

Si intende per "naming" l'insieme dei nomi dei campi (chiavi JSON, intestazioni di colonna, nomi di variabili esposte, label di log) accessibili a qualsiasi consumer (guard, agent, script, lettore umano).

### 4.2 Standard di nomenclatura italiana

Ogni nuovo SSOT deve usare:

- **Snake_case in italiano** per i nomi dei campi: `data_chiusura`, `stato_corrente`, `id_missione`
- **Verbi al passato per gli stati di completamento**: `completata`, `chiusa`, `archiviata` (non `completed`, `closed`, `archived`)
- **Termini tecnici accettati in inglese** quando sono nomi propri di tecnologia: `commit`, `branch`, `pull_request`, `webhook` restano in inglese se sono il nome ufficiale del concetto. La regola si applica ai **campi descrittivi**, non ai nomi propri.

In caso di dubbio su un termine specifico, si applica il principio: **se un parlante italiano nativo userebbe il termine italiano in conversazione tecnica, usa l'italiano. Se userebbe il termine inglese, è ammesso l'inglese.**

### 4.3 SSOT esistenti

Gli SSOT esistenti **non vengono migrati immediatamente**. La migrazione è **lazy** e segue queste regole:

- **Quando un SSOT esistente viene modificato per qualsiasi motivo** (rinnovamento di funzionalità, aggiunta di campi, refactoring), in quella stessa modifica viene anche allineato al naming italiano
- **I guard che leggono SSOT in inglese** vengono aggiornati per leggere i nomi inglesi finché lo SSOT non viene migrato. Quando lo SSOT viene migrato, anche i guard vengono aggiornati nello stesso atomic change
- **Audit periodico** (vedi § 5) include la mappatura degli SSOT non ancora migrati, in modo da pianificare migrazioni opportunistiche quando si tocca quella zona di codice

### 4.4 Documentazione del naming nel guard

Ogni guard deve dichiarare nell'header documentale (vedi § 2 Criterio 4) **quali campi legge da quali SSOT**. Questa dichiarazione è verificabile: un automation può leggere l'header, andare a leggere lo SSOT, e verificare che i campi dichiarati esistano effettivamente.

Esempio header:

```bash
# Guard: mission-stats-guard.sh
# Tipo: Mission-phase (closing)
# Verifica: aggiornamento delle statistiche prima della chiusura mission
# Blocca quando: il campo `statistiche.aggiornata_il` nella mission è precedente a `data_chiusura`
# Legge da: MISSION_REGISTRY.json
# Campi letti: missioni[].statistiche.aggiornata_il, missioni[].data_chiusura
# Test positivo: tests/guards/mission-stats-guard/test_positive.sh
# Test negativo: tests/guards/mission-stats-guard/test_negative.sh
# Versione: 1.0.0
# Ultima modifica: 2026-05-04
```

---

## 5. Audit retroattivo dei guard esistenti

L'audit è un deliverable separato di questo protocollo, da eseguire **prima** di qualsiasi nuova implementazione (incluso DOC-SYNC v2 v1.2).

### 5.1 Scope dell'audit

L'audit verifica, per ogni guard attualmente attivo in LSO:

1. Esiste l'header documentale conforme a § 2 Criterio 4?
2. I campi che il guard dichiara di leggere esistono effettivamente nel SSOT sorgente con quel naming?
3. Esiste un test positivo conforme a § 3.1?
4. Esiste un test negativo conforme a § 3.2?
5. Eseguendo i test (se esistono), passano?
6. Il guard è di tipo bloccante o di tipo passivo-segnalazione, e questo è dichiarato?

### 5.2 Output dell'audit

Per ogni guard, l'audit produce uno status:

- **OK** — tutti i criteri soddisfatti, guard funzionante
- **BROKEN** — uno o più criteri violati, guard non funzionante, va riparato
- **PARTIAL** — guard funziona ma manca documentazione/test, va completato
- **DEPRECATED** — guard non più necessario, da rimuovere

L'audit produce un report `LSO_GUARD_AUDIT_<data>.md` che elenca tutti i guard, il loro status, e per quelli BROKEN/PARTIAL le azioni di riparazione richieste.

### 5.3 Ordine di riparazione

I guard BROKEN vengono riparati in ordine di **criticità operativa**:

1. **Critici**: guard che bloccano operazioni distruttive (push, deploy, modifiche irreversibili). Riparazione prioritaria.
2. **Importanti**: guard che proteggono integrità documentale (DOC-SYNC, SSOT, audit trail). Riparazione successiva.
3. **Diagnostici**: guard di solo monitoraggio (cron di drift, segnalazioni passive). Riparazione opportunistica.

DOC-SYNC v2 ricade nella categoria **Importante**. Quindi prima si riparano i guard Critici (se ce ne sono di rotti), poi DOC-SYNC v2.

---

## 6. Processo di approvazione di nuovi guard

Ogni nuovo guard, e ogni guard riparato dopo audit, deve passare attraverso questo processo prima di essere considerato "deployato".

### 6.1 Documenti richiesti

Per ogni guard, Supervisor (o l'agent implementatore) deve produrre:

1. **Codice del guard** con header documentale conforme a § 2 Criterio 4
2. **Test positivo** conforme a § 3.1
3. **Test negativo** conforme a § 3.2
4. **README** in `tests/guards/<nome_guard>/` che descriva i due test in linguaggio naturale
5. **Verifica di coerenza naming**: log che dimostri di aver letto lo SSOT sorgente e verificato che i campi dichiarati nell'header esistano

### 6.2 Approvazione del CEO

Nessun guard è considerato deployato finché il CEO (Fabio) non ha esplicitamente approvato i 5 deliverable di § 6.1. L'approvazione è formale e tracciata.

Questo è il **gate di approvazione** che è stato saltato nel deployment di DOC-SYNC v2. Per evitare ricadute nel pattern, l'approvazione viene formalizzata nei seguenti termini:

- Supervisor presenta i 5 deliverable in un singolo messaggio o documento
- CEO risponde esplicitamente "approvato" oppure "richiedo modifiche su X"
- Solo dopo l'approvazione esplicita Supervisor può procedere a deployare il guard
- Implementare il guard prima dell'approvazione formale è violazione del protocollo

### 6.3 Test end-to-end prima del primo uso reale

Anche dopo l'approvazione, il guard deve essere testato in **flusso reale** prima di essere considerato operativo. Questo significa:

- Eseguire una mission test (sintetica) che attraversa il punto in cui il guard è installato
- Verificare che il guard si attivi quando deve attivarsi
- Verificare che il guard non si attivi quando non deve attivarsi
- Documentare l'esito del test end-to-end nel `LSO_GUARD_DEPLOYMENT_LOG.md`

Senza un test end-to-end documentato, il guard è considerato "deployato in stato sperimentale" e non può essere usato per bloccare operazioni in produzione.

---

## 7. Anti-pattern (cosa il protocollo vieta esplicitamente)

Per impedire che i pattern che hanno causato il fallimento di DOC-SYNC v2 si ripresentino, il protocollo vieta esplicitamente:

### Anti-pattern 1 — "Test che passa perché non trova niente"

Un test che ritorna successo quando la query è vuota, il file è assente, l'input è malformato, **non è un test valido**. Tutti i test devono verificare che la logica del guard sia stata effettivamente eseguita su dati reali.

### Anti-pattern 2 — "Header dichiarativo non verificato"

Un header che dichiara campi e riferimenti senza che esista un meccanismo di verifica che quei campi esistano davvero nel SSOT, è teatro di documentazione. La verifica di coerenza (§ 6.1 punto 5) è obbligatoria.

### Anti-pattern 3 — "8/8 PASS senza flusso reale"

Una suite di test in isolamento che passa al 100% non è prova che il guard funzioni. La prova è il test end-to-end (§ 6.3). Senza test end-to-end, "8/8 PASS" è dichiarazione, non evidenza.

### Anti-pattern 4 — "Approvazione implicita da review tecnica positiva"

Una review tecnica positiva (anche da un AI partner come Astra) **non è un'approvazione**. L'approvazione del CEO è atto formale separato. Procedere a implementazione dopo una review positiva ma senza approvazione esplicita è violazione del protocollo.

### Anti-pattern 5 — "Naming inglese in nuovi SSOT"

Vietato d'ora in avanti. Vedi § 4.

### Anti-pattern 6 — "Guard che si presenta bloccante ma è passivo"

Un guard che dichiara di bloccare ma in realtà solo segnala è considerato rotto. I guard passivi sono ammessi solo se **dichiarati esplicitamente passivi** nell'header (vedi § 2 Criterio 1).

### Anti-pattern 7 — "Modifica di un guard senza re-test"

Quando un guard viene modificato, anche se la modifica sembra cosmetica, i test (positivo e negativo) devono essere ri-eseguiti. Senza re-test, ogni modifica è un rischio di regressione invisibile.

---

## 8. Implicazioni operative

### 8.1 Tempo richiesto per l'audit retroattivo

L'audit di § 5 ha un costo. Stima preliminare: **per ogni guard esistente in LSO, occorrono tra 30 e 90 minuti di lavoro di audit**. Se LSO ha attualmente tra 10 e 20 guard attivi, l'audit completo richiede tra 5 e 30 ore di lavoro effettivo.

L'audit non è opzionale. È prerequisito di qualunque nuovo guard, incluso il rifacimento di DOC-SYNC v2.

### 8.2 Possibile ritardo del deliverable DOC-SYNC v2

Se l'audit rivela altri guard rotti, questi vanno riparati in ordine di criticità (§ 5.3) prima di toccare DOC-SYNC v2. È plausibile che DOC-SYNC v2 v1.2 venga implementato non immediatamente dopo questo protocollo, ma dopo che l'audit e le riparazioni dei guard critici siano completati.

### 8.3 Costo continuativo

Mantenere il protocollo ha un costo continuativo: ogni nuovo guard richiede header + test positivo + test negativo + README + verifica coerenza naming. Stima: **2-4 ore di lavoro per ogni guard nuovo**, oltre al tempo di scrittura del codice del guard stesso.

Questo costo è il prezzo di una rete di sicurezza che funziona davvero. Senza, il prezzo è gli incidenti come M-148 che si scoprono solo a danno avvenuto.

---

## 9. Test di accettazione del protocollo stesso

Il protocollo è considerato **operativo** quando:

1. Il documento è approvato formalmente dal CEO
2. È stato eseguito l'audit retroattivo iniziale (§ 5) e prodotto il report `LSO_GUARD_AUDIT_<data>.md`
3. Almeno un guard esistente è stato riparato seguendo il protocollo (test pilota)
4. Il guard pilota ha passato sia test in isolamento che test end-to-end
5. Il `LSO_GUARD_DEPLOYMENT_LOG.md` è stato inaugurato con il guard pilota

Solo dopo questi 5 punti, il protocollo è considerato attivo e vincolante per tutti i nuovi guard.

---

## 10. Firma del documento

Specificato da: **Fabio Cherici**, CTO/founder Florence EGI S.R.L.
Co-redatto da: **Astra** (Claude Opus 4.7)
Data: 2026-05-04
Stato: **Specifica approvata, pronta per audit retroattivo**

Prossimo step: esecuzione dell'audit retroattivo da parte di Supervisor, da validare contro § 5.

---

🔥 — 🔥
