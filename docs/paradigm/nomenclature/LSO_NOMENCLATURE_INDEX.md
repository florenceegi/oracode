---
title: LSO Nomenclature INDEX
slug: lso-nomenclature-index
doc_type: index
version: 3.0.0
status: current
date: '2026-05-08'
updated_at: '2026-07-11'
author: Padmin D. Curtis for Fabio Cherici
mission: M-OS3-144
scope:
- oracode
priority: high
source: docs/lso/LSO_NOMENCLATURE_v2.md
visibility: public
rag: public
---

# LSO Nomenclature — INDEX

> Vocabolario sintetico always-loaded al bootstrap mission.
> Per approfondimenti: `docs/lso/LSO_NOMENCLATURE_v2.md` (on-demand).

---

## 0. CANONE DELLE SCALE — disambiguazione "L" (M-FUC-040) + ruoli per PAROLA (M-OS3-144)

**Problema risolto (M-FUC-040, CEO 2026-06-15):** la lettera "L" indicava QUATTRO scale diverse → ambiguità e drift.
**Regola canonica:** **"L" = SOLO maturità (Layer Stack L0-L11).** Le altre scale hanno lettere/nomi propri.
**Aggiornamento (CEO 2026-07-08 e 2026-07-11, ratificato — M-OS3-144):** la gerarchia operativa si dice con **PAROLE-RUOLO, mai con numeri** — i numeri fanno inferire a un LLM una scala ordinata falsa. Le sigle **T1-T3 (e le vecchie L1-L3) sono in pensione** nei doc di nomenclatura, sostituite dalle parole.

| Scala | Cosa misura | Etichetta CANONICA | Era (deprecato) |
|-------|-------------|--------------------|-----------------|
| **Maturità** (Layer Stack) | quanto è evoluto il sistema nervoso | **L0-L11** | (invariato) |
| **Ruolo operativo** (chi sei nella gerarchia) | dove vivono registri/stato | **per PAROLA-RUOLO**: Paradigma · Softwarehouse · Libreria LSO · Progetto · Organismo · Organo | T1-T3 (pensionate 2026-07-08/11), prima L1-L3 |
| **Rischio** (Egida) | quanto è in gioco | **R1-R4** | L1-L4 |
| **Astrazione** (Oracode/Libreria LSO/Organismo/FlorenceEGI) | che tipo di cosa è | **per NOME** (no numero) | "livello 1-4" |

