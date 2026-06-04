---
title: Web Page Quality Gate
slug: web-page-quality-gate
doc_type: protocol
version: 1.2.0
status: current
date: '2026-05-22'
updated_at: '2026-06-04'
author: Padmin D. Curtis for Fabio Cherici
scope:
- oracode
priority: high
visibility: public
rag: public
---

# Web Page Quality Gate — Protocollo Ultra Eccellenza

> Ogni pagina web pubblica dell'ecosistema deve passare qualsiasi test di terze parti al livello massimo. Questo protocollo definisce i criteri e il processo per garantirlo.

---

## 0. Scope e attivazione

Questo protocollo si attiva **automaticamente** quando una mission ha come deliverable una pagina web pubblica (nuova o modifica significativa). Si integra nel Mission Protocol v2.0.0 come gate obbligatorio tra FASE 4 (esecuzione) e FASE 5 (review).

> **Inquadramento Oracode Nexus.** Il gate si attiva nel ciclo mission del flusso Oracode Nexus (`/discovery` → `/project` → `/mission`, context-aware). La mission è auto-registrata nel `MISSION_REGISTRY` dell'istanza (Livello 3) tramite il ponte automatico L1→L3 risolto via `.oracode/project.json` dal CWD; il campo `standards_check` (vedi §1) va nella entry di quel registry. SSOT livelli: `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`.

**Trigger**: `type` in [feature, refactor] AND deliverable include file `.tsx`/`.html`/`.blade.php` serviti su URL pubblico.

> Nota chiavi: `type` è la chiave inglese canonica del MISSION_REGISTRY (decisione CEO 2026-05-30, vedi `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`). La chiave italiana `tipo_missione` è legacy di un'istanza (esempio: EGI-DOC, istanza FlorenceEGI).

### 0.1 I due assi: Correttezza e Distinzione

Questo gate misura **due assi indipendenti**. Passare il primo non implica il secondo.

```
ASSE 1 — CORRETTEZZA    (§3.1–§3.12)   Tecnico, verificabile, binario.
                                        HTML/SEO/Schema/a11y/perf/security/i18n.
                                        "Il test di terze parti passa al massimo."

ASSE 2 — DISTINZIONE    (§3.13–§3.15)  Editoriale, qualitativo, calibrato.
                                        Craft/motion/progressive-enhancement.
                                        "La pagina è al top nel mondo, non mediana."
```

**Una pagina può passare tutti i 101 criteri di correttezza ed essere comunque anonima.**
"Competente" è il default — ed è insufficiente per pagine vetrina/identitarie. L'Asse 2
è obbligatorio quando la mission produce una pagina che rappresenta un'identità (brand,
luogo, persona, dominio). Per pagine puramente funzionali (es. form interno, status page)
l'Asse 2 si dichiara non applicabile con motivazione.

> **Regola anti-mediano (origine M-LEVESPE 2026-06-02).** Quando l'LLM produce output
> "competente ma anonimo", sta servendo la propria metrica mediana. Riconoscere il default
> e romperlo deliberatamente è parte del gate, non un extra. La distinzione si **calibra**
> su riferimenti (vedi §8) e si **giudica dal vivo** dal CEO/committente sul device reale.

---

## 1. Ricerca standard aggiornati (FASE 1 — bootstrap)

**Obbligatorio a ogni mission** con deliverable pagina pubblica.

Prima di pianificare, ricerca sul web:

```
RICERCA STANDARD WEB — M-XXX
Query: "web quality standards [anno corrente]", "Lighthouse latest version",
       "Core Web Vitals updates", "WCAG latest", "Schema.org changes",
       "new SEO requirements", "security headers best practices [anno]"

Obiettivo: identificare standard nuovi o soglie cambiate rispetto alla
versione corrente di questo protocollo.

Se trovati cambiamenti: aggiornare questo documento PRIMA di procedere.
Se nessun cambiamento: dichiarare "standard confermati" e procedere.
```

Il risultato della ricerca va annotato nel report mission (campo `standards_check`).

---

## 2. Criteri di accettazione (FASE 3 — piano)

Il piano di implementazione DEVE includere una sezione "Criteri di Accettazione" che elenca quali dei criteri sotto si applicano alla pagina in lavorazione.

Non tutti i criteri si applicano a tutte le pagine (es. una pagina senza form non ha criteri CORS/form). Il piano dichiara esplicitamente quali si applicano e quali no (con motivazione).

---

## 3. Criteri — Checklist completa

