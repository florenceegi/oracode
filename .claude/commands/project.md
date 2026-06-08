# /project — Bootstrap nuovo progetto Oracode

Quando ricevi questo comando, guida l'utente attraverso il bootstrap COMPLETO di un nuovo progetto Oracode,
**orchestrando in sequenza 4 micro-skill** (componibili, ognuna invocabile anche da sola). Il flusso ha fasi
sequenziali. Non saltare fasi. Non procedere senza risposte.

## Orchestrazione (esegui in quest'ordine, leggendo e applicando ciascuna micro-skill)

1. **`/oracode-detect`** (`.claude/commands/oracode-detect.md`) — rileva paradigma / OS3 Matrix (licenza) /
   librerie LSO sul sistema. Produce il report di capacità.
2. **`/oracode-install`** (`.claude/commands/oracode-install.md`) — presenta le opzioni e installa
   paradigma / Matrix (se licenziato) / librerie LSO scelte.
3. **`/oracode-configure`** (`.claude/commands/oracode-configure.md`) — raccoglie nome/società/CEO/dominio/
   stack/lingue, determina il livello (triage), domande condizionali per livello. Produce la config.
4. **`/oracode-scaffold`** (`.claude/commands/oracode-scaffold.md`) — genera la directory progetto, lo scaffold,
   CLAUDE.md, i registry e il **descrittore ponte L1→L3** `.oracode/project.json`.

Poi esegui la **Fase 5 — Riepilogo** (sotto). Lo stato passa di fase in fase: report → scelte → config → scaffold.

> Per un singolo pezzo (es. solo rilevare l'infra, o rigenerare lo scaffold da una config già nota), invoca
> direttamente la micro-skill corrispondente: sono componibili.

---

## Fase 5 — Riepilogo

Mostra all'utente:
- Struttura creata (tree)
- Infrastruttura Oracode installata (paradigma, Matrix, librerie)
- Livello determinato e perche
- **Difesa Egida installata** (se Matrix, livello 2+): profilo `egida_profile`, `SECURITY_INVARIANTS.json`
  scaffoldato nella root (target `<PLACEHOLDER>` da compilare dalla corsia dell'organo), `egida_gate` nel
  descrittore. Ricorda all'utente: prima della consegna l'LSO deve passare il **Banco di Prova** (`/collaudo`),
  e i `<PLACEHOLDER>` degli invarianti vanno riempiti coi valori reali dell'organo. Per L1 paradigm-only senza
  Matrix: nessuna difesa-by-default (proporzionalità — "dove ha senso").
- Prossimi passi consigliati per il livello scelto

<!-- Fase 5 sara espansa con step aggiuntivi futuri -->

---

## Note operative (valgono per tutte le fasi/micro-skill)

- MAI inventare risposte. Se l'utente non risponde, usa placeholder espliciti `[DA COMPILARE]`.
- La data nei file generati e la data corrente.
- Se il CWD non e il posto giusto, chiedi conferma del path di destinazione.
- Lo scaffold e minimale di proposito. Il progetto cresce con le mission, non con lo scaffold.
- I commenti `<!-- da formalizzare -->` segnano punti che richiedono decisioni future del CEO.
