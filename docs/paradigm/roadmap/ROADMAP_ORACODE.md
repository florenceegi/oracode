---
title: Roadmap di disaccoppiamento di Oracode
slug: oracode-roadmap
doc_type: roadmap
version: 1.1.0
status: working_draft
date: '2026-05-22'
updated: '2026-06-01'
author: Padmin D. Curtis con Fabio Cherici
scope:
- oracode
priority: high
visibility: public
rag: public
---

> ⛔ **DEPRECATO — clausole di stato (M-OS3-138, 2026-07-06).** Le affermazioni «FlorenceEGI/EGI-DOC = HUB+istanza *accoppiato* / *caso unico*; L2/HUB *differito* finché non ci sono 2+ clienti» in questo documento sono **superate**: il disaccoppiamento è fatto, **L2 = Florence EGI S.R.L.** (software house acquirente con licenza Nexus) *esiste*, e le istanze L3-clienti sono già molte (FlorenceEGI, Capasso, LeVespe, DeepDebug). Stato corrente autoritativo → **oracode: docs/paradigm/nomenclature/NEXUS_HIERARCHY_CURRENT_STATE.md**. Le *definizioni core* L1/L2/L3 restano valide.


# Roadmap di disaccoppiamento di Oracode

## 0. Punto di arrivo

Oracode puro (triade OSZ/OS3/OS4) diventa paradigma largamente accettato — riconosciuto come cornice di sviluppo AI-native al pari di OOP per la complessità del dominio e SOLID per la manutenibilità.

Il punto di arrivo non è "Oracode famoso", non è "Oracode pubblicato", non è "Oracode utilizzato da molti". È "Oracode riconosciuto come cornice paradigmatica", che è cosa concettualmente diversa.

## 1. Stato di partenza

Oracode oggi è paradigma codificato e applicato dall'autore su una sola istanza (Florence EGI). È documentato in SSOT interni (LSO_NOMENCLATURE_v2.x.md, ORACODE_PARADIGM_v2_draft.md), ha una triade formale (OSZ/OS3/OS4), ha uno strumento di enforcement (OS3 Matrix), ha prodotto componenti riusabili (Libreria LSO). Non è conosciuto fuori da chi lo costruisce. Non è stato applicato a domini diversi da quello di origine. Non è portato su modelli LLM diversi dall'unico oggi utilizzato.

## 2. Step intermedi

I quattro step seguenti sono passaggi funzionali necessari per arrivare al punto di arrivo. Gli step A, B, C possono procedere in parallelo. Lo step D presuppone A e C, ed è quindi l'ultimo in ordine di chiusura. La sequenza qui sotto è l'ordine di lettura, non l'ordine di esecuzione.

### STEP A — Applicazione a un dominio esterno

**Sostanza.** Oracode applicato a una commessa custom in un dominio diverso da quello di origine (Florence EGI). Il contesto naturale è Magicsoft 2.0: una PMI italiana, un progetto software custom, costruito con Oracode senza dipendenze concettuali dal dominio originario.

**Framing Oracode Nexus.** Magicsoft 2.0 è il primo caso di Livello 2 HUB di Oracode Nexus — una softwarehouse acquirente che installa il motore L1 (`~/oracode-engine`), tiene il proprio MISSION_REGISTRY L2 (HUB-DOC, numerazione globale + statistiche consolidate) e genera istanze L3 per i suoi clienti via `/project`. Vedi `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`.

**Presuppone.** Niente. Lo step può essere avviato in qualsiasi momento.

**Contributo al punto di arrivo.** Un paradigma applicato a una sola istanza non è un paradigma — è una metodologia personale. La trasferibilità a domini terzi è condizione minima per parlare di paradigma.