### 3.1 HTML e Semantica

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| H-1 | `<!DOCTYPE html>` presente | obbligatorio | grep nel HTML generato |
| H-2 | `<html lang="xx">` corretto per locale | obbligatorio | grep nel HTML generato |
| H-3 | `<meta charset="utf-8">` entro primi 1024 byte | obbligatorio | grep nel HTML generato |
| H-4 | `<meta name="viewport" content="width=device-width, initial-scale=1">` | obbligatorio | grep nel HTML generato |
| H-5 | Singolo `<h1>` per pagina | obbligatorio | `grep -c '<h1' output.html` = 1 |
| H-6 | Gerarchia heading logica (h1 → h2 → h3, nessun salto) | obbligatorio | ispezione manuale |
| H-7 | Landmark semantici: `<main>`, `<nav>`, `<footer>` | obbligatorio | grep nel HTML |
| H-8 | Zero errori W3C Nu HTML Checker | obbligatorio | validator.w3.org/nu/ |
| H-9 | Zero tag HTML escapati nel testo visibile (`&lt;b&gt;`) | obbligatorio | grep `&lt;` nel HTML body |

### 3.2 SEO On-Page

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| S-1 | `<title>` presente, unico, 30-60 char | obbligatorio | grep + conteggio char |
| S-2 | Nessuna duplicazione nel title (verificare composizione con template layout) | obbligatorio | curl pagina live → grep `<title>` |
| S-3 | `<meta name="description">` presente, 120-160 char | obbligatorio | grep + conteggio char per ogni lingua |
| S-4 | `<link rel="canonical">` self-referencing, corretto per locale | obbligatorio | grep nel HTML |
| S-5 | Hreflang: un tag per ogni lingua + `x-default` | obbligatorio | conteggio tag = N lingue + 1 |
| S-6 | Hreflang bidirezionale: ogni lingua linka tutte le altre | obbligatorio | curl ogni locale, verificare set completo |
| S-7 | Pagina presente in `sitemap.xml` con hreflang | obbligatorio | curl sitemap, grep path |
| S-8 | `robots.txt` non blocca la pagina | obbligatorio | curl robots.txt |
| S-9 | Nessun `noindex` sulla pagina | obbligatorio | grep `noindex` = 0 |
| S-10 | Singolo `<h1>` contenente keyword principale | obbligatorio | ispezione |

### 3.3 Schema.org / Dati Strutturati

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| SD-1 | JSON-LD `@type: WebPage` specifico per la pagina | obbligatorio | parse JSON-LD, verificare @type |
| SD-2 | `name`, `description`, `url`, `inLanguage` presenti in WebPage | obbligatorio | parse JSON-LD |
| SD-3 | `isPartOf` collega al WebSite | obbligatorio | parse JSON-LD |
| SD-4 | Entita `about` appropriata (Organization, Person, Product, etc.) | obbligatorio | parse JSON-LD |
| SD-5 | Valori dinamici per locale (url, lang, name, description) | obbligatorio | confronto HTML di 2+ lingue |
| SD-6 | JSON-LD valido (no errori di parsing) | obbligatorio | `json.loads()` su ogni script ld+json |
| SD-7 | Nessun tipo deprecato da Google (verificare lista aggiornata) | obbligatorio | confronto con lista deprecati |

### 3.4 Open Graph e Social Sharing

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| OG-1 | `og:title` presente | obbligatorio | grep |
| OG-2 | `og:description` presente | obbligatorio | grep |
| OG-3 | `og:image` presente, 1200x630px, < 5MB | obbligatorio | grep + verifica asset |
| OG-4 | `og:url` presente | raccomandato | grep |
| OG-5 | `og:type` presente (website, article, etc.) | obbligatorio | grep |
| OG-6 | `og:locale` presente | obbligatorio | grep |
| OG-7 | `twitter:card` presente (summary o summary_large_image) | obbligatorio | grep |
| OG-8 | `twitter:title` e `twitter:description` presenti | obbligatorio | grep |
| OG-9 | `twitter:image` presente | obbligatorio | grep |
| OG-10 | Preview verificato su opengraph.xyz o Facebook Debugger | raccomandato | test manuale post-deploy |

