---
title: Oracode Audit — Target Matrix
slug: oracode-audit-01-target-matrix
doc_type: guide
version: 1.1.0
status: current
date: '2026-03-25'
updated_at: '2026-03-25'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- oracode
supersedes:
- /home/fabio/EGI-DOC/docs/_archive/oracode/audit/01_TARGET_MATRIX_v1.0.0_20260325.md
superseded_by: null
rag_indexed: true
priority: normal
---

# Oracode Audit — Target Matrix

<!-- Fonte normativa: ../oracode_compliance_audit_v_1.md §3 -->
<!-- Aggiornare questo file ogni volta che cambia un organo, il suo owner, la sua SSOT o il suo stato audit -->
<!-- Ultima revisione: 2026-03-24 — Padmin D. Curtis -->

---

## Scopo

Registro ufficiale di tutti i target auditabili dell'ecosistema FlorenceEGI. Ogni target ha un owner, una SSOT locale, una SSOT centrale e uno stato audit tracciato.

---

## Prerequisiti

- Accesso ai repository elencati nella matrice (path locali su macchina Fabio Cherici)
- Familiarità con il framework di audit Oracode (`oracode/oracode_compliance_audit_v_1.md` §3)
- Accesso ai file `CLAUDE.md` di ciascun progetto per verifica config Claude Code

---

## Legenda campi

| Campo | Valori possibili | Descrizione |
|-------|-----------------|-------------|
| **Tipo** | A = Repository | Codebase versionato |
| | B = Progetto applicativo | Applicazione deployata |
| | C = Package shared | Libreria condivisa tra organi |
| | D = Flusso cross-project | Integrazione tra più organi |
| | E = Config Claude Code | Configurazione agenti/comandi |
| **Criticità** | CRITICA | Impatto su pagamenti, blockchain, GDPR, schema condiviso |
| | ALTA | Integrazione cross-organo, architettura in evoluzione |
| | MEDIA | Frontend pubblico, no dati sensibili |
| | BASSA | Componenti isolati, basso impatto |
| **Stato audit** | NOT_AUDITED | Mai auditato |
| | IN_PROGRESS | Audit in corso |
| | PASS | Audit superato |
| | PASS_WITH_CONDITIONS | Superato con riserve documentate |
| | FAIL | Non superato |
| | SUSPENDED | Audit sospeso |
| **Claude Code** | CONFIGURED | Agenti e comandi operativi |
| | PARTIAL | Configurazione incompleta |
| | MISSING | Nessuna configurazione |

---

## Registro Target — Organi (Tipo A/B)

### T-001 — EGI (ArtFlorenceEGI)

Organo centrale dell'ecosistema, processa pagamenti e gestisce certificati blockchain.

| Campo | Valore |
|-------|--------|
| **Nome** | ArtFlorenceEGI — EGI |
| **Tipo** | A — Repository + B — Progetto applicativo |
| **Owner** | Fabio Cherici |
| **Path locale** | `/home/fabio/EGI/` |
| **Branch auditabile** | `develop` |
| **Stack** | Laravel 11.31 (PHP 8.2) + React 19 + TypeScript + Vite 5 |
| **URL produzione** | `art.florenceegi.com` |
| **SSOT locale** | `CLAUDE.md` (root progetto) |
| **SSOT centrale** | `docs/egi/` |
| **Config Claude Code** | CONFIGURED — 5 agenti, 4 comandi |
| **Criticità** | CRITICA — Organo centrale, processa pagamenti, blockchain, GDPR |
| **Stato audit** | NOT_AUDITED |
| **Ultimo audit** | — |
| **Note** | File LEGACY critici documentati in `docs/egi/debiti_tecnici.md` §10. AlgoKit testnet → mainnet previsto settimana 2026-03-13. |

---

### T-002 — NATAN_LOC

RAG Engine documentale per Pubblica Amministrazione.

