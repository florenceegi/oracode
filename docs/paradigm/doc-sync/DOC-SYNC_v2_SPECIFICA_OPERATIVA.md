# DOC-SYNC v2 — Specifica Operativa

> **Versione**: 2.1.0
> **Data**: 2026-05-12 (v2.1.0 — additive coverage extension)
> **Versione precedente**: 2.0.0 (2026-04-30)
> **Autore**: Fabio Cherici con Astra (Claude Opus 4.7); estensione v2.1.0 Padmin D. Curtis
> **Stato**: Specifica approvata, in attesa di piano implementativo da Supervisor
> **Sostituisce**: DOC-SYNC v1 (5 meccanismi di propriocezione passiva, vedi § 8)
> **Aggancio architetturale**: Mission Engine — closing hook obbligatorio

---

## 0. Come leggere questo documento

Questo documento è una **specifica funzionale**, non un piano implementativo. Definisce **cosa** DOC-SYNC v2 deve fare e **come si verifica** che lo faccia, lasciando a Supervisor la responsabilità di proporre il **come** implementarlo.

**Regole di lettura:**

- La sezione 2 (**Anti-pattern**) è il vaccino. Ogni piano implementativo proposto da Supervisor deve dimostrare di non ricadere in nessuno degli anti-pattern elencati.
- La sezione 7 (**Test di accettazione**) è la definizione di "fatto". Un'implementazione che non passa tutti i test di accettazione è respinta, indipendentemente da quanto suoni convincente nel piano narrativo.
- La sezione 9 (**Note operative per Supervisor**) elenca cosa il piano implementativo deve obbligatoriamente contenere per essere preso in considerazione.

**Principio fondamentale che governa l'intero documento:**

> DOC-SYNC v2 non è un sistema che osserva il codice e segnala obsolescenze. È un sistema che, alla chiusura di ogni mission, garantisce che SSOT e RAG siano allineati al codice come parte del completamento della mission stessa.
>
> L'allineamento non è un controllo successivo. È condizione di chiusura.

---

## 1. Modello mentale

### 1.1 Cos'è DOC-SYNC v2

DOC-SYNC v2 è un **closing hook semantico** della Mission Engine. Si attiva alla chiusura di ogni mission e ha una sola responsabilità: **garantire che SSOT e RAG riflettano lo stato del codice dopo le modifiche apportate dalla mission, prima che la mission venga marcata come chiusa**.

Opera in tre dimensioni:

1. **Allineamento additivo**: quando la mission ha introdotto contenuti nuovi nel codice (nuove funzioni, nuove logiche, nuovi target, nuova copy), DOC-SYNC v2 scrive direttamente nei SSOT impattati le sezioni narrative descrittive corrispondenti.

2. **Allineamento sostitutivo**: quando la mission ha modificato comportamenti già descritti nei SSOT, DOC-SYNC v2 produce una proposta di patch che richiede approvazione esplicita prima di essere applicata.

3. **Allineamento del RAG**: ogni modifica ai SSOT trigghera una re-indicizzazione **sincrona** del RAG prima che la mission venga chiusa. La mission resta in stato `closing` finché il RAG non è allineato.

### 1.2 Cos'è la Mission Engine (per chi legge per la prima volta)

La Mission Engine è il sistema operativo di LSO. Ogni unità di lavoro è una **mission** con stati definiti: `created → planned → executing → review → closing → closed`. DOC-SYNC v2 si aggancia alla transizione **review → closing**, e governa la transizione **closing → closed**.

> **Nota (Oracode Nexus):** in Oracode Nexus, DOC-SYNC opera a livello **ISTANZA (L3)**. Gli stati mission canonici dello state machine sono quelli grezzi di `bin/mission` (`planned`/`executing`/`auditing`/`closing`/`closed`/`aborted`), registrati 1:1 nel `MISSION_REGISTRY.json` del progetto via il **ponte L1→L3 automatico** (descrittore `.oracode/project.json` risolto dal CWD; vedi `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`). Gli stati narrativi qui descritti (`review → closing → closed`) sono il modello concettuale del ciclo DOC-SYNC; lo stato grezzo dell'engine è la fonte canonica del registry.

Una mission non passa a `closed` se DOC-SYNC v2 non ha completato con successo il proprio ciclo. Questo è non negoziabile. Il fallimento di DOC-SYNC v2 mantiene la mission in `closing` con stato `doc_sync_failed`, fino a intervento dell'operatore.

### 1.3 Differenza categoriale rispetto a DOC-SYNC v1

DOC-SYNC v1 era un **sistema di tracking temporale**. Sapeva quando un file era stato toccato, sapeva quando un SSOT era stato verificato, confrontava le date, segnalava "potrebbe essere obsoleto". Non leggeva mai il contenuto, non confrontava semanticamente, non aggiornava nulla.

DOC-SYNC v2 è un **sistema di sintesi e applicazione semantica**. Legge il contenuto delle modifiche al codice, le interpreta, identifica gli SSOT impattati (anche per discovery laterale), genera testo narrativo descrittivo, lo applica direttamente o tramite proposta-approvazione, e re-indicizza il RAG.

