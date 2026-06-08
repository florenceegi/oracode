/**
 * @package  oracode/templates/fx
 * @author   Oracode System (paradigma) — MIT
 * @version  1.0.0
 * @effect   Photo Wheel — giostra verticale a cilindro per sequenze di immagini (foto storiche,
 *           opere d'arte, portfolio). CILINDRO FINTO leggero: posizione CONTINUA; ogni immagine è
 *           trasformata indipendentemente (translateY = R·sin, scale/opacity da cos, lieve rotateX
 *           di tilt) in base alla distanza dal centro. La centrale è dritta e a piena dimensione
 *           (eroe); le vicine si inclinano e rimpiccioliscono in prospettiva; le lontane sfumano.
 *           FISICA: trascini (mouse/dito) sulle immagini O sulla ruzzola → ruotano in continuo;
 *           al rilascio una spinta gira per inerzia e poi SI ASSESTA da sola al centro (snap).
 *           Comandi: swipe sulle immagini, drag+rotellina sulla ruzzola, pulsanti su/giù, frecce.
 *           Tap/click secco su un'immagine = lascia passare il click (es. apertura lightbox).
 *
 *           Pure Vanilla JS, ZERO dipendenze (no three.js), self-hosted → CSP `script-src 'self'`.
 *           Progressive enhancement: si attiva SOLO se il moto è consentito; altrimenti resta il
 *           fallback statico (immagini impilate, server-rendered, a11y/SEO/no-JS safe).
 *
 * CONTRATTO HTML (vedi /web-fx-carousel per lo schema completo):
 *   <div data-photo-wheel [data-ang data-radius data-slideh data-tilt data-smin data-oppow
 *        data-friction data-snapms  data-word-photo data-word-of]>
 *     <div class="wheel-viewport">
 *       <ul class="wheel">
 *         <li class="slide" data-caption="…"><figure class="slide-fig">
 *           <img …/><figcaption class="slide-cap">…</figcaption></figure></li> × N
 *       </ul>
 *     </div>
 *     <div class="dial" aria-hidden="true"><span class="dial-ridges"></span><span class="dial-notch"></span></div>
 *     <div class="wheel-controls">
 *       <button class="wheel-btn" data-dir="up" …>▲</button>
 *       <button class="wheel-btn" data-dir="down" …>▼</button>
 *     </div>
 *     <p class="wheel-caption" aria-live="polite"></p>
 *   </div>
 *
 * ADATTAMENTO PER ISTANZA:
 *   - toggle a11y "riduci animazioni": `data-reduce-class` (default `a11y-reduce-motion`) = la classe
 *     che l'istanza mette su <html> quando l'utente disattiva le animazioni.
 *   - parametri di resa/fisica: tutti via data-attr (nessun rebuild dello script per tarare).
 */