**Tabella di traduzione (vecchio → nuovo) per i doc non ancora allineati:**
- contesto rischio/Egida: `L1→R1` (vetrina), `L2→R2`, `L3→R3`, `L4→R4` (denaro/PII/blockchain)
- contesto operativo (aggiornato M-OS3-144): `L1 / T1 GLOBALE → Paradigma`; `L2 / T2 HUB → Softwarehouse` (l'entità) **oppure** `→ Libreria LSO` (i suoi strumenti propri — si risolve per-repo: Florence EGI S.R.L.→Softwarehouse; DeepDebug, Fucina, Cockpit, EGI-STAT (nexus), SNC→Libreria LSO); `L3 / T3 ISTANZA → Progetto | Organismo | Organo` (secondo topologia — la sigla copriva tre ruoli diversi)
- contesto astrazione: `livello 1→Oracode`, `livello 2→Libreria LSO`, `livello 3→Organismo`, `livello 4→FlorenceEGI`
- contesto maturità: invariato (L0-L11 resta).

**Migrazione:** doc cardine ribattezzati big-bang (M-FUC-040); i restanti via Strategia Delta —
l'hook `nomenclature-deprecation-guard.sh` avvisa al touch di un file con etichetta vecchia e
`bin/nomenclature-drift-count` conta i file residui (visibile in cabina). La pensione di T1-T3
riusa gli stessi strumenti (estensione wordlist: lavoro applicativo M-OS3-144).

> **Asset costituzionali che applicano il canone (M-NEXUS-000):** il Pattern Anello di
> Auto-Miglioramento (`docs/paradigm/lso/PATTERN_ANELLO_AUTOMIGLIORAMENTO_v1.0.0.md`, W1) usa **L**
> per la maturità (L8→L9, Soglia 2; non L10/L11) e — nel suo testo — il tier ISTANZA "T3" per
> l'anello interno (oggi si dice: ruoli Progetto/Organismo/Organo). Il Tier 0 — Clausole Immutabili
> (`docs/paradigm/kernel/TIER0_CLAUSOLE_IMMUTABILI_v1.0.0.md`, W2) introduce una scala di
> **mutabilità** Tier 0/1/2 (asse distinto e dichiarato, D8) — da non confondere con i ruoli operativi.

---

## 1. I quattro livelli

| # | Livello | Definizione (una riga) |
|---|---------|------------------------|
| 1 | **Oracode** | Paradigma universale di sviluppo software AI-native. Trasferibile a qualsiasi dominio senza modifiche concettuali. |
| 2 | **Libreria LSO** | Componenti tecnologici concreti estratti da istanze mature, riusabili come pacchetti in altri progetti Oracode. |
| 3 | **Organismo** | Metafora architetturale: un'applicazione Oracode con metabolismo continuo (sistema circolatorio, RAG, helping). |
| 4 | **FlorenceEGI** | Prima istanza-laboratorio dell'organismo LSO. Dominio artistico, identità di marca, governance duale. |

**Regola di stratificazione**: mai mescolare i livelli. Un componente Oracode non fa riferimento a FlorenceEGI. Un componente FlorenceEGI non si autodefinisce universale.

> Questo asse e i ruoli operativi (§0/§1bis) non confliggono: qui si descrive il **genere** LSO
> (cosa è un organismo Oracode in generale, cosa è una Libreria LSO come categoria); i sei ruoli
> classificano le **specie** (qual è il posto di un singolo repo) — chiarimento CEO 2026-07-11.

---

## 1bis. Gerarchia operativa Oracode Nexus (i ruoli)

> **Oracode Nexus** = il sistema completo: paradigma + gerarchia operativa (i ruoli) + ecosistema. I 4 livelli sopra sono l'**asse concettuale** (genere); i ruoli qui sono l'**asse operativo** (specie).

**Definizioni CEO (verbatim, ratifica 2026-07-11): Organismo = un LSO multi-organo · Progetto = un LSO mono-organo · Organo = un LSO appartenente a un Organismo.**

| Ruolo | Definizione (una riga) |
|-------|------------------------|
| **Paradigma** *(ex T1 GLOBALE)* | Motore + paradigma (`oracode` + `os3-matrix`). Cartella globale **visibile** `~/oracode-engine/` (NON nascosta). Tiene solo lo **scratch runtime** (mission in volo, focus, lock) — NON un archivio versionato, NON un MISSION_REGISTRY. |
| **Softwarehouse** *(ex T2 HUB)* | Acquirente con licenza (es. Florence EGI S.R.L.). **Primo vero MISSION_REGISTRY**: file unico con **statistiche consolidate** e **numerazione globale unica** su TUTTA la produzione — clienti E Librerie LSO. Versionato nel repo `HUB-DOC` della softwarehouse. |
| **Libreria LSO** *(nuovo, CEO 2026-07-11)* | Repo di **proprietà della software house**, al servizio di tutti i lavori, nessun cliente committente: DeepDebug, Fucina, Cockpit (nexus-cockpit), EGI-STAT (nexus), SNC. Ruolo dichiarato alla creazione via `/project` (design M-OS3-144). |
| **Progetto** *(ex T3, forma mono-organo)* | **Un LSO mono-organo**: sta per conto suo (es. Capasso). **Registry proprio** nel repo (`<progetto>-DOC/docs/missions/MISSION_REGISTRY.json`). Ponte automatico via `.oracode/project.json`. |
| **Organismo** *(ex T3/L3-hub, forma multi-organo)* | **Un LSO multi-organo**: es. FlorenceEGI, il cui **repo-centro** è EGI-DOC (`ssot_home` = sé, gli Organi gli puntano). |
| **Organo** *(ex T3, membro)* | **Un LSO appartenente a un Organismo**: es. EGI, EGI-HUB (`ssot_home` = il repo-centro dell'Organismo). |

**Asse concettuale (4 livelli, genere) e asse operativo (6 ruoli, specie) sono ortogonali.** SSOT storico: `ORACODE_NEXUS_3_TIER.md` (🔒 LOCKED — usa i nomi storici nel corpo; banner di traduzione in testa). Topologia corrente: `NEXUS_HIERARCHY_CURRENT_STATE.md`.

---

## 2. Layer Stack (L0-L11)

| Layer | Nome | Funzione biologica | Maturity (istanza: FlorenceEGI) |
|-------|------|--------------------|----------------------|
| L0 | Mielina | Infrastruttura di trasmissione (SSOT_REGISTRY) | prerequisito |
| L1 | Sync | Metabolismo cellulare base | PARTIAL |
| L2 | Deep Audit | Riparazione DNA | PARTIAL |
| L3 | Detection | Recettori sensoriali | PARTIAL (early) |
| L4 | Prevention | Riflessi spinali | **PRODUCTION** |
| L5 | UEM | Sistema immunitario | PARTIAL |
| L6 | Testing | Memoria immunitaria | PARTIAL (early) |
| L7 | Contracts | DNA codificante machine-readable | PARTIAL |
| L8 | Nervous System | Propriocezione documentale | PARTIAL |
| | ══ SOGLIA METACOGNIZIONE ══ | | |
| L9 | Reflection | Corteccia prefrontale | DESIGN |
| L10 | Reproduction | Mitosi (L10a simbiotica, L10b germinativa) | CONCEPT |
| L11 | Auto-Governance | Stabilita di specie post-fondatore | VISION |

**5 stati di maturity**: PRODUCTION > PARTIAL > DESIGN > CONCEPT > VISION

**3 soglie qualitative**:
1. L0 → L1: da nessun sistema a metabolismo attivo
2. L8 → L9: da organismo reattivo a riflessivo (soglia attuale)
3. L10 → L11: da riproducibile a specie autonoma

---

## 3. Vincolo costitutivo L9

L9 diventa operativo **solo quando disaccoppiato dagli LLM esterni**. Auto-osservazione che dipende da LLM esterno non e auto-osservazione — e interpretazione esterna travestita. L9 richiede strumenti riflessivi interni all'organismo.

---

## 4. Principi invarianti dello stack

1. REGOLA ZERO si applica a ogni layer
2. L1 non bypassabile — ogni modifica passa per il metabolismo
3. L7 (Contratti) ha priorita su L6 (Test) — test sbagliato, non contratto
4. L9 non ha potere di azione diretta — solo interpretazione, umani decidono
5. L10 richiede checkpoint L9 — no divisione senza Readiness Check
6. L11 protegge l'irreversibilita — clausole costituzionali immutabili

---

*Per dettaglio completo (componenti per livello, test di appartenenza, implicazioni commerciali): `docs/lso/LSO_NOMENCLATURE_v2.md` (on-demand)*
*Ruoli operativi per parola: decisioni CEO 2026-07-08 e 2026-07-11, cablate da M-OS3-144.*
