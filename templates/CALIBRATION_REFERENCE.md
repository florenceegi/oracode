# Calibrazione stime — Riferimento Oracode

> Ordini di grandezza REALI per calibrare le stime di `/discovery` (Fase 3).
> Numeri derivati da git history di progetti Oracode reali — non da stime a istinto.
> Tabella **anonimizzata** per archetipo: è parte del paradigma pubblico (MIT).

## Archetipi e ordini di grandezza

| Archetipo progetto | Ore reali | LOC | Cosa include |
|--------------------|-----------|-----|--------------|
| Sito vetrina + CMS | ~16h | ~18k | landing/marketing, CMS leggero, i18n base |
| Configuratore complesso | ~30h | ~27k | UI interattiva multi-step, stato client, validazioni |
| Business card virale | ~25h | ~15k | micro-app condivisibile, QR/vCard, deploy |
| Certificazione blockchain | 38–44h | ~17k | integrazione on-chain + pagina di verifica canonica |
| Wallet credenziali W3C | ~78h | ~45k | VC/DID, SD-JWT, flussi OID4VC/VP |

## Regole di calibrazione

- **La tendenza naturale è SOVRASTIMARE.** Se pensi "3 giorni" e l'archetipo simile dice "~16h", fidati dell'archetipo.
- I numeri sono ore di sviluppo *effettive* (da commit/sessioni), non calendario. Il calendario va calcolato a parte (non è sviluppo full-time).
- Scegli l'archetipo più vicino e adatta per scope/rischio, non ripartire da zero.

## Fonti

- **Calibrazione dettagliata per-progetto**: se l'organismo ha un registro numerico interno (es. metriche di sviluppo
  proprietarie), usalo come fonte primaria — resta privato all'organismo, non in questo file pubblico.
- **Tariffa oraria**: parametro commerciale dell'organismo. NON è codificata qui — chiedila al responsabile commerciale del progetto.