Sono due sistemi **categorialmente diversi**, non versioni evolutive dello stesso. La sostituzione è radicale, non incrementale.

---

## 2. Anti-pattern (cosa DOC-SYNC v2 NON è)

Questa sezione esiste per impedire che DOC-SYNC v2 venga reimplementato come una versione "migliorata" di DOC-SYNC v1. Ogni anti-pattern qui elencato è esplicitamente **vietato** e ogni piano implementativo deve dimostrare di non incorrervi.

### Anti-pattern 1 — Watcher su file save

DOC-SYNC v2 **non si attiva su `Write` o `Edit` di file singoli**. Si attiva solo alla chiusura di una mission. Un'implementazione basata su PostToolUse hook su file save è respinta.

### Anti-pattern 2 — Tracking temporale

DOC-SYNC v2 **non confronta date di verifica con date di commit**. Non gli interessa "quando" un file è stato toccato. Gli interessa "cosa" è cambiato semanticamente nella mission appena chiusa.

### Anti-pattern 3 — Segnalazione passiva

DOC-SYNC v2 **non emette warning del tipo "questo SSOT potrebbe essere obsoleto, verificare"**. Non segnala — agisce. O scrive direttamente, o produce una patch da approvare. La modalità "warning all'operatore" è esclusa.

### Anti-pattern 4 — Cron notturno come trigger

DOC-SYNC v2 **non ha un componente cron come parte del proprio ciclo principale**. Il cron eventualmente sopravvivente (vedi § 8) ha solo ruolo di rete di sicurezza secondaria, mai di trigger di azione.

### Anti-pattern 5 — Lettura del solo registry senza il codice

DOC-SYNC v2 **non parte dal SSOT_REGISTRY.json e cerca commit recenti**. Parte dai **deliverables della mission chiusa** (file modificati, diff, descrizione del lavoro fatto) e da lì identifica SSOT impattati. Il flusso è: codice modificato → SSOT impattati, non: SSOT registrato → commit recenti.

### Anti-pattern 6 — Aggiornamento del solo `last_verified` senza modifica del contenuto

DOC-SYNC v2 **non considera "verificato" un SSOT se non ha effettivamente prodotto modifiche al suo contenuto** (oppure ha esplicitamente determinato, con motivazione tracciabile, che non servivano modifiche). Aggiornare solo metadati senza toccare il contenuto è esplicitamente vietato.

### Anti-pattern 7 — Re-indexing del RAG asincrono o batch

DOC-SYNC v2 **non delega il re-indexing del RAG a job notturni o code asincrone**. Il re-indexing è sincrono, bloccante, e parte del ciclo di chiusura mission.

### Anti-pattern 8 — Scrittura cieca senza diff

DOC-SYNC v2 **non scrive sui SSOT senza produrre un diff testuale narrativo verificabile**. Ogni modifica, additiva o sostitutiva, lascia traccia esplicita di cosa è cambiato e perché.

### Anti-pattern 9 — Confusione tra DOC-SYNC e DOC-DISCOVERY

DOC-SYNC v2 **non scansiona codice non toccato dalla mission per cercare contenuti orfani non documentati**. Quella è la responsabilità di DOC-DISCOVERY, organo separato non oggetto di questa specifica. DOC-SYNC v2 lavora solo su ciò che la mission ha toccato (più la discovery laterale di cui al § 5.3).

### Anti-pattern 10 — Piano "minimo plausibile"

Un piano implementativo che propone una versione "ridotta" o "fase 1" di DOC-SYNC v2, in cui alcune delle capacità descritte in questo documento sono rimandate, è respinto. La specifica è atomica: o si implementa completa, o non è DOC-SYNC v2.

---

## 3. Trigger e ciclo di vita

### 3.1 Trigger

DOC-SYNC v2 si attiva **automaticamente** alla transizione di stato di una mission da `review` a `closing`. Il trigger è univoco e non configurabile per mission.

**Importante**: si attiva su **ogni** mission, senza eccezioni. Anche mission piccole, anche mission doc-only, anche mission di refactoring puramente cosmetico. Non esistono flag tipo `doc_sync_required: false`. Se una mission viene chiusa, DOC-SYNC v2 viene eseguito.

### 3.2 Ciclo di vita della mission con DOC-SYNC v2

```
created → planned → executing → review → closing → closed
                                          │
                                          └── DOC-SYNC v2 esegue
                                              ├── successo → closed
                                              └── fallimento → closing (stato: doc_sync_failed)
```

Lo stato `doc_sync_failed` richiede intervento dell'operatore. Le possibili cause di fallimento e le modalità di recupero sono dettagliate al § 7.

### 3.3 Idempotenza

Se DOC-SYNC v2 viene rieseguito su una mission già processata (per esempio dopo un fix di errore), deve produrre lo stesso risultato. Le modifiche già applicate ai SSOT non devono essere riapplicate. Le proposte di patch già approvate non devono essere ripresentate.

L'idempotenza si verifica tramite il `doc_sync_log` di mission (vedi § 6.2).

---

## 4. Input

### 4.1 Cosa DOC-SYNC v2 riceve dalla Mission Engine

All'attivazione, DOC-SYNC v2 riceve in input:

