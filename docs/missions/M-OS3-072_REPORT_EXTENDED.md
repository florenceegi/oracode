# M-OS3-072 — Report Esteso

## Richiesta CEO
Dopo la rivalutazione esterna (Qwen) del sito Capasso, il CEO ha chiesto: estrai i consigli, verifica
l'attendibilità, correggi il sito, e "se ci sono cose che dobbiamo aggiungere al nostro SSOT
WEB_PAGE_QUALITY_GATE.md, aggiungiamole". Questa mission è la seconda metà: il travaso delle lezioni
nel gate di paradigma.

## Cosa è entrato nel gate (e perché è attendibile)
Filtrati i falsi positivi di Qwen (contrasto, OG, meta, font — già coperti dal gate o dal sito) e le
scelte CEO non negoziabili. Sono rimasti 4 gap di metodo, tutti verificati su Capasso prima di
codificarli:

1. **404 custom + status reale (F-8)** — Qwen ha segnalato "404 page spesso dimenticata". Su Capasso
   abbiamo scoperto che generare `dist/404.html` non basta: nginx con `try_files … /index.html`
   restituiva **200** su path inesistenti, mascherando l'errore. Il criterio richiede sia la pagina
   sia lo **status 404 reale** verificato via curl — la lezione vera era questa, non solo "fai la 404".
2. **Trust-signal integrity (F-9)** — Qwen: badge decorativi non dimostrabili = "fake trust signals".
   È puro Pilastro 3 (Coerenza Semantica): un badge "WCAG AA" che non porta a una prova è una parola
   che non corrisponde a un'azione. Il criterio impone link a prova o rimozione.
3. **Mozilla Observatory A+ (SEC-11)** — il gate aveva solo securityheaders.com; Observatory è il
   secondo scanner di riferimento di settore. Aggiunto come companion obbligatorio.
4. **axe / WAVE 0 errori (A-13/A-14)** — il gate misurava a11y solo via Lighthouse; axe e WAVE sono
   gli scanner che Qwen stesso indica come target per il "9,5/10". Resi espliciti.

## Decisioni di design del gate
- Nessuna rinumerazione dei criteri Asse Distinzione (§3.13–3.15 CR/MO/PE intatti): i nuovi criteri
  sono append nelle famiglie esistenti (A, SEC, F) → zero rotture di riferimenti.
- L'agente `web-quality-gate` legge il gate come fonte dati: i nuovi criteri sono attivi senza
  modifiche al codice dell'agente (SSOT-driven by design).

## Esito
Gate 1.1.0 → 1.2.0. Test di presenza verde. I criteri sono già stati applicati e dimostrati su Capasso
(M-CAPASSO-024/025), quindi nascono "PRODUCTION", non "DESIGN".
