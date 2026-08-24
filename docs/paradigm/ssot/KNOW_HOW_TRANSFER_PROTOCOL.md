---
title: Protocollo Trasferimento Know-How — Privato → Prodotto
slug: know-how-transfer-protocol
doc_type: concept
status: current
visibility: public
rag: public
---

# Protocollo Trasferimento Know-How — Privato → Prodotto

> Principio costituzionale in `CLAUDE_ORACODE_CORE.md` §"Trasferimento Know-How". Questo SSOT è il dettaglio
> operativo: la procedura di promozione, gli esempi, gli anti-pattern.

## Il problema

L'operatore accumula **esperienza privata** durante il lavoro (in Claude Code: la memoria-file privata; in
generale: "ciò che abbiamo imparato facendo"). Questa memoria è preziosa ma **non è il prodotto**: è specifica
dell'istanza, non si vende, non si spedisce. Il rischio: cristallizzare un **know-how operativo generico**
(riusabile da chiunque) solo nel privato → il prodotto non lo eredita, e chi acquista il paradigma/enforcement
NON riceve ciò che hai imparato. È spreco di Circolarità Virtuosa (Pilastro 4) ed Evoluzione Ricorsiva (Pilastro 5).

## La distinzione (la prima cosa da fare)

| | Esperienza d'istanza | Know-how operativo generico |
|---|---|---|
| esempio | "il progetto Z si chiama così", "il CEO preferisce X", "il repo W è su org Y" | "come si testa uno skill in prosa", "come si riconcilia stat-vs-git", "come evitare il drift sorgente↔deploy" |
| dove vive | **memoria privata** (non spedisce) | **vettore di prodotto** (spedisce) |
| chi lo usa | solo questa istanza | chiunque acquista Oracode Nexus |

Le domande-guida sono **due**, e vanno superate entrambe.

**Prima — universalità:** *«questa lezione è vera solo per noi, o sarebbe utile a QUALSIASI istanza
Oracode?»*. Se è universale, il primo cancello è passato.

**Seconda — esposizione:** *«se il repository che la contiene fosse pubblico domani, questa riga
farebbe danno?»*. Vale per **tutti e sette** i vettori, non solo per quello nuovo, e si applica anche
quando la prima domanda ha già detto sì.

Solo con due sì la lezione si promuove.

> **Perché la seconda domanda esiste.** Fino al 24 agosto 2026 il criterio ne aveva una sola, e per
> questo non ha fermato niente: nel paradigma pubblico erano finiti lo stato di cassa di una società,
> il nome di una persona accanto a un danno, il giudizio sull'operato di un'altra, e un elenco che
> mandava a leggere i documenti interni di quell'azienda. Nessuna di quelle righe sarebbe stata
> respinta dalla domanda sull'universalità: uno stato commerciale *sembra* un esempio utile a
> chiunque. È la seconda domanda che le ferma.
>
> **Il segnale d'allarme è il FATTO, non il nome.** Il nome di un'istanza usato come esempio
> didattico è legittimo, e il paradigma lo fa in centinaia di righe. È il fatto che non passa: uno
> stato commerciale, una cifra, un giudizio su una persona, un evento con la sua data, un rimando
> allo stato interno. Il nome in un titolo non dice niente a chi legge fra un anno; un rimando che
> manda a leggere lo stato di quell'azienda dice tutto, e continua a dirlo.

## I vettori di prodotto (dove promuovere, e perché lì)

