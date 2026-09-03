---
title: Ruoli e contenitori — il documento definitivo della gerarchia Oracode Nexus
slug: ruoli-e-contenitori
doc_type: concept
version: 1.0.0
status: current
date: '2026-08-31'
updated_at: '2026-08-31'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- oracode
supersedes: []
superseded_by: null
visibility: public
rag: public
priority: high
---

# Ruoli e contenitori — il documento definitivo

> Testo ratificato dal CEO il 2026-08-31 (mission M-OS3-215). Le parole fra virgolette «» sono
> sue, verbatim, con la data. Questo è il documento autoritativo dei ruoli: gli altri documenti
> di nomenclatura rimandano qui. La proiezione machine-readable è il contratto L7
> `os3-matrix/contracts/role-enum.json` (le macchine leggono quello, mai una copia).

> **AGGIORNATO il 2026-09-03 (M-OS3-217), su decisioni del CEO del 2026-09-02.** Tre punti di
> questo testo sono superati e sono stati riscritti qui dentro, non altrove:
> **(a)** la difesa non e' piu' «per profilo di rischio»: Fortino si installa **tutto o niente** e
> discende dal ruolo (D16, parole sue: «Fortino si installa tutto o non si installa affatto,
> punto»); **(b)** le domande sul rischio — denaro, dati personali, blockchain — sono **eliminate**
> (D20); **(c)** la domanda della nascita **chiede il ruolo e si chiama cosi'**: la formula «Che
> cosa stiamo creando?» e' eliminata (D22). Il resto del documento resta in vigore.

## 1. La prima domanda

Alla nascita di ogni repository si chiede **il RUOLO**: che cosa è questo repository.
La risposta è una parola dei sei ruoli. Due sono già stati creati, sono unici, e non si
ricreeranno mai più (Oracode e os3-matrix): restano nell'elenco per capire il quadro intero.
**Le risposte reali oggi sono quattro: Libreria LSO · Organismo · Organo · Progetto.**
Dalla risposta discende tutto il resto da sé («a seconda della risposta tutto il resto
dovrebbe andare a posto da sé» — CEO, 31/08/2026).

## 2. Le sei parole, una per una

- **Oracode** (nel campo macchina: `paradigma`) — le regole, la legge. Licenza MIT. Già
  creato, unico.
- **os3-matrix** — l'attuazione che fa rispettare le regole. È il confine software del
  contenitore Softwarehouse: «tutto quello che potenzialmente viene venduto quando si vende
  Oracode Nexus» (CEO, 31/08). Già creato, unico.
- **Libreria LSO** — «si chiamano Librerie LSO perché sono
  componenti che potrebbero essere installati in un LSO» (CEO, 31/08). Fortino stesso è una
  Libreria LSO. **Non sono
  organismi: sono componenti PER gli organismi** — e quindi non ricevono il trattamento da
  LSO (e men che meno Fortino: sarebbe installare l'allarme dentro l'allarme).
- **Organismo** — un LSO multi-organo (es. FlorenceEGI, col repo-centro EGI-DOC).
- **Organo** — un LSO che appartiene a un Organismo. Non esiste da solo.
- **Progetto** — un lavoro con un committente, mono-organo. Può essere un LSO oppure no
  (vedi §4).

## 3. I due contenitori (che NON sono ruoli)

- **Softwarehouse** — il contenitore di ciò che si consegna quando si vende Oracode Nexus.
  Nel modello software il suo confine è os3-matrix (con le Librerie LSO); come entità
  titolare è l'azienda con licenza (oggi Florence EGI S.R.L.). Due sensi, entrambi
  legittimi, mai più confusi con un ruolo.
- **Customer** — il contenitore di ciò che la softwarehouse produce per i propri clienti:
  Organismi e Progetti.

## 4. Le domande conseguenti (la simmetria del disegno)

