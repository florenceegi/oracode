# {{PROJECT_NAME}} — Configurazione Istanza

> Sezione progetto-specifica. Compila i placeholder con i dati del tuo dominio.
> Richiede: @CLAUDE_ORACODE_CORE.md (sempre)
> Opzionale: @CLAUDE_OS3_MATRIX.md (se livello 2+)

---

## Identità del Progetto

```
Nome:        {{PROJECT_NAME}}
Società:     {{COMPANY_NAME}}
Dominio:     {{DOMAIN_DESCRIPTION}}
Livello Oracode: {{ORACODE_LEVEL}} (1 = disciplina | 2 = enforcement | 3 = LSO mono | 4 = LSO multi)
```

---

## Modello Operativo

```
CEO:  {{CEO_NAME}} — visione, standard, approvazione architetturale
CTO:  {{CTO_NAME}} — esecuzione, enforcement, delivery
```

---

## Stack Tecnologico

```
Backend:    {{BACKEND_STACK}}
Frontend:   {{FRONTEND_STACK}}
Database:   {{DATABASE}}
Infra:      {{INFRASTRUCTURE}}
AI:         {{AI_STACK}}
```

---

## Lingue Target (P0-9)

```
{{TARGET_LANGUAGES}}
Esempio: it en de es fr pt
```

---

## Organi (se multi-organo, livello 4)

<!-- Compilare solo per livello 4. Per livelli 1-3 rimuovere questa sezione. -->

```
{{ORGANS_MAP}}
Esempio:
  CORE:     App (app.example.com) | HUB (hub.example.com)
  PUBBLICI: Website (example.com) | Info (info.example.com)
  INTERNI:  Stats | Docs
  DB condiviso: {{SHARED_DB}}
```

---

## P0 Dominio-Specifiche

Regole P0 aggiuntive specifiche del dominio, oltre alle 13 universali.

<!-- Compilare se il dominio richiede P0 proprie. Altrimenti rimuovere. -->

```
{{DOMAIN_P0_RULES}}
Esempio:
  P0-D1: [Regola specifica del dominio] — [istruzione operativa]
  P0-D2: ...
```

---

## Sistema Circolatorio (se esiste)

<!-- Compilare solo per livelli 3-4 con sistema circolatorio attivo. -->

```
{{CIRCULATORY_SYSTEM}}
Esempio:
  Nome:       Egili
  Natura:     Punti premio interni, zero valore monetario
  Compliance: MiCA-SAFE
  Regola:     Mai tasso diretto sistema↔EUR. Mai vendita diretta.
```

---

## Stack Bannati

```
{{BANNED_STACK}}
Esempio:
  Alpine.js + Livewire: ban codice nuovo. Eccezione: Strategia Delta su legacy.
  Filament: ban totale.
  Alternative: {{ALTERNATIVES}}
```

---

## Valori Immutabili

Decisioni non negoziabili del progetto. Non si cambiano senza approvazione CEO.

```
{{IMMUTABLE_VALUES}}
Esempio:
  - EGI ≠ NFT — distinzione fondamentale
  - Egili = punti premio, zero valore monetario
  - Non sostituto d'imposta
```

---

## Deploy

```
Pipeline:     {{DEPLOY_PIPELINE}}
Ambiente:     {{DEPLOY_ENVIRONMENT}}
Nota:         {{DEPLOY_NOTES}}
```

---

## Firma Progetto

```
@package  {{PACKAGE_PATTERN}}
@author   {{CTO_NAME}} ({{CTO_ROLE}}) for {{CEO_NAME}}
@version  1.0.0 ({{PROJECT_NAME}})
@date     YYYY-MM-DD
@purpose  [scopo specifico]
```

---

## Pattern Output — Specifici dello Stack

<!-- Esempi di codice idiomatico per lo stack scelto. -->

```
{{OUTPUT_PATTERNS}}
Esempio PHP:
  catch (\Exception $e) { return $this->errorManager->handle('ERRORE', [...], $e); }
  $this->auditService->logUserAction($user, 'action', $ctx, GdprActivityCategory::ENUM);

Esempio TS:
  element.innerHTML = DOMPurify.sanitize(content);
```

---

## Documenti Collegati

```
Boot context:   {{BOOT_CONTEXT_PATH}}
Mission Registry: {{MISSION_REGISTRY_PATH}}
SSOT Registry:    {{SSOT_REGISTRY_PATH}}
Organ Index:      {{ORGAN_INDEX_PATH}}
```

---

## Placeholder completi

```
{{PROJECT_NAME}}          — nome progetto
{{COMPANY_NAME}}          — società
{{DOMAIN_DESCRIPTION}}    — descrizione dominio in una riga
{{ORACODE_LEVEL}}         — livello applicazione (1-4)
{{CEO_NAME}}              — CEO/founder
{{CTO_NAME}}              — CTO/AI partner
{{CTO_ROLE}}              — ruolo CTO (es. "AI Partner OS3.0")
{{BACKEND_STACK}}         — stack backend
{{FRONTEND_STACK}}        — stack frontend
{{DATABASE}}              — database
{{INFRASTRUCTURE}}        — infrastruttura (es. AWS, GCP)
{{AI_STACK}}              — stack AI (es. Claude, GPT)
{{TARGET_LANGUAGES}}      — lingue i18n
{{ORGANS_MAP}}            — mappa organi (livello 4)
{{SHARED_DB}}             — DB condiviso (livello 4)
{{DOMAIN_P0_RULES}}       — P0 dominio-specifiche
{{CIRCULATORY_SYSTEM}}    — sistema circolatorio (livello 3-4)
{{BANNED_STACK}}          — stack bannati
{{ALTERNATIVES}}          — alternative agli stack bannati
{{IMMUTABLE_VALUES}}      — valori non negoziabili
{{DEPLOY_PIPELINE}}       — pipeline di deploy
{{DEPLOY_ENVIRONMENT}}    — ambiente (es. EC2, Vercel)
{{DEPLOY_NOTES}}          — note deploy
{{PACKAGE_PATTERN}}       — pattern @package per firma
{{OUTPUT_PATTERNS}}       — pattern output specifici dello stack
{{BOOT_CONTEXT_PATH}}     — path boot context
{{MISSION_REGISTRY_PATH}} — path mission registry
{{SSOT_REGISTRY_PATH}}    — path SSOT registry
{{ORGAN_INDEX_PATH}}      — path organ index
```

---

*Template istanza progetto per Oracode System.*
*Versione template: 1.0.0 — Data: 2026-05-25*
