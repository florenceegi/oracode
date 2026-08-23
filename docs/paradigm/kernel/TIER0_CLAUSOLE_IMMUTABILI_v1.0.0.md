---
title: Tier 0 — Clausole Immutabili
slug: tier0-clausole-immutabili
doc_type: concept
version: 1.0.0
status: DRAFT
date: '2026-06-17'
author: Padmin D. Curtis for Fabio Cherici
mission: M-NEXUS-000
scope:
  - oracode
priority: high
visibility: public
rag: public
---

# Tier 0 — Clausole Immutabili

> @purpose Elencare le clausole che l'anello di auto-miglioramento NON può modificare, e
> dichiarare per ciascuna l'enforcer reale che la rende immutabile PER COSTRUZIONE.

## 0. Scopo e principio

Il Tier 0 raccoglie le meta-regole del COME-si-migliora e le clausole costituzionali che
l'organismo non può riscrivere autonomamente.

**Principio: "immutabile PER COSTRUZIONE".** Una clausola Tier 0 non è immutabile perché un documento
dice "non toccare" (divieto interpretabile, che un LLM può aggirare per asimmetria di degradazione).
È immutabile perché un **controllo d'accesso meccanico** glielo impedisce: il file vive fuori dal
write-set dell'agente, o un hook fail-closed blocca la scrittura.

> Fondamento (`docs/paradigm/nomenclature/LSO_NOMENCLATURE_v3.md §«I sei principi invarianti dello stack»`): le asimmetrie di velocità e
> degradazione dell'LLM richiedono "gate che non 'correggano' ma impediscano — hook fail-closed, non
> istruzioni interpretabili".

## 1. STRATO 1 — Costituzionale (meta-regole + identità)

| Clausola | Fonte | Perché immutabile | Enforcer |
|---|---|---|---|
| **REGOLA ZERO** ("mai dedurre; se non sai, chiedi") | `OSZ:147`, `OSZ:308` | +1 dei Pilastri, autorità superiore agli altri 6; ogni layer deve avere fonti esplicite | file fuori write-set + ratifica CEO (DOC-SYNC ESITO C) |
| **Gerarchia OSZ→OS3→OS4** (OSZ è la verità; OS3/OS4 si allineano, mai il contrario) | `OSZ:25`, `OSZ:274` | se OS3 contraddice OSZ, va corretto OS3 | file fuori write-set + ratifica CEO |
| **I 6 invarianti dello stack** | `LSO_NOMENCLATURE_v3.md` §«I sei principi invarianti dello stack» | violarli fa cessare un'app di essere Oracode | file fuori write-set + ratifica CEO |
| **Invariante #4 — L9 non ha potere di azione diretta** | `LSO_NOMENCLATURE_v3.md` §«I sei principi invarianti dello stack» | protegge l'agency umana: l'agente propone, l'umano agisce | `mission-state-guard.sh` + ratifica CEO |
| **Invariante #2 — L1 non bypassabile** | `LSO_NOMENCLATURE_v3.md` §«I sei principi invarianti dello stack» | ogni modifica passa per il metabolismo; no modifiche a freddo | Mission Protocol + spawn-fingerprint |
| **Invariante #6 — L11 protegge l'irreversibilità** | `LSO_NOMENCLATURE_v3.md` §«I sei principi invarianti dello stack» | alcune cose, una volta nel genoma, non escono | file fuori write-set + ratifica CEO |

