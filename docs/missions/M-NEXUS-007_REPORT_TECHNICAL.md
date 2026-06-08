# M-NEXUS-007 — Report Tecnico

**Titolo:** Dottrina del Supervisor nel kernel OSZ (generica, diffusa a tutti i progetti)
**Tipo:** ARCH/paradigma · Trigger Matrix 6 · **Data:** 2026-06-09
**Autore:** Padmin D. Curtis (CTO AI) for Fabio Cherici (CEO) · **Esito:** chiusa · test green

## Scope
Promuovere la Dottrina del Supervisor (5 riflessi; pool grounded = esecutore default) dal CLAUDE.md locale di Fucina al **kernel paradigma** `CLAUDE_ORACODE_CORE.md` (canonico `oracode/templates/`), in versione **generica** (nessun nome-agente instance-specifico) → si diffonde a TUTTI i progetti via `@import` del CORE. Richiesta CEO 2026-06-08.

## Modifica
- `templates/CLAUDE_ORACODE_CORE.md`: nuova sezione "## Dottrina del Supervisor" (dopo "Agenti Specializzati"). I 5 riflessi: grounding (mai da memoria), routing (pool=esecutore default; Supervisor orchestra), REGOLA ZERO+onestà, misura-prima (Pilastro 5), no over-claim. Versione 1.1.0→1.2.0.
- Copia downstream Fucina `CLAUDE_ORACODE_CORE.md` sincronizzata.
- Test `tests/m-nexus-007/test_supervisor_doctrine.sh` (green).

## Distinzione
- **Generico (kernel):** i 5 riflessi + "pool = esecutore default" → paradigma, MIT, diffuso a tutti.
- **Specifico (SSOT Fucina):** il roster (quali dev/engineer) resta in `SSOT_INGEGNERI` / `SSOT_SUPERVISOR_DOCTRINE`.

## Diffusione
Ogni progetto Oracode `@importa` il CORE → eredita la Dottrina automaticamente. I cloni downstream (es. Fucina) si risincronizzano dal canonico.

## Confini
Solo paradigma, no codice. Penna unica nel kernel = corsia Fucina (patto SESSION_COORDINATION). Prossimo: i progetti esistenti si riallineano alla CORE 1.2.0 alla prossima sync.
