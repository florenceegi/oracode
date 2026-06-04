# M-OS3-072 — Report Tecnico

**Titolo:** Web Quality Gate v1.2.0 — 404 custom, trust-signal integrity, Observatory, axe/WAVE
**Trigger:** 3 · **Tipo:** feature · **Priorità:** P2 · **Organo:** oracode · **Data:** 2026-06-04

## Scope
Estendere l'Asse Correttezza del Web Page Quality Gate con i criteri di metodo emersi dalla
rivalutazione esterna (Qwen) del sito Capasso — gap reali non ancora codificati nello standard.

## Modifiche a `docs/paradigm/standards/WEB_PAGE_QUALITY_GATE.md`
- **A-13** — axe DevTools / axe-core: 0 violazioni critical e serious (§3.5).
- **A-14** — WAVE (webaim.org): 0 errori (§3.5).
- **SEC-11** — Mozilla Observatory grade A/A+ (§3.7), affianca securityheaders (SEC-10).
- **F-8** — Pagina 404 custom brandizzata + **status HTTP 404 reale** (mai fallback 200 che maschera
  l'errore). Server statico: `error_page 404 /404.html` + `try_files … =404` (§3.9).
- **F-9** — **Integrità dei segnali di fiducia** (Pilastro 3): ogni badge/claim (SSL, Security, WCAG,
  GDPR, zero-tracking…) deve linkare una prova (validatore terzo live o pagina in-site) o essere
  rimosso. Vietati i "fake trust signals" (§3.9).
- Aggiornati: checklist sintetica §6 (range A/SEC/F), tabella standard §7 (scanner security + a11y),
  frontmatter `version 1.1.0→1.2.0` + `updated_at`, changelog.

## Verifica
- `tests/m-os3-072/gate-v120.test.mjs` 6/6 verde (presenza F-8/F-9/SEC-11/A-13/A-14 + version 1.2.0).

## Provenienza
Lezioni da M-CAPASSO-024 (sr-only/schema) e M-CAPASSO-025 (404 custom + trust-badge onesti +
nginx error_page verificato live). I criteri sono la generalizzazione paradigmatica di quei fix.

## DOC-SYNC
Trigger 3: il gate è SSOT di paradigma. Consumatori: agente `web-quality-gate` (legge i criteri come
fonte dati, non hardcoded → nessuna modifica codice agente necessaria) e ogni mission con deliverable
pagina web pubblica.