| Campo | Valore |
|-------|--------|
| **Nome** | NATAN_LOC — RAG Engine documentale per PA |
| **Tipo** | A — Repository + B — Progetto applicativo |
| **Owner** | Fabio Cherici |
| **Path locale** | `/home/fabio/NATAN_LOC/` |
| **Branch auditabile** | [DA COMPLETARE] — Da verificare con Fabio |
| **Stack** | Python + FastAPI + RAG (Anthropic/OpenAI) |
| **SSOT locale** | `CLAUDE.md` (root progetto) |
| **SSOT centrale** | `docs/natan-loc/` |
| **Config Claude Code** | CONFIGURED — agenti + comandi presenti |
| **Criticità** | ALTA — RAG multi-dominio: PA (natan.*), piattaforma (rag_natan.*), NPE (marketing_rag.*) |
| **Stato audit** | NOT_AUDITED |
| **Ultimo audit** | — |
| **Note** | Sistema RAG-Fortress per query cross-tenant. Integrazione con EGI-HUB pianificata. |

---

### T-003 — EGI-HUB

Command Center dell'ecosistema con autorità gerarchica su tutti gli organi.

| Campo | Valore |
|-------|--------|
| **Nome** | EGI-HUB — Command Center Ecosistema |
| **Tipo** | A — Repository + B — Progetto applicativo |
| **Owner** | Fabio Cherici |
| **Path locale** | `/home/fabio/EGI-HUB/` |
| **Branch auditabile** | [DA COMPLETARE] — Da verificare con Fabio |
| **Stack** | Laravel backend (`backend/`) + React Dashboard (`frontend/`) + Package (`src/`) |
| **URL produzione** | `hub.florenceegi.com` |
| **SSOT locale** | `CLAUDE.md` (root progetto) |
| **SSOT centrale** | `docs/egi-hub/` |
| **Config Claude Code** | CONFIGURED — 3 agenti, 4 comandi |
| **Criticità** | CRITICA — Autorità gerarchica su tutti gli organi. Schema `core` condiviso. |
| **Stato audit** | NOT_AUDITED |
| **Ultimo audit** | — |
| **Note** | DB schema `core` — modifica impatta TUTTI gli organi. File LEGACY: TenantService.php (593 LOC), ProjectService.php (530 LOC). |

---

### T-004 — EGI-HUB-HOME-REACT

Frontend 3D pubblico dell'ecosistema.

| Campo | Valore |
|-------|--------|
| **Nome** | EGI-HUB-HOME-REACT — Frontend 3D Ecosistema |
| **Tipo** | A — Repository + B — Progetto applicativo |
| **Owner** | Fabio Cherici |
| **Path locale** | `/home/fabio/EGI-HUB-HOME-REACT/` |
| **Branch auditabile** | `main` |
| **Stack** | React 18 + TypeScript + Three.js + Framer Motion + GSAP + Zustand |
| **SSOT locale** | `CLAUDE.md` (root progetto) |
| **SSOT centrale** | `docs/egi-hub/` |
| **Config Claude Code** | CONFIGURED — 2 agenti, 4 comandi |
| **Criticità** | MEDIA — Frontend pubblico, no dati sensibili, no pagamenti |
| **Stato audit** | NOT_AUDITED |
| **Ultimo audit** | — |
| **Note** | Target Lighthouse 95+. 60fps+ per Three.js. WCAG 2.1 AA. |

---

### T-005 — EGI-INFO

SPA educativa pubblica di FlorenceEGI.

| Campo | Valore |
|-------|--------|
| **Nome** | EGI-INFO — SPA Educativa FlorenceEGI |
| **Tipo** | A — Repository + B — Progetto applicativo |
| **Owner** | Fabio Cherici |
| **Path locale** | `/home/fabio/EGI-INFO/` |
| **Branch auditabile** | `main` |
| **Stack** | React 19 + TypeScript + i18next (10 namespace IT/EN) + Tailwind 4 |
| **URL produzione** | `info.florenceegi.com` |
| **SSOT locale** | `CLAUDE.md` (root progetto) |
| **SSOT centrale** | `docs/egi/` |
| **Config Claude Code** | CONFIGURED — 2 agenti, 4 comandi |
| **Criticità** | MEDIA — SPA statica pubblica, no dati sensibili |
| **Stato audit** | NOT_AUDITED |
| **Ultimo audit** | — |
| **Note** | 43 mattoncini educativi. 60+ route. 503 termini glossario. WCAG 2.1 (328+ ARIA). |