**Criteri di completamento.** Almeno una commessa custom in dominio diverso è stata consegnata applicando Oracode. La consegna ha prodotto codice in produzione presso il cliente. Nessun elemento del paradigma è stato modificato per adattarsi al nuovo dominio: solo i contenuti specifici (regole P0 adattate alle convenzioni del dominio, ecc.) sono cambiati, non la struttura.

### STEP B — Indipendenza dal modello

**Sostanza.** Oracode è definito come paradigma agnostico al modello LLM specifico. Lo step rende evidente questa proprietà facendo girare il paradigma su almeno un secondo modello, diverso dal primario (oggi Claude di Anthropic), che soddisfi i requisiti minimi di esecuzione di Oracode (modello agentico, capacità di seguire disciplina P0, capacità di operare via tool use e file system). I requisiti precisi del modello ospitante sono formalizzati come parte di questo step.

**Presuppone.** Niente. Lo step può essere avviato in qualsiasi momento.

**Contributo al punto di arrivo.** Oracode-paradigma è distribuito come MIT-licensed, gratuito, al pari di OOP e SOLID (decisione strategica del 22 maggio 2026, formalizzata in Nomenclatura LSO §1.1.B). Chi adotta deve poter scegliere il proprio modello di esecuzione liberamente. La dimostrazione che il paradigma non è accoppiato a un fornitore specifico è condizione di legittimità come paradigma pubblico — l'opposto sarebbe vendor lock-in mascherato da paradigma. Questo step costituisce inoltre la gamba A del vincolo costitutivo L9 documentato in Nomenclatura LSO.

**Criteri di completamento.** Una sessione operativa Oracode (composta da: bootstrap mission, applicazione regole P0, rispetto della disciplina del paradigma, produzione di output coerente) è stata condotta integralmente con un modello LLM diverso dal primario. L'output ha rispettato gli stessi standard del modello primario, o gli scostamenti sono stati nominati e codificati come limiti noti di quel modello specifico. I requisiti minimi del modello ospitante sono stati formalizzati come SSOT (in Nomenclatura o documento dedicato).

**Nota commerciale.** Questo step riguarda Oracode-paradigma (MIT). Non riguarda OS3 Matrix, che è prodotto commerciale di Florence EGI S.R.L. e ha vincoli di portabilità propri, definiti separatamente nella roadmap di prodotto di OS3 Matrix.

### STEP C — Completamento del Layer Stack

**Sostanza.** Il Layer Stack L0-L11 di Oracode è oggi parzialmente in produzione. L'audit M-LS-AUDIT-001 (7 maggio 2026) ha rilevato che solo L4 raggiunge genuinamente PRODUCTION; i layer reattivi L1-L8 sono in stati intermedi, i layer evolutivi L9-L11 sono in design o concept. Lo step è il completamento progressivo dei layer reattivi verso PRODUCTION e l'attivazione effettiva dei layer evolutivi.

**Nota di stato.** La gamba B del vincolo L9 (autocorrezione operativa via DOC-SYNC v2) è già operativa. Va dichiarata come tale: una delle due gambe di L9 è raggiunta. *(Aggiornamento 2026-06-01: `oracode-lint` — M-OS3-037…044 — aggiunge un secondo strumento di autocorrezione, il Layer 3 auto-correttivo, che codifica in enforcement automatico il drift-detection prima manuale. Vedi §5.)*

**Presuppone.** Niente. Lo step può procedere in qualsiasi momento, ed è di fatto già in corso.

**Contributo al punto di arrivo.** Un paradigma non si fa adottare quando i suoi strati propri sono parzialmente specificati. L'accettazione esterna richiede che chi adotta sappia cosa sta adottando — il paradigma deve essere completo nella sua auto-descrizione, anche se non tutti i layer sono attivi in ogni applicazione.

**Criteri di completamento.** Ogni layer L0-L11 ha definizione operativa stabile, criteri di maturity verificabili, ed è o in stato PRODUCTION sulla prima istanza o in stato DESIGN documentato che spiega perché non è ancora attivo. Nessun layer è in stato "dichiarazione aspirazionale non verificata".

