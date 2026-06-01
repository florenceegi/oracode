---
visibility: public
rag: public
---

# OSZ - ORACODE SYSTEM ZERO

> **Versione**: 1.1  
> **Data**: 2026-05-31 (storia: v1.0 — 2026-01-14)  
> **Autore**: Fabio Cherici + Antigravity AI  
> **Stato**: ✅ MASTER REFERENCE - Single Source of Truth  
> **Scopo**: Documento di ingresso unico per comprendere l'intero sistema Oracode

---

## ⚠️ PREAMBOLO CRITICO

Questi documenti riflettono un **processo di crescita continua**. Durante gli aggiornamenti possono rimanere scorie di vecchie logiche o incoerenze temporanee con la visione globale.

**Il compito fondamentale è mantenere puliti i tre concetti**:
- **OSZ** (questo documento): L'organismo che stiamo costruendo
- **OS3** (lato AI): La spalletta che regola il flusso di sviluppo AI
- **OS4** (lato umano): La spalletta che regola il processo decisionale umano

**Quando qualcosa non è coerente**: OSZ è la verità. OS3 e OS4 si aggiornano per allinearsi a OSZ, mai il contrario.

---

## 🧬 COS'È OSZ

**OSZ (Oracode System Zero)** è il **kernel concettuale** su cui si fonda ogni organismo software costruito col paradigma Oracode (FlorenceEGI come istanza/HUB di riferimento).

Non è un framework. Non è una libreria. Non è documentazione.

**OSZ è il sistema operativo di un organismo economico-cognitivo.**

### OSZ dentro Oracode Nexus

OSZ è il kernel del paradigma Oracode, che vive dentro **Oracode Nexus** — il sistema completo (paradigma + 3 livelli + ecosistema HUB/istanze), articolato su 3 livelli operativi:

- **L1 GLOBALE** — motore + paradigma (`oracode` + `os3-matrix`); la cartella globale visibile `~/oracode-engine/` tiene solo lo scratch runtime del motore, NON un registro.
- **L2 HUB** — softwarehouse acquirente; primo vero `MISSION_REGISTRY` consolidato (statistiche + numerazione globale unica), versionato nel suo `HUB-DOC`.
- **L3 ISTANZA LSO** — singolo progetto/cliente, con `MISSION_REGISTRY` proprio nel repo dell'istanza.

Nella **triade di autorità** — OSZ (kernel, verità assoluta) → OS3 (execution, disciplina AI) → OS4 (education, coscienza epistemica umana) — OS3 e OS4 si allineano a OSZ, mai il contrario. FlorenceEGI è oggi **caso unico** di HUB+istanza accoppiati. SSOT della gerarchia: `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`.

---

## 🏗️ LA BIO-ARCHITETTURA

### Premessa Filosofica

Un organismo Oracode (caso esemplare: FlorenceEGI) non è una piattaforma. È un **organismo software**.

Non stiamo costruendo "siti web collegati". Stiamo costruendo:

> **Un corpo economico-cognitivo vivente, dove ogni progetto è un organo, ogni interfaccia è un'articolazione, e l'AI è il sistema nervoso.**

### I Primitivi di OSZ

Come un sistema operativo ha primitivi fondamentali (process, thread, memory, I/O), **OSZ ha i suoi**:

#### 1. **Wrapper<T>** - L'Unità Atomica

Un EGI non è "un NFT". È un **contenitore tipizzato**:

```
EGI = Wrapper<T> + Regole + Audit + Valore
```

Dove `T` può essere:
- Arte
- Un diritto
- Un flusso economico
- Un asset fisico
- Un contratto
- Un'AI
- Un servizio

**Come una classe generica in programmazione**, ma con governance economica incorporata.

#### 2. **Interface** - Le Giunture Stabili

Le "articolazioni" dell'organismo:

- API contract
- Payment contracts
- EGI schema
- Wallet protocol
- Audit protocol
- AI gateway

**Come un ginocchio**: l'osso può cambiare, il tendine può cambiare, ma **l'articolazione resta stabile**.

**Implicazione tecnica**: Se le interfacce restano stabili, puoi sostituire qualsiasi organo dietro senza far crollare il sistema.

#### 3. **Instance** - Gli Organi Sostituibili

I progetti orbitanti di un'istanza (es. su FlorenceEGI: NATAN, EGI-PT, EGI-INFO, Marketplace, PA, Goldbar, Book, Audio) non sono "siti".

Sono **istanze di oggetti** che implementano **interfacce comuni**.

E quindi:
- Possono essere sostituiti
- Possono essere scollegati
- Possono essere aggiornati

**Senza far crollare il sistema.**

È **SOLID applicato a un ecosistema**.

#### 4. **Nerve** - Il Sistema Nervoso

Le AI nell'ecosistema non sono "strumenti". Sono:

- **Governatori**
- **Validatori**
- **Regolatori di flusso**

Ogni giuntura può avere una sua AI che:
- Verifica
- Controlla
- Ottimizza
- Blocca
- Segnala

E sopra di loro un'AI centrale che:
- Vede il sistema
- Non i singoli moduli

