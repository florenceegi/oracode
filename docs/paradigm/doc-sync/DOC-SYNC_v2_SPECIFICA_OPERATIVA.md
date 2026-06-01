---
title: DOC-SYNC v2 — Modello (stub public)
slug: doc-sync-v2-specifica-operativa
doc_type: stub
status: current
visibility: public
rag: public
---

# DOC-SYNC v2 — Modello

> **Stub pubblico (M-OS3-048).** Modello (cosa/perché). La **specifica operativa dettagliata**
> (6 step implementati, agent, formati interni) è un SSOT `visibility: private` nell'enforcement
> OS3 Matrix (repo privato) — confine mono.

## Cosa è (modello)

**DOC-SYNC v2** allinea **codice ↔ SSOT** alla chiusura di ogni mission (P0-11): nessuna
mission chiude con documentazione incoerente. Opera al **Layer 8** (propriocezione documentale).

Pattern in sei momenti: analisi semantica del diff → SSOT diretti impattati → discovery
laterale (RAG) → generazione/applicazione patch → re-index RAG → audit trail.

## ESITO A/B/C (modello di sicurezza)

- **A** — SSOT già allineati, nessuna patch.
- **B** — patch **additiva** (solo aggiunte, nessuna perdita) → chiude.
- **C** — patch **sostitutiva** (rimuove/riscrive) → **approvazione CEO** obbligatoria
  (anti-frode documentale: l'AI non sostituisce contenuto SSOT senza umano).

> Implementazione concreta: privata (OS3 Matrix). Vedi Mission Protocol § 6.1 per l'aggancio.