(function () {
  'use strict';
  var stages = document.querySelectorAll('[data-photo-wheel]');
  if (!stages.length) return;
  var prefersReduce = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  Array.prototype.forEach.call(stages, function (stage) {
    var reduceClass = stage.getAttribute('data-reduce-class') || 'a11y-reduce-motion';
    var manualReduce = document.documentElement.classList.contains(reduceClass);
    if (prefersReduce || manualReduce) return; // resta il fallback statico
    initWheel(stage);
  });

  function initWheel(stage) {
    var slides = Array.prototype.slice.call(stage.querySelectorAll('.slide'));
    var N = slides.length;
    if (N < 2) return;

    var dial = stage.querySelector('.dial');
    var ridges = stage.querySelector('.dial-ridges');
    var captionEl = stage.querySelector('.wheel-caption');
    var btns = stage.querySelectorAll('.wheel-btn');
    var wordPhoto = stage.getAttribute('data-word-photo') || 'Foto';
    var wordOf = stage.getAttribute('data-word-of') || '/';

    // ── Parametri regolabili da HTML (data-attr sullo stage), con default calibrati ──
    function num(attr, def) { var v = parseFloat(stage.getAttribute(attr)); return isNaN(v) ? def : v; }
    var ANG = num('data-ang', 44);          // gradi virtuali fra un'immagine e l'adiacente sulla ruota
    var ANG_R = ANG * Math.PI / 180;
    var TILT = num('data-tilt', 0.8);       // quanto inclinare le carte (0 = piatte, 1 = tangente)
    var SMIN = num('data-smin', 0.46);      // scala minima delle carte lontane
    var RFAC = num('data-radius', 1.35);    // raggio verticale = slideH * RFAC (separazione)
    var SHFAC = num('data-slideh', 0.5);    // altezza immagine centrale = altezza viewport * SHFAC
    var OPPOW = num('data-oppow', 1.5);     // quanto sfumano le vicine (più alto = più stacco)
    var VIS = 0.05;                          // soglia: sotto cos(phi) la carta sparisce
    var FRICTION = num('data-friction', 0.93);
    var SNAP_VEL = 0.018;                     // sotto questa velocità scatta lo snap
    var SNAP_MS = num('data-snapms', 380);   // durata assestamento al centro
    var WHEEL_PUSH = 0.0011;
    var RIDGE_PX = 26;

    var pos = 0;             // posizione CONTINUA (indice centrale, frazionario)
    var vel = 0;             // velocità (immagini/frame)
    var R = 240;             // raggio verticale (px) — da layout()
    var pxPerStep = 200;     // pixel di drag per avanzare di 1 immagine — da layout()
    var raf = 0, mode = '';  // 'momentum' | 'snap' | ''
    var lastIdx = -1;

    stage.classList.add('is-wheel');

    function layout() {
      var vp = stage.querySelector('.wheel-viewport');
      var vh = vp.clientHeight || 420;
      var vw = vp.clientWidth || 600;
      var slideH = Math.round(vh * SHFAC);
      var slideW = Math.round(Math.min(slideH * 1.5, vw * 0.92));
      if (slideW >= Math.round(vw * 0.92)) slideH = Math.round(slideW / 1.5);
      stage.style.setProperty('--slide-w', slideW + 'px');
      stage.style.setProperty('--slide-h', slideH + 'px');
      R = slideH * RFAC;            // distanza verticale fra le carte (separazione)
      pxPerStep = slideH * 0.6;     // “quanto trascinare” per cambiare immagine
    }

    // distanza relativa minima (wrap circolare): risultato in (-N/2, N/2]
    function wrap(d) {
      d = d % N;
      if (d > N / 2) d -= N;
      if (d <= -N / 2) d += N;
      return d;
    }

    function render() {
      for (var i = 0; i < N; i++) {
        var rel = wrap(i - pos);
        var phi = rel * ANG_R;
        var cosp = Math.cos(phi);
        var s = slides[i];
        if (cosp <= VIS) { s.style.opacity = '0'; s.style.visibility = 'hidden'; continue; }
        var y = R * Math.sin(phi);
        var scale = Math.max(SMIN, cosp);
        var op = Math.pow(Math.max(0, (cosp - VIS) / (1 - VIS)), OPPOW);
        var rot = -rel * ANG * TILT; // sopra (rel<0) → top all'indietro
        s.style.visibility = 'visible';
        s.style.opacity = op.toFixed(3);
        s.style.zIndex = String(1000 + Math.round(cosp * 1000));
        s.style.transform = 'translate(-50%, -50%) translateY(' + y.toFixed(1) + 'px) rotateX(' + rot.toFixed(2) + 'deg) scale(' + scale.toFixed(3) + ')';
      }
      if (ridges) ridges.style.backgroundPositionY = (pos * RIDGE_PX).toFixed(1) + 'px';
      var idx = ((Math.round(pos) % N) + N) % N;
      if (idx !== lastIdx) {
        lastIdx = idx;
        var cap = slides[idx].getAttribute('data-caption') || '';
        if (captionEl) captionEl.textContent = wordPhoto + ' ' + (idx + 1) + ' ' + wordOf + ' ' + N + ' — ' + cap;
      }
    }

    function stop() { if (raf) { cancelAnimationFrame(raf); raf = 0; } mode = ''; }

    function momentum() {                 // inerzia → quando rallenta, passa allo snap
      pos += vel; vel *= FRICTION; render();
      if (Math.abs(vel) < SNAP_VEL) { snapTo(Math.round(pos)); return; }
      raf = requestAnimationFrame(momentum);
    }
    function snapTo(target) {              // assesta dolcemente al centro
      stop(); mode = 'snap';
      var start = pos, t0 = 0;
      function frame(ts) {
        if (!t0) t0 = ts;
        var k = Math.min(1, (ts - t0) / SNAP_MS);
        var e = 1 - Math.pow(1 - k, 3); // easeOutCubic
        pos = start + (target - start) * e; render();
        if (k < 1) raf = requestAnimationFrame(frame); else { pos = target; render(); raf = 0; mode = ''; }
      }
      raf = requestAnimationFrame(frame);
    }
    function fling() {
      stop();
      if (Math.abs(vel) > SNAP_VEL) { mode = 'momentum'; raf = requestAnimationFrame(momentum); }
      else snapTo(Math.round(pos));
    }

    // ── Drag (pointer unificato) sulla ruzzola ──
    var dragging = false, lastY = 0;
    function onDown(e) {
      dragging = true; stop(); vel = 0; lastY = e.clientY;
      if (dial.setPointerCapture && e.pointerId != null) { try { dial.setPointerCapture(e.pointerId); } catch (err) {} }
      e.preventDefault();
    }
    function onMove(e) {
      if (!dragging) return;
      var d = -(e.clientY - lastY) / pxPerStep;   // su → immagini salgono
      pos += d; vel = d; lastY = e.clientY; render();
      e.preventDefault();
    }
    function onUp(e) {
      if (!dragging) return;
      dragging = false;
      if (dial.releasePointerCapture && e.pointerId != null) { try { dial.releasePointerCapture(e.pointerId); } catch (err) {} }
      fling();
    }
    function onWheel(e) {                  // rotellina del mouse SULLA RUZZOLA → ruota (no scroll pagina qui)
      stop(); vel += -e.deltaY * WHEEL_PUSH; mode = 'momentum'; raf = requestAnimationFrame(momentum);
      e.preventDefault();
    }
    if (dial) {
      dial.addEventListener('pointerdown', onDown);
      dial.addEventListener('pointermove', onMove);
      dial.addEventListener('pointerup', onUp);
      dial.addEventListener('pointercancel', onUp);
      dial.addEventListener('wheel', onWheel, { passive: false });
    }

    // ── Swipe DIRETTO sulle immagini: desktop = premi e muovi; mobile = dito che scorre.
    //    Tap/click secco (senza muovere) = lascia passare il click (es. lightbox). ──
    var viewport = stage.querySelector('.wheel-viewport');
    var vDrag = false, vMoved = false, vStartY = 0, vLastY = 0, suppressClick = false;
    function vEnd(e) {
      if (!vDrag) return;
      vDrag = false;
      if (viewport.releasePointerCapture && e.pointerId != null) { try { viewport.releasePointerCapture(e.pointerId); } catch (x) {} }
      if (vMoved) { suppressClick = true; fling(); }
    }
    if (viewport) {
      viewport.addEventListener('pointerdown', function (e) {
        vDrag = true; vMoved = false; vStartY = e.clientY; vLastY = e.clientY; stop(); vel = 0;
        if (viewport.setPointerCapture && e.pointerId != null) { try { viewport.setPointerCapture(e.pointerId); } catch (x) {} }
        // niente preventDefault qui: un tap deve poter diventare click (lightbox/zoom)
      });
      viewport.addEventListener('pointermove', function (e) {
        if (!vDrag) return;
        if (!vMoved && Math.abs(e.clientY - vStartY) > 6) vMoved = true;
        if (vMoved) {
          var d = -(e.clientY - vLastY) / pxPerStep;
          pos += d; vel = d; render();
          e.preventDefault();
        }
        vLastY = e.clientY;
      });
      viewport.addEventListener('pointerup', vEnd);
      viewport.addEventListener('pointercancel', vEnd);
      // dopo uno swipe sopprimi il click (così non apre lo zoom); il tap secco invece lo apre
      viewport.addEventListener('click', function (e) {
        if (suppressClick) { suppressClick = false; e.stopPropagation(); e.preventDefault(); }
      }, true);
    }

    // ── Pulsanti su/giù (alternativa al drag, WCAG 2.5.7) + frecce tastiera ──
    Array.prototype.forEach.call(btns, function (btn) {
      btn.addEventListener('click', function () {
        var dir = btn.getAttribute('data-dir') === 'up' ? 1 : -1;
        stop(); snapTo(Math.round(pos) + dir);
      });
    });
    stage.addEventListener('keydown', function (e) {
      if (e.key === 'ArrowUp' || e.key === 'ArrowRight') { stop(); snapTo(Math.round(pos) + 1); e.preventDefault(); }
      else if (e.key === 'ArrowDown' || e.key === 'ArrowLeft') { stop(); snapTo(Math.round(pos) - 1); e.preventDefault(); }
    });

    // ── Resize ──
    var rt = 0;
    window.addEventListener('resize', function () {
      clearTimeout(rt);
      rt = setTimeout(function () { layout(); render(); }, 150);
    });

    layout();
    render();
  }
})();