### 3.5 Accessibilita (WCAG 2.2 AA — obbligatorio EU dal giugno 2025)

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| A-1 | Tutte le immagini hanno `alt` (decorative: `alt=""` + `aria-hidden="true"`) | obbligatorio | grep `<img` senza `alt=` = 0 |
| A-2 | Skip-to-content link presente | obbligatorio | grep nel HTML |
| A-3 | Contrasto testo: 4.5:1 (normale), 3:1 (grande/bold) | obbligatorio | Lighthouse Accessibility |
| A-4 | Focus visibile su tutti gli elementi interattivi | obbligatorio | test manuale tab navigation |
| A-5 | Focus non oscurato (WCAG 2.4.11) | obbligatorio | test manuale |
| A-6 | Target cliccabili >= 24x24px (WCAG 2.5.8) | obbligatorio | ispezione CSS |
| A-7 | `aria-label` su link/button icon-only | obbligatorio | grep button/a senza testo con aria-label |
| A-8 | `aria-hidden="true"` su elementi decorativi | obbligatorio | ispezione |
| A-9 | `sr-only` per contenuto screen-reader-only | obbligatorio | grep `sr-only` |
| A-10 | Ordine di lettura logico (DOM order = visual order) | obbligatorio | ispezione |
| A-11 | Link che aprono nuova finestra: indicatore per screen reader | obbligatorio | `target="_blank"` + sr-only "(nuova finestra)" o aria-label |
| A-12 | Form: `<label>` associato a ogni input, errori annunciati | se form presente | ispezione |
| A-13 | axe DevTools / axe-core: **0 violazioni** critical e serious | obbligatorio | axe DevTools o `@axe-core/cli` post-build |
| A-14 | WAVE (webaim.org): **0 errori** | obbligatorio | wave.webaim.org/report#/<url> post-deploy |

### 3.6 Performance

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| P-1 | LCP < 2.5s | obbligatorio | Lighthouse / PageSpeed Insights |
| P-2 | CLS < 0.1 | obbligatorio | Lighthouse / PageSpeed Insights |
| P-3 | INP < 200ms (su pagine interattive) | obbligatorio | Lighthouse / PageSpeed Insights |
| P-4 | FCP < 1.8s | obbligatorio | Lighthouse / PageSpeed Insights |
| P-5 | Lighthouse Performance >= 90 | obbligatorio | Lighthouse |
| P-6 | Immagini in WebP o AVIF | obbligatorio | ispezione asset |
| P-7 | `loading="lazy"` su immagini below-fold | obbligatorio | grep nel HTML |
| P-8 | `fetchpriority="high"` sull'elemento LCP | obbligatorio | grep nel HTML |
| P-9 | Font precaricati con `<link rel="preload">` | obbligatorio | grep nel HTML |
| P-10 | `font-display: swap` o `optional` | obbligatorio | ispezione CSS |
| P-11 | `width` e `height` espliciti su `<img>`, `<video>`, `<iframe>` | obbligatorio | grep nel HTML |
| P-12 | JS: defer/async su script non critici | obbligatorio | grep nel HTML |

### 3.7 Security Headers

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| SEC-1 | `Strict-Transport-Security: max-age=63072000; includeSubDomains; preload` | obbligatorio | curl -sI |
| SEC-2 | `Content-Security-Policy` con `default-src` | obbligatorio | curl -sI |
| SEC-3 | `X-Content-Type-Options: nosniff` | obbligatorio | curl -sI |
| SEC-4 | `X-Frame-Options: DENY` | obbligatorio | curl -sI |
| SEC-5 | `Referrer-Policy: strict-origin-when-cross-origin` | obbligatorio | curl -sI |
| SEC-6 | `Permissions-Policy: camera=(), microphone=(), geolocation=()` | obbligatorio | curl -sI |
| SEC-7 | `Cross-Origin-Opener-Policy` presente | raccomandato | curl -sI |
| SEC-8 | `Cross-Origin-Embedder-Policy` presente | raccomandato | curl -sI |
| SEC-9 | HTTPS attivo, nessun mixed content | obbligatorio | curl -sI |
| SEC-10 | securityheaders.com grade A o A+ | obbligatorio | test manuale post-deploy |
| SEC-11 | Mozilla Observatory (developer.mozilla.org/observatory) grade A o A+ | obbligatorio | test manuale post-deploy |