### STEP D — Validazione esterna

**Sostanza.** Il paradigma viene letto, compreso e applicato da persone diverse dall'autore. Software house terze, team enterprise, sviluppatori indipendenti adottano Oracode. La documentazione del paradigma è leggibile da chi non ha mai fatto parte del contesto di origine. Esistono canali di feedback e di correzione da parte di chi adotta.

**Presuppone.** STEP A (trasferibilità), STEP C (completezza auto-descrittiva). Senza questi, l'adozione esterna non è materialmente possibile. STEP B non è prerequisito stretto: un adottante può iniziare con il modello primario, ma l'indipendenza dal modello rende l'adozione più sostenibile nel medio periodo.

**Contributo al punto di arrivo.** L'accettazione di un paradigma è per definizione esterna. Un paradigma che resta nel perimetro del suo autore non è accettato — è personale.

**Criteri di completamento.** Il paradigma è stato applicato in almeno un contesto totalmente esterno (autore non presente nell'esecuzione). La documentazione è stata letta e applicata da almeno un soggetto terzo senza necessità di chiarimenti diretti dall'autore. Esiste almeno un riferimento documentato a Oracode prodotto da una fonte terza (post tecnico, contributo open-source, citazione professionale).

## 3. Lettura della roadmap

Tre punti per chi legge:

1. Gli step A, B, C possono procedere in parallelo. Lo step D presuppone A e C, ed è quindi l'ultimo in ordine di chiusura.

2. La roadmap non è calendario. La progressione è governata da funzionalità e coerenza con altre priorità del progetto, non da scadenze fissate a priori.

3. La roadmap non è un piano di lavoro. È una mappa delle condizioni. I piani di lavoro derivati (chi fa cosa, con quale priorità, con quali risorse) vivono altrove e si riferiscono a questo documento come fonte.

## 4. Aggiornamento del documento

Il documento è in stato Working Draft. Ogni avanzamento sostanziale su uno degli step (criterio di completamento raggiunto, dipendenza sciolta, nuovo elemento di sostanza emerso) viene registrato qui con riformulazione incrementale.

Il documento è promosso a STABLE quando il CEO ritiene che la struttura non richieda più riassetti. La promozione non implica che gli step siano completati — implica che la mappa è consolidata.

## 5. Cronologia degli avanzamenti

- **2026-05-22.** Prima formalizzazione della roadmap (v1.0.0 Working Draft).

- **2026-05-26 (sessione 2 simulazione Poli).** Lo STEP A (applicazione a dominio esterno) registra il primo avvio non concluso: il banco prova Poli è stato rilanciato come dataset di stress test per il paradigma. Sono emerse 23+ violazioni strutturali (catalogate `S2-*` in il BACKLOG dell'enforcement (privato, OS3 Matrix)) la cui maggioranza è stata chiusa nelle mission `M-OS3-012` (multi-mission concurrency) e `M-OS3-013` (hardening hook: package-reality-check, spawn-fingerprint-logger, test-quality-gate, uem-provenance-guard, nuovo `uem-code-validation-guard`). Lo STEP C (completamento Layer Stack) ne ricava una direzione operativa concreta: ogni hook OS3 reso non-aggirabile è un passo verso la completezza auto-descrittiva richiesta dal criterio di completamento dello step. Resta scoperto come AP residuo non hook-enforceable la disciplina di lettura della documentazione delle librerie prima dell'uso (root cause del finding S2-23 — codici errore UEM inventati invece di letti dal `README` della libreria), candidato a futura mission OS3 di tipo cognitivo-procedurale, distinta dagli hook lessicali.

  Nello stesso intervallo era emerso un debito tecnico architetturale sul Mission Engine: la state machine di `bin/mission` (vissuta nel motore globale) e il Mission Registry del progetto applicativo (versionato col repo) richiedevano sincronizzazione manuale. La nota era registrata in `LSO_NOMENCLATURE_v2.md` §3.1.A.12, `ORACODE_PARADIGM_v2_draft.md` Macroarea 4 §10, `DOC-SYNC_v2_STATO_DELLARTE.md` §5.

- **2026-05-31.** Il debito tecnico architetturale sul Mission Engine — sincronizzazione manuale tra state machine (`bin/mission`) e `MISSION_REGISTRY.json` del progetto — è stato risolto. `bin/mission` ora propaga automaticamente le transizioni di stato al MISSION_REGISTRY del progetto via il descrittore `.oracode/project.json` risolto dal CWD (ponte L1→L3 di Oracode Nexus, parallel-safe con lockfile per-registry). La sincronizzazione manuale e le "mission fantasma" sono superate. Questo chiude un gap di auto-descrizione rilevante per lo STEP C.

- **2026-06-01 (sessione "Agent infrastructure + auto-correzione").** 16 mission (`M-OS3-029`…`M-OS3-044`). Tre filoni, soprattutto su **STEP C** (completamento Layer Stack / auto-descrizione) con ricaduta su **STEP A** (trasferibilità):

  - **Layer 3 auto-correttivo REALIZZATO (STEP C).** `oracode-lint` — linter degli artefatti Oracode con 6 regole (R1 broken-ref, R2 organism-coupling, R3 source↔deploy, R4 doctrine-drift, R5 cross-organo, R6 semantico-LLM), wiring event-driven (guard PostToolUse + gate pre-push) + sweep cron (`M-OS3-037/038/043/044`). Il drift-detection prima manuale (audit) è ora **enforcement automatico**: il paradigma si auto-osserva e blocca il drift prima del push. Rafforza la **gamba B di L9** (autocorrezione) con un secondo strumento concreto oltre a DOC-SYNC v2.

  - **Single-source per costruzione → auto-descrizione (STEP C).** Dottrina via skill `oracode-doctrine` (`M-OS3-029/032`), deploy agenti+hook single-source sorgente↔deploy (`M-OS3-030/035`), modello documentato come SSOT `AGENT_DEPLOY_RUNTIME_MODEL`/`ORACODE_LINT` (`M-OS3-033/039`). Gli artefatti operativi non duplicano più la dottrina né divergono dalla sorgente: il sistema descrive sé stesso senza drift.

  - **Decoupling degli artefatti dall'organismo → trasferibilità (STEP A enabler).** Agenti e hook risolvono i root a runtime (`{{instance_root}}`/`{{paradigm_root}}`/`{{engine_root}}`), zero path FlorenceEGI baked (`M-OS3-031/036/040`); anchor stabile + seed fresh-clone (`M-OS3-034/041`). Gli artefatti operano ora su **qualsiasi** organismo (Poli, Capasso…), non solo FlorenceEGI — condizione materiale di STEP A.

  **Nota STEP B (onesta).** Nessuna sessione operativa su un modello LLM diverso da Claude è stata condotta oggi → il criterio di completamento di **STEP B NON è avanzato**. Unico tocco: R6 del linter invoca l'LLM via interfaccia astratta (`ORACODE_LINT_LLM_CMD`/`ORACODE_LINT_LLM_MODEL`), quindi non hardcoda il fornitore — un punto di design model-agnostic, non il criterio.

  **Limite emerso (auto-applicazione del paradigma).** Questa roadmap è rimasta ferma al 31-05 per un'intera giornata di 16 mission: DOC-SYNC v2 è change-triggered sui path watchati, ma i doc di sintesi (roadmap, Nexus index) hanno `watches` vuoti → cadono fuori dal trigger. **Gap di copertura del sistema nervoso** da chiudere (mission a sé). Inoltre il RAG paradigma resta **non istituito** (`rag_indexed: true` nel front-matter è oggi falso) — decisione rinviata, da formalizzare.
