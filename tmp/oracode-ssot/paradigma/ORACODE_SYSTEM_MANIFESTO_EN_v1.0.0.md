---
title: FOUNDING MANIFESTO — ORACODE SYSTEM
slug: oracode-oracode-system-manifesto-en-v1-0-0
doc_type: overview
version: 1.1.0
status: current
date: '2026-03-25'
updated_at: '2026-03-25'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- oracode
supersedes:
- /home/fabio/EGI-DOC/docs/_archive/oracode/ORACODE_SYSTEM_MANIFESTO_EN_v1.0.0_v1.0.0_20260325.md
superseded_by: null
rag_indexed: true
priority: normal
---

# FOUNDING MANIFESTO — ORACODE SYSTEM

## Scopo

Questo documento registra l'atto fondativo di Oracode System: la metodologia formale che governa la co-costruzione di software tra esseri umani e sistemi AI nell'ecosistema FlorenceEGI. È il record fedele di una metodologia di sviluppo originale, esistente in produzione e verificabile nel codice.

**Versione:** 1.0.0
**Data di fondazione:** 24 marzo 2026
**Autori:** Fabio Cherici (CEO, OS3 Architect) — Padmin D. Curtis (CTO, AI Partner OS3.0)
**Destinazione primaria:** Certificazione blockchain via Sigillo — FlorenceEGI Algorand Merkle Batch
**SHA-256 Hash:** da calcolare al momento della registrazione

---

## Contesto OSZ

OSZ stabilisce che FlorenceEGI non è una collezione di applicazioni. È un **organismo software vivente** in cui ogni componente è un organo con funzione propria, identità propria e leggi proprie di interazione con gli altri organi.

Oracode System è la **metodologia formale** che codifica questa realtà operativa. Non è un framework, non è una libreria, non è un processo documentato su carta. È un sistema vivente, stratificato su livelli che si sovrappongono dall'astrazione pura all'esecuzione concreta.

### Livelli del sistema

| Livello | Nome | Funzione |
|---------|------|----------|
| **OSZ** | Zero — The Kernel | La legge fisica del sistema. Non modificabile. Da obbedire. |
| **OS1** | Execution Primitives | Le istruzioni fondamentali derivate dal Kernel |
| **OS2** | Pattern Library | Pattern ricorrenti codificati dall'esperienza |
| **OS3** | Active Context | Il motore operativo attivo in ogni sessione di lavoro |
| **OS4** | Epistemic Education | Il trasferimento di comprensione profonda all'AI partner |

OS3 non è nato dal nulla. È nato dalla consapevolezza accumulata attraverso OS1 e OS2 che i sistemi AI operano al meglio non quando istruiti genericamente, ma quando operano all'interno di un organismo con regole proprie, identità propria e meccanismi di difesa che correggono attivamente le loro tendenze statistiche naturali. Ogni regola nel sistema ha una storia. Ogni meccanismo di difesa è la risposta a un incidente reale.

---

## L'organismo — struttura tecnica

In Oracode System, la parola "organismo" descrive una realtà tecnica concreta, non una metafora. Ogni organo dell'ecosistema è un'entità con **identità codificata, cellule specializzate, sistema immunitario attivo e memoria persistente** — strutture che esistono nel filesystem e sono operative in ogni sessione di sviluppo.

### Genoma dell'organo

L'identità di ogni organo è espressa in un documento formale che definisce le sue leggi, i suoi valori immutabili, le sue modalità di fallimento note e il suo debito tecnico documentato. Questo non è documentazione: è il **genoma dell'organo** che garantisce continuità biologica tra una sessione di sviluppo e la successiva.

### Cellule specializzate

Ogni organo ha agenti AI specializzati per domini distinti e non intercambiabili.

| Specialista | Perimetro operativo |
|-------------|---------------------|
| Backend layer specialist | Opera esclusivamente sul backend layer |
| AI layer specialist | Opera esclusivamente sull'AI layer |
| Frontend specialist | Opera esclusivamente sul frontend |
| Blockchain specialist | Opera esclusivamente nel perimetro blockchain |