### 3.8 Internazionalizzazione (i18n)

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| I-1 | Tutte le lingue richieste presenti (P0-9) | obbligatorio | conteggio file i18n |
| I-2 | Diacritici corretti in ogni lingua | obbligatorio | ispezione post-traduzione |
| I-3 | Nomi legali/propri NON tradotti | obbligatorio | grep nome in ogni lingua |
| I-4 | Rich text (`t.rich()`) renderizzato correttamente in ogni lingua | obbligatorio | grep `<strong>` etc. in HTML per ogni locale |
| I-5 | Meta description length verificata per ogni lingua | obbligatorio | conteggio char per locale |
| I-6 | Title length verificata per ogni lingua (post-composizione template) | obbligatorio | grep `<title>` in HTML per ogni locale |
| I-7 | JSON i18n valido (no errori di parsing) | obbligatorio | `json.loads()` su ogni file |
| I-8 | Zero testo hardcoded nel codice (P0-2) | obbligatorio | ispezione page.tsx |

### 3.9 Funzionalita

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| F-1 | HTTP 200 su ogni locale | obbligatorio | curl per ogni lingua |
| F-2 | Tempo di risposta < 500ms | obbligatorio | curl -w %{time_total} |
| F-3 | Form: invio valido restituisce successo | se form presente | POST di test |
| F-4 | Form: CORS configurato correttamente | se form cross-origin | curl -X OPTIONS |
| F-5 | Link interni: nessun 404 | obbligatorio | crawl link nella pagina |
| F-6 | Link esterni: `target="_blank" rel="noopener noreferrer"` | obbligatorio | grep nel HTML |
| F-7 | Redirect da vecchi URL (se pagina rinominata) | se applicabile | curl vecchio URL |
| F-8 | **Pagina di errore 404 custom** brandizzata + **status HTTP 404 reale** su path non risolto (mai fallback a 200 che maschera l'errore). Server statico: `error_page 404 /404.html` + `try_files … =404` (no fallback a `/index.html`). i18n se il sito è multilingua | obbligatorio | `curl -o /dev/null -w "%{http_code}" <url>/path-inesistente` = 404 + corpo brandizzato |
| F-9 | **Integrità dei segnali di fiducia** (Pilastro 3 — Coerenza Semantica): ogni badge/claim di qualità, sicurezza o compliance esposto (SSL, Security, WCAG, GDPR, "zero tracking", ecc.) deve **linkare una prova** — validatore terzo live (SSLLabs, securityheaders, Observatory, WAVE) o pagina in-site che lo dimostra (es. privacy) — **oppure essere rimosso**. Vietati i "fake trust signals": claim decorativi non verificabili | obbligatorio | ispezione: ogni badge è `<a href>` verso prova; nessun claim statico nudo |

### 3.10 Privacy e GDPR

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| PR-1 | Sito statico senza cookie: nessun banner richiesto | verificare assenza cookie | DevTools → Application → Cookies |
| PR-2 | Se cookie presenti: consenso PRIMA del caricamento | obbligatorio | ispezione |
| PR-3 | "Accetta" e "Rifiuta" con stessa prominenza (no dark pattern) | obbligatorio | ispezione visiva |
| PR-4 | Link a Privacy Policy accessibile da ogni pagina | obbligatorio | ispezione footer |

### 3.11 Agentic Browsing (Lighthouse 13.3+, maggio 2026)

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| AB-1 | `/llms.txt` presente e raggiungibile | raccomandato | curl |
| AB-2 | `/llms.txt` in formato Markdown valido | raccomandato | parse |
| AB-3 | `/sitemap.xml` referenziato in `robots.txt` | obbligatorio | grep sitemap in robots.txt |
| AB-4 | Ogni elemento interattivo ha nome programmatico | obbligatorio | coincide con A-7/A-8 |

### 3.12 Web Sustainability (W3C WSG)

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| WS-1 | Peso pagina HTML < 200KB | raccomandato | stat HTML generato |
| WS-2 | Immagini ottimizzate (WebP/AVIF, dimensioni appropriate) | obbligatorio | coincide con P-6 |
| WS-3 | Nessun asset inutilizzato caricato | raccomandato | Lighthouse unused-css/js |

---

## 3bis. Asse Distinzione (§3.13–§3.15)

> Si applica a pagine che rappresentano un'identità. Verifica in parte **qualitativa**:
> dove la colonna "Verifica" dice "giudizio CEO" il criterio non è binario-automatizzabile —
> è un gate umano, deliberato. Non per questo opzionale.

### 3.13 Editorial Craft & Distinction (CR)

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| CR-1 | **Anti-mediano**: nessuna pagina "competente ma anonima". Ogni pagina chiave ha almeno un momento memorabile (gesto, composizione, transizione) che la distingue | obbligatorio | giudizio CEO + confronto north-star (§8) |
| CR-2 | **Raffinatezza per sottrazione**: una sola famiglia d'accento cromatico dominante, saturazione contenuta, whitespace generoso. Togliere prima di aggiungere | obbligatorio | ispezione design tokens |
| CR-3 | **Hero editoriale full-bleed** sulle pagine chiave (immagine a tutta larghezza + overlay tipografico + accento), non header testuale piatto | obbligatorio | ispezione |
| CR-4 | **Ritmo compositivo**: alternanza di blocchi (chiaro/scuro, testo/immagine, denso/arioso). Nessuna pagina mono-blocco | obbligatorio | ispezione sezioni |
| CR-5 | **Chiusura attiva**: ogni pagina termina con invito/cross-link, mai un "muro" statico | obbligatorio | ispezione fondo pagina |
| CR-6 | **Sistema, non one-off**: hero/sezioni/CTA derivano da componenti riusabili condivisi, non duplicati per pagina | obbligatorio | conteggio componenti condivisi |
| CR-7 | **Tipografia espressiva**: scala fluida (`clamp`), variable/opsz font dove disponibile, gerarchia visiva netta | raccomandato | ispezione CSS |
| CR-8 | **Identità riflessa**: l'estetica esprime il soggetto (luogo, brand, dominio), non un template generico riusabile per chiunque | obbligatorio | giudizio CEO |

### 3.14 Motion & Interaction Quality (MO)

> Il movimento è infrastruttura espressiva, non decorazione. Vincolato sempre all'Asse 1
> (perf §3.6, reduced-motion §3.5): la distinzione non sacrifica mai la correttezza.

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| MO-1 | **Easing fisico**: palette di easing definita (almeno soft/standard/elastic). Nessun `linear`/`ease` di default su transizioni espressive | obbligatorio | ispezione tokens CSS |
| MO-2 | **Reveal on-scroll** con stagger sui gruppi; nessun "pop-in" brusco | raccomandato | ispezione |
| MO-3 | **Profondità**: parallax o layering su almeno l'elemento hero, entro budget perf | raccomandato | ispezione |
| MO-4 | **Movimento ambientale lento e continuo** dove appropriato (ken-burns ≥ ~20s, marquee morbidi). Mai loop nervosi/veloci | raccomandato | ispezione durate |
| MO-5 | **`prefers-reduced-motion`**: TUTTE le animazioni espressive neutralizzate, contenuto pienamente fruibile | obbligatorio | toggle OS + ispezione |
| MO-6 | Nessun movimento blocca l'interazione o sposta il layout | obbligatorio | coincide con P-2 (CLS) |
| MO-7 | **Movimento = enhancement, mai prerequisito**: contenuto leggibile e completo senza JS | obbligatorio | disabilita JS + verifica |

### 3.15 Progressive Enhancement & Resilience (PE)

> L'eccellenza non si paga con la fragilità. Ogni enhancement ricco (3D/WebGL, smooth-scroll,
> sfogliabili, canvas) è uno strato sopra una base che funziona da sola.

