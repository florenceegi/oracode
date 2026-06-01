---
title: Read Tracking — Modello (stub public)
slug: read-tracking-tech-spec
doc_type: stub
status: current
visibility: public
rag: public
---

# Read Tracking — Modello

> **Stub pubblico (M-OS3-048).** Questo documento è il **modello** (cosa/perché). La
> **specifica tecnica implementativa** (hook, matcher, wiring, path runtime) è un SSOT
> `visibility: private` nell'enforcement OS3 Matrix (repo privato) — confine mono.

## Cosa è (modello)

Il **read-tracking** è il substrato **empirico** del retrospective auto-migliorante del
Mission Protocol (§ 4.2, § 6.2): traccia gli accessi al filesystem durante una mission per
permettere il confronto **caricato-vs-usato** alla chiusura. È un sottosistema del **motore
(Livello 1)** di Oracode Nexus; produce un read-log d'istanza (Livello 3) risolto via il
descrittore `.oracode/project.json`.

## Perché

Rende il retrospective **basato su dati reali** (Read effettive), non su autopercezione —
coerente con REGOLA ZERO (no deduzione) e con l'anti-pattern AP-MP-2 (retrospective
dichiarativo). L'aggregazione cross-istanza appartiene al HUB (Livello 2).

> Implementazione concreta: privata (OS3 Matrix). Vedi Mission Protocol § 4.2 / § 6.2 per il pattern.