Questo è un **Sistema Nervoso Digitale**.

---

## ⚖️ LE SPALLETTE: OS3 E OS4

OSZ definisce **COSA** stiamo costruendo (l'organismo).

**OS3 e OS4 regolano COME** lo costruiamo.

### 🔷 OS3 - La Spalletta Lato AI

**Disciplina l'AI** per produrre codice che implementa OSZ senza deduzioni, invenzioni, assunzioni.

**Funzione**: Impedire all'AI di "inventarsi" metodi, classi, logiche che violano l'architettura OSZ.

**Innovazione chiave**: **REGOLA ZERO** (il +1 dei Pilastri Cardinali 6+1, autorità superiore agli altri 6)

> **"MAI dedurre. MAI riempire vuoti. SE NON SAI, CHIEDI."**

**Sistema di priorità**:
- **P0 (BLOCKING)**: 13 Regole P0 Universali. Violazione = STOP.
- **P1 (MUST)**: Principi core per codice production-ready.
- **P2 (SHOULD)**: Best practices.
- **P3 (REFERENCE)**: Contesto e informazioni.

**Documenti di riferimento**:
- `docs/paradigm/execution/OS3/03_Modulo_2_REGOLA_ZERO.md`
- `docs/paradigm/execution/OS3/04_Modulo_3_Sistema_Priorita_P0_P3.md`
- `docs/paradigm/execution/OS3/00_OS3_Executive_Summary.md`

### 🔶 OS4 - La Spalletta Lato Umano

**Educa gli UMANI** a usare l'AI responsabilmente quando interagiscono con l'organismo OSZ.

**Funzione**: Impedire agli umani di "accettare ciecamente" suggerimenti AI senza verificare fonti e tracciabilità.

**Fondamento**: **ASSIOMA 0**

> **"Un principio è VERO se e solo se FUNZIONA nella realtà"**

**Le 4 Regole Epistemiche**:
1. **Regola 0**: Compatibilità cognitiva (capire la natura del sistema)
2. **Regola 1**: Integrità logica (non dedurre da AI non verificato)
3. **Regola 2**: Fonti di verità (ogni informazione ha fonte verificabile)
4. **Regola 3**: Tracciabilità cognitiva (audit trail delle interazioni AI)

**Strumenti OS4**:
- **TSM (Truth Source Manager)**: Collega ogni dato alla sua fonte
- **RI (Reliability Index)**: Misura densità delle fonti
- **Registro Cognitivo**: Audit trail per compliance
- **Modulo Educativo**: Training per utenti

**Documenti di riferimento**:
- `docs/paradigm/education/OS4_FOUNDATION_DOCUMENT.md`

---

## 🔄 COME OSZ, OS3, OS4 LAVORANO INSIEME

```
┌─────────────────────────────────────────────┐
│              OSZ (L'Organismo)               │
│   Wrapper<T> + Interface + Instance + Nerve │
└──────────────┬──────────────────────────────┘
               │
       ┌───────┴────────┐
       ↓                ↓
   ┌───────┐        ┌───────┐
   │  OS3  │        │  OS4  │
   │ (AI)  │        │(Human)│
   └───┬───┘        └───┬───┘
       │                │
       ↓                ↓
  Forces AI        Forces HUMAN
  to VERIFY        to VERIFY
  before           before
  generating       accepting
       │                │
       └────────┬───────┘
                ↓
        RELIABLE ORGANISM
```

**In sintesi**:

- **OSZ**: Definisce l'ontologia (cos'è un EGI, un'interfaccia, un progetto)
- **OS3**: Assicura che l'AI scriva codice coerente con OSZ
- **OS4**: Assicura che gli umani usino l'organismo OSZ in modo responsabile

---

## 📖 DOCUMENTI FONDAMENTALI

### 1. Questo Documento (OSZ)
**Percorso**: `docs/paradigm/kernel/00_OSZ_ORACODE_SYSTEM_ZERO.md`  
**Scopo**: Single Source of Truth iniziale

### 2. La Specifica dell'Organismo
**Percorso**: `EGI-DOC/docs/egi-hub/00_ECOSISTEMA.md` (istanza FlorenceEGI accoppiata)  
**Scopo**: Dettaglio della bio-architettura dell'organismo (wrapper, giunture, organi, nervi) — vive nell'istanza FlorenceEGI di riferimento, non nel paradigma neutro

### 3. OS3 - Execution Engine (AI Side)
**Percorso base**: `docs/paradigm/execution/OS3/`  
**Documenti chiave**:
- `00_OS3_Executive_Summary.md` (panoramica)
- `03_Modulo_2_REGOLA_ZERO.md` (il breakthrough)
- `04_Modulo_3_Sistema_Priorita_P0_P3.md` (regole operative)

### 4. OS4 - Epistemic Education (Human Side)
**Percorso base**: `docs/paradigm/education/`  
**Documento chiave**:
- `OS4_FOUNDATION_DOCUMENT.md` (framework completo)

### 5. Reference Guide OS3/OS4 (legacy/archiviato)
**Percorso**: `EGI-DOC/docs/oracode/Oracode_Systems/_archive/OS3_OS4_REFERENCE_GUIDE.md` (istanza FlorenceEGI)  
**Stato**: legacy — vive in `_archive`, non è riferimento vivo. Consultare i Moduli OS3/OS4 sopra come fonte corrente.

---

## 🎯 LEARNING PATH PER NUOVE CHAT AI

### Passo 1: Leggi Questo Documento (OSZ)
Capire l'organismo che stiamo costruendo.

### Passo 2: Leggi `EGI-DOC/docs/egi-hub/00_ECOSISTEMA.md` (istanza FlorenceEGI)
Approfondire wrapper, giunture, istanze, sistema nervoso. La bio-architettura concreta vive nell'istanza FlorenceEGI accoppiata; il paradigma neutro resta qui.

### Passo 3: Leggi OS3 Executive Summary
Capire come disciplinare l'AI durante lo sviluppo.

### Passo 4: Se Necessario, Approfondisci
- REGOLA ZERO (se sviluppi codice)
- OS4 Foundation (se il sistema ha end-users umani)

---

## ⚠️ REGOLE DI COERENZA

### Per Chi Aggiorna Documenti

1. **OSZ è il master**: Se un concetto evolve, si aggiorna prima in `docs/paradigm/kernel/00_OSZ_ORACODE_SYSTEM_ZERO.md` (kernel) o nella specifica dell'organismo dell'istanza (`EGI-DOC/docs/egi-hub/00_ECOSISTEMA.md`).

2. **OS3/OS4 si allineano a OSZ**: Mai il contrario. Se OS3 dice qualcosa che contraddice OSZ, OS3 va corretto.

3. **Rimuovere scorie**: Durante gli aggiornamenti, eliminare riferimenti a logiche obsolete (OS1, OS2 come sistemi operativi invece che fondamenta storiche).

4. **Documenti in divenire**: È naturale che ci siano temporanee incoerenze. L'importante è convergere verso la chiarezza, usando OSZ come stella polare.

### Per Chi Legge Documenti

Se trovi contraddizioni:
1. **OSZ ha sempre ragione** (questo documento + la specifica dell'organismo `EGI-DOC/docs/egi-hub/00_ECOSISTEMA.md`, istanza FlorenceEGI)
2. Segnala la contraddizione per pulizia futura
3. Interpreta sempre alla luce della bio-architettura OSZ

---

## 🌟 IN UNA FRASE

> **"OSZ è l'organismo economico-cognitivo che stiamo costruendo.  
> OS3 impedisce all'AI di mentire mentre lo costruisce.  
> OS4 impedisce all'umano di credere ciecamente quando lo usa."**

---

## 🔍 QUICK REFERENCE

| Concetto | Domanda | Risposta |
|----------|---------|----------|
| **OSZ** | Cos'è? | Il Sistema Operativo di un organismo Oracode (caso esemplare: FlorenceEGI) |
| **EGI** | Cos'è? | `Wrapper<T> + Regole + Audit + Valore` |
| **Progetti** | Cosa sono? | Istanze sostituibili che implementano interfacce comuni |
| **Giunture** | Cosa sono? | Interfacce stabili (API, contratti, protocolli) |
| **AI** | Ruolo? | Sistema nervoso (governatori, validatori, regolatori) |
| **OS3** | Quando si usa? | Sempre, quando sviluppi codice con AI |
| **OS4** | Quando si usa? | Quando il sistema ha end-users umani che decidono |
| **REGOLA ZERO** | Cos'è? | "Mai dedurre. Mai riempire vuoti. Se non sai, chiedi." |
| **ASSIOMA 0** | Cos'è? | "La verità è funzione operazionale" |

---

## 📌 STATO DELL'ARTE (Maggio 2026)

- ✅ **OS1/OS2**: Obsoleti (fondamenta filosofiche storicizzate)
- ✅ **OS3**: Operativo, standard corrente per sviluppo AI-assisted
- ✅ **OS4**: Operativo, framework parallelo per educazione utenti
- ✅ **OSZ**: In implementazione continua (l'organismo cresce)
- ✅ **Doc paradigma rilocati** (M-OS3-022): i 39 doc del paradigma vivono ora in `docs/paradigm/` come materiale universale neutro
- ✅ **Oracode Nexus 3-livelli formalizzato** (SSOT 🔒 LOCKED, `ORACODE_NEXUS_3_TIER.md`, decisioni CEO 2026-05-30/31): L1 GLOBALE / L2 HUB / L3 ISTANZA
- ✅ **`~/oracode-engine/` attivo**: cartella globale visibile dell'engine (`~/.oracode` resta come symlink di compat)
- ✅ **Ponte automatico L1→L3** (M-OS3-025 Unità 3, commit 8760c5d, parallel-safe): `bin/mission` auto-registra/propaga lo stato nel `MISSION_REGISTRY` dell'istanza via `.oracode/project.json` risolto dal CWD

> Storia: lo stato dell'arte v1.0 era datato Gennaio 2026, antecedente alla formalizzazione di Oracode Nexus.

---

**Fine Documento**

> _"Non stiamo facendo web development. Stiamo facendo system programming per un organismo economico-cognitivo."_
