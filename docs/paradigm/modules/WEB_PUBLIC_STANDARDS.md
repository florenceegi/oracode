# Standard Web Pubblici — SEO · Accessibility · GDPR (modulo on-demand)

> @package  oracode/paradigm/modules
> @author   Claude (CTO AI) for Fabio Cherici (CEO)
> @version  1.0.0 (M-OS3-144 D21+D22+D23 — dieta CORE: dettaglio migrato dal CLAUDE_ORACODE_CORE)
> @date     2026-07-11
> @purpose  Standard per gli organi con superficie web pubblica e/o trattamento dati personali,
>           caricato on-demand dal bootstrap mirato (type=feature|fix) invece che a ogni boot di
>           ogni organo. Enforcement meccanico già attivo a prescindere dal boot:
>           web-quality-gate-guard.sh + seo-public-content-guard.sh (PreToolUse).

## SEO — Contenuto Pubblico

Ogni pagina pubblica indicizzabile rispetta disciplina SEO codificata:

- SSR obbligatorio per contenuto indicizzabile
- Meta tags strutturati (title, description, canonical, viewport, lang, robots)
- Open Graph + Twitter Card completi
- Core Web Vitals entro soglie definite dal progetto
- Schema.org / JSON-LD strutturato con componenti tipizzati

## Accessibility — WCAG 2.1 AA

Accessibilità è infrastruttura obbligatoria, non feature etica.

- Sistema ARIA tipizzato con componenti riutilizzabili
- Skip-to-main link
- Focus management (focus-visible, focus trap in modali)
- Keyboard navigation completa
- Contrast ratio minimo 4.5:1 testo, 3:1 UI elements
- `prefers-reduced-motion` rispettato
- Semantic HTML + Landmarks

## GDPR — Infrastruttura Strutturata

GDPR non è compliance a posteriori — è strato infrastrutturale di prima classe.
⚠️ **GDPR = Trigger Matrix tipo 4: approvazione CEO PRIMA di toccare** (regola nel CORE, sempre caricata).

- Servizio Consensi con versionamento e granularità
- Audit Trail immutabile con retention definita
- Tassonomia eventi strutturata (attività, privacy level, security events)
- Pagine legal pubbliche senza autenticazione
- Diritti utente operativi (accesso, portabilità, cancellazione)
- DPIA per organi che fanno profilazione o trattano dati sensibili