---

### T-006 — EGI-DOC

SSOT centrale documentale dell'intero ecosistema.

| Campo | Valore |
|-------|--------|
| **Nome** | EGI-DOC — SSOT Centrale Documentale |
| **Tipo** | A — Repository |
| **Owner** | Fabio Cherici |
| **Path locale** | `/home/fabio/EGI-DOC/` |
| **Branch auditabile** | `main` |
| **Stack** | Markdown + VitePress (se presente) |
| **SSOT locale** | `docs/` (è essa stessa SSOT) |
| **SSOT centrale** | Sé stessa — è la fonte di verità centrale |
| **Config Claude Code** | CONFIGURED — struttura principale |
| **Criticità** | CRITICA — Deriva documentale qui = deriva in tutti gli organi |
| **Stato audit** | NOT_AUDITED |
| **Ultimo audit** | — |
| **Note** | Audit speciale: verificare coerenza interna tra `docs/egi/`, `docs/egi-hub/`, `docs/ecosistema/` e stato reale dei codebase. |

---

### T-007 — EGI Credential

Wallet credenziali professionali con ancoraggio blockchain Algorand.

| Campo | Valore |
|-------|--------|
| **Nome** | EGI Credential — Wallet Credenziali Professionali |
| **Tipo** | A — Repository + B — Progetto applicativo |
| **Owner** | Fabio Cherici |
| **Path locale** | `/home/fabio/EGI-Credential/` |
| **Branch auditabile** | `main` |
| **Stack** | Laravel 11 (PHP 8.2) + React 18 + TypeScript + AlgoKit (Node.js :3002) |
| **URL produzione** | `egi-credential.florenceegi.com` |
| **SSOT locale** | `CLAUDE.md` (root progetto) |
| **SSOT centrale** | `docs/egi-credential/` |
| **Config Claude Code** | CONFIGURED — 3 agenti, 4 comandi, 2 hooks |
| **Criticità** | CRITICA — Blockchain (Algorand), GDPR (dati professionali), NATAN API |
| **Stato audit** | NOT_AUDITED |
| **Ultimo audit** | — |
| **Note** | Schema `credential` su RDS. Ogni credential = `core.egis` EGI type='credential'. MAI dati personali on-chain (P0-EC-2). AlgoKit microservice porta 3002. NATAN API per skill extraction (P0-EC-3). |

---

### T-008 — EGI Proof

Layer sociale dell'ecosistema con Function Cards e reazioni semantiche.

| Campo | Valore |
|-------|--------|
| **Nome** | EGI Proof — Layer Sociale dell'Ecosistema |
| **Tipo** | A — Repository + B — Progetto applicativo |
| **Owner** | Fabio Cherici |
| **Path locale** | `/home/fabio/EGI-PROOF/` |
| **Branch auditabile** | `main` |
| **Stack** | Next.js 15 SSR + TypeScript + Tailwind + Social Hook API (HMAC-SHA256) |
| **URL produzione** | `proof.florenceegi.com` |
| **SSOT locale** | `CLAUDE.md` (root progetto) |
| **SSOT centrale** | `docs/egi-proof/` |
| **Config Claude Code** | PARTIAL — da configurare |
| **Criticità** | ALTA — Integrazione cross-organo, Egili sociali, Social Hook API |
| **Stato audit** | NOT_AUDITED |
| **Ultimo audit** | — |
| **Note** | Schema `social` su RDS. Function Cards: CertificateCard, CredentialCard, AcquisitionCard, InsightCard. Reazioni semantiche: USEFUL (5 Egili), VERIFIED (10 Egili), FOLLOW_UP (15 Egili). |

---

## Riepilogo Target per criticità

Panoramica sintetica di tutti gli organi con criticità e stato audit.