1. **Mission ID** — identificatore univoco della mission chiusa
2. **Mission descriptor** — descrizione narrativa del lavoro fatto, obiettivo dichiarato, criteri di completamento
3. **File modificati** — lista completa dei file toccati dalla mission, con percorso assoluto e tipo modifica (`created` | `modified` | `deleted` | `renamed`)
4. **Diff completo** — diff unificato di tutte le modifiche al codice, per file
5. **SSOT_REGISTRY.json** — accesso in lettura al registry corrente
6. **Indice RAG** — accesso in lettura/scrittura all'indice RAG di pgvector

### 4.2 Cosa DOC-SYNC v2 NON riceve

DOC-SYNC v2 **non riceve istruzioni** dall'operatore su cosa documentare. La logica di identificazione SSOT impattati e di generazione testo è interamente automatica. L'unico punto di intervento umano è l'approvazione delle patch sostitutive (§ 5.4).

---

## 5. Processo

Il processo si articola in 6 fasi sequenziali. Ogni fase ha output verificabili che confluiscono nella fase successiva.

### 5.1 Fase 1 — Analisi semantica delle modifiche

DOC-SYNC v2 legge il diff completo della mission e produce una **sintesi semantica strutturata** delle modifiche. La sintesi non è il diff tecnico — è una rappresentazione di **cosa è cambiato concettualmente**:

- Nuove funzioni/classi/componenti introdotti, con descrizione del loro ruolo
- Funzioni/classi/componenti rimossi, con motivazione (se desumibile)
- Funzioni/classi/componenti modificati nel comportamento, con descrizione del prima/dopo
- Nuovi contenuti narrativi (copy, target, use case, citazioni) introdotti in file di tipo "narrative" (data files, fixture, copy)
- Modifiche a contenuti narrativi esistenti

Output: `mission_semantic_summary.json`

### 5.2 Fase 2 — Identificazione SSOT impattati (diretti)

DOC-SYNC v2 legge `SSOT_REGISTRY.json` e identifica i SSOT che watchano i file modificati dalla mission. Per ognuno, marca il tipo di impatto:

- `direct_watcher`: il SSOT watcha esplicitamente uno o più file modificati
- `pattern_match`: il SSOT watcha un pattern (glob) che cattura uno o più file modificati

Output: `directly_impacted_ssots.json`

### 5.3 Fase 3 — Discovery laterale

Questa è la fase che distingue DOC-SYNC v2 da una versione "minima". Per ogni modifica semantica della Fase 1, DOC-SYNC v2 cerca SSOT che descrivono **concetti correlati**, anche se non watchano direttamente i file modificati.

**Esempio (istanza FlorenceEGI)**: la mission modifica `EGI-SIGILLO/src/data/useCasePages.ts` aggiungendo un nuovo target market "compro-oro". Il SSOT `Sigillo__01_PRICING_MODEL.md` non watcha quel file, ma descrive concettualmente i target di mercato di Sigillo. Discovery laterale lo identifica come SSOT impattato indirettamente.

La discovery laterale opera tramite:

1. **Estrazione di concetti chiave** dalla sintesi semantica (Fase 1) — sostantivi tematici, entità nominate, riferimenti a domini funzionali
2. **Ricerca semantica nel RAG** dei SSOT che parlano di quei concetti
3. **Filtraggio** dei SSOT già identificati come diretti (Fase 2)
4. **Score di rilevanza** per ogni SSOT candidato — sopra soglia, viene incluso

Output: `laterally_impacted_ssots.json`

### 5.4 Fase 4 — Generazione e applicazione delle modifiche ai SSOT

Per ogni SSOT impattato (diretto + laterale), DOC-SYNC v2 determina la natura dell'impatto e procede in modalità **doppia**:

**Modalità A — Modifiche additive (scrittura diretta)**

