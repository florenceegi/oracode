# P0-8 — Complete Flow Analysis (procedura on-demand)

> Norma (verbatim CORE): *"Prima di modificare qualcosa di non triviale, mappa il
> flusso completo in 4 fasi."* Qui sotto il **metodo** con esempio. La norma vince
> sempre sull'esempio.

## Le 4 fasi obbligatorie (verbatim dal CORE)

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

## Quando si applica
Modifica **non triviale**: cambia comportamento, firma, tipi, o tocca codice usato
in più punti. Un fix di una stringa locale NON la richiede; rinominare un metodo di
service SÌ.

## Esempio worked — rinominare `getStats()` → `computeStats()` in un service

**FASE 1 — Flow Mapping**
Controller `ReportController@index` → `StatsService::getStats($filters)` →
aggrega da repository → ritorna `StatsDTO` → view `report.blade`.
Può fallire se `$filters` arriva null (branch non gestito).

**FASE 2 — Type Tracing**
`$filters`: `array` nel controller → `Collection` dentro il service (trasformazione
esplicita a riga X) → `StatsDTO` in uscita. Il tipo cambia: annotare.

**FASE 3 — All Occurrences** (questo è il passo che gli agenti saltano)
```
grep -rn 'getStats' app/ resources/ tests/
```
Non fermarsi al primo hit. Trovati 3 usi: il controller, un job schedulato, un test.
Tutti e 3 vanno aggiornati nello stesso commit, o il rename rompe.

**FASE 4 — Impact Analysis**
Upstream: chi chiama `getStats` (controller, job, test).
Downstream: chi consuma `StatsDTO` (la view, un export CSV).
Il job schedulato gira di notte: se lo dimentichi, il fallimento è silenzioso fino
al giorno dopo. → impatto va dichiarato nel report di mission.

## Errore tipico che questa procedura previene
Saltare FASE 3 → impact analysis incompleta → rename applicato in 1 punto su 3 →
P0 (sistema si rompe) in un percorso non testato. È la violazione che la riga-secca
nel CORE non basta a evitare: serve il metodo.

---
*Procedura skill `oracode-doctrine`. Norma: CLAUDE_ORACODE_CORE.md §P0-8.*
