# /web-fx-displacement — Effetto immagini "displacement" WebGL (Asse Distinzione · MO)

Quando ricevi questo comando, applichi a un'istanza Oracode l'effetto immagini **displacement WebGL**:
le immagini si **rivelano da una distorsione liquida** al primo scroll-in e **ondeggiano ad acqua**
attorno al puntatore in hover. È un effetto "extra-luxury" dell'**Asse Distinzione** del Web Page
Quality Gate (criteri **MO — Motion & Interaction Quality**). Nasce da M-CAPASSO-030 (sito Pino Capasso)
ed è la base motion da cui un organo parte, non l'arrivo.

> Origine e cicatrici: questo skill codifica un lavoro reale già validato dal vivo + le lezioni dei suoi
> errori (vedi §Anti-pattern). Non reinventare: parti dal template, poi tara.

---

## Quando usarlo (e quando NO)

USA quando la pagina rappresenta **identità viva** (presente/futuro, brand, persone, lavori) e l'immagine
beneficia di un tocco sensoriale. Funziona benissimo su **ritratti/teste** (l'hover sembra "scompigliare i
capelli") e su foto-lavoro a colori.

NON usare su:
- pagine **sobrie/archivio/memoria** (es. un "Monumento" B&N) — l'effetto tradirebbe il tono;
- immagini di **oggetti/ambienti** dove la deformazione non aggiunge senso (es. un carousel di interni) —
  a meno di richiesta esplicita;
- contenuto **funzionale** (form, status). In quei casi dichiara l'Asse 2 non applicabile (gate §0.1).

Scelta delle pagine/immagini = **decisione intenzionale** (Pilastro 1), confermata dal CEO/committente.

---

## Procedura

**1. Copia il template**
`templates/fx/fximage.v1.js` (repo oracode) → `public/scripts/fximage.vN.js` dell'istanza.
> Convenzione asset versionato: il file sta sotto `/scripts/*.vN.js`. Se il deploy applica cache
> immutabile a lungo termine su quel path, **ogni modifica al contenuto richiede il bump `vN`** (v1→v2),
> altrimenti i client servono lo stale. (Cicatrice M-CAPASSO-029.)

**2. Adatta il toggle a11y**
Nel template, sostituisci la chiave `localStorage 'capasso-a11y'` con quella del pannello accessibilità
dell'istanza (se l'utente ha attivato "riduci animazioni", l'effetto NON parte).

**3. Marca le immagini target**
Aggiungi l'attributo `data-fx-displace` agli `<img>` da potenziare. Se l'istanza ha un componente immagine
(es. `MuseumPhoto.astro`), aggiungi una prop booleana `fx` che emette `data-fx-displace`:
```astro
<img ... class={...} data-fx-displace={fx ? '' : undefined} />
```
L'`<img>` reale **resta sempre nel DOM**: è il fallback (a11y/SEO/no-JS/mobile). Mai sostituirlo a build-time.

**4. Monta lo script SOLO sulle pagine scelte**
Importa `fximage.vN.js` solo nei layout/pagine target (scope discipline). Mai globale se non voluto.
```astro
<script type="module" src="/scripts/fximage.v1.js" is:inline></script>
```

**5. Tara i parametri** (nel template, nel fragment shader / costanti):
- ampiezza load-unveil (default `0.18`) — quanto è liquida la rivelazione;
- raggio/intensità hover (`1.0 - smoothstep(0.0, 0.45, d)` + `0.012`) — **edge0 < edge1** sempre (vedi anti-pattern);
- aberrazione cromatica creste (`0.004`).
Eleganza prima di spettacolo: parti gentile, alza solo se il CEO lo chiede.

---

## Garanzie obbligatorie (non negoziabili)

- **Progressive Enhancement (PE-1)**: l'`<img>` server-rendered è il fallback; il canvas lo **sostituisce
  visivamente** solo **dopo il primo frame** (`img.style.opacity='0'` dentro `frame()`, non prima). Se WebGL
  fallisce → l'immagine reale resta visibile.
- **Guardie di degrado (PE-3)**: WebGL2 + `pointer:fine` + `min-width 768` + `!prefers-reduced-motion` +
  `!save-data` + `!toggle a11y`. Fuori gating: nessun canvas. Tutto in `try/catch` (fallback silenzioso).
- **Posizionamento drop-in (template ≥1.1.0)**: il canvas è `position:fixed` e **insegue il bounding-rect
  dell'`<img>`** a ogni frame → funziona su qualsiasi markup (img nuda, card, grid) **senza** richiedere un
  `<figure>`/wrapper stretto. Basta `data-fx-displace` sull'`<img>`.
- **Per-immagine, mai full-viewport**: ogni immagine ha il proprio canvas dimensionato all'immagine. Un
  overlay full-viewport refrattivo può "opacizzare" l'intera pagina su bug dell'alpha. (Cicatrice M-CAPASSO-029.)
- **Texture same-origin**: usa solo immagini servite dalla stessa origin (no CORS taint su `texImage2D`).

---

## Verifica (il punto critico: il motion NON si vede headless)

1. **Harness offline OBBLIGATORIO prima del deploy.** Crea una pagina HTML standalone che inlinea lo
   shader, con **stati fissi** (es. `u_load` 0 / 0.5 / 1 e `u_hover` 1 + mouse al centro) e una texture
   reale, e cattura con render software:
   `google-chrome --headless=new --no-sandbox --enable-unsafe-swiftshader --use-gl=swiftshader
   --virtual-time-budget=3000 --screenshot=out.png file:///.../harness.html`
   Verifica: effetto **contenuto** per-immagine, **nessun wash**, settle a immagine nitida a `load=1`,
   cover-fit corretto. (Senza harness, NON deployare: lo screenshot headless normale non avanza WebGL.)
2. **Gate umano live (gate §8)**: dopo il deploy, il CEO/committente giudica hover e rivelazione dal vivo
   sul device reale (l'interazione non è verificabile in automatico).
3. **Test di scope (P0-13)**: smoke test che asserisce lo scope — l'effetto è SOLO sulle pagine volute,
   `data-fx-displace` presente lì e **assente** altrove; gli `<img>` restano nel DOM.

---

## Anti-pattern / cicatrici (da non ripetere)

- **`smoothstep` con edge invertiti** (`smoothstep(R,0,d)`) = **comportamento indefinito in GLSL** → l'alpha
  non va a zero e la texture copre tutta la pagina. Usa `1.0 - smoothstep(0.0, R, d)`.
- **Overlay full-viewport** per un "alone cursore" che vorrebbe distorcere il DOM: richiederebbe
  render-to-texture della pagina (pesante) e su bug opacizza tutto. Per immagini, l'approccio **per-immagine**
  è giusto. (L'alone-cursore è stato abbandonato a favore di questo.)
- **Regressione visibile sul live**: se l'effetto rompe la pagina, **ripristina subito** (smonta lo script)
  e debugga **offline** con l'harness. Mai lasciare il committente davanti a una pagina rotta.
- **Texture pallida = effetto pallido**: una distorsione su un'immagine quasi-bianca rende poco.

---

## Output e tracciamento

- Registra l'effetto nello **SSOT Design System** dell'istanza (sezione motion: quali immagini, gating, PE).
- Mappa sui criteri **MO** del `WEB_PAGE_QUALITY_GATE.md` (§3.14): movimento con scopo, guardie di degrado,
  60fps desktop, rispetto `prefers-reduced-motion`.
- Stack: **WebGL2 raw**, zero dipendenze (Pilastro 2 — niente three.js per questo). Nota: se l'istanza
  banna WebGL "per l'hero", questo effetto è su **immagini di contenuto**, non sull'hero → non viola il ban.

---

## Note operative
- File di riferimento: `templates/fx/fximage.v1.js` (questa repo, MIT).
- È un effetto **desktop-only by design**: su mobile/touch resta l'immagine. Coerente con la realtà degli
  effetti WebGL premium (anche i riferimenti north-star degradano su mobile).
- Mai promettere salti di metrica: questo è Asse 2 (distinzione), si **giudica dal vivo**, non si misura.
