# Egida — Asse Difesa Costitutivo dell'LSO (modulo on-demand)

> @package  oracode/paradigm/modules
> @author   Claude (CTO AI) for Fabio Cherici (CEO)
> @version  1.0.0 (M-OS3-144 D11 — dieta CORE: dettaglio migrato dal CLAUDE_ORACODE_CORE)
> @date     2026-07-11
> @purpose  Dettaglio operativo dell'asse difesa Egida (strumenti, proporzionalità, vincoli),
>           caricato on-demand dal bootstrap mirato (type=guard) invece che a ogni boot.
>           La clausola costitutiva resta nel CORE; la fonte della decisione è la ratifica
>           CEO 2026-06-08 (4 punti), entrata in OSZ via M-NEXUS-005.

## Clausola costitutiva (nel CORE, ripetuta qui per contesto)

**"Un LSO si difende e prova la propria difesa. La difesa è proporzionale alla superficie di rischio.
Un progetto che non integra l'asse difesa — dove esso ha senso — non è un LSO: è solo software."**

Conseguenza: l'asse difesa non è opzionale. Un software che assume lo status di LSO **deve** integrarlo.

## I due strumenti + l'ombrello

```
Fortino    — DIFENDE (difesa runtime continua, invarianti di sicurezza, sentinella, forense).
DeepDebug  — COLLAUDA (banco di prova: triage 5 domini, debug profondo, read-only). ESISTE GIÀ.
Egida      — USARLI INSIEME, in proporzione al rischio. NON un terzo strumento.
             Lo scudo "Egida" si attribuisce a un software quando unisce Fortino + DeepDebug.
Sigillo    — CERTIFICA (hash del report → ancoraggio Algorand + marca temporale TSA).
```

## Regola di proporzionalità — la difesa scala col rischio

"Dove ha senso" è **regola scritta**, non discrezione: il profilo di difesa è scalato sul **rischio R1-R4**
(R1 vetrina → R4 denaro/PII/blockchain). NB nomenclatura (M-FUC-040): "R" = rischio, "L" = maturità
(Layer Stack) — vedi LSO_NOMENCLATURE_INDEX §0.

| Livello / superficie | Banco di Prova (consegna, DeepDebug) | Fortino (runtime) |
|---|---|---|
| Sito vetrina statico (R1) | domini applicabili: reverse-security (secrets/headers/deps), perf | Liv. A leggero (secrets, headers, deps, TLS) |
| App con auth/dati (R2–R3) | + ai-driven (variant analysis) | Liv. A pieno + B (sentinella) |
| Organo con denaro/PII/blockchain (R3–R4) | tutti i domini applicabili | A + B + C (forense) |
| Codice nativo (C/C++/Rust-FFI) | + memory, concurrency | come sopra |

## Vincoli invarianti

- **Triage**: solo domini applicabili, mai "tutti a forza".
- **No over-claim**: si attesta "controlli superati in data certa", non "sicuro al 100%".
- **Deterministico dove blocca**: gate su regola scritta, mai su opinione di un modello — il passaggio AI è esplorativo.
- **Onestà epistemica** (REGOLA ZERO).

## Record storico

Il documento di fondazione (genesi, piano mission E1-E6, dottrina estesa) è esperienza d'istanza
FlorenceEGI e vive nel suo repo-centro: `EGI-DOC/docs/oracode/Egida/00_EGIDA_CHARTER.md`.
NON fa parte del prodotto (decisione CEO 2026-07-11, M-OS3-145/M-OS3-144): questo modulo è la
forma-paradigma, generica, del know-how ratificato.
