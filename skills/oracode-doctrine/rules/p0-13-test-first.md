# P0-13 — Test-First Discipline (procedura on-demand)

> Norma (verbatim CORE): *"Ogni feature/fix/refactor produce o aggiorna test. Task
> non chiusa senza test verde."* Tre flussi distinti, sotto. La norma vince sempre.

## I 3 obblighi (verbatim dal CORE)

```
FEATURE NUOVA:
  P0-8 (identifica edge case) → test (red) → implementazione (green) → refactor → DOC-SYNC → chiusa

FIX:
  Bug riprodotto → test che lo cattura (red) → fix (green) → nessuna regressione → DOC-SYNC → chiusa

REFACTOR:
  Test esistenti verdi (baseline) → refactor incrementale → test verdi a ogni step → DOC-SYNC → chiusa
```

## Regola di sequenza (il punto che gli agenti invertono)
Il test **red viene PRIMA** dell'implementazione. Un test scritto dopo il codice
verde non prova nulla: conferma solo ciò che hai appena scritto. Il valore del
test-first è che il red dimostra che il test **sa fallire** quando la cosa è rotta.

## Esempio worked — FIX di un bug

Bug: `/bc/123` ritorna 404, dovrebbe redirezionare a `/c/123`.

1. **Riproduci**: `curl -i localhost/bc/123` → 404. Confermato.
2. **Test che lo cattura (RED)**:
   ```
   test('bc redirect to c', () => {
     const r = get('/bc/123');
     expect(r.status).toBe(301);
     expect(r.header.location).toBe('/c/123');
   });
   ```
   Esegui → **fallisce** (oggi è 404). Il red prova che il test è vivo.
3. **Fix (GREEN)**: aggiungi la route redirect. Riesegui → passa.
4. **Nessuna regressione**: l'intera suite resta verde (`/c/123` ancora ok).
5. **DOC-SYNC**: aggiorna l'SSOT che mappa le route. Poi chiudi.

## Esempio worked — REFACTOR
Prima di toccare: la suite è **verde** (baseline). Se non lo è, NON refactori —
prima ripari. Poi muovi a piccoli passi, suite verde a ogni step. Se uno step
diventa rosso, è il refactor ad averlo rotto, non un test sbagliato.

## Aggancio a P0-8
Per una feature nuova, gli edge case da testare li trovi con la FASE 1 di P0-8
(dove può fallire?). I due si compongono: P0-8 trova i casi, P0-13 li blinda.
Vedi `rules/p0-08-flow-analysis.md`.

---
*Procedura skill `oracode-doctrine`. Norma: CLAUDE_ORACODE_CORE.md §P0-13.*
