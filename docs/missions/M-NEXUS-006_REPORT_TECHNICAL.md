# M-NEXUS-006 — Report Tecnico

**Titolo:** E5-`/project` — Egida difesa-by-default nel bootstrap
**Tipo:** ARCH (flusso bootstrap) · Trigger Matrix 3 · **Data:** 2026-06-08
**Autore:** Padmin D. Curtis (CTO AI) for Fabio Cherici (CEO)
**Esito:** chiusa · test 16/16 green · commit `c7c5a90`

## Scope

Aggiungere al flusso `/project` l'installazione Egida-by-default, consumando
`EGIDA_INSTALL_CONTRACT §6` (corsia Fortino, M-OS3-099/103). Solo lato `oracode`; os3-matrix/FORTINO non toccati.

## Modifiche (commit `c7c5a90`)

| File | Cosa |
|---|---|
| `.claude/commands/oracode-configure.md` | Q8 — determina `egida_profile` ∈ {L1,L2-L3,L3-L4} da `level` + segnale rischio (denaro/PII/blockchain). Solo Matrix (liv 2+). Output esteso. |
| `.claude/commands/oracode-install.md` | Step 2.3.e — persiste `templates/egida/SECURITY_INVARIANTS.starter.*.json` (clone Matrix) → `.oracode/etc/egida/` (G1: clone è temporaneo). |
| `.claude/commands/oracode-scaffold.md` | Step 6b — copia starter `<profile>` → `<repo>/SECURITY_INVARIANTS.json` + scrive `egida_gate`/`egida_profile` nel descrittore. |
| `templates/PROJECT-DOC/.oracode/project.json` | `_meta.egida_fields` documenta i campi. Versione 1.0.0→1.1.0. |
| `.claude/commands/project.md` | Fase 5 — riepilogo cita la difesa Egida installata. |
| `tests/m-nexus-006/test_egida_project_install.sh` | Acceptance (16 assert). |

Deploy: i 4 command sincronizzati in `~/.claude/commands/`.

## Decisioni di contract (gap risolti con Fortino, M-OS3-103)

- **G1** — starter persistiti in `.oracode/etc/egida/` dall'install (clone Matrix temporaneo).
- **G2** — Egida-by-default da **livello 2+** (tooling vive in Matrix). L1 paradigm-only → nessun `egida_gate` (esente, "dove ha senso").
- **G3** — `fortino-check` fuori scope `/project` (runtime, via `--fortino-check`). §6 è l'interfaccia autoritativa.

> **Nota (estensione consumer):** il contract §6.2 enumera `1→L1, 2→L2-L3, 3→L2-L3` (non cita il level 4).
> `oracode-configure` aggiunge `4 → L2-L3` come default conservativo (un L4 multi-organo eredita il profilo medio,
> con upgrade a `L3-L4` sul segnale rischio denaro/PII/blockchain come per gli altri livelli). Non diverge dal
> contract (che non vieta L4); segnalato a corsia Fortino per eventuale ratifica in §6.2.

## Test

`tests/m-nexus-006/test_egida_project_install.sh` — 16 assert (dipendenza starter + configure/install/scaffold/descrittore/Fase5). Red→Green (11 fail pre → 16/16 post).

## Confini

os3-matrix/FORTINO non toccati. Descrittore stabile `egida_gate`/`egida_profile`. Hook enforcement = corsia Fortino (M-OS3-100). E6 pilot (EGI-Proof) = condiviso, prossimo.