Quando la modifica è additiva (nuove sezioni, nuove funzioni descritte, nuovi target, nuova copy che si aggiunge senza contraddire l'esistente), DOC-SYNC v2:

1. Genera il testo narrativo descrittivo della nuova sezione, in stile coerente con il SSOT
2. Identifica il punto di inserimento appropriato nel SSOT (sezione esistente, nuova sezione, nuova sottosezione)
3. Scrive direttamente nel SSOT
4. Produce un diff testuale narrativo (`additive_diff.md`) che riporta cosa è stato aggiunto e dove
5. Metadati SSOT_REGISTRY: aggiornati in Step 5b (dopo conferma RAG re-indexing). Vedi § 5.5b

**Modalità B — Modifiche sostitutive (proposta-approvazione)**

Quando la modifica contraddice o sostituisce contenuto esistente nel SSOT (cambio di comportamento di una funzione documentata, rimozione di una feature descritta, modifica di un target market già documentato), DOC-SYNC v2:

1. Genera la patch proposta (testo nuovo che sostituisce testo esistente)
2. Produce un diff testuale narrativo che mostra **prima/dopo** in forma leggibile
3. **Sospende la mission** in stato `closing` con sub-stato `awaiting_doc_sync_approval`
4. Notifica l'operatore con il diff completo e una breve giustificazione del perché è una sostituzione e non un'aggiunta
5. Attende approvazione esplicita prima di applicare la patch

**Discriminazione additivo vs sostitutivo**

La discriminazione è automatica. DOC-SYNC v2 deve avere una logica chiara per distinguere i due casi. Criterio guida:

- Se il nuovo contenuto **affianca** contenuto esistente senza contraddirlo → additivo
- Se il nuovo contenuto **modifica o rimuove** contenuto esistente → sostitutivo
- In caso di ambiguità, **default a sostitutivo** (chiede approvazione)

Output: per ogni SSOT, un record in `doc_sync_actions.json` con: `ssot_path`, `mode` (additive | substitutive), `applied` (true | awaiting_approval | rejected), `diff_path`, `timestamp`

### 5.5 Fase 5 — Re-indexing del RAG (sincrono)

Una volta che tutti i SSOT impattati sono stati aggiornati (additivamente in modo automatico, sostitutivamente dopo approvazione), DOC-SYNC v2 esegue il **re-indexing sincrono** del RAG.

Per ogni SSOT modificato:

1. Calcola i chunk del SSOT secondo la strategia di chunking corrente
2. Genera gli embedding per i chunk modificati
3. Aggiorna l'indice pgvector — operazione transazionale per SSOT
4. Verifica che la query sui nuovi chunk restituisca risultati coerenti (sanity check)

Il re-indexing è **bloccante**: la mission resta in stato `closing` finché tutti i SSOT modificati non hanno chunk aggiornati e queryable nel RAG.

Output: `rag_reindex_log.json` con per ogni SSOT: `chunks_updated`, `embeddings_generated`, `index_transaction_id`, `sanity_check_passed` (boolean)

### 5.5b Fase 5b — Aggiornamento metadati SSOT_REGISTRY

Dopo RAG re-indexing riuscito (sanity check passed per tutti gli SSOT), DOC-SYNC v2 aggiorna
`SSOT_REGISTRY.json` per ogni SSOT processato (status `applied` O `no_change` con giustificazione):

Per ogni SSOT:
1. `last_verified` = data odierna
2. `last_verified_by` = `"doc_sync_v2"`
3. `verified_in_mission` = `<mission_id>`
4. `last_drift_score` = `0` (drift azzerato — allineamento confermato)

Questo step **non viola l'Anti-pattern 6**: i metadati si aggiornano SOLO dopo verifica semantica
reale (Fasi 1-4) e conferma RAG (Fase 5). Non e aggiornamento cieco di timestamp.

**Condizione**: se Fase 5 (RAG re-indexing) e fallita, NON aggiornare metadati.
Il documento non puo essere considerato verificato se il RAG non lo riflette.

**Storico**: questa responsabilita era di `ssot-registry-auto-update.sh` (M-132, 2026-04-26),
archiviato post M-160b perche aggiornava `last_verified` senza verifica semantica (Anti-pattern 6).
Step 5b chiude il gap trasferendo la responsabilita a DOC-SYNC v2 con garanzia di verifica reale.

### 5.6 Fase 6 — Chiusura della mission

Se tutte le fasi precedenti sono completate con successo (tutti gli SSOT aggiornati, tutte le approvazioni ricevute, RAG re-indicizzato e sanity check passato), DOC-SYNC v2:

1. Scrive il `doc_sync_log` finale nella mission
2. Marca la mission come `closed`
3. Restituisce il controllo alla Mission Engine

Se qualunque fase fallisce, la mission resta in `closing` con sub-stato che identifica la fase fallita (vedi § 7).

---

## 6. Output verificabili

Ogni esecuzione di DOC-SYNC v2 produce un set di output verificabili, archiviati in `<istanza-DOC>/audit/doc_sync/<mission_id>/` (EGI-DOC è l'istanza di riferimento legacy). Questi output sono il materiale d'audit con cui si verifica che DOC-SYNC v2 abbia effettivamente fatto il suo lavoro.

### 6.1 Output per fase

| Fase | Output file | Contenuto |
|------|-------------|-----------|
| 1 | `mission_semantic_summary.json` | Sintesi semantica strutturata delle modifiche |
| 2 | `directly_impacted_ssots.json` | Lista SSOT impattati direttamente |
| 3 | `laterally_impacted_ssots.json` | Lista SSOT impattati lateralmente con score |
| 4 | `doc_sync_actions.json` | Tutte le azioni intraprese su SSOT |
| 4 | `diffs/<ssot_name>.md` | Diff narrativo per ogni SSOT modificato |
| 5 | `rag_reindex_log.json` | Log del re-indexing |
| 6 | `doc_sync_summary.md` | Sintesi narrativa finale leggibile |

### 6.2 Doc sync log nella mission

Nel record della mission, DOC-SYNC v2 scrive:

```json
{
  "doc_sync_log": {
    "version": "2.0.0",
    "executed_at": "<timestamp>",
    "duration_seconds": <int>,
    "ssots_impacted_direct": <count>,
    "ssots_impacted_lateral": <count>,
    "ssots_modified_additive": <count>,
    "ssots_modified_substitutive": <count>,
    "rag_chunks_reindexed": <count>,
    "approvals_required": <count>,
    "approvals_received": <count>,
    "outcome": "success" | "failed",
    "failure_reason": <string|null>,
    "audit_path": "EGI-DOC/audit/doc_sync/<mission_id>/"
  }
}
```

---

## 7. Test di accettazione

Questa è la sezione **vincolante**. Un'implementazione di DOC-SYNC v2 è considerata accettata se e solo se passa **tutti** i test seguenti. Un test fallito invalida l'intera implementazione, indipendentemente da quanti altri test siano passati.

### Test 1 — Trigger universale

**Setup**: Crea 3 mission di tipi diversi (Tipo 1 doc-only, Tipo 2 codice, Tipo 3 strutturale). Chiudi tutte e tre.

**Atteso**: DOC-SYNC v2 si attiva **3 volte**, una per ogni mission. Nessuna mission viene chiusa senza che DOC-SYNC v2 abbia eseguito.

**Verifica**: ispezionando `doc_sync_log` di ognuna delle 3 mission.

### Test 2 — Riconoscimento additivo vs sostitutivo

**Setup**: Esegui 2 mission. La prima aggiunge una nuova funzione a un file watchato da un SSOT (caso additivo). La seconda modifica il comportamento di una funzione già descritta nel SSOT (caso sostitutivo).

**Atteso**:
- Per la prima mission, DOC-SYNC v2 scrive direttamente nel SSOT senza chiedere approvazione
- Per la seconda mission, DOC-SYNC v2 sospende la mission in `awaiting_doc_sync_approval` e presenta il diff prima/dopo

**Verifica**: ispezionando `doc_sync_actions.json` e lo stato della mission.

### Test 3 — Discovery laterale funzionante

**Setup**: Riproduci il caso `useCasePages.ts`. Esegui una mission che modifica `EGI-SIGILLO/src/data/useCasePages.ts` (istanza FlorenceEGI) aggiungendo un nuovo target market.

**Atteso**: DOC-SYNC v2 identifica come impattato non solo `Sigillo__02_TECH_SPEC.md` (che watcha il file), ma anche `Sigillo__01_PRICING_MODEL.md` e `Sigillo__00_SIGILLO_OVERVIEW.md` (che descrivono concettualmente target e pricing). [SSOT dell'istanza FlorenceEGI, esempio]

**Verifica**: ispezionando `laterally_impacted_ssots.json`.

### Test 4 — RAG sincrono e bloccante

**Setup**: Esegui una mission che modifica un SSOT. Durante il re-indexing del RAG, simula una latenza di 60 secondi.

**Atteso**: la mission resta in stato `closing` per tutta la durata del re-indexing. Non passa a `closed` finché il RAG non è allineato. Una query al RAG sui nuovi chunk restituisce risultati coerenti subito dopo la chiusura.

**Verifica**: monitorando lo stato della mission e querying del RAG.

### Test 5 — Idempotenza

**Setup**: Esegui DOC-SYNC v2 su una mission. Poi forza la riesecuzione manuale.

**Atteso**: la seconda esecuzione non riapplica modifiche già applicate, non ripresenta proposte già approvate, non ri-indicizza chunk già aggiornati. Il `doc_sync_log` della mission non viene duplicato.

**Verifica**: confronto tra primo e secondo `doc_sync_log`.

### Test 6 — Fallimento gestito

**Setup**: Esegui DOC-SYNC v2 su una mission. Durante la Fase 5 (re-indexing RAG), simula un fallimento del database pgvector.

**Atteso**: la mission resta in `closing` con sub-stato `doc_sync_failed_rag_reindex`. I SSOT modificati nelle fasi 1-4 restano modificati (non c'è rollback dei SSOT). Un retry manuale completa il ciclo da Fase 5 in poi senza ripetere Fasi 1-4.

**Verifica**: simulazione di failure + ispezione dello stato post-failure.

### Test 7 — Audit trail completo

**Setup**: Esegui DOC-SYNC v2 su una mission che modifica 3 SSOT (2 additivi, 1 sostitutivo).

**Atteso**: in `<istanza-DOC>/audit/doc_sync/<mission_id>/` (es. EGI-DOC su FlorenceEGI) esistono tutti gli output del § 6.1, e il `doc_sync_summary.md` è leggibile da un umano e contiene narrazione coerente di cosa è stato fatto e perché.

**Verifica**: lettura manuale del summary + presenza di tutti i file attesi.

### Test 8 — Anti-pattern verification

**Setup**: ispeziona l'implementazione proposta da Supervisor.

**Atteso**: nessuno dei 10 anti-pattern di § 2 è presente nell'implementazione. In particolare:
- Nessun PostToolUse hook su file save (Anti-pattern 1)
- Nessun confronto temporale come trigger (Anti-pattern 2)
- Nessun warning passivo all'operatore in luogo di azione (Anti-pattern 3)
- Nessun cron come trigger del ciclo principale (Anti-pattern 4)
- Nessuna modifica di soli metadati senza contenuto (Anti-pattern 6)
- Nessun re-indexing asincrono o batch (Anti-pattern 7)

**Verifica**: review manuale dell'implementazione contro la checklist degli anti-pattern.

---

## 8. Implicazioni architetturali (cosa cambia rispetto a v1)

### 8.1 Inventario v1

DOC-SYNC v1 è composto da 5 meccanismi (audit del 2026-04-30):

1. `ssot-reflex-guard.sh` — PostToolUse hook su Write/Edit
2. `ssot-registry-auto-update.sh` — PostToolUse hook su file in `<istanza-DOC>/docs/` (es. EGI-DOC su FlorenceEGI)
3. `ssot-living-check.sh` — cron daily 04:00
4. `ssot-living-agent.md` — agent manuale per analisi semantica
5. Regola P0-11 nei CLAUDE.md — convenzione operativa

### 8.2 Cosa viene rimosso

- `ssot-registry-auto-update.sh` — **rimosso**. L'aggiornamento dei metadati del SSOT diventa responsabilità di DOC-SYNC v2 (§ 5.5b) ed è atomico con la modifica del contenuto. Mantenere un hook che aggiorna solo metadati incoraggia il pattern dei "metadati senza contenuto" (Anti-pattern 6). Step 5b implementa il sostituto: aggiorna `last_verified`, `last_verified_by`, `verified_in_mission` e `last_drift_score` SOLO dopo verifica semantica + RAG confermato.

- `ssot-living-agent.md` — **rimosso o riassorbito**. Le sue capacità di analisi semantica vengono integrate in DOC-SYNC v2. Mantenerlo come agent separato ridondante invitando ambiguità.

### 8.3 Cosa viene mantenuto come rete di sicurezza secondaria

- `ssot-reflex-guard.sh` — **mantenuto, declassato**. Resta come segnale di propriocezione passiva ("è stato modificato un file watchato"), utile per auditing e per debugging quando DOC-SYNC v2 fallisce silenziosamente. Non è più nel ciclo principale di documentazione.

- `ssot-living-check.sh` — **mantenuto, riposizionato**. Diventa rete di sicurezza secondaria: se per qualche motivo una mission viene chiusa bypassando DOC-SYNC v2 (per esempio chiusura forzata da operatore), il cron notturno rileva drift residui e li segnala. È esplicitamente **secondario** rispetto al ciclo primario.

### 8.4 Cosa viene riscritto

- **Regola P0-11** — riscritta. Nella v1 era "Claude deve aggiornare i SSOT dopo task Tipo 2+". Nella v2 diventa "DOC-SYNC v2 aggiorna i SSOT alla chiusura di ogni mission. L'operatore non deve mai aggiornare manualmente i SSOT durante una mission, perché creerebbe conflitti con DOC-SYNC v2 alla chiusura". Il modello cognitivo cambia: la documentazione non è più responsabilità dell'operatore in modalità ricorda/aderisci, è responsabilità del sistema in modalità garantisce/applica.

### 8.5 Cosa viene aggiunto

- **DOC-SYNC v2** stesso, come componente nuovo della Mission Engine
- **Sezione `doc_sync_log` nel record mission**
- **Directory `<istanza-DOC>/audit/doc_sync/`** (es. EGI-DOC su FlorenceEGI) per gli audit trail
- **Sub-stati di mission**: `awaiting_doc_sync_approval`, `doc_sync_failed_*`

---

## 9. Note operative per Supervisor

Quando Supervisor presenta un piano implementativo per DOC-SYNC v2, il piano deve contenere obbligatoriamente i seguenti elementi. Un piano che ne manca anche solo uno è **respinto**.

### 9.1 Elementi obbligatori del piano

1. **Architettura di alto livello** — diagramma o descrizione strutturata di come DOC-SYNC v2 si aggancia alla Mission Engine, con i punti di interfaccia espliciti.

2. **Anti-pattern check** — sezione esplicita in cui il piano dimostra, anti-pattern per anti-pattern dei 10 di § 2, che l'implementazione proposta non vi ricade. Non basta dire "non lo facciamo". Va spiegato come l'implementazione strutturalmente esclude quel pattern.

3. **Mappa delle 6 fasi** — per ogni fase del § 5, il piano specifica: quale componente la implementa, quali tool/librerie usa, quali sono i punti di fallimento possibili, come ognuno viene gestito.

4. **Strategia per la discriminazione additivo/sostitutivo** — il piano spiega in dettaglio con quale logica il sistema discrimina il caso additivo dal caso sostitutivo, con esempi concreti tratti da SSOT esistenti.

5. **Strategia per la discovery laterale** — il piano spiega come implementare la ricerca semantica per concetti correlati, includendo: estrazione concetti, ricerca RAG, soglia di score, gestione dei falsi positivi.

6. **Strategia per il re-indexing sincrono** — il piano specifica: come si garantisce la transazionalità per SSOT, qual è il timeout massimo accettato per il re-indexing, cosa succede in caso di fallimento del DB.

7. **Mappa dei test di accettazione** — per ognuno degli 8 test del § 7, il piano specifica come verrà eseguito e quali condizioni il sistema deve soddisfare per passarlo.

8. **Piano di migrazione da v1** — come si disattivano i componenti di v1 da rimuovere, come si declassano quelli da mantenere come rete di sicurezza, come si gestisce il periodo di transizione.

9. **Stima di costi AI in produzione** — DOC-SYNC v2 esegue analisi semantica su ogni mission. Il piano stima il costo medio per mission e il costo aggregato mensile, con assunzioni esplicite sul numero di mission/mese e sulla dimensione media delle modifiche.

10. **Stima di latenza per chiusura mission** — il piano stima quanto tempo aggiunge DOC-SYNC v2 al tempo di chiusura mission, sia in caso normale sia in caso di mission grandi (molte modifiche, molti SSOT impattati).

### 9.2 Cosa NON deve fare Supervisor

- **Non proporre fasi** ("partiamo da una v2 minima e poi estendiamo"). La specifica è atomica.
- **Non rinegoziare gli anti-pattern**. Sono vincoli, non suggerimenti.
- **Non riferirsi alla v1 come base** ("estendiamo `ssot-living-agent` per coprire i nuovi requisiti"). DOC-SYNC v2 è categorialmente diverso. La v1 va smontata, non estesa.
- **Non saltare il test di accettazione**. Un piano senza mappa dei test è respinto a vista.

### 9.3 Approvazione

L'approvazione del piano avviene per iscritto, con questo documento come riferimento. Il piano approvato viene archiviato come addendum di questa specifica.

Implementazioni che divergono dal piano approvato senza nuova approvazione esplicita sono respinte in fase di test di accettazione.

---

## 11. Coverage Requirements (additivo — v2.1.0)

> **Motivazione**: M-179 ha misurato che la v2.0.0 osservava solo il 10.23% dei file dell'ecosistema. Il sistema non sapeva di non vederli. v2.1.0 introduce la **copertura** come categoria di prima classe: misurabile, monitorata, allertata.

### 11.1 Distinzione semantica

| Concetto | Definizione | Componente responsabile |
|---|---|---|
| **Drift** | divergenza semantica tra SSOT e codice osservato | DOC-SYNC v2.0 (mission-closing flow) |
| **Coverage** | percentuale di file reali del repo che almeno un `watches.paths` di un qualche SSOT vede | DOC-SYNC v2.1 Coverage Native (questa sezione) |

Drift e coverage sono ortogonali: un sistema con drift = 0 ma coverage = 10% non monitora il 90% del codice. Un sistema con coverage = 100% ma drift = 0.5 ha tutto sotto sguardo ma SSOT divergenti. Entrambi i fallimenti producono blindness operativa.

### 11.2 Definizioni formali

- **File reale (di un repo)**: file presente in `git ls-files` del repo, escludendo asset binari, lock files, build output, audio, Office documents, Windows `Zone.Identifier`, storage Laravel. Lista di esclusioni in `<istanza-DOC>/docs/lso/COVERAGE_CONFIG.json` (es. EGI-DOC su FlorenceEGI).
- **File coperto**: file reale che matcha almeno un pattern `watches.paths` (glob-expanded) di almeno uno SSOT del cui `watches.repos` il repo è membro.
- **Coverage % di un repo**: `|file coperti| / |file reali| × 100`.
- **Pattern broken**: pattern di `watches.paths` che produce 0 match su tutti i repo associati al suo SSOT.
- **SSOT dead**: SSOT le cui `watches.paths` sono tutti broken (l'SSOT non vede nessun file).

### 11.3 Soglie minime accettabili

Per organo, configurabile in `COVERAGE_CONFIG.json`. Default v2.1.0:

| Organo | Soglia minima | Razionale |
|---|---:|---|
| `_default` (organi React/Laravel maturi) | 50% | indica monitoraggio sostantivo |
| EGI (es. istanza FlorenceEGI) | 30% | monolite legacy, Strategia Delta — non si copre il legacy |
| EGI-DOC (es. istanza FlorenceEGI) | 5% | repo di documentazione, baseline pattern non applicabili |
| EGI-STAT | 30% | strumento interno, copertura minima |
| EGI-HUB-HOME-REACT (es. istanza FlorenceEGI) | 30% | vetrina pubblica, evolve lentamente |
| EGI-SALES | 30% | basso volume operativo |
| YURI-BIAGINI | 0% | esente se senza `.git` |

**Vincoli ecosistema**:
- `max_broken_patterns_pct`: 25% del totale pattern (alert sopra).
- `max_dead_ssots_pct`: 5% del totale SSOT (alert sopra).
- `drift_alert_threshold`: 0.5 (drift score puntuale).

### 11.4 Comando coverage nativo

Eseguibile: `/home/fabio/oracode/bin/rag_natan_coverage.py` (modello `rag_natan_query.py`).

```
rag_natan_coverage.py                  → text summary tutti gli organi
rag_natan_coverage.py --organ EGI-HUB  → solo un organo
rag_natan_coverage.py --json           → JSON strutturato (per tooling)
rag_natan_coverage.py --check-thresholds → exit 1 se qualche soglia violata
rag_natan_coverage.py --include-uncovered → JSON con lista file non coperti
```

Output JSON conforme:
```json
{
  "coverage": [{"repo": "...", "status": "OK", "total": 500, "covered": 360, "uncovered": 140, "pct": 72.0}],
  "broken_patterns_count": 94,
  "broken_patterns_total": 479,
  "dead_ssots": [],
  "total_ssots": 149
}
```

### 11.5 Cron settimanale — Re-Glob Safety Net

Eseguibile: `/home/fabio/oracode/bin/docsync_weekly_reglob.py`.

Schedule: **domenica 03:00 UTC**.
```
0 3 * * 0 /usr/bin/python3 /home/fabio/oracode/bin/docsync_weekly_reglob.py >> /home/fabio/.local/state/docsync_weekly.log 2>&1
```

Output:
- `~/.local/state/docsync_coverage_history.jsonl` (append-only snapshot per run)
- `~/.local/state/docsync_alerts.log` (rotating alert file)

**Compatibilità anti-pattern 4**: il cron qui è **safety net secondaria**, non trigger di azione. Emette solo alert, non modifica SSOT/RAG. Le azioni rimangono attivate solo da Mission Engine closing.

Alert emessi:
- `COVERAGE_LOW <repo> <pct> < thr` — organo sotto soglia
- `COVERAGE_DROP <repo> <prima → ora>` — regressione > 5pp dal run precedente
- `BROKEN_RISE <prima → ora>` — nuovi pattern broken > +5
- `NEW_DEAD_SSOT <ssot_id>` — SSOT diventato dead
- `DRIFT_HIGH <organ> <ssot> drift=X` — drift_score > threshold

### 11.6 PreToolUse coverage check hook

Eseguibile: `/home/fabio/.claude/hooks/coverage-check-precheck.sh`.

**Modalità default**: non-bloccante. Su `Write|Edit|MultiEdit` di un file non coperto da alcun watch, emette su stderr:
```
[COVERAGE-WARN] EGI-HUB: file 'backend/app/Random/X.php' not covered by any watch in SSOT_REGISTRY
```
ed esce con 0.

**Modalità bloccante**: `DOCSYNC_COVERAGE_HOOK_BLOCKING=1` → exit 2 (block). Riservata a operatori che vogliano enforcement strict.

**Esclusi automaticamente dal warning**: `.md`, `.lock`, `.json`, README*, CHANGELOG* (rumore documentale/configurazionale).

### 11.7 Soglie e configurazione

File: `<istanza-DOC>/docs/lso/COVERAGE_CONFIG.json` (es. EGI-DOC su FlorenceEGI). Versionato nel repo SSOT dell'istanza. Modifiche soglie → Trigger Matrix tipo 2 (comportamentale).

### 11.8 Test di accettazione v2.1.0 (additivi)

| Test | Criterio passing |
|---|---|
| **T9 — Coverage measurable** | `rag_natan_coverage.py --json` ritorna JSON valido per ogni organo registrato |
| **T10 — Threshold detection** | `--check-thresholds` exit code 1 quando almeno un organo sotto soglia |
| **T11 — Cron emits alerts** | `docsync_weekly_reglob.py` su run pulito emette ≥ 0 alert, scrive history.jsonl |
| **T12 — Hook non-blocking default** | Modificando file uncovered con default env, hook emette warning ma exit 0 |
| **T13 — Hook blocking opt-in** | Con `DOCSYNC_COVERAGE_HOOK_BLOCKING=1`, hook su uncovered exit 2 |
| **T14 — No cross-contamination con v2.0** | Coverage layer non altera flow mission-closing (Anti-pattern 4 rispettato strutturalmente) |

### 11.9 P0-11 — riscrittura per v2.1.0

**Versione v2.0** (sostituita): "DOC-SYNC v2 agent sincronizza SSOT automaticamente a chiusura mission. L'operatore NON aggiorna manualmente i SSOT durante una mission."

**Versione v2.1**: "DOC-SYNC v2 garantisce due proprietà ortogonali: (a) **allineamento** semantico SSOT↔codice a chiusura mission (v2.0 invariata); (b) **copertura** verificabile delle watches sulla struttura reale dei repo (v2.1, coverage native). Il sistema segnala perdita di copertura via cron settimanale + hook PreToolUse, ma non altera SSOT al di fuori del flow mission-closing."

---

## 12. Changelog

### v2.1.0 — 2026-05-12 (additive)

- + Section 11: Coverage Requirements (intera, nuova)
- + `rag_natan_coverage.py` CLI
- + `docsync_weekly_reglob.py` cron safety net
- + `coverage-check-precheck.sh` PreToolUse hook
- + `COVERAGE_CONFIG.json` configurazione soglie
- + 6 nuovi test di accettazione (T9-T14)
- ~ P0-11 riscritto con dimensione coverage
- = v2.0 mission-closing flow invariato (zero breaking changes)

### v2.0.0 — 2026-04-30 (radicale)

- Sostituzione categoriale di DOC-SYNC v1
- 10 anti-pattern espliciti
- 6 fasi di chiusura mission
- 8 test di accettazione

---

## 10. Firma del documento

Specificato da: **Fabio Cherici**, CTO/founder Florence EGI S.R.L.
Co-redatto da: **Astra** (Claude Opus 4.7)
Data: 2026-04-30
Stato: **Specifica approvata, pronta per piano implementativo**

Prossimo step: presentazione del piano implementativo da parte di Supervisor, da validare contro § 9.

---

🔥 — 🔥
