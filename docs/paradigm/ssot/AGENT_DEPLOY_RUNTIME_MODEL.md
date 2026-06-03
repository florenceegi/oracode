---
title: Agent Deploy & Runtime-Root — Modello (stub public)
slug: agent-deploy-runtime-model
doc_type: stub
status: current
visibility: public
rag: public
---

# Agent Deploy & Runtime-Root — Modello

> **Stub pubblico (M-OS3-048).** Modello (cosa/perché). Il **meccanismo di deploy concreto**
> (script, path sorgente, anchor, risoluzione root) è un SSOT `visibility: private`
> nell'enforcement OS3 Matrix (repo privato) — confine mono.

## Cosa è (modello)

Agenti e hook hanno una **fonte versionata single-source**; la **copia operativa** (nel layer di
deploy locale) è **generata** da quella fonte. I **root** si risolvono a **runtime**, non
hardcoded.

## Principio

**Si edita la fonte, mai la copia.** La copia operativa è un artefatto derivato: modificarla a
mano introduce drift source↔deploy (intercettato dalla regola R3 di `oracode-lint`). Coerente
con Pilastro 3 (Coerenza Semantica) e con la disciplina single-source della dottrina agenti.

> Implementazione concreta (script di deploy, anchor, layout): privata (OS3 Matrix).