| # | Criterio | Soglia | Verifica |
|---|----------|--------|----------|
| PE-1 | **Fallback semantico SEMPRE nel DOM**: la versione accessibile/SEO/no-JS è server-rendered; l'enhancement la sostituisce o arricchisce a runtime | obbligatorio | view-source con JS disabilitato |
| PE-2 | Enhancement decorativo marcato `aria-hidden`; non duplica contenuto agli screen reader | obbligatorio | ispezione (coincide con A-8) |
| PE-3 | **Guardie di degrado esplicite** per ogni enhancement pesante: `prefers-reduced-motion`, `navigator.connection.saveData`, capability check (es. WebGL) | obbligatorio | ispezione script |
| PE-4 | **Parità mobile per taratura, non per esclusione**: gli enhancement ricchi restano su mobile in forma adattata (DPR/qualità ridotti, single-column/single-page), non disattivati per default | obbligatorio | test su device mobile reale |
| PE-5 | `save-data` e `reduced-motion` sono gli **unici opt-out legittimi** del 3D/animazioni pesanti | obbligatorio | ispezione guardie |
| PE-6 | Asset JS/CSS di terze parti **self-hosted** (CSP `script-src 'self'`), mai CDN né inline | obbligatorio | coincide con SEC-2 + ispezione |
| PE-7 | **Filename versionato** per asset self-hosted con cache lunga; rinomina (`v1`→`v2`) a ogni cambio di contenuto, per cache-bust deterministico | obbligatorio | diff filename su modifica del contenuto |
| PE-8 | **Preload LCP per-pagina corretto**: si precarica l'immagine hero *di quella pagina*, non un default globale | obbligatorio | grep preload vs hero reale |

