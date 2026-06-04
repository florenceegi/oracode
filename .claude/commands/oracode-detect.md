# /oracode-detect — Rileva l'infrastruttura Oracode sul sistema

Micro-skill (READ-ONLY) del ciclo `/project`. Rileva cosa l'utente ha già installato e produce un **report di
capacità**. Invocabile da sola ("che infra Oracode ho?") o come Fase 0 dell'orchestratore `/project`. Non installa
nulla (→ `/oracode-install`), non configura (→ `/oracode-configure`).

## 0.1 Oracode Paradigma
Cerca `CLAUDE_ORACODE_CORE.md` in:
- `~/oracode-engine/CLAUDE_ORACODE_CORE.md`
- CWD e parent directories
- Path noti (es. `/home/*/oracode/templates/`)

Se trovato: "Oracode paradigma rilevato in [path]."
Se non trovato: "Oracode paradigma non rilevato. Vuoi installarlo ora?" → procedi a installazione.

## 0.2 OS3 Matrix
Cerca file di licenza OS3 Matrix in questo ordine:
1. Variabile ambiente `ORACODE_LICENSE_PATH` (se definita, usa quel path)
2. `~/oracode-engine/license.json` (path convenzionale)

Se trovato, leggi il file JSON e verifica:
- `product` deve essere `"os3-matrix"`
- `expires` deve essere una data futura (non scaduta)
- `repo` contiene l'URL del repo da cui clonare Matrix

Se licenza valida: "OS3 Matrix — licenza valida (scade [data]). Licensee: [name], [company]."
Se licenza scaduta: "OS3 Matrix — licenza SCADUTA il [data]. Rinnova per utilizzare Matrix."
Se non trovato: "OS3 Matrix non rilevato. Puoi operare con il paradigma (livello 1) o acquistare una licenza su [URL]."

## 0.3 Librerie LSO installate
Cerca librerie LSO già presenti nel sistema. Librerie note:

| Libreria | Sigla | Funzione | Fonte |
|----------|-------|----------|-------|
| Ultra Error Manager | UEM | Gestione errori centralizzata | Florence EGI (pubblica) |
| Ultra Log Manager | ULM | Logging strutturato, GDPR-aware | Florence EGI (pubblica) |
| Ultra Translation Manager | UTM | i18n, chiavi atomiche | Florence EGI (pubblica) |
| Ultra Config Manager | UCM | Configurazioni centralizzate | Florence EGI (pubblica) |
| Ultra Upload Manager | UUM | Upload, validazione, scan | Florence EGI (pubblica) |

Metodo di rilevamento: controlla package manager del progetto (composer.json, package.json), o path convenzionali. Se nessun progetto esiste ancora, segna "nessuna libreria rilevata".

**Output**: mostra il report detection all'utente prima di procedere (è l'input di `/oracode-install` e `/oracode-configure`).