Enforcer comune STRATO 1: **file fuori dal write-access dell'agente** + **DOC-SYNC ESITO C / ratifica
CEO** (`MISSION_PROTOCOL.md:334-336`: ESITO C = "AI non sostituisce contenuto SSOT senza approvazione
esplicita umana").

## 2. STRATO 2 — Operativo (azione → enforcer reale)

Ogni voce è cablata OGGI a un enforcer fail-closed:

| Azione vietata | Enforcer reale |
|---|---|
| no-exfiltrazione di `~/.claude` | safety-classifier (harness) |
| no-persistence / no-crontab non autorizzato | safety-classifier (harness) |
| no-enumerazione credenziali AWS | safety-classifier (harness) |
| no-scrittura del registry a mano | `mission-registry-guard.sh` (cita M-FUC-027) + `registry-close-guard.sh` |
| no-Write fuori working-set | `mission-state-guard.sh` |
| no-rm distruttivo | `rm-guard.sh` |

> Evidenza empirica (sessione Fucina, 2026-06-16): tutte e 6 le azioni sono state **rifiutate in
> autonomia** dal sistema durante un giro reale del loop. Il safety-classifier è capability
> dell'harness, non un file hook del repo. [da validare] mappatura path esatta degli hook in os3-matrix.

## 3. Meta-clausola

> **L'elenco del Tier 0 non si modifica via anello.** Discende dall'invariante #6
> (`LSO_NOMENCLATURE_v3.md` §«I sei principi invarianti dello stack»): l'irreversibilità del genoma include le regole che proteggono il
> genoma. Un anello che potesse riscrivere il proprio Tier 0 non avrebbe Tier 0.

## 4. Gerarchia di mutabilità (Tier 0 / Tier 1 / Tier 2)

| Tier | Contenuto | Mutabilità |
|---|---|---|
| **Tier 0** | meta-regole COME-si-migliora + denylist + identità PADMIN | solo via ratifica CEO (mai via anello) — D8 |
| **Tier 1** | contenuto di skill e agenti | evolvibile dall'anello sotto gate (eval-gated + ratifica rinforzata) — D8 |
| **Tier 2** | artefatti operativi (report, log) | liberamente prodotto sotto mission |

> Identità PADMIN (`docs/paradigm/padmin/PADMIN_INDEX.md`) è Tier 0 perché definisce CHI è l'agente
> che esegue l'anello. Renderla Tier 1 permetterebbe all'anello di ridefinire la propria identità.
> Renderla con il contenuto-skill Tier 0 congelerebbe invece la missione di Fucina (auto-miglioramento):
> per questo il **contenuto** di skill/agenti resta Tier 1 (D8), mentre le **meta-regole del come** sono Tier 0.

## 5. Manutenzione

Il Tier 0 ha DUE classi (M-OS3-148). La manutenzione differisce per classe, ma in nessun caso è
auto-modifica dell'anello.

### 5.1 — L'ELENCO e la classe DURA (invariato — meta-livello)

- L'**elenco** del Tier 0 (COSA è protetto: il deny-set, i namespace `~/.os3-policy/*` e
  `~/.os3-approvals/*`, e questo file che l'elenco lo definisce) si **aggiunge o rimuove SOLO via
  ratifica CEO, mai per auto-modifica dell'anello** (coerente con §3 e invariante #6).
- La classe **DURA** — `~/.os3-policy/*`, `~/.os3-approvals/*`, l'intero kernel
  (`docs/paradigm/kernel/*`: il kernel OSZ e questo file W2) — è **nega-sempre, anche con un TOTP
  valido**: il merge è **atto umano**, mai via anello. Stesso principio del muro §7 (M-OS3-128).

### 5.2 — Il CONTENUTO dei documenti di classe PORTA (nuovo — M-OS3-148)

- Il **contenuto** dei documenti Tier-0 di classe **PORTA** (i costituzionali che il CEO fa
  legittimamente evolvere: `PATTERN_ANELLO`, `LSO_NOMENCLATURE_v3`/`INDEX`, `PADMIN_INDEX`,
  `M-OS3-121_RECINTO_PREVENTIVO_DESIGN`) può essere aggiornato tramite una **ratifica del CEO
  verificata meccanicamente**: (a) un **codice TOTP** che solo il CEO possiede (fattore di possesso,
  anti-replay) **E** (b) l'**approvazione interattiva** della chiamata in **modalità permessi
  non-auto** (l'occhio umano sulla scrittura reale). L'anello è la penna, il CEO è l'autore.
- **"Via anello" (§3) si intende: SENZA ratifica del CEO verificata meccanicamente.** Una scrittura
  autorizzata da (a)+(b) NON è auto-modifica dell'anello — rispetta la sostanza di §3/§5.
- **Un codice = una scrittura = un documento.** Nessun batch. La challenge mostra il target esatto.
- **Enforcer reale (fail-closed):** `fence-policy.sh` v2 (`fence_tier0_class` dura|porta +
  `fence_tier0_door`), i due chokepoint (`mission-state-guard.sh`, `fence-bash-guard.sh`),
  `os3-totp-grant`. In qualunque degrado (lib/deny-set/hardcore/stato TOTP/campo modalità assenti o
  ignoti) → tutto classe **dura** → deny. Il rollback è sempre nella direzione della chiusura.
- La Porta **non scavalca il Mission Protocol**: vale solo con mission in focus e stato `executing`
  (invariante #2, L1 non bypassabile). Nessuna scrittura Tier-0 "a freddo".


## 6. Stato di enforcement (onesto, no over-claim)

- **STRATO 2 — già reale**: tutti gli enforcer di §2 esistono e sono fail-closed (verificati in
  `~/.claude/hooks/`, mirror in `os3-matrix/hooks/`).
- **STRATO 1 — da cablare**: l'enforcement meccanico delle clausole costituzionali (oltre alla
  ratifica DOC-SYNC ESITO C + il working-set escluso) è in direzione, non ancora completo per ogni
  voce. Oggi lo STRATO 1 è protetto da ratifica umana + esclusione dal write-set, non da un hook
  dedicato per clausola.

## Cross-reference

- `docs/paradigm/lso/PATTERN_ANELLO_AUTOMIGLIORAMENTO_v1.0.0.md` (W1 — l'anello che questo Tier 0 vincola).
- `docs/paradigm/kernel/00_OSZ_ORACODE_SYSTEM_ZERO.md` (kernel — fonte di REGOLA ZERO e gerarchia).
- `docs/paradigm/nomenclature/LSO_NOMENCLATURE_v3.md §«I sei principi invarianti dello stack»` (i 6 invarianti).
- `docs/paradigm/nomenclature/LSO_NOMENCLATURE_INDEX.md` §0 (canone scale L/T/R).

## 7. Anti-distruzione dell'anello (M-OS3-128 — CEO 2026-06-30)

L'anello (l'agente) non esegue MAI azioni di azzeramento totale di dati/persistenza — né con un TOTP valido, né su richiesta esplicita del CEO in-banda. Il TOTP autorizza SOLO l'alto-rischio REVERSIBILE. L'azzeramento totale (`migrate:fresh/refresh/reset`, `db:wipe`, `DROP DATABASE`, `DROP SCHEMA`, e ogni operazione che cancella tutto) è muro assoluto; se voluto, lo esegue il CEO a mano, fuori dall'anello. Enforcer reale: `db-prod-guard.sh` (rule 1) + `totp-irreversible-gate.sh` (muro `MASS_DESTRUCTION`, mai TOTP-abile). Modificabile solo via ratifica CEO, mai via anello.
