---
name: oracode-doctrine
description: "Dottrina normativa Oracode — fonte unica per agenti. REGOLA ZERO, 6+1 pilastri, le 13 regole P0, sistema di priorita. Contenuto normativo VERBATIM dal CLAUDE_ORACODE_CORE.md (single-source, mai parafrasato). Le procedure profonde (metodo P0-8, flussi P0-13, ...) stanno nei file rules/ caricati on-demand via topic-index. Usa quando un agente deve applicare o citare una regola P0, un pilastro, o la disciplina Oracode."
---

# Oracode Doctrine — Skill normativa single-source

> Contenuto normativo **verbatim** da `CLAUDE_ORACODE_CORE.md` (paradigma MIT).
> Questa skill NON riscrive la norma: la proietta navigabile e ci aggiunge
> **profondita procedurale ed esempi** (file `rules/`, on-demand).
> Il CORE resta l'unico SSOT normativo. In caso di divergenza, **vince il CORE**.
>
> Provenienza meccanismo + attribuzione: vedi §Provenance in fondo.

---

## REGOLA ZERO — Principio fondante

**Mai dedurre. Mai completare lacune. Se non sai, chiedi.**

Davanti a informazione mancante, l'LLM non procede — si ferma e chiede.
La domanda sostituisce l'invenzione. La verifica sostituisce la deduzione.
REGOLA ZERO non è una P0 tra le altre — è il principio da cui derivano molte P0.

---

## Pilastri Cardinali (6+1)

| # | Pilastro | Principio |
|---|----------|-----------|
| 1 | **Intenzionalità Esplicita** | Dichiara sempre perché fai quello che fai. `@purpose` in ogni unità di codice |
| 2 | **Semplicità Potenziante** | Scegli sempre la strada che ti rende più libero. No over-abstraction |
| 3 | **Coerenza Semantica** | Parole e azioni allineate. Una funzione fa ciò che il nome promette |
| 4 | **Circolarità Virtuosa** | Bug → test. Feature → pattern. Ogni soluzione alimenta il sistema |
| 5 | **Evoluzione Ricorsiva** | Ogni risultato migliora il processo. Documentazione co-evolve col codice |
| 6 | **Sicurezza Proattiva** | Sicurezza by-design, non patch a posteriori. GDPR come infrastruttura |
| **+1** | **REGOLA ZERO** | Mai dedurre. Autorità superiore agli altri 6 |

---

## Sistema di Priorità P0-P3

| Priorità | Significato | Azione |
|----------|-------------|--------|
| **P0** | Sistema si rompe immediatamente | STOP. Correggi prima di procedere |
| **P1** | Codice non production-ready | Correggi prima del deploy |
| **P2** | Accumulo debito tecnico | Refactoring programmato |
| **P3** | Informazione di contesto | Consigliato, non vincolante |

---

## Le 13 Regole P0 Universali

Ogni regola nasce da un errore concreto in produzione. Sono cicatrici codificate.

| # | Regola | Istruzione operativa |
|---|--------|---------------------|
| P0-1 | **REGOLA ZERO** | Informazione mancante → STOP, chiedi. Mai dedurre, mai completare |
| P0-2 | **Translation keys** | Mai testo hardcoded in UI. Ogni stringa visibile passa per sistema i18n. Chiavi atomiche |
| P0-3 | **Statistics Rule** | Parametri statistiche sempre espliciti. Mai default nascosti, mai aggregazioni con parametri assunti |
| P0-4 | **Anti-Method-Invention** | Prima di chiamare un metodo, verifica che esista: grep o lettura file. Mai fidarsi che "dovrebbe esistere" |
| P0-5 | **UEM-First** | Errori passano dal gestore centralizzato. Mai try/catch improvvisati, mai solo log |
| P0-6 | **Anti-Service-Method** | Prima di chiamare un metodo di un service, verifica nel filesystem che il service esista e abbia quel metodo con quella firma |
| P0-7 | **Anti-Enum-Constant** | Prima di usare una costante enum, verifica che esista come case dell'enum. Mai completare con valori plausibili |
| P0-8 | **Complete Flow Analysis** | Prima di modificare qualcosa di non triviale, mappa il flusso completo in 4 fasi (vedi sotto) |
| P0-9 | **i18n completa** | Ogni nuova stringa disponibile in tutte le lingue target fin dal primo commit. Mai "le altre lingue le faccio dopo" |
| P0-10 | **Anti-bypass data layer** | Accesso al database sempre tramite service factory o repository. Mai query raw quando esiste un'astrazione |
| P0-11 | **DOC-SYNC** | Task non chiusa finché documentazione SSOT non è aggiornata con il codice. Codice e doc viaggiano insieme |
| P0-12 | **Anti-Infra-Invention** | URL, path, branch, config di deploy: verifica dalla fonte. Mai dedurre nomi plausibili |
| P0-13 | **Test-First Discipline** | Ogni feature/fix/refactor produce o aggiorna test. Task non chiusa senza test verde |

---

## Procedure profonde — on-demand

Le regole sopra sono la **norma** (verbatim). Il **metodo operativo** con esempi
sta nei file `rules/`, da caricare solo quando la regola entra in gioco.
Routing deterministico in `topic-index.md`.

| Regola | File procedura | Quando caricarlo |
|--------|----------------|------------------|
| P0-8 Complete Flow Analysis | `rules/p0-08-flow-analysis.md` | prima di modificare codice non triviale |
| P0-13 Test-First Discipline | `rules/p0-13-test-first.md` | apertura di feature/fix/refactor |

Altre P0 avranno il proprio `rules/p0-NN-*.md` con l'estensione della skill
(mission successive). La norma resta qui, verbatim; la procedura va on-demand.

---

## Provenance & Attribution

Il **meccanismo** progressive-disclosure di questa skill (SKILL.md sottile sempre-on
+ file caricati on-demand + topic-index) è ispirato al tool open-source
**book-to-skill** di **Virgilio Borges** (GitHub `virgiliojr94`), licenza **MIT**,
`https://github.com/virgiliojr94/book-to-skill` — Copyright (c) 2025 virgiliojr94.

Usiamo il *formato/meccanismo*, non la pipeline di estrazione PDF→testo (i doc
Oracode sono già markdown). Ringraziamento all'autore. Dettaglio completo e
condizioni MIT nel SSOT paradigma: `docs/paradigm/ssot/ORACODE_AGENT_SKILL.md`.
