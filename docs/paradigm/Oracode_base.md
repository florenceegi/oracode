---
title: "Oracode — Documento Base (radice del paradigma)"
slug: oracode-base
doc_type: ssot-white-paper
status: draft-per-ratifica-CEO
version: 0.1.0
date: '2026-07-14'
author: "Padmin D. Curtis (Supervisor-CTO) per Fabio Cherici (CEO)"
scope: [oracode]
visibility: public
rag: public
---

# Oracode — Documento Base

> **Cos'è questo documento.** È l'**SSOT radice** del paradigma: descrive Oracode e la sua anatomia
> (OSZ · OS3 · OS4) *nel loro insieme*. È **white paper** — completo, dettagliato, **non compresso**,
> autorevole. Sta *prima* di ogni altro documento del paradigma; gli altri lo rimandano.
>
> **Non è un file operativo.** I file `CLAUDE_*` (compressi, caricati nel contesto dell'LLM per guidare
> il lavoro, imbrigliati dagli hook) sono la sua **distillazione**: si deriva `Oracode_base` → `CLAUDE_*`,
> **mai il contrario**. Lettori di questo documento: umani, dev, chi valuta il prodotto, e l'AI su richiesta.
>
> **Regola catalogo-rimando.** I *concetti* si scrivono per esteso qui. Le *liste che cambiano* (cataloghi
> di prodotti, organi, elenchi) e le *macchine* (implementazioni, hook, spec) NON stanno qui: se ne dà il
> concetto e si **rimanda** al documento specifico. Test: *se cambia o si esegue, non è documento-base.*

---

## 0. Cos'è il Paradigma Oracode

**Oracode è un paradigma di sviluppo software AI-native.** È il paradigma di sviluppo AI-human che impone
**disciplina epistemica** e **infrastruttura documentale** a qualsiasi software costruito con esso. **È
metodologia, non prodotto** — è *il modo in cui si costruisce*, non *ciò che si costruisce*.

**Il problema che risolve.** Un LLM produce codice, documentazione e decisioni a una velocità che rende
impossibile la revisione umana in tempo reale, e con una **degradazione** propria della generazione
statistica (può violare al minuto 45 una regola per cui è stato corretto al minuto 12). Le due asimmetrie —
**velocità** e **degradazione** — sono il motivo per cui la disciplina non può restare "istruzioni che
l'AI legge e spera di seguire": deve diventare **enforcement meccanico**. Oracode codifica questa disciplina.

**Licenza.** Oracode è **MIT**: i principi sono pubblici e liberi.

---

## 1. La linea MIT ↔ Commerciale (cosa è gratis, cosa si compra)

Oracode-il-paradigma è gratis. La sua **attuazione** — ciò che fa *rispettare meccanicamente* i principi —
è prodotto commerciale. La linea è netta:

- **Gratis (MIT):** i **documenti dei principi** — questo Documento Base e l'anatomia OSZ · OS3 · OS4.
  Chi scarica il MIT scarica i principi espressi nei documenti.
- **A pagamento:** il **sistema che imbriglia OS3** e gli strumenti attorno.

### 1.1 I prodotti *(concetto qui; cataloghi e implementazioni → rimando)*

