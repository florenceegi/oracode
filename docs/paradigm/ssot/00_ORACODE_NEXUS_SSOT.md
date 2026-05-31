---
title: Oracode Nexus — Definizione (SSOT di record)
slug: oracode-nexus-ssot
doc_type: concept-ssot
version: 1.0.0
status: current
date: '2026-06-01'
updated_at: '2026-06-01'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
supersedes: null
superseded_by: null
rag_indexed: true
priority: critical
---

# Oracode Nexus — Definizione

> **Cosa fissa questo documento:** la **definizione canonica** di Oracode Nexus — la risposta
> precisa e autorevole a *"cos'è esattamente, e di che parti è fatto"*. È il documento **di record**:
> gli altri lo citano per la definizione.
>
> **Dove andare per altro:** intro discorsiva → `00_ORACODE_NEXUS_EXECUTIVE_SUMMARY.md` · dettaglio
> tecnico completo → `ORACODE_NEXUS_SYSTEM_REFERENCE.md` · gerarchia a 3 livelli →
> `nomenclature/ORACODE_NEXUS_3_TIER.md` · mappa dei documenti → `index/Oracode-Nexus-index.md`.

---

## 1. La definizione

Oracode Nexus è un **«[CATEGORIA DI PRODOTTO — PLACEHOLDER]»**: un sistema che sta **tra l'AI e il
codice e impedisce — mentre l'AI scrive — che entri qualcosa che rompe le regole.** Previene *prima*,
non verifica *dopo*.

Non è un singolo strumento: è un **paradigma reso operativo da un motore**. Il paradigma porta le
regole; il motore le fa rispettare meccanicamente, al momento della scrittura.

<!-- INTERNO — NON PUBBLICO: la categoria di prodotto reale (che sostituisce il PLACEHOLDER) e l'intero naming stack — brand / categoria / pratica — vivono nel documento privato ~/.florenceegi-private/naming-strategy/NAMING_STACK_SSOT.md (fuori da git). Pubblicabili solo dopo trademark check. -->

---

## 2. I tre componenti

Oracode Nexus è fatto di tre strati distinti che vanno tenuti separati:

| Componente | Cos'è | Ruolo | Licenza |
|------------|-------|-------|---------|
| **Paradigma** | le **regole e la disciplina**: REGOLA ZERO, i 6+1 Pilastri, le Regole P0, la Strategia Delta, il Mission Protocol, DOC-SYNC | **il metodo** — *cosa* è giusto fare | MIT, pubblico |
| **Motore (enforcement)** | ciò che **fa rispettare** le regole in automatico: hook meccanici, agenti specializzati, GATE, audit | **la macchina** — *fa* rispettare il metodo | commerciale |
| **Ecosistema** | **HUB** (coordina, numera, consolida le statistiche) + **istanze** (i singoli progetti) | **la scala** — *dove* gira | per istanza |

Il paradigma da solo è disciplina (l'AI segue le regole leggendole). Il motore aggiunge
l'enforcement meccanico (l'AI **non può** romperle). L'ecosistema porta il tutto su più progetti.

---

## 3. La gerarchia a 3 livelli (sintesi)

Oracode Nexus si dispone su tre livelli — dettaglio e direttive in `nomenclature/ORACODE_NEXUS_3_TIER.md` (🔒 LOCKED):

- **L1 — GLOBALE:** il **motore + paradigma** sulla macchina (cartella visibile `~/oracode-engine/`). Tiene solo lo scratch runtime. **Non è un registro.**
- **L2 — HUB:** la softwarehouse che adotta Oracode Nexus. Il **primo vero registro** consolidato + statistiche + numerazione globale unica.
- **L3 — ISTANZA:** il singolo progetto/cliente, col proprio registro nel suo repo.

---

## 4. Cosa diventa il software: l'LSO

Il software costruito con Oracode Nexus tende a diventare un **Living Software Organism (LSO)**:
un software che **conosce le proprie regole**, le fa rispettare, **si auto-documenta**, mantiene la
propria coerenza nel tempo e ha una **mente interrogabile** (documentazione indicizzata, interrogabile
in linguaggio naturale). L'LSO è *cosa diventa l'output*; il motore è *cosa lo produce e lo governa*.

---

## 5. Cos'è / cosa NON è

**È:** un paradigma reso operativo da un motore di enforcement — disciplina + macchina che la applica.

**NON è:**
- *solo una metodologia* → c'è la macchina (hook, agenti, GATE) che enforce, non solo regole scritte;
- *un linter* o *una pipeline CI/CD* → quelli controllano **dopo** che il codice esiste; Oracode Nexus
  impedisce **prima**;
- *un framework di codice* (non è una libreria che importi nel tuo software): governa **come** il codice
  viene scritto, non *cosa* il tuo software fa.

> Nota: questa formulazione risolve di proposito l'ambiguità storica "metodologia vs framework" —
> Oracode Nexus è **paradigma + motore**, non l'uno o l'altro.

---

## 6. Relazione coi documenti del corpus

| Documento | Lavoro |
|-----------|--------|
| **Questo (`00_ORACODE_NEXUS_SSOT.md`)** | la **definizione di record** |
| `00_ORACODE_NEXUS_EXECUTIVE_SUMMARY.md` | l'**intro discorsiva** (persuade, orienta) |
| `ORACODE_NEXUS_SYSTEM_REFERENCE.md` | il **riferimento tecnico completo** (l'enciclopedia) |
| `nomenclature/ORACODE_NEXUS_3_TIER.md` | la **legge della gerarchia** a 3 livelli |
| `index/Oracode-Nexus-index.md` | la **mappa** navigabile |

---

*SSOT di definizione. Caso esemplare di istanza in produzione: FlorenceEGI (la prima emersa, non
l'unica possibile — i meccanismi descritti sono universali).*
