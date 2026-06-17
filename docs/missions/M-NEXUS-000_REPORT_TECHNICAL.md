# M-NEXUS-000 — Report Tecnico

> FASE 0 paradigma — SSOT pattern Anello di Auto-Miglioramento del Nexus + denylist Tier 0
> Repo: oracode (T1 paradigma) · Trigger: 3 · CEO: Fabio Cherici · 2026-06-16/17

## Obiettivo
Produrre i prerequisiti costituzionali (fondamento safety) PRIMA di ogni build dell'Anello di
Auto-Miglioramento del Nexus. Decisione CEO: partenza da FASE 0; autonomia v1 = agente PROPONE,
umano ratifica TUTTO.

## Deliverable prodotti
- **W1** `docs/paradigm/lso/PATTERN_ANELLO_AUTOMIGLIORAMENTO_v1.0.0.md` — SSOT del pattern:
  operazionalizzazione L9 Gamba B; due anelli annidati con barriera dura L8/L9; trigger PUSH
  UEM→`NexusNotificationHandler`→nexus.florenceegi.com; 4 punti-di-stop + GATE Q6 anti-soppressione;
  GATE Q7 anti-collapse; chiave di idempotenza (error fingerprint, R-1); barriera by-construction (R-3).
- **W2** `docs/paradigm/kernel/TIER0_CLAUSOLE_IMMUTABILI_v1.0.0.md` — denylist Tier 0 a due strati
  (costituzionale + operativo), ogni voce mappata al suo enforcer reale; gerarchia mutabilità
  Tier 0/1/2 (skill = Tier 1); meta-clausola.
- **Test** `tests/m-nexus-000/test_anello_ssot.sh` — P0-13, GREEN 16/16 (anticorpo costituzionale).

## Decisioni CEO ratificate (D5-D10)
- D5 Nexus = nexus.florenceegi.com (riceve segnale); code.florenceegi.com = workbench dev/sandbox.
- D6 trigger PUSH (NexusNotificationHandler, gemello di TelegramNotificationHandler); error_logs = store+recupero.
- D7 Tier 0 due strati, ogni voce → enforcer.
- D8 contenuto skill/agenti = Tier 1; Tier 0 = meta-regole + denylist + identità PADMIN.
- D9 (Q6) gate anti-soppressione: QUARANTENA richiede CAUSA-RIMOSSA, non sintomo-zittito. NUOVO.
- D10 (Q7) gate anti-collapse: stop-al-plateau + ri-derivazione da fonte primaria + misura esterna.

## Grounding e verifiche
- Pool grounded: engineer-architecture (sign-off SÌ-CON-RISERVE: R-1, R-3 piegate), oracode-specialist
  (conformità invarianti #2/#4/#6 OK), + i 5 engineer della fase di analisi (architecture, security,
  evaluator, construction, oracode-specialist).
- W1 referenzia (non duplica) `/home/fabio/Fucina/docs/ssot/SSOT_LOOP_PROTOCOL.md` (metodo-padre);
  Q7 = promozione a gate duro di principi preesistenti; Q6 = nuovo.
- Audit OS3: WARN→PASS dopo fix 2 citazioni off-by-N (W1 inv#3 :709→:711; W2 inv#2 :706→:710).
- DOC-SYNC v2: ESITO B additivo, success — SSOT_REGISTRY (48 doc), Oracode-Nexus-index, NOMENCLATURE_INDEX
  allineati; deliverable non toccato.

## Precondizioni di ATTIVAZIONE (mission separate, repo propri)
- **W3** (os3-matrix): chiusura falla scope-drift (`MISSION_PROTOCOL.md:473-478`).
- **W4** (EGI/infra): verifica isolamento `error_logs`↔DB prod + EC2 nexus/code.

## Stato
Status doc = DRAFT (costituzione ratificata dal CEO alla chiusura). STRATO 2 Tier-0 già enforced reale;
STRATO 1 in parte da cablare (onestà dichiarata in W2 §6).
