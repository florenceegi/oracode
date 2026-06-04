/**
 * @package  oracode/templates/fx
 * @author   Oracode paradigm (MIT) — reference implementation
 * @version  1.1.0 (template)
 * @purpose  TEMPLATE riusabile — effetto immagini "displacement" WebGL (skill /web-fx-displacement):
 *           ogni <img data-fx-displace> viene potenziata con un canvas WebGL2 sovrapposto che
 *           (1) la "rivela" con una distorsione liquida al primo scroll-in (IntersectionObserver) e
 *           (2) ondeggia ad acqua attorno al puntatore in hover. Progressive Enhancement: l'<img>
 *           reale resta nel DOM come FALLBACK (a11y/SEO/no-JS/mobile) e diventa trasparente SOLO dopo
 *           il primo frame del canvas. Gating desktop-only: WebGL2 + pointer:fine + min-width 768 +
 *           !prefers-reduced-motion + !save-data + !toggle a11y (chiave localStorage configurabile).
 *           Per-immagine (mai full-viewport) -> impossibile "opacizzare" la pagina. WebGL2 raw, zero
 *           dipendenze. Copia in public/scripts/fximage.vN.js dell'istanza e monta SOLO sulle pagine target.
 *           Tuning: ampiezza load (0.18), raggio/intensità hover, aberrazione cromatica (0.004).
 *           Toggle a11y: cambia la chiave 'fx-a11y' con quella del pannello a11y della tua istanza.
 */