---

## 4. Processo di verifica — Quality Gate

L'enforcement dell'**Asse 1 (Correttezza)** è **automatizzato** da un **Quality Gate pre-commit** per pagine web pubbliche (101 criteri, 12 categorie tecniche; exit code `0 = PASS`, `1 = FAIL` su almeno un criterio obbligatorio fallito). Lo snippet bash di §4.2 è la **logica di riferimento**.

L'**Asse 2 (Distinzione, §3.13–§3.15)** è in parte auto-verificabile (es. PE-1 view-source senza JS, PE-7 diff filename, MO-1 grep easing tokens) e in parte **gate umano** (CR-1/CR-8 = giudizio CEO dal vivo, §5). Il Quality Gate automatico copre i controlli statici dell'Asse 2; i criteri qualitativi restano verdetto del committente sul device reale (§8 passo 4).

> **Invocazione concreta privata (M-OS3-048).** Il comando del gate (CLI, argomenti `argparse`, path) è un SSOT `visibility: private` nell'enforcement OS3 Matrix (repo privato): `web-page-quality-gate-impl`. Confine mono — il modello (i 101 criteri di §1-3) resta pubblico.

### 4.1 Durante la creazione (FASE 4)

Ogni file prodotto viene verificato **prima di passare al successivo**:

```
FILE CREATO: [path]

VERIFICA IMMEDIATA:
- [ ] HTML semantico (H-5, H-6, H-7)
- [ ] Zero testo hardcoded (I-8)
- [ ] alt su immagini (A-1)
- [ ] aria-label su button/link icon-only (A-7)
- [ ] target="_blank" ha rel="noopener noreferrer" (F-6)
- [ ] Rich text tags corretti nel codice (I-4)

VERIFICA i18n (dopo ogni file di traduzione):
- [ ] JSON valido (I-7)
- [ ] Diacritici corretti (I-2) — ispezione visiva
- [ ] Nomi legali/propri preservati (I-3)
- [ ] Meta description 120-160 char (I-5, S-3)
- [ ] Title senza duplicazione col template (I-6, S-2)
```

### 4.2 Pre-deploy (dopo build, prima di S3 sync)

In pratica si invoca il Quality Gate (vedi §4; comando concreto privato). Lo snippet sotto resta come **logica di riferimento** dei controlli sul HTML generato in `out/`:

```bash
# Eseguire per ogni locale
for lang in it en de es fr pt zh; do
  HTML="out/$lang/[pagina].html"

  # Struttura
  grep -c '<h1'          "$HTML"  # deve essere 1
  grep -c 'DOCTYPE html' "$HTML"  # deve essere 1
  grep -c '<main'        "$HTML"  # deve essere >= 1
  grep -c '<nav'         "$HTML"  # deve essere >= 1

  # Title (verificare NO duplicazione)
  grep -oP '<title>[^<]+</title>' "$HTML"

  # Meta description (contare char)
  python3 -c "..."  # come nell'audit M-211

  # Schema.org
  python3 -c "..."  # parse JSON-LD, verificare WebPage + about

  # Hreflang
  grep -oP 'hrefLang="[^"]+"' "$HTML" | wc -l  # deve essere N+1

  # OG tags
  for tag in og:title og:description og:image og:type og:locale; do
    grep -c "$tag" "$HTML"
  done

  # Accessibilita
  # Immagini senza alt
  python3 -c "import re; html=open('$HTML').read(); imgs=re.findall(r'<img[^>]+>',html); print([i for i in imgs if 'alt=' not in i])"

  # Security headers (post-deploy)
  # curl -sI "https://[dominio]/$lang/[pagina]"
done
```

### 4.3 Post-deploy (dopo CloudFront invalidation)

```
VERIFICA POST-DEPLOY:
- [ ] HTTP 200 su ogni locale (curl)
- [ ] Title corretto su URL live (curl → grep <title>)
- [ ] Security headers presenti (curl -sI)
- [ ] Sitemap aggiornato (curl sitemap.xml → grep pagina)
- [ ] robots.txt non blocca (curl robots.txt)
```

---

## 5. Escalation

Se un criterio **obbligatorio** non passa:

- **Bloccante**: la mission NON chiude finche il criterio non e soddisfatto
- **Eccezione site-wide**: se il problema e architetturale e riguarda tutto il sito (es. og:image mancante su tutte le pagine), dichiarare WARN con motivazione e aprire entry in MISSION_QUEUE per fix site-wide

