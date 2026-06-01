---
title: Web Page Quality Gate
slug: web-page-quality-gate
doc_type: protocol
version: 1.0.0
status: current
date: '2026-05-22'
updated_at: '2026-05-22'
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

## 4. Processo di verifica — Quality Gate

L'enforcement è **automatizzato** da un **Quality Gate pre-commit** per pagine web pubbliche (90 criteri, 12 categorie; exit code `0 = PASS`, `1 = FAIL` su almeno un criterio obbligatorio fallito). Lo snippet bash di §4.2 è la **logica di riferimento**.

> **Invocazione concreta privata (M-OS3-048).** Il comando del gate (CLI, argomenti `argparse`, path) è un SSOT `visibility: private` nell'enforcement OS3 Matrix (repo privato): `web-page-quality-gate-impl`. Confine mono — il modello (i 90 criteri di §1-3) resta pubblico.

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
Accessibilita:     A-1..A-12  (alt, skip, contrast, focus, target size, aria, sr-only)
Performance:       P-1..P-12  (LCP, CLS, INP, FCP, Lighthouse >=90, images, fonts, JS)
Security:          SEC-1..SEC-10 (HSTS, CSP, nosniff, X-Frame, Referrer, Permissions,
                                  COOP, COEP, HTTPS, securityheaders.com A+)
i18n:              I-1..I-8   (tutte le lingue, diacritici, nomi legali, rich text,
                              meta lengths, title composition, JSON valid, no hardcoded)
Funzionalita:      F-1..F-7   (200 OK, response time, form, CORS, link interni/esterni)
Privacy:           PR-1..PR-4 (cookie, consenso, dark pattern, privacy link)
Agentic:           AB-1..AB-4 (llms.txt, sitemap in robots)
Sustainability:    WS-1..WS-3 (peso pagina, immagini, asset inutilizzati)
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
| Open Graph | og:* + twitter:card | attivo |
| W3C WSG | Web Sustainability Guidelines | target spec aprile 2026 |
| llms.txt | Convenzione community | emergente |

**Questo documento va aggiornato quando la ricerca di FASE 1 identifica cambiamenti.**

---

## 8. Versionamento e firma

**Versione**: 1.0.0
**Data**: 2026-05-22
**Autore**: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
**Origine**: Audit M-211 — difetti trovati post-deploy che il protocollo mission non preveniva

Il protocollo nasce dalla constatazione che "build passa" non equivale a "pagina eccellente". I criteri qui elencati sono la definizione operativa di "eccellente" per una pagina web pubblica.
