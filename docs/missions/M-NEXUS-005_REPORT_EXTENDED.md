# M-NEXUS-005 — Report Esteso

**Titolo:** E1 Egida — Asse Difesa Costitutivo dell'LSO entra in OSZ
**Data:** 2026-06-08 · **Autore:** Padmin D. Curtis (CTO AI) for Fabio Cherici (CEO)

## Perché questa mission

Il CEO ha deciso che **la difesa di un software diventa proprietà costitutiva dell'LSO**, non un
add-on: "un organismo che non si difende — e non lo prova — non è un LSO, è solo software".
Questa decisione vive nel charter Egida (`EGI-DOC/docs/oracode/Egida/00_EGIDA_CHARTER.md`), che
restava in status PROPOSTA in attesa di ratifica. Il 2026-06-08 il CEO ha ratificato i 4
[DECISIONE CEO]:

1. **Clausola costitutiva** — un software che assume lo status di LSO deve avere la difesa.
2. **Proporzionalità** — la difesa scala col rischio (sito vetrina ≪ organo con transazioni).
3. **Nome "Egida"** — lo scudo si attribuisce quando un software unisce Fortino + DeepDebug.
4. **Fortino-di-default** — conseguenza operativa della 1: ogni LSO nasce difeso dove ha senso.

E1 è il passo di paradigma: scrivere la clausola nel kernel immutabile (OSZ) perché il kernel
rifletta la ratifica. Per una norma costituzionale, l'implementazione *è* il testo stesso — non
c'è codice separato. Il codice che la fa rispettare (checker, gate, certificato, `/project`) è la
catena E2..E6, su altre corsie.

## Cosa è stato scritto

Nel kernel `CLAUDE_ORACODE_CORE.md`, sezione "Asse Difesa Costitutivo — Egida", subito dopo
Mission Protocol (al pari di Mission Protocol e DOC-SYNC, come da charter):

- la **clausola** verbatim;
- il modello a tre + uno: **Fortino** difende (runtime) · **DeepDebug** collauda (banco di prova,
  esiste già) · **Egida** = usarli insieme (non un terzo strumento) · **Sigillo** certifica;
- la **matrice di proporzionalità** (4 profili: vetrina L1 → leggero; app auth/dati L2-L3; organo
  denaro/PII/blockchain L3-L4 → pieno; codice nativo → + memory/concurrency);
- i vincoli invarianti: triage (no "tutti a forza"), no over-claim, deterministico-dove-blocca,
  onestà epistemica.

Il Nexus index registra Egida tra le **Decisioni LOCKED** (legge anti-deriva). Il charter passa a
RATIFICATO. La copia downstream in Fucina è risincronizzata byte-identica.

## Coordinamento cross-session

Spartizione concordata su `~/oracode-engine/SESSION_COORDINATION.md` con la corsia Fortino
(`a430d03b`): **io** = E1 (questa) + E5-lato-`/project`; **lui** = E4 (certificato Sigillo) +
E5-os3-matrix (hook enforcement). E3 `/collaudo` già chiuso (M-OS3-097/098). Penna unica nel
kernel = io. E6 pilot insieme con EGI-Proof come target.

## Prossimo

Catena Egida ancora aperta: E4, E5 (entrambi i lati), E6. Per direttiva CEO "no cose a metà",
EGI-Proof parte solo a integrazione Egida completa. Mio prossimo step locale: E5-lato-`/project`
(consumo l'install-contract `os3-matrix/docs/lso/EGIDA_INSTALL_CONTRACT.md`).

## Audit OS3

Verdetto WARN→PASS: contenuto conforme (clausola verbatim, no drift, no over-claim, firme/versioni
in regola, test reale e verde). L'unico WARN era procedurale — la chiusura della mission stessa,
ora eseguita. Report: `~/oracode-engine/missions/M-NEXUS-005/audits/03-os3-audit-specialist.md`.