Se un criterio **raccomandato** non passa:

- Dichiarare nel report mission come WARN con motivazione
- Non blocca la chiusura

Per i criteri dell'**Asse Distinzione** a verifica qualitativa ("giudizio CEO", es. CR-1,
CR-8): non sono auto-bloccabili da uno script — sono un **gate umano**. La mission non chiude
"distinzione PASS" finché il CEO/committente non l'ha giudicata dal vivo sul device reale.
L'LLM dichiara onestamente cosa NON è misurabile staticamente (resa motion/3D, impatto di una
transizione) e rimanda il verdetto, invece di auto-certificarsi eccellente.

---

## 6. Checklist sintetica (copia rapida per piano mission)

```
QUALITY GATE — Pagina web pubblica

HTML/Semantica:    H-1..H-9  (DOCTYPE, lang, charset, viewport, h1, heading order,
                              landmarks, W3C valid, no escaped tags)
SEO:               S-1..S-10 (title, desc, canonical, hreflang, sitemap, robots,
                              noindex, h1 keyword)
Schema.org:        SD-1..SD-7 (WebPage, about, locale-dynamic, valid JSON-LD)
Social:            OG-1..OG-10 (og:*, twitter:*, image 1200x630)
Accessibilita:     A-1..A-14  (alt, skip, contrast, focus, target size, aria, sr-only,
                                  axe 0 critical/serious, WAVE 0 errori)
Performance:       P-1..P-12  (LCP, CLS, INP, FCP, Lighthouse >=90, images, fonts, JS)
Security:          SEC-1..SEC-11 (HSTS, CSP, nosniff, X-Frame, Referrer, Permissions,
                                  COOP, COEP, HTTPS, securityheaders.com A+, Observatory A+)
i18n:              I-1..I-8   (tutte le lingue, diacritici, nomi legali, rich text,
                              meta lengths, title composition, JSON valid, no hardcoded)
Funzionalita:      F-1..F-9   (200 OK, response time, form, CORS, link interni/esterni,
                                  404 custom + status reale, trust-signal integrity)
Privacy:           PR-1..PR-4 (cookie, consenso, dark pattern, privacy link)
Agentic:           AB-1..AB-4 (llms.txt, sitemap in robots)
Sustainability:    WS-1..WS-3 (peso pagina, immagini, asset inutilizzati)

── ASSE DISTINZIONE (pagine identitarie) ──
Craft:             CR-1..CR-8 (anti-mediano, sottrazione, hero full-bleed, ritmo,
                              chiusura attiva, sistema, tipografia, identità)
Motion:            MO-1..MO-7 (easing fisico, reveal/stagger, profondità, ambientale,
                              reduced-motion, no-CLS, enhancement-non-prerequisito)
Progressive Enh.:  PE-1..PE-8 (fallback semantico, aria-hidden, guardie degrado, parità
                              mobile per taratura, self-hosted, filename versionato, preload LCP)
```

---

## 7. Standard di riferimento (maggio 2026)

| Standard | Versione | Stato |
|----------|----------|-------|
| Lighthouse | 13.3+ (con Agentic Browsing) | attivo |
| Core Web Vitals | LCP + INP + CLS | attivo (INP sostituisce FID da marzo 2024) |
| WCAG | 2.2 AA | obbligatorio EU (EAA, giugno 2025) |
| Schema.org | 31 tipi attivi rich results (marzo 2026) | attivo |
| HTML | Living Standard (W3C/WHATWG) | attivo |
| Security Headers | HSTS + CSP + COOP/COEP/CORP | attivo |
| Security scanners | securityheaders.com A+ + Mozilla Observatory A+ | attivo |
| A11y scanners | axe-core (0 critical/serious) + WAVE (0 errori) | attivo |
| Open Graph | og:* + twitter:card | attivo |
| W3C WSG | Web Sustainability Guidelines | target spec aprile 2026 |
| llms.txt | Convenzione community | emergente |
| Asse Distinzione (CR/MO/PE) | calibrato su north-star, non su spec esterna | attivo (da M-LEVESPE, giugno 2026) |

**Questo documento va aggiornato quando la ricerca di FASE 1 identifica cambiamenti.**

> L'Asse 1 (correttezza) insegue spec esterne aggiornate dalla ricerca di §1. L'Asse 2
> (distinzione) non ha una spec esterna: si calibra sui riferimenti del committente (§8) e
> si misura contro lo stato dell'arte del momento, non contro una soglia fissa.

