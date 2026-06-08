# M-NEXUS-006 — Report Esteso

**Titolo:** E5-`/project` — la difesa Egida diventa parte del bootstrap di ogni LSO
**Data:** 2026-06-08 · **Autore:** Padmin D. Curtis (CTO AI) for Fabio Cherici (CEO)

## Perché

E1 (M-NEXUS-005) ha scritto nel kernel la clausola costitutiva: "un LSO si difende e lo prova,
in proporzione al rischio". Una clausola però resta lettera morta se non si fa rispettare in automatico.
E5 è il braccio operativo lato bootstrap: **ogni nuovo LSO creato con `/project` nasce difeso di default**,
senza azione manuale. Insieme all'hook enforcement os3-matrix (E5-os3-matrix, M-OS3-100, corsia Fortino),
chiude il cerchio: nascita difesa + blocco-consegna-senza-banco-PASS.

## Cosa cambia per chi usa `/project`

Prima: `/project` orchestrava detect → install → configure → scaffold, senza alcuna nozione di difesa.
Ora, per i progetti con OS3 Matrix (livello 2+):

1. **configure** chiede/deduce il **profilo di difesa** (`egida_profile`): `L1` leggero per vetrine,
   `L2-L3` per app con auth/dati, `L3-L4` per organi che trattano denaro/PII/blockchain. Il segnale di
   rischio NON è deducibile dal livello — si chiede (REGOLA ZERO).
2. **install** mette al sicuro gli starter di invarianti dentro il progetto (`.oracode/etc/egida/`), perché
   il clone Matrix da cui provengono è temporaneo e sparisce.
3. **scaffold** scrive il file `SECURITY_INVARIANTS.json` nella root del nuovo repo (starter del profilo,
   con target `<PLACEHOLDER>` che la corsia dell'organo riempirà coi valori reali) e marca il descrittore
   con `egida_gate: true` + `egida_profile`.
4. Il **riepilogo** finale ricorda all'utente due cose: riempire i placeholder degli invarianti, e che prima
   della consegna l'LSO dovrà passare il Banco di Prova (`/collaudo`).

## Proporzionalità rispettata

Un sito vetrina statico **livello 1 paradigm-only** (senza Matrix) NON riceve la difesa-by-default: niente
tooling, niente `egida_gate`. L'hook enforcement tratta il flag assente come zero requisito. Così la clausola
costitutiva (difesa obbligatoria per gli LSO, livello 3+) e la proporzionalità (non imporre Fortino a una
vetrina) coesistono senza contraddizione. È esattamente il "dove ha senso" della clausola.

## Coordinamento corsie

Tre gap di contract emersi durante l'analisi sono stati risolti con la corsia Fortino (`a430d03b`) sul
blackboard `SESSION_COORDINATION.md` e blindati nel contract (M-OS3-103) prima di scrivere una riga: dove
vivono gli starter al momento dello scaffold, il prerequisito Matrix, e lo scope di `fortino-check`. Nessuna
invenzione: `/project` copia gli starter di os3-matrix, non ne definisce il contenuto.

## Stato Egida complessivo

- **E1** clausola OSZ ✅ (M-NEXUS-005, mia)
- **E2** Fortino Liv.A ✅ · **E3** `/collaudo` ✅ · **E4** certificato Sigillo ✅ · **E5-os3-matrix** ✅ (corsia Fortino)
- **E5-/project** ✅ (questa)
- **E6** pilot end-to-end — resta, condiviso: EGI-Proof come primo organo che nasce difeso → collaudo → certificato.

## Prossimo

Con E1+E5 completi lato mio e tutta la metà Fortino chiusa, la catena Egida è integrata nel Nexus
(paradigma + bootstrap + enforcement + banco + certificato). Si sblocca **EGI-Proof** (direttiva CEO:
"no cose a metà" — i prerequisiti Egida ora ci sono). E6 sarà EGI-Proof stesso come pilota.
