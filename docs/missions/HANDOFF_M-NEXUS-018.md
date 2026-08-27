# HANDOFF — M-NEXUS-018 · il CORE rimanda al modulo Egida, non al charter d'istanza

> **Validità:** fino alla chiusura di M-NEXUS-018 (stessa sessione, 2026-08-27). CONSUMATO alla chiusura.
> Sorella di M-FORTINO-003 (FORTINO) e M-280 (EGI-DOC). Autore: Padmin D. Curtis (CTO) per Fabio Cherici (CEO).

## Cosa è stato fatto (verificato: test `docs/tests/m-nexus-018/verify_rimando_egida.sh` verde)

- `templates/CLAUDE_ORACODE_CORE.md` r.224-225: il rimando Egida punta a `docs/paradigm/modules/EGIDA_ASSE_DIFESA.md`;
  il charter di fondazione è dichiarato esperienza d'istanza, fuori dal prodotto. Versione template **2.2.1**.
- `docs/paradigm/index/Oracode-Nexus-index.md`: r.28 (riga Egida) rimanda al modulo; voce Fortino → repo `FORTINO/docs/lso/`.
- Commit `8d98147` (grano `core-rimanda-al-modulo-non-al-charter`) e `2af7580` (grano `dottrina-strumento-nel-proprio-repo`), pushati.
- Copie CORE riallineate: FORTINO (`d77b37a`) ed EGI-DOC (`0467562`). **Le altre 27 copie NO** — rinvio deciso dal CEO
  2026-08-27: le riallinea ciascun repo (`check_ecosystem_core_drift.sh` oggi segnala 28/28 in drift: segnale-fondo, riportato al CEO).

## Decisione che governa questa mission

CEO 2026-07-11 (M-OS3-144 D11) riconfermata 2026-08-27: «la storia resta tua, la dottrina è di tutti». Il charter resta in
`EGI-DOC/docs/oracode/Egida/00_EGIDA_CHARTER.md`. Lo step 3 di M-FORTINO-003 («charter nel paradigma») cade per questa decisione.

## PROSSIMO PASSO

1. Chiudere M-NEXUS-018 (auditing → closed → finalize).
2. Nessun lavoro residuo in oracode. Il riallineamento delle 27 copie è di ciascun organo, non di questa mission.
3. Nota per chi riprende M-NEXUS-015: porta un piano-capacità spurio attaccato per errore il 2026-08-27 (vedi memoria FORTINO).