(function () {
  try {
    var mm = window.matchMedia;
    if (!mm) return;
    var reduce = mm('(prefers-reduced-motion: reduce)').matches;
    var fine = mm('(pointer: fine)').matches;
    var wide = mm('(min-width: 768px)').matches;
    var saveData = navigator.connection && navigator.connection.saveData === true;
    var a11yMotion = false;
    try { a11yMotion = JSON.parse(localStorage.getItem('fx-a11y') || '{}').motion === true; } catch (e) {}
    if (reduce || a11yMotion || saveData || !fine || !wide) return; // fallback: <img> resta com'è

    var imgs = document.querySelectorAll('img[data-fx-displace]');
    if (!imgs.length) return;

    var VERT = '#version 300 es\nin vec2 p; out vec2 v; void main(){ v = p*0.5+0.5; gl_Position = vec4(p,0.,1.); }';
    var FRAG = '#version 300 es\n' +
      'precision highp float;\n' +
      'in vec2 v; out vec4 o;\n' +
      'uniform sampler2D u_tex; uniform vec2 u_res; uniform vec2 u_texres;\n' +
      'uniform float u_time; uniform float u_load; uniform float u_hover; uniform vec2 u_mouse;\n' +
      // value noise
      'float h(vec2 p){ return fract(sin(dot(p, vec2(127.1,311.7)))*43758.5453); }\n' +
      'float noise(vec2 p){ vec2 i=floor(p), f=fract(p); f=f*f*(3.0-2.0*f);\n' +
      '  return mix(mix(h(i),h(i+vec2(1,0)),f.x), mix(h(i+vec2(0,1)),h(i+vec2(1,1)),f.x), f.y); }\n' +
      'vec2 cover(vec2 uv){ float ra=u_res.x/u_res.y, ta=u_texres.x/u_texres.y;\n' +
      '  vec2 s = ra>ta ? vec2(1.0, ta/ra) : vec2(ra/ta, 1.0); return (uv-0.5)*s + 0.5; }\n' +
      'void main(){\n' +
      '  vec2 uv = v; uv.y = 1.0 - uv.y;\n' +
      // load: distorsione liquida che si calma (u_load 0->1)
      '  float le = 1.0 - clamp(u_load, 0.0, 1.0); le = le*le;\n' +
      '  float n1 = noise(uv*6.0 + u_time*0.25);\n' +
      '  float n2 = noise(uv*12.0 - u_time*0.18);\n' +
      '  vec2 ld = (vec2(n1, n2) - 0.5) * 0.18 * le;\n' +
      // hover: onde attorno al mouse
      '  float d = distance(v, u_mouse);\n' +
      '  float ring = sin(d*22.0 - u_time*4.0);\n' +
      '  float he = u_hover * (1.0 - smoothstep(0.0, 0.45, d));\n' + // edge0<edge1 (definito): 1 al mouse -> 0 a 0.45
      '  vec2 dir = normalize(v - u_mouse + 1e-5);\n' +
      '  vec2 hd = dir * ring * 0.012 * he;\n' +
      '  vec2 off = ld + hd;\n' +
      '  vec2 uvc = cover(uv + off);\n' +
      // leggera aberrazione cromatica sulle creste (tocco premium)
      '  float ca = (le*0.6 + he*0.4) * 0.004;\n' +
      '  float r = texture(u_tex, cover(uv + off + vec2(ca,0.0))).r;\n' +
      '  float g = texture(u_tex, uvc).g;\n' +
      '  float b = texture(u_tex, cover(uv + off - vec2(ca,0.0))).b;\n' +
      '  o = vec4(r,g,b, 1.0);\n' +
      '}';

    function makeGL(canvas) {
      var gl = canvas.getContext('webgl2', { antialias: false, premultipliedAlpha: true });
      if (!gl) return null;
      function sh(t, s) { var x = gl.createShader(t); gl.shaderSource(x, s); gl.compileShader(x); return x; }
      var pr = gl.createProgram();
      gl.attachShader(pr, sh(gl.VERTEX_SHADER, VERT));
      gl.attachShader(pr, sh(gl.FRAGMENT_SHADER, FRAG));
      gl.linkProgram(pr);
      if (!gl.getProgramParameter(pr, gl.LINK_STATUS)) return null;
      gl.useProgram(pr);
      var b = gl.createBuffer(); gl.bindBuffer(gl.ARRAY_BUFFER, b);
      gl.bufferData(gl.ARRAY_BUFFER, new Float32Array([-1, -1, 3, -1, -1, 3]), gl.STATIC_DRAW);
      var l = gl.getAttribLocation(pr, 'p'); gl.enableVertexAttribArray(l);
      gl.vertexAttribPointer(l, 2, gl.FLOAT, false, 0, 0);
      return { gl: gl, pr: pr };
    }

    var dpr = Math.min(window.devicePixelRatio || 1, 2);

    function enhance(img) {
      // attende che l'immagine sia decodificata (serve come texture)
      var run = function () {
        var box = img.getBoundingClientRect();
        if (box.width < 2 || box.height < 2) { return setTimeout(run, 120); }
        var canvas = document.createElement('canvas');
        canvas.setAttribute('aria-hidden', 'true');
        canvas.className = 'fx-canvas';
        var ctx = makeGL(canvas);
        if (!ctx) return; // niente WebGL2 -> resta l'<img>
        var gl = ctx.gl, pr = ctx.pr;

        // Posizionamento robusto (drop-in su qualsiasi markup): canvas FIXED che insegue il
        // bounding-rect dell'<img> a ogni frame. Nessuna dipendenza da un <figure>/wrapper stretto.
        canvas.style.cssText = 'position:fixed;left:0;top:0;display:block;pointer-events:none;z-index:5;';
        document.body.appendChild(canvas);
        function place() {
          var r = img.getBoundingClientRect();
          canvas.style.left = r.left + 'px'; canvas.style.top = r.top + 'px';
          canvas.style.width = r.width + 'px'; canvas.style.height = r.height + 'px';
          var w = Math.max(2, Math.round(r.width * dpr)), h = Math.max(2, Math.round(r.height * dpr));
          if (canvas.width !== w || canvas.height !== h) { canvas.width = w; canvas.height = h; gl.viewport(0, 0, w, h); }
        }

        var tex = gl.createTexture();
        gl.bindTexture(gl.TEXTURE_2D, tex);
        gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, false);
        gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, img);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
        gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);

        var U = {
          tex: gl.getUniformLocation(pr, 'u_tex'), res: gl.getUniformLocation(pr, 'u_res'),
          texres: gl.getUniformLocation(pr, 'u_texres'), time: gl.getUniformLocation(pr, 'u_time'),
          load: gl.getUniformLocation(pr, 'u_load'), hover: gl.getUniformLocation(pr, 'u_hover'),
          mouse: gl.getUniformLocation(pr, 'u_mouse')
        };
        var texW = img.naturalWidth || box.width, texH = img.naturalHeight || box.height;

        place();

        // NB: l'<img> viene reso trasparente SOLO dopo il primo frame disegnato (vedi frame()),
        // così se il canvas fallisse l'immagine reale resta comunque visibile (fallback robusto).
        var firstDrawn = false;
        var hover = 0, hoverTarget = 0, mx = 0.5, my = 0.5;
        img.addEventListener('pointerenter', function () { hoverTarget = 1; });
        img.addEventListener('pointerleave', function () { hoverTarget = 0; });
        img.addEventListener('pointermove', function (e) {
          var bb = img.getBoundingClientRect();
          mx = (e.clientX - bb.left) / bb.width; my = (e.clientY - bb.top) / bb.height;
        }, { passive: true });

        var load = 0, started = false, t0 = 0, visible = false, raf = 0;
        var io = new IntersectionObserver(function (es) {
          es.forEach(function (en) {
            visible = en.isIntersecting;
            if (visible && !raf) { raf = requestAnimationFrame(frame); }
          });
        }, { threshold: 0.12 });
        io.observe(img);

        function frame(ts) {
          if (t0 === 0) t0 = ts;
          if (!started) { started = true; }
          place(); // insegue posizione/dimensione dell'img (scroll, resize, reflow)
          // avvia il load solo quando visibile
          if (visible && load < 1) { load += 0.018; if (load > 1) load = 1; }
          hover += (hoverTarget - hover) * 0.08;
          var t = (ts - t0) / 1000;
          gl.useProgram(pr);
          gl.uniform1i(U.tex, 0); gl.activeTexture(gl.TEXTURE0); gl.bindTexture(gl.TEXTURE_2D, tex);
          gl.uniform2f(U.res, canvas.width, canvas.height);
          gl.uniform2f(U.texres, texW, texH);
          gl.uniform1f(U.time, t);
          gl.uniform1f(U.load, load);
          gl.uniform1f(U.hover, hover);
          gl.uniform2f(U.mouse, mx, 1.0 - my);
          gl.drawArrays(gl.TRIANGLES, 0, 3);
          if (!firstDrawn) { firstDrawn = true; img.style.opacity = '0'; } // ora il canvas è pronto: nascondi l'<img>
          // continua finché visibile o c'è movimento (load non finito / hover attivo)
          if (visible || load < 1 || hover > 0.01) { raf = requestAnimationFrame(frame); }
          else { raf = 0; }
        }
      };
      if (img.complete && img.naturalWidth) run();
      else img.addEventListener('load', run, { once: true });
    }

    function start() { imgs.forEach(enhance); }
    if ('requestIdleCallback' in window) requestIdleCallback(start, { timeout: 1500 });
    else setTimeout(start, 400);
  } catch (e) { /* fallback silenzioso: restano gli <img> */ }
})();
