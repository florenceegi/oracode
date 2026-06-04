# M-OS3-074 — Report Tecnico

**Titolo:** Skill /web-fx-displacement + template riusabile + criterio gate MO-8
**Trigger:** 3 · **Tipo:** feature · **Priorità:** P2 · **Organo:** oracode · **Data:** 2026-06-04

## Scope
Codificare in **skill riusabile** l'effetto immagini displacement WebGL validato su M-CAPASSO-030, così
ogni organo futuro lo adotti senza ripartire da zero ("skilliamolo" — richiesta CEO).

## Deliverable
- **`.claude/commands/web-fx-displacement.md`** — skill: quando usarlo/quando no, procedura (copia
  template → toggle a11y → marca img `data-fx-displace` → monta script solo sulle pagine target → tara),
  garanzie obbligatorie (PE + 6 guardie + per-immagine + same-origin), **verifica** (harness offline
  swiftshader obbligatorio + gate umano live + smoke test scope), anti-pattern/cicatrici (smoothstep edge,
  overlay full-viewport, ripristino-su-regressione, texture pallida), output (SSOT-DESIGN istanza + MO gate).
- **`templates/fx/fximage.v1.js`** — implementazione di riferimento MIT (WebGL2 raw, zero dipendenze),
  header generalizzato a template (toggle a11y configurabile, parametri tarabili).
- **`WEB_PAGE_QUALITY_GATE.md` → 1.3.0**: nuovo criterio **MO-8** (immagini displacement) + nota "effetti
  riusabili (skill)" che istituisce il pattern `/web-fx-*` + `templates/fx/`. Changelog + §9 + frontmatter.

## Verifica
- `tests/m-os3-074/skill.test.mjs` 12/12 verde (skill: sezioni chiave, PE, harness, smoothstep, per-immagine,
  tie MO, riferimento template; template: WebGL2, data-fx-displace, shader). `node --check` template OK.

## Fix audit (BLOCK risolto)
Audit → BLOCK: il template spediva l'**anti-pattern che la skill stessa vieta** — `smoothstep(0.45,0.0,d)`
(edge0>edge1, spec-undefined). Risolto: template + skill → `1.0 - smoothstep(0.0, 0.45, d)`; il test
tautologico è stato sostituito da una **rete anti-regressione reale** (vieta edge-invertiti + esige la
forma definita; control-test ok). WARN minori risolti: default `capasso-a11y` → `fx-a11y` (template
neutro); riga §9 "Data" del gate → `· 2026-06-04 (v1.3.0)` (via doc-sync).
> Nota: lo stesso bug latente esiste nel `fximage.v1.js` di Capasso (live, funziona perché i driver
> clampano) → fix correttivo in mission separata M-CAPASSO-031.

## DOC-SYNC
Trigger 3 (paradigma): gate 1.3.0; eventuale aggiornamento index/registry SSOT. Il template è MIT-pulito
(nessun riferimento a codice commerciale).
