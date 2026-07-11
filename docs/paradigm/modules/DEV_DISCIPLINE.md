# Disciplina di Sviluppo — P0-8/P0-13 espansi · Firma · Pattern Output · Ultra (modulo on-demand)

> @package  oracode/paradigm/modules
> @author   Claude (CTO AI) for Fabio Cherici (CEO)
> @version  1.0.0 (M-OS3-144 D6+D8+D17+D18 — dieta CORE: dettaglio migrato dal CLAUDE_ORACODE_CORE)
> @date     2026-07-11
> @purpose  Dettaglio operativo della disciplina di sviluppo, caricato on-demand dal bootstrap
>           mirato (type=feature|fix|refactor) invece che a ogni boot. Le regole P0 in tabella
>           restano SEMPRE nel CORE; qui vivono le espansioni procedurali.

## P0-8 — Complete Flow Analysis (4 fasi obbligatorie)

```
FASE 1 — FLOW MAPPING
  User Action → Entry Point → Processing → Exit Point
  Dove può fallire? Dove cambiano i tipi? Branch logic?

FASE 2 — TYPE TRACING
  Per ogni variabile: tipo in ogni step. Ogni trasformazione esplicita.

FASE 3 — ALL OCCURRENCES
  Ricerca esaustiva di tutti gli usi nel codebase PRIMA di modificare.

FASE 4 — IMPACT ANALYSIS
  Mappa di chi viene impattato, upstream e downstream.
```

## P0-13 — Test-First Discipline (3 obblighi)

```
FEATURE NUOVA:
  P0-8 (identifica edge case) → test (red) → implementazione (green) → refactor → DOC-SYNC → chiusa

FIX:
  Bug riprodotto → test che lo cattura (red) → fix (green) → nessuna regressione → DOC-SYNC → chiusa

REFACTOR:
  Test esistenti verdi (baseline) → refactor incrementale → test verdi a ogni step → DOC-SYNC → chiusa
```

## Firma Oracode (P1)

Ogni file porta una firma. Non ornamento — dichiarazione di responsabilità.

```
@package  [modulo/area]
@author   [autore] ([ruolo]) for [CEO/responsabile]
@version  [versione] ([progetto])
@date     [data]
@purpose  [perché esiste questo file — Pilastro 1]
```

Assenza della firma non blocca lo sviluppo ma rende il file non production-ready.

## Pattern di Output — Principi

```
ERRORI:    Sempre via gestore centralizzato (UEM). Mai try/catch isolati, mai solo log.
I18N:      Chiavi atomiche. Mai testo interpolato nelle chiavi di traduzione.
SICUREZZA: Mai innerHTML raw senza sanitizzazione. Mai input utente non validato.
A11Y:      aria-label su button icon-only. aria-live su aggiornamenti dinamici. label[for] su input.
GDPR:      Audit trail su azioni utente con categoria classificata. Consenso versionato.
```

## Disciplina di Codice — Librerie Ultra

Responsabilità trasversali coperte da librerie obbligatorie. Ultra è parte del paradigma.

| Libreria | Sigla | Funzione | P0 di riferimento |
|----------|-------|----------|-------------------|
| Ultra Error Manager | UEM | Gestione errori centralizzata, recovery patterns | P0-5 |
| Ultra Log Manager | ULM | Logging strutturato, multi-channel, GDPR-aware | Sicurezza Proattiva |
| Ultra Translation Manager | UTM | Internazionalizzazione, chiavi atomiche | P0-2 + P0-9 |
| Ultra Config Manager | UCM | Configurazioni centralizzate | — |
| Ultra Upload Manager | UUM | Upload, validazione, scan, storage | — |

Multi-linguaggio nativo: Ultra esiste per PHP, TypeScript, e si estende al linguaggio target del progetto.