| Vettore | Quando sceglierlo | Come "opera" per chi acquista |
|---------|-------------------|-------------------------------|
| **CORE** (`CLAUDE_ORACODE_CORE.md`, paradigma MIT) | regola costituzionale, valore, principio di lavoro | letto a ogni sessione — sempre presente |
| **SSOT doc** | protocollo/pattern operativo, "come si fa X" | consultabile; DOC-SYNC lo tiene allineato al codice |
| **Agente** (con descrizione-trigger) | capacità che deve **auto-attivarsi** nel contesto giusto | si innesca quando l'LLM riconosce la situazione (vedi disambiguazione trigger: `USA QUANDO … NON usare per … → fratello`) |
| **Skill / comando** | operazione **invocabile** dall'utente | `/comando`; spedito dalla fonte versionata via deploy |
| **Hook** | enforcement automatico legato a un **evento** (pre-commit, pre-push, close) | blocca/avvisa senza intervento |
| **Engine** (`bin/…`) | tooling deterministico riusabile | comando CLI riproducibile |
| **File del ruolo** (`docs/paradigm/cto/CTO_COMPETENZE.md`) | know-how su **come si sta nel ruolo**: come si lavora bene con un CEO, come si scrive perché decida bene, quando un controllo non è un controllo. Non «come si fa X», ma «come si sta» | arriva col prodotto **già pieno** e viene letto all'apertura di ogni sessione; ogni istanza lo fa crescere nel tempo, e la sua personalizzazione — che porta lo stesso nome — vive fuori dal prodotto e non viaggia |

Regola di parsimonia: il CORE resta **snello** — il principio nel CORE, il dettaglio nell'SSOT (un solo punto di
verità sul dettaglio). Non gonfiare il CORE con procedure.

## Procedura di promozione

1. **Triage** (FASE 6 / DOC-SYNC): la lezione è generica? Sì → continua. No → resta in memoria privata.
2. **Scegli il vettore** dalla tabella sopra (spesso più d'uno: protocollo→SSOT *e* capacità→agente *e* op→skill).
3. **Scrivi nella FONTE versionata** (mai nella copia deployata): es. agente in `agents/`, comando in
   `.claude/commands/` della fonte, regola nel CORE-template che spedisce. Poi **deploy** (deploy-agents/-commands).
4. **DOC-SYNC**: aggiorna l'SSOT pertinente; registra il vettore.
5. **Lascia un puntatore in memoria privata** (non il contenuto): "promosso a <vettore> in <mission>".
   La memoria privata diventa un INDICE di dove vive il know-how, non il suo deposito.

## Esempi (da missioni reali)

- **reconcile + auto-enrich** (stat-vs-git): promosso a **Engine** (`bin/mission reconcile`, auto-enrich al close)
  + **SSOT** (`STATS_SYSTEM_SSOT`). Chi acquista ha lo strumento e la regola, non solo "noi sappiamo farlo".
- **deploy-commands** (fine drift sorgente↔deploy comandi): promosso a **Engine** (`bin/deploy-commands`) +
  **SSOT** (`AGENT_DEPLOY_RUNTIME_MODEL` §comandi, con la regola di precedenza Personal>Project).
- **dry-run harness per skill in prosa**: protocollo→**SSOT** (`LSO_GUARD_TESTING_PROTOCOL` + `DRYRUN_PROTOCOL`),
  in promozione a **skill** (`/dry-run-skill`) + **agente-trigger** ("USA QUANDO modifichi uno skill in prosa").
- **disambiguazione trigger agenti** (R1): promossa nelle **descrizioni-agente** stesse (il vettore agente porta
  anche il "quando usarmi").

## Anti-pattern

- ❌ Cristallizzare un know-how generico **solo** in memoria privata → il prodotto non lo eredita.
- ❌ Spedire un **fatto d'istanza** in un vettore di prodotto (es. mettere "il progetto Z…" nel CORE) → inquina il prodotto.
- ❌ Gonfiare il CORE con procedure → mettere il principio nel CORE, il dettaglio nell'SSOT.
- ❌ Scrivere nella copia **deployata** invece che nella fonte versionata → drift (vedi `AGENT_DEPLOY_RUNTIME_MODEL`).

## Vedi anche
- `CLAUDE_ORACODE_CORE.md` §Trasferimento Know-How (il principio)
- `AGENT_DEPLOY_RUNTIME_MODEL` (fonte→deploy, precedenza) · Trigger Matrix DOC-SYNC · Layer Stack L0-L11
