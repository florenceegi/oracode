# HANDOFF — M-NEXUS-019 · il banner di deprecazione non elenca più DeepDebug tra i clienti

> **Validità:** fino alla chiusura di M-NEXUS-019 (2026-08-28). CONSUMATO alla chiusura.
> Autore: Padmin D. Curtis (CTO) per Fabio Cherici (CEO).

## Cosa è stato fatto (commit `194b811`; test `docs/tests/m-nexus-019/verify_banner_deepdebug.sh` verde)

- Conferma CEO 2026-08-28: **DeepDebug è Libreria LSO**, non un'istanza-cliente. Il banner DEPRECATO (M-OS3-138, 6 luglio)
  replicato nel paradigma diceva «istanze L3-clienti: FlorenceEGI, Capasso, LeVespe, DeepDebug»: corretto su **8 documenti versionati** (solo la riga del banner; corpi intatti, 3_TIER LOCKED compreso) + 1 file locale
  ignorato da git (`index/SSOT_NEXUS_COHERENCE_AUDIT_2026-05-31.md`, `.gitignore:20`): corretto sul disco, non versionabile.
- **Escluso** `docs/paradigm/kernel/00_OSZ_ORACODE_SYSTEM_ZERO.md`: Tier-0, deny-always (`fence-bash-guard`, W2 §3). Porta ancora la
  riga vecchia: si corregge solo con la cerimonia di ratifica CEO prevista per il kernel.
- Nata micro, promossa a piena per i tetti (13 file). Il commit `194b811` aveva trascinato 4 file residui di altre sessioni (`git add` largo):
  tre tolti dal tracking nel commit successivo (restano sul disco come trovati); il quarto e' un frontmatter `doc_type` di un documento
  Tier-0 di nomenclatura (deny-always): non posso ne' toglierlo ne' ratificarlo — decisione CEO in coda.

## PROSSIMO PASSO

1. Chiudere M-NEXUS-019 (auditing → closed → finalize).
2. Il CEO decide se aprire la cerimonia Tier-0 per la stessa riga nel kernel OSZ (una parola, stesso testo).