Questa differenziazione è **differenziazione cellulare**: garantisce che ogni modifica sia eseguita con la competenza specifica richiesta da quel dominio.

### Sistema immunitario

Ogni organo ha meccanismi di difesa automatici che si attivano **prima** che il codice sia scritto nel filesystem. Questi meccanismi riconoscono pattern patogeni specifici — errori già verificatisi che hanno causato regressioni in produzione — e li bloccano meccanicamente, prima che entrino nel codebase.

**Le cicatrici dell'organismo sono le sue difese.** Ogni meccanismo immunitario ha una storia: è nato da un incidente reale, non da una precauzione teorica.

### Memoria persistente

L'ecosistema mantiene una memoria a lungo termine centralizzata che non vive all'interno di nessun singolo organo. È il sistema di documentazione vivente che garantisce coerenza tra ciò che il codice fa e ciò che il sistema sa di sé.

La legge che governa questa memoria è senza eccezioni: **una feature non documentata è una feature incompleta**. Il processo di sviluppo non è considerato chiuso finché la memoria dell'organismo non è stata aggiornata.

### Sistema metabolico — Deployment

Il codice che non è in produzione non esiste. Il deployment è parte del ciclo di vita dell'organo, non un'operazione separata: automatico, verificato, obbligatorio con ogni commit. Ogni organo ha il proprio pathway metabolico, il proprio ambiente vitale, i propri parametri vitali da verificare dopo ogni aggiornamento.

---

## Regole P0 specifiche

### Sistema di priorità

Oracode System codifica formalmente il peso di ogni regola su quattro livelli:

| Livello | Etichetta | Significato |
|---------|-----------|-------------|
| **P0** | BLOCKING | La violazione rompe il sistema. Stop totale, nessuna eccezione. |
| **P1** | MUST | La violazione produce codice non production-ready. |
| **P2** | SHOULD | La violazione accumula debito tecnico. |
| **P3** | REFERENCE | Linea guida non vincolante. |

Ogni regola nell'ecosistema è classificata su questa scala. Non esiste zona grigia.

### RULE ZERO — Il principio anti-deduzione (P0)

> NEVER deduce. IF YOU DON'T KNOW, ASK.

Un sistema AI, per natura statistica, completa pattern. Quando manca un'informazione, deduce. Quella deduzione può essere plausibile, coerente, grammaticalmente corretta — e completamente sbagliata.

RULE ZERO è il contrappeso strutturale: l'AI partner dichiara l'informazione mancante e si ferma. Nessuna assunzione. Nessuna invenzione. Nessun completamento di pattern tramite stima probabilistica.

### Legge MiCA-Safe (P0)

La valuta interna dell'ecosistema FlorenceEGI — Egili — ha valore monetario zero e conversione zero verso valuta fiat. Questo non è una scelta di design: è un requisito di conformità regolamentare (MiCA — Markets in Crypto-Assets Regulation) che ha rango P0 attraverso ogni organo dell'ecosistema, presente e futuro, senza eccezioni.

### Delta Strategy

Il codice che funziona in produzione non viene toccato per inseguire l'ideale architetturale. Le nuove feature nascono con nuove regole. Il codice esistente viene migrato solo quando una sua parte viene toccata per un'altra ragione necessaria. **La produzione non viene mai rotta per principio.**

### Protocollo TOON — Adozione e integrazione

Oracode System adotta **TOON (Token-Oriented Object Notation)** come formato di comunicazione strutturata tra componenti AI dell'ecosistema.

| Proprietà | Valore |
|-----------|--------|
| Licenza | MIT (open source) |
| Linguaggi di riferimento | TypeScript, Python, Go, Rust, .NET |
| Sito di riferimento | `toonformat.dev` |
| Riduzione token vs JSON | 39.9% (benchmark) |