| ID | Nome | Tipo | Criticità | Stato audit | Config Claude Code |
|----|------|------|-----------|-------------|-------------------|
| T-001 | EGI (ArtFlorenceEGI) | A+B | CRITICA | NOT_AUDITED | CONFIGURED |
| T-002 | NATAN_LOC | A+B | ALTA | NOT_AUDITED | CONFIGURED |
| T-003 | EGI-HUB | A+B | CRITICA | NOT_AUDITED | CONFIGURED |
| T-004 | EGI-HUB-HOME-REACT | A+B | MEDIA | NOT_AUDITED | CONFIGURED |
| T-005 | EGI-INFO | A+B | MEDIA | NOT_AUDITED | CONFIGURED |
| T-006 | EGI-DOC | A | CRITICA | NOT_AUDITED | CONFIGURED |
| T-007 | EGI Credential | A+B | CRITICA | NOT_AUDITED | CONFIGURED |
| T-008 | EGI Proof | A+B | ALTA | NOT_AUDITED | PARTIAL |

---

## Flussi Cross-Project (Tipo D)

Integrazioni tra organi che richiedono audit coordinato tra più codebase.

### T-D01 — Flusso Algorand Certificate Anchoring (EGI → Blockchain)

Minting ASA su Algorand — flusso irreversibile da auditare prima del passaggio a mainnet.

| Campo | Valore |
|-------|--------|
| **Descrizione** | Minting ASA su Algorand — da EGI (MintController) ad AlgoKit microservice |
| **Organi coinvolti** | EGI, Algorand Testnet/Mainnet |
| **Criticità** | CRITICA — Irreversibile. Blockchain. |
| **Stato audit** | NOT_AUDITED |
| **Trigger audit** | Prima del passaggio Testnet → Mainnet (previsto settimana 2026-03-13) |

---

### T-D02 — Architettura RAG Multi-Dominio

RAG multipli specializzati per dominio: natan.rag_* (PA), rag_natan.* (piattaforma), marketing_rag.* (NPE).

| Campo | Valore |
|-------|--------|
| **Descrizione** | RAG multi-dominio — ogni RAG ottimizzato per il proprio contesto operativo |
| **Organi coinvolti** | NATAN_LOC, EGI, EGI-HUB |
| **Criticità** | ALTA — Architettura in evoluzione |
| **Stato audit** | NOT_AUDITED |
| **Trigger audit** | Prima dell'integrazione cross-organo |

---

### T-D03 — Schema core.* (EGI-HUB → tutti gli organi)

Schema condiviso `core` le cui migration impattano tutti gli organi dell'ecosistema.

| Campo | Valore |
|-------|--------|
| **Descrizione** | Modifiche a schema `core` in EGI-HUB impattano tutti gli organi (EGI, NATAN_LOC, EGI Credential, EGI Proof) |
| **Organi coinvolti** | EGI-HUB, EGI, NATAN_LOC, EGI Credential, EGI Proof |
| **Criticità** | CRITICA — Schema condiviso, migration irreversibili |
| **Stato audit** | NOT_AUDITED |
| **Trigger audit** | Ogni migration su schema `core` |

---

### T-D04 — Flusso Egili Cross-Organ (tutti gli organi → core.wallets)

Produzione e consumo Egili tramite `core.wallets` e `core.egili_transactions`, MiCA-safe.

| Campo | Valore |
|-------|--------|
| **Descrizione** | Ogni organo produce e consuma Egili tramite `core.wallets` e `core.egili_transactions`. MiCA-safe. |
| **Organi coinvolti** | EGI-HUB, EGI, NATAN_LOC, Sigillo, EGI Proof, EGI Credential |
| **Criticità** | CRITICA — MiCA compliance, nessun rate EUR, transazioni irreversibili |
| **Stato audit** | NOT_AUDITED |
| **Trigger audit** | Prima di ogni nuovo meccanismo di produzione/consumo Egili |

---

### T-D05 — Flusso NATAN API → EGI Credential (skill extraction)

Estrazione competenze da documenti Self-Certified via NATAN_LOC come Interface OSZ.

