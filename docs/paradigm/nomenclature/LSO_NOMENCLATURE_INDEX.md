---
title: LSO Nomenclature INDEX
slug: lso-nomenclature-index
doc_type: index
version: 2.0.0
status: current
date: '2026-05-08'
updated_at: '2026-06-17'
author: Padmin D. Curtis for Fabio Cherici
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

## 0. CANONE DELLE SCALE — disambiguazione "L" (M-FUC-040, decisione CEO 2026-06-15)

**Problema risolto:** la lettera "L" indicava QUATTRO scale diverse → ambiguità e drift.
**Regola canonica:** **"L" = SOLO maturità (Layer Stack L0-L11).** Le altre scale hanno lettere/nomi propri.

| Scala | Cosa misura | Etichetta CANONICA | Era (deprecato) |
|-------|-------------|--------------------|-----------------|
| **Maturità** (Layer Stack) | quanto è evoluto il sistema nervoso | **L0-L11** | (invariato) |
| **Tier operativo** (GLOBALE/HUB/ISTANZA) | dove vivono registri/stato | **T1-T3** | L1-L3 |
| **Rischio** (Egida) | quanto è in gioco | **R1-R4** | L1-L4 |
| **Astrazione** (Oracode/Libreria LSO/Organismo/FlorenceEGI) | che tipo di cosa è | **per NOME** (no numero) | "livello 1-4" |

**Tabella di equivalenza (vecchio → nuovo)** per la migrazione:
- contesto rischio/Egida: `L1→R1` (vetrina), `L2→R2`, `L3→R3`, `L4→R4` (denaro/PII/blockchain)
- contesto operativo: `L1→T1` (GLOBALE), `L2→T2` (HUB), `L3→T3` (ISTANZA)
- contesto astrazione: `livello 1→Oracode`, `livello 2→Libreria LSO`, `livello 3→Organismo`, `livello 4→FlorenceEGI`
- contesto maturità: invariato (L0-L11 resta).

**Migrazione (M-FUC-040):** doc cardine ribattezzati big-bang; i restanti via Strategia Delta —
l'hook `nomenclature-deprecation-guard.sh` avvisa al touch di un file con etichetta vecchia in
contesto rischio/operativo, e `bin/nomenclature-drift-count` conta i file residui (visibile in cabina).

> **Asset costituzionali che applicano il canone (M-NEXUS-000):** il Pattern Anello di
> Auto-Miglioramento (`docs/paradigm/lso/PATTERN_ANELLO_AUTOMIGLIORAMENTO_v1.0.0.md`, W1) usa **L**
> per la maturità (L8→L9, Soglia 2; non L10/L11) e **T3** per il tier ISTANZA dell'anello interno.
> Il Tier 0 — Clausole Immutabili (`docs/paradigm/kernel/TIER0_CLAUSOLE_IMMUTABILI_v1.0.0.md`, W2)
> introduce una scala di **mutabilità** Tier 0/1/2 (asse distinto e dichiarato, D8) — da non confondere
> con il tier operativo T1-T3 della tabella sopra.

---

## 1. I quattro livelli

| # | Livello | Definizione (una riga) |
|---|---------|------------------------|
| 1 | **Oracode** | Paradigma universale di sviluppo software AI-native. Trasferibile a qualsiasi dominio senza modifiche concettuali. |
| 2 | **Libreria LSO** | Componenti tecnologici concreti estratti da istanze mature, riusabili come pacchetti in altri progetti Oracode. |
| 3 | **Organismo** | Metafora architetturale: un'applicazione Oracode con metabolismo continuo (sistema circolatorio, RAG, helping). |
| 4 | **FlorenceEGI** | Prima istanza-laboratorio dell'organismo LSO. Dominio artistico, identità di marca, governance duale. |

**Regola di stratificazione**: mai mescolare i livelli. Un componente Oracode (livello 1) non fa riferimento a FlorenceEGI (livello 4). Un componente FlorenceEGI non si autodefinisce universale.

---

## 1bis. Gerarchia operativa Oracode Nexus (3 tier, T1-T3)

> **Oracode Nexus** = il sistema completo: paradigma + gerarchia operativa a 3 livelli + ecosistema (HUB / istanze). I 4 livelli sopra sono l'**asse concettuale**; i 3 livelli qui sono l'**asse operativo**.

| # | Livello operativo | Definizione (una riga) |
|---|-------------------|------------------------|
| T1 | **GLOBALE** | Motore + paradigma (`oracode` + `os3-matrix`). Cartella globale **visibile** `~/oracode-engine/` (NON nascosta). Tiene solo lo **scratch runtime** (mission in volo, focus, lock) — NON un archivio versionato, NON un MISSION_REGISTRY. |
| T2 | **HUB** | Softwarehouse acquirente. **Primo vero MISSION_REGISTRY**: file unico che raduna tutto, con **statistiche consolidate** e **numerazione globale unica** delle mission. Versionato nel repo `HUB-DOC` della softwarehouse. |
| T3 | **ISTANZA LSO** | Singolo progetto/cliente. **Registry proprio** nel repo del progetto (`<progetto>-DOC/docs/missions/MISSION_REGISTRY.json`). Ponte T1→T3 **automatico** (FATTO): `bin/mission` propaga lo stato dell'engine al registry del progetto via `.oracode/project.json`. |

**Asse concettuale (4 livelli) e asse operativo (3 livelli) sono ortogonali.** SSOT: `ORACODE_NEXUS_3_TIER.md`.

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