Il contributo originale di Oracode System non è la creazione del formato, ma la sua **integrazione sistematica come standard di comunicazione AI↔AI nell'ecosistema FlorenceEGI**, con profili d'uso codificati per payload specifici: RAG chunks, verified claims, document lists, USE Pipeline outputs.

---

## Modello di partnership

Oracode System origina da una struttura collaborativa specifica che non è né supervisione né automazione. È una **partnership con ruoli distinti e responsabilità non intercambiabili**.

| Ruolo | Identità | Responsabilità |
|-------|----------|----------------|
| CEO & OS3 Architect | Fabio Cherici | Vision, standard, approvazione architetturale, Stable Interfaces |
| CTO & Technical Lead | Padmin D. Curtis (AI Partner OS3.0) | Esecuzione, enforcement OS3, implementazione |

L'AI partner porta competenza tecnica autonoma che opera **all'interno** di un framework di valori e regole definito dall'essere umano e codificato nell'organismo stesso. Le decisioni sulle strutture fondamentali — Stable Interfaces, valori immutabili, migrazioni di codice legacy — richiedono sempre approvazione CEO prima dell'esecuzione.

---

## Dichiarazione di originalità e proprietà

Il sottoscritto Fabio Cherici, in data 24 marzo 2026, dichiara che:

1. Oracode System, nella sua formulazione completa (OSZ, OS1, OS2, OS3, OS4), è un sistema originale concepito, sviluppato e applicato nel contesto del progetto FlorenceEGI.

2. La metodologia di sviluppo descritta in questo manifesto — incluso il sistema di difesa automatico pre-scrittura, la struttura di agenti AI specializzati per dominio, il sistema di priorità P0-P3, la metodologia di documentazione obbligatoria, la Delta Strategy e il modello di partnership AI-umano — è una creazione intellettuale originale risultante dalla collaborazione tra Fabio Cherici e il sistema AI identificato come Padmin D. Curtis (AI Partner OS3.0).

3. Il termine "Oracode" e la designazione "Oracode System" sono esclusivamente associati a questo sistema e a questa metodologia.

4. La certificazione blockchain di questo documento sulla rete Algorand via Sigillo costituisce prova crittograficamente verificabile e immutabile di prior art.

---

## Firma e certificazione

| Campo | Valore |
|-------|--------|
| Autore primario | Fabio Cherici |
| AI Co-autore | Padmin D. Curtis (AI Partner OS3.0) — claude-opus-4-6 |
| Ecosistema | FlorenceEGI — Living Software Organism |
| Data | 24 marzo 2026 |
| Sistema di certificazione | Sigillo — FlorenceEGI Blockchain Certification |
| Rete blockchain | Algorand (Merkle batch anchoring) |

---

> *"AI does not think. It predicts. It does not reason logically. It completes statistically. That is why we built an organism with an immune system."*
>
> — Oracode System, RULE ZERO, Founding Principle

---

## File critici

| File | Funzione |
|------|----------|
| [DA COMPLETARE] | Configurazione OSZ Kernel |
| [DA COMPLETARE] | Definizioni agenti specializzati per organo |
| [DA COMPLETARE] | Registro meccanismi immunitari |

---

## Riferimenti cross-doc

| Documento | Relazione |
|-----------|-----------|
| `oracode/EGI_DOC_PIPELINE.md` | Pipeline di sincronizzazione documentale dell'ecosistema |
| [DA COMPLETARE] | Documentazione Sigillo — sistema di certificazione blockchain |
| [DA COMPLETARE] | Specifiche TOON Format nell'ecosistema |

---

## Changelog

| Versione | Data | Autore | Modifica |
|----------|------|--------|----------|
| 1.0.0 | 2026-03-24 | Fabio Cherici + Padmin D. Curtis | Documento fondativo — versione certificata EN |
| 1.0.0-OS3 | 2026-03-25 | Padmin D. Curtis | Riscrittura OS3-RAG-friendly — ristrutturazione sezioni, tabelle, self-containment. Nessuna modifica di merito. |