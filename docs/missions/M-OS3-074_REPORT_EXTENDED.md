# M-OS3-074 — Report Esteso

## Richiesta CEO
"Mi raccomando, skilliamolo adesso." Dopo l'approvazione dell'effetto immagini displacement su
M-CAPASSO-030, il CEO ha chiesto di trasformarlo subito in skill per gli agent — coerente con la sua
strategia: "documentare bene quello che riusciamo a fare ... creare skill per gli agent che
successivamente non avranno più alcuna difficoltà a creare questi effetti sensazionali". Posizionamento:
web agency extra-luxury.

## Cosa rende questa skill diversa da una semplice doc
Codifica non solo il "come", ma le **cicatrici** del lavoro reale (M-029/M-030), così l'agente non le
ripete:
- il bug GLSL `smoothstep` con edge invertiti (comportamento indefinito → pagina opacizzata);
- la scelta **per-immagine vs full-viewport** (l'overlay full-viewport per distorcere il DOM richiede
  render-to-texture ed è rischioso → abbandonato);
- la regola di processo "**regressione visibile = ripristino immediato + debug offline**";
- la **verifica offline obbligatoria con harness swiftshader** perché il motion WebGL non è verificabile
  con screenshot headless standard (questa è la rete anti-regressione del motion);
- la regola cache `vN` immutabile (bump su modifica).

## Architettura del pattern riusabile
- Skill `/web-fx-displacement` (prosa, in `.claude/commands/`) + template MIT `templates/fx/fximage.v1.js`.
- Tie nel gate: criterio **MO-8** + nota che istituzionalizza la famiglia `/web-fx-*` con template in
  `templates/fx/`. Così il gate (SSOT di qualità) e la skill (esecuzione) restano allineati.
- Progressive Enhancement come invariante non negoziabile (PE-1/PE-3 del gate): l'`<img>` reale è sempre
  il fallback; il canvas lo sostituisce solo dopo il primo frame.

## Confine MIT
Il template e la skill non contengono riferimenti a codice commerciale (os3-matrix). WebGL2 raw, zero
dipendenze (Pilastro 2). Pronti per essere pubblici nel paradigma.

## Seguito possibile (non in questa mission)
- Altri `/web-fx-*` (es. render-to-texture per distorsione del DOM vero, se mai servisse il livello "alone
  cursore" Lusion completo).
- Harness di verifica motion riutilizzabile come tool/skill dedicato.