- **Oracode Nexus** — il **sistema operativo**: Oracode (i principi, MIT) **+ os3-matrix** (l'enforcement).
  «Nexus» è il fatto che le regole ora **vincolano**: os3-matrix è ciò che trasforma Oracode da *documenti*
  a *sistema operativo vivo*. **Chi compra Oracode + os3-matrix compra Oracode Nexus** — non gli manca "la
  parte Nexus": os3-matrix *è* quella parte.
- **os3-matrix** — l'**attuazione di OS3** (non è OS3, e non è il paradigma): la macchina di hook, gate e
  agenti che imbriglia il piano OS3. A pagamento. *(catalogo hook/agenti → doc-spec os3-matrix.)*
- **Cockpit** — lo strumento di **amministrazione** (osservazione, statistiche, portale documentale).
  **Opzionale, non serve per programmare.** Vive su `nexus.florenceegi.com` — dove *gira*, non come *si
  chiama*. *(dettaglio → doc Cockpit.)*
- **Librerie LSO** — accessori potenti (gadget), vendibili a parte. *(elenco → catalogo Librerie LSO.)*

> **Categoria di mercato:** Oracode Nexus è un **AICP — AI Code Prevention** (sul modello DLP): un sistema
> che sta tra l'AI e il codice e **impedisce — mentre l'AI scrive — che entri qualcosa che rompe le regole.
> Previene *prima*, non verifica *dopo*.** La pratica di chi lo usa: **Solid Coding** (l'opposto del "vibe
> coding"). *(naming stack completo → doc dedicato.)*

---

## 2. L'anatomia del Paradigma: OSZ · OS3 · OS4

Oracode ha tre sistemi. Insieme sono il paradigma; separati hanno funzioni distinte.

- **OSZ — Kernel.** Il «sistema operativo» dell'organismo cognitivo: **costituzionale e immutabile**.
  Contiene i concetti che non cambiano (l'ontologia, i valori, gli invarianti).
- **OS3 — Execution.** Il protocollo operativo **AI-Human**: il piano dove l'AI opera come co-autore, con
  le regole (P0) e i meccanismi (DOC-SYNC, Mission Protocol) che ne disciplinano il lavoro.
- **OS4 — Education.** L'**educazione epistemica dell'umano**: opera sull'umano a velocità umana, con
  pattern pedagogici.

> **Regola di precedenza (immutabile):** **OSZ è verità assoluta. OS3 e OS4 si aggiornano per allinearsi a
> lei — mai il contrario.**

---

## 3. OSZ — Kernel (costituzione e ontologia)

> OSZ, **una volta fondato, non si cambia**: qui vanno **solo i concetti che non cambiano mai**. Ciò che
> cambia o si esegue vive altrove.

### 3.1 REGOLA ZERO — il principio fondante   `[⚖️ mia scelta: in OSZ; da ratificare (alternativa: OS3)]`
**«Mai dedurre. Mai completare le lacune. Se non sai, chiedi.»** Davanti a un'informazione mancante l'LLM
non procede: si ferma e chiede. La domanda sostituisce l'invenzione; la verifica sostituisce la deduzione.
È l'autorità superiore da cui derivano molte regole operative (le P0, §4).

### 3.2 I Pilastri Cardinali (6+1)   `[⚖️ mia scelta: in OSZ; da ratificare]`
I valori costituzionali del paradigma:
1. **Intenzionalità Esplicita** — dichiara sempre *perché* fai ciò che fai.
2. **Semplicità Potenziante** — scegli la strada che ti rende più libero; no over-abstraction.
3. **Coerenza Semantica** — parole e azioni allineate; una funzione fa ciò che il nome promette.
4. **Circolarità Virtuosa** — bug → test; feature → pattern; ogni soluzione alimenta il sistema.
5. **Evoluzione Ricorsiva** — ogni risultato migliora il processo; doc e codice co-evolvono.
6. **Sicurezza Proattiva** — sicurezza by-design, non patch a posteriori.
   **+1 · REGOLA ZERO** — autorità superiore agli altri sei.

### 3.3 I Primitivi (l'ontologia — cosa esiste)
Come un sistema operativo ha i suoi primitivi (process, thread, memory, I/O), OSZ ha i suoi. Sono **quattro**:

- **RAV — l'unità atomica di valore.** Un contenitore tipizzato reso *prodotto reale* da tre cose:
  `RAV = Wrapper<T> + Regole + Audit + Valore`. Dove `T` è **qualsiasi cosa** (un'opera, un diritto, un
  flusso economico, un asset fisico, un contratto, un'AI, un servizio, una competenza, una capacità-software).
  Le **Regole** governano, l'**Audit** certifica, il **Valore** lo rende scambiabile. *(Nome interno `RAV`;
  qualificato pubblico `Oracode_RAV`.)*
  - *Istanze:* un **EGI** (l'unità di valore di FlorenceEGI) è un `RAV<opera>` certificato su blockchain; una
    **capacità/grano** di produzione software è un `RAV<responsabilità>` certificato dalla chiusura standard;
    una **competenza** verificabile è un `RAV<competenza>`. Stesso primitivo, istanze diverse.
- **Interface — le giunture stabili.** Il contratto **fisso** tra due parti che non cambia anche se cambia
  ciò che c'è dietro (come un ginocchio: l'articolazione resta stabile mentre osso e tendine cambiano). Se le
  interfacce restano stabili, si sostituisce qualsiasi organo dietro senza far crollare il sistema.
- **Instance — gli organi sostituibili.** Un pezzo che fa un lavoro e parla col resto **solo attraverso le
  interfacce**; per questo si può sostituire, scollegare, aggiornare senza far crollare il sistema. È SOLID
  applicato a un ecosistema.
- **Nerve — il riflesso deterministico.** Il **gate/hook** che scatta al confine: **verifica, blocca,
  segnala — senza giudizio**. Come un nervo che ritira la mano dal fuoco prima che il cervello decida. È
  *deterministico*, mai opinione di un modello.
  > **Nota (correzione M-OS3-147):** l'**AI che giudica** (che ottimizza, che vede il sistema intero) **non
  > è un nervo** — è la *mente*, e opera in **OS3**, non nell'anatomia del kernel. L'anatomia ha i nervi; la
  > mente li usa. `[era un errore del kernel v1 mettere "le AI" dentro Nerve]`

### 3.4 Relazione OSZ ↔ LSO
OSZ **definisce** i primitivi; un **LSO** (§3.5) è **costruito con istanze** di essi — i suoi organi sono
istanze di *Instance*, le giunture di *Interface*, i nervi di *Nerve*, il valore che maneggia è *RAV*. La
relazione è **definizione → istanziazione**: l'anatomia di un LSO *usa* i primitivi, non *è* i primitivi.

### 3.5 Concetto di LSO (Living Software Organism)
Un **LSO** è il prodotto vivente di Oracode applicato a un dominio: un software con **sistema circolatorio
proprio** (§3.6), che cattura la propria esperienza, la struttura e la rende riusabile — e così **cresce**.
Non "siti collegati": un corpo dove ogni progetto è un organo, ogni interfaccia un'articolazione, l'AI il
sistema nervoso.

### 3.6 Concetto di Sistema Circolatorio *(agnostico)*
Il meccanismo per cui in un LSO l'esperienza **circola** e diventa patrimonio riusabile: ogni cosa fatta viene
catturata, strutturata, resa disponibile alla volta successiva. È un **concetto universale** — gli *Egili*
di FlorenceEGI ne sono **un'applicazione**, non la definizione. *(implementazioni dei meccanismi — Mission
Protocol, DOC-SYNC, RAG — sono OS3, §4.)*

### 3.7 Concetto di Audit
La **prova verificabile** di cos'è una cosa e da dove viene: è la "A" del RAV. Concetto universale di
certificazione (esistenza, integrità, anteriorità). *(la macchina che lo attua — hash + ancoraggio su
blockchain, il "Sigillo" — è implementazione: → rimando.)*

### 3.8 Immutabilità (perché OSZ non si cambia via anello)
OSZ è immutabile **per costruzione**, non per divieto in prosa: un controllo d'accesso meccanico impedisce
all'anello (l'AI) di riscriverlo. Si evolve solo per **ratifica umana verificata**. *(il meccanismo —
recinto Tier-0, la Porta TOTP — è attuazione: → doc TIER0_CLAUSOLE / Porta.)*

---

## 4. OS3 — Execution (il protocollo AI-Human)

OS3 è il **piano dove l'AI opera come co-autore** a velocità non verificabile in tempo reale. È **parte del
paradigma** (un *principio*: l'esecuzione va imbrigliata meccanicamente) — da non confondere con **os3-matrix**,
che ne è l'**attuazione** (la macchina, a pagamento, §4.6).

### 4.1 Il sistema di priorità P0-P3
`P0` sistema si rompe subito → STOP, correggi prima di procedere · `P1` non production-ready → correggi prima
del deploy · `P2` debito tecnico → refactoring programmato · `P3` contesto → consigliato.

### 4.2 Le 13 Regole P0   `[🟡 concetto+elenco qui; testo per esteso da groundare dal CORE — white paper completo]`
Ogni P0 nasce da un errore concreto in produzione (cicatrici codificate): P0-1 REGOLA ZERO · P0-2 translation
keys · P0-3 statistics rule · P0-4 anti-method-invention · P0-5 UEM-first · P0-6 anti-service-method · P0-7
anti-enum-constant · P0-8 complete-flow-analysis · P0-9 i18n completa · P0-10 anti-bypass-data-layer · P0-11
DOC-SYNC · P0-12 anti-infra-invention · P0-13 test-first. *(operazionalizzano i Pilastri §3.2.)*

### 4.3 DOC-SYNC *(concetto)*
Codice e documentazione **viaggiano insieme**: una task non è chiusa finché la documentazione SSOT non è
allineata al codice (P0-11). *(il software che lo esegue — drift detection, coverage, re-index — è os3-matrix.)*

### 4.4 Mission Protocol *(concetto)*
Ogni cambiamento al codice passa da una **mission** numerata, con fasi sequenziali e track record decisionale.
Niente si modifica fuori da una mission aperta. *(il motore che lo enforcea è os3-matrix.)*

### 4.5 Strategia Delta *(concetto)*
Codice nuovo → tutte le regole Oracode. Codice legacy → resta; si migra solo quando lo si tocca per altra
ragione, mai "refactoring di principio". Protegge dai due rischi opposti: debito non gestito e refactoring nevrotico.

### 4.6 os3-matrix = l'ATTUAZIONE di OS3
**os3-matrix non è OS3.** È l'insieme dei componenti software (hook bloccanti, gate, agenti) che **fanno
rispettare meccanicamente** le regole di OS3, sul piano dove l'AI opera. È **prodotto commerciale** al livello
software house. *(catalogo dei componenti → doc-spec os3-matrix.)*

---

## 5. OS4 — Education (l'educazione dell'umano)   `[🟡 da groundare su education/OS4_FOUNDATION]`

OS4 opera **sull'umano**, a velocità umana, con **giudizio**. Non servono gate meccanici (sarebbe paternalismo):
servono **pattern pedagogici** — onboarding, manifesti, formazione. Il suo scopo: che l'operatore impari a
**usare bene** l'AI. È l'altra faccia degli errori: gli errori *OS3* sono l'AI che produce plausibile-ma-falso;
gli errori *OS4* sono l'umano che non sa ancora guidare l'AI. OS4 cura i secondi.

---

## 6. La gerarchia dei ruoli   `[⚖️ dove vive: qui, o doc a sé (ex-nomenclatura)? — da decidere]`

Gli attori dell'ecosistema, definiti **per funzione + meccanismo** (mai per "chi contiene chi"):
- **Paradigma** — le regole (Oracode, MIT).
- **Softwarehouse** — l'acquirente con licenza; a questo livello vivono os3-matrix (attuazione) e le Librerie
  LSO. *Funzione/meccanismo:* è il confine di aggregazione delle **statistiche globali** (conta tutto ciò che
  quel compratore produce).
- **Customer** — il cliente; *funzione/meccanismo:* **separazione** (distingue le funzioni di un cliente
  dall'altro). Sotto la software house stanno i clienti, non le app: i clienti hanno le app.
- **Organismo** — un LSO multi-organo (es. FlorenceEGI); **Organo** — un LSO che appartiene a un Organismo;
  **Progetto** — un LSO mono-organo.
- **Libreria LSO** — repo-strumento della software house, al servizio di tutti i lavori.

*(NB: alcuni ruoli sono paradigmatici — Organismo/Organo/Progetto/LSO, struttura dell'organismo software —
altri più commerciali/deployment — Softwarehouse/Customer. Possibile che non finiscano tutti nello stesso capitolo.)*

---

## Rimandi (i cataloghi e le macchine, non qui)
- Catalogo **Librerie LSO** (DeepDebug/Fucina/SNC…) · catalogo **organi/istanze** (FlorenceEGI e organi) →
  doc d'istanza / Softwarehouse.
- **Spec os3-matrix** (hook, gate, agenti), **Sigillo** (hash+Algorand), **DOC-SYNC v3** (software) → doc-spec.
- **Layer Stack L0-L11** → `[⚖️ concetto qui o doc a sé?]`.
- **Naming stack** (AICP / Solid Coding / brand) → doc dedicato.

## Domande aperte (da chiudere con la ratifica)
1. `[⚖️]` REGOLA ZERO + Pilastri: confermi in **OSZ** (§3.1/3.2)?
2. `[⚖️]` I 7 ruoli (§6) e il Layer Stack: qui in Oracode_base o documento a sé?
3. `[🟡]` Profondità: le 13 P0 per esteso qui (white paper) — le espando?
4. `[⚖️]` Nome file `Oracode_base.md`, repo `oracode/docs/paradigm/`, visibilità **public** (MIT): confermi?

*Documento Base di Oracode — draft 0.1.0, 2026-07-14. Da ratificare capitolo per capitolo, poi ri-sigillo +
distillazione nei `CLAUDE_*` (DOC-SYNC fra strati). Sostituirà/assorbirà i concetti sparsi (nomenclatura, ecc.).*