| Campo | Valore |
|-------|--------|
| **Descrizione** | EGI Credential usa NATAN_LOC come Interface OSZ per estrarre competenze da documenti (Self-Certified). |
| **Organi coinvolti** | NATAN_LOC, EGI Credential |
| **Criticità** | ALTA — Timeout, qualità estrazione, GDPR |
| **Stato audit** | NOT_AUDITED |
| **Trigger audit** | Prima dell'attivazione Self-Certified in produzione |

---

### T-D06 — Flusso Social Hook (organi → EGI Proof)

Pubblicazione Function Cards su EGI Proof via Social Hook API con autenticazione HMAC-SHA256.

| Campo | Valore |
|-------|--------|
| **Descrizione** | Organi pubblicano Function Cards su EGI Proof via Social Hook API (HMAC-SHA256). Reazioni generano Egili sociali. |
| **Organi coinvolti** | EGI Proof, EGI, NATAN_LOC, EGI Credential |
| **Criticità** | ALTA — Autenticazione HMAC, integrità dati, Egili sociali |
| **Stato audit** | NOT_AUDITED |
| **Trigger audit** | Prima del lancio EGI Proof in produzione |

---

## Riepilogo Flussi Cross-Project per criticità

| ID | Flusso | Organi coinvolti | Criticità | Stato audit |
|----|--------|-----------------|-----------|-------------|
| T-D01 | Algorand Certificate Anchoring | EGI, Algorand | CRITICA | NOT_AUDITED |
| T-D03 | Schema core.* | EGI-HUB, EGI, NATAN_LOC, EGI Credential, EGI Proof | CRITICA | NOT_AUDITED |
| T-D04 | Egili Cross-Organ | EGI-HUB, EGI, NATAN_LOC, Sigillo, EGI Proof, EGI Credential | CRITICA | NOT_AUDITED |
| T-D02 | RAG Multi-Dominio | NATAN_LOC, EGI, EGI-HUB | ALTA | NOT_AUDITED |
| T-D05 | NATAN API → EGI Credential | NATAN_LOC, EGI Credential | ALTA | NOT_AUDITED |
| T-D06 | Social Hook → EGI Proof | EGI Proof, EGI, NATAN_LOC, EGI Credential | ALTA | NOT_AUDITED |

---

## Errori comuni e soluzioni

Errori ricorrenti nella gestione della Target Matrix.

| Errore | Causa | Soluzione |
|--------|-------|----------|
| Stato audit non aggiornato dopo un audit completato | Dimenticanza di aggiornare sia il target sia lo storico | Aggiornare il campo "Stato audit" del target E aggiungere riga nello Storico audit |
| Branch auditabile errato | Branch cambiato senza aggiornare la matrice | Verificare con `git branch -r` sul repository prima di avviare l'audit |
| SSOT centrale non allineata | Documento modificato nella SSOT locale senza sync | Verificare coerenza tra SSOT locale (`CLAUDE.md`) e SSOT centrale (`docs/<organo>/`) prima dell'audit |
| Flusso cross-project auditato senza coinvolgere tutti gli organi | Audit parziale su un solo lato dell'integrazione | Controllare il campo "Organi coinvolti" e auditare tutti i lati del flusso |

---

## Storico audit

Registro cronologico di tutti gli audit completati.

| Data | Target | Esito | Auditor | Report |
|------|--------|-------|---------|--------|
| — | — | — | — | — |

*Aggiungere una riga per ogni audit completato. Link al file report in `audit/reports/`.*

---

## Riferimenti

| Documento | Path (relativo a `docs/`) |
|-----------|--------------------------|
| Framework di audit Oracode | `oracode/oracode_compliance_audit_v_1.md` |
| Debiti tecnici EGI | `egi/debiti_tecnici.md` |
| Documentazione EGI-HUB | `egi-hub/` |
| Documentazione NATAN_LOC | `natan-loc/` |
| Documentazione EGI Credential | `egi-credential/` |
| Documentazione EGI Proof | `egi-proof/` |
| Documentazione Ecosistema | `ecosistema/` |