# M-OS3-076 — Report Tecnico

**Titolo:** Template fx robusto — canvas fixed che insegue il rect dell'img (drop-in)
**Trigger:** 3 · **Tipo:** refactor · **Priorità:** P2 · **Organo:** oracode · **Data:** 2026-06-04

## Scope
Applicando `/web-fx-displacement` a Le Vespe è emerso che le immagini reali spesso NON hanno un
`<figure>`/wrapper stretto (img nuda in section, o card `<li>` con testo). Il template v1 attaccava il
canvas al wrapper sbagliato (dimensione errata). Reso il posizionamento **universale**.

## Modifica (`templates/fx/fximage.v1.js` → @version 1.1.0)
- Canvas `position:fixed` appeso a `document.body`; nuova `place()` che a ogni frame setta
  `left/top/width/height` del canvas = `img.getBoundingClientRect()` e ridimensiona il buffer.
- Rimossa la dipendenza da `img.closest('figure')` / `parent.appendChild` / `parent` relative.
- Hover legato all'`<img>` (non al parent). `place()` chiamata anche nel loop `frame()` → il canvas
  insegue l'immagine durante scroll/resize/reflow.
- Shader invariato (fix M-031 mantenuto: `1.0 - smoothstep(0.0, R, d)`).
- Skill `/web-fx-displacement` aggiornata (nota "posizionamento drop-in ≥1.1.0").

## Verifica
- `tests/m-os3-076/positioning.test.mjs` 7/7 verde; `tests/m-os3-074/skill.test.mjs` ancora verde (non
  regredito). `node --check` OK.

## DOC-SYNC
Trigger 3: template paradigma + skill. Backward-compatible (funziona anche su markup con figure).