---

## 8. Calibrazione Distinzione — metodo north-star

L'Asse 2 non si misura contro una soglia fissa: si **calibra**. Il metodo, in quattro passi,
è parte del Quality Gate per pagine identitarie e va eseguito **in FASE 1/3**, prima di costruire.

```
PASSO 1 — RACCOGLI RIFERIMENTI
  Il committente indica 2-4 siti che ammira (north-star). Sono la sua bussola estetica,
  non un capitolato di feature da copiare.

PASSO 2 — DISTILLA IL FILO COMUNE
  Non "che features hanno" ma QUALE PRINCIPIO condividono. Esempio di distillato:
  "raffinatezza per sottrazione" (saturazione bassa, un accento, motion fisico,
  whitespace costoso, sofisticazione tecnica invisibile). Il filo, non la copia.

PASSO 3 — PARAMETRA IL LAVORO SUL FILO
  Ogni scelta (palette, tipografia, motion, densità) si giustifica contro il filo distillato.
  Se una scelta non serve il filo, è rumore: si toglie (CR-2).

PASSO 4 — VALIDA DAL VIVO
  Motion, 3D, transizioni e sfogliabili NON rendono in screenshot headless. Il giudizio
  finale è del CEO/committente sul device reale (desktop E mobile). L'LLM consegna con
  onestà: dichiara cosa ha verificato staticamente e cosa richiede l'occhio umano.
```

**Trappola della metrica mediana.** Il default dell'LLM è "competente" — corretto, pulito,
anonimo. Per pagine identitarie è un fallimento dell'Asse 2. Riconoscere quando si sta
producendo il default e romperlo è una disciplina attiva, non un'aspirazione. Il segnale
d'allarme: "tecnicamente è tutto a posto" mentre la pagina non ha alcun momento che si
ricordi (viola CR-1).

**Restraint come default, non timidezza.** "Rompere il mediano" non significa caricare
effetti. La direzione è di solito *sottrarre* (CR-2): un accento, movimento fisico misurato,
spazio. La distinzione nasce dalla precisione delle poche cose presenti, non dal numero.

---

## 9. Versionamento e firma

**Versione**: 1.2.0
**Data**: 2026-05-22 (v1.0.0) · 2026-06-02 (v1.1.0) · 2026-06-04 (v1.2.0)
**Autore**: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
**Origine v1.0.0**: Audit M-211 — difetti trovati post-deploy che il protocollo mission non preveniva
**Origine v1.1.0**: ciclo mission M-LEVESPE (giugno 2026) — un sito identitario che passava
la correttezza ma veniva giudicato "mediano". Da lì l'Asse 2 (Distinzione: CR/MO/PE) + il
metodo north-star (§8).

Il protocollo nasce dalla constatazione che "build passa" non equivale a "pagina eccellente".
La v1.1.0 aggiunge la constatazione successiva: **"corretta" non equivale a "distinta"**. La
v1.2.0 rinforza l'Asse Correttezza con la lezione che **un errore nascosto resta un errore**
(404 che restituisce 200 — F-8) e che **un claim non provato è un anti-pattern** (fake trust
signals — F-9). I criteri qui elencati sono la definizione operativa di "eccellente" su
entrambi gli assi.

### Changelog

| Versione | Data | Modifica |
|----------|------|----------|
| 1.0.0 | 2026-05-22 | Protocollo iniziale — Asse Correttezza (§3.1–§3.12, 90 criteri). Origine audit M-211 |
| 1.1.0 | 2026-06-02 | Asse Distinzione: §0.1 (due assi), §3.13 Craft (CR-1..8), §3.14 Motion (MO-1..7), §3.15 Progressive Enhancement (PE-1..8), §8 metodo north-star, gate umano in §5. Origine M-LEVESPE |
| 1.2.0 | 2026-06-04 | Asse Correttezza esteso da rivalutazione esterna (Qwen) su Capasso: **F-8** (404 custom + status HTTP 404 reale, no fallback 200), **F-9** (integrità segnali di fiducia — anti fake trust signals, Pilastro 3), **SEC-11** (Mozilla Observatory A+), **A-13/A-14** (axe 0 critical/serious + WAVE 0 errori). Corretto anche il conteggio Asse 1 stale ("90"→**101**, P0-3 Statistics Rule). Origine M-OS3-072 (lezioni M-CAPASSO-024/025) |