| Risposta | Domanda conseguente | Perché |
|---|---|---|
| **Organismo** | nessuna | è vivo per costruzione: riceve tutto |
| **Organo** | **«Di quale Organismo fa parte?»** | l'appartenenza È ciò che lo distingue: da lì il repo-centro, i registri, il circolatorio. Senza, sarebbe un Progetto travestito |
| **Libreria LSO** | nessuna | è un componente, non un organismo: niente trattamento LSO |
| **Progetto** | **«È un LSO?»** | un cliente può commissionare anche software che nasce finito (una vetrina, uno script): si costruisce, si consegna, e la sua storia è chiusa. «Un progetto che non integra l'asse difesa non è un LSO: è solo software» |

**La cascata del Progetto:** «È un LSO?» → **no**: regole di base e stop (sarebbe sbagliato
tempestare di domande una vetrina). → **sì**: riceve il corredo completo e Fortino **intero**. Le domande sul rischio e i profili
graduati sono ELIMINATI dal 2026-09-02 (D16, M-OS3-217): «Fortino si installa tutto o non si
installa affatto». Non si chiede mai «vuoi Fortino?» e non si chiede piu' nemmeno cosa rischia:
la difesa discende dal ruolo.

## 5. Che cosa discende da ogni risposta

| | Corredo operativo (missioni, doc-sync, cancelli, prove, memoria) | Difesa (Fortino: tutto o niente) |
|---|---|---|
| Organismo | tutto | sì — Fortino intero |
| Organo | tutto (registri nel repo-centro dell'Organismo) | sì — Fortino intero |
| Progetto-LSO | tutto | sì — Fortino intero |
| Progetto non-LSO | regole di base | no |
| Libreria LSO | disciplina di lavoro della softwarehouse (missioni, prove) | **no** — è lei che si installa negli altri |

## 6. La domanda «livello» muore

Il questionario non chiede più il «Livello di applicazione»: quel numero mescolava due
domande (quanta attrezzatura / che forma hai) e ha prodotto carte d'identità che si
contraddicevano da sole. Ciò che serviva sapere ora discende dal ruolo e dalla domanda-LSO.
Il campo esistente nelle carte d'identità resta per compatibilità come annotazione derivata,
non decide più nulla; il suo pensionamento completo è materia della mission che corregge
l'engine del bootstrap (parola CEO 31/08: «poi dovremo correggere anche di nuovo l'engine
del bootstrap in base a quello che abbiamo deciso»).

## 7. Le parole che non si confondono più

- **«Project operativo» del motore** (il contenitore di lavoro che ospita le mission dopo la
  Discovery) **si nomina sempre per esteso, mai «progetto» da solo**: aprire un Project
  operativo non rende `role=progetto` — DeepCodexDebug è il caso canonico (Project operativo
  sì, ruolo Libreria LSO).
- **«ruolo» resta la parola canonica** (decisione CEO 31/08: «Va bene per Ruolo»): «dominio»
  è già occupata dai domini web e dai domini di collaudo dell'Egida.
- La domanda del questionario **chiede il ruolo e si chiama così**. La vecchia formula «Che cosa
  stiamo creando?» è ELIMINATA dal 2026-09-03 (D22, ordine del CEO: «va eliminata erasa asfaltata
  bruciata»): era larga a piacere e non nominava la cosa che chiedeva.

## 8. L'instradamento dei documenti (la mappa ruolo → scope)

Lo `scope` (dove vengono indicizzati i documenti) si DERIVA dal ruolo con una mappa scritta
nel contratto `role-enum.json`, non più in prosa: Oracode → `paradigm` · os3-matrix →
`engine` · Libreria LSO → `nexus-tool` · Organismo e Organo → `organism` · Progetto →
`organism`. Eccezioni solo con parola CEO registrata.

---

*Ratifica: CEO 2026-08-31 («bene per questa mission con l'aggiornamento degli SSOT, ma poi
dovremo correggere anche di nuovo l'engine del bootstrap in base a quello che abbiamo
deciso»). Provenienza: conversazione di design 31/08, sessione os3-matrix-df; verifiche del
CEO superate (domanda conseguente dell'Organo, il perché del Progetto non-LSO, la cascata
del Progetto). Mission M-OS3-215.*
