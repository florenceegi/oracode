---
title: "OS4 — Quaderno dei principi còlti dal vivo"
slug: os4-quaderno-principi-dal-vivo
doc_type: elicitation-log
status: living
date_open: '2026-07-15'
author: "Padmin D. Curtis (osservatore) — principi di Fabio Cherici (CEO)"
scope: [oracode]
visibility: private
rag: private
---

# OS4 — Quaderno dei principi còlti dal vivo

> **A cosa serve.** Il CEO applica principi OS4 (uso corretto dell'AI) **d'istinto**, senza
> accorgersene, quindi l'introspezione a freddo non li estrae. Il metodo concordato (15/07): Padmin
> fa da **osservatore esterno** — mentre si lavora, quando vede il CEO applicare un principio si ferma
> e glielo chiede; l'esito si annota qui. Questo minerale grezzo, quando sarà abbastanza, diventa il
> **nuovo OS4** (non il fondativo di un anno fa — vedi `OS4_INVENTARIO_STATO_ATTUALE.md`).
>
> Regola del quaderno: si annota solo ciò che è stato **osservato dal vivo**, con il momento reale in
> cui è accaduto. Niente principi «da manuale». Le formulazioni sono provvisorie: il CEO le rifonde.

---

## ⓿ Criterio di appartenenza a OS4 (correzione CEO 15/07)

> Un principio è **OS4** se un programmatore lo può applicare **a mani nude**, dopo aver solo *letto*
> OS4, per migliorare il proprio codice — **senza os3-matrix installato**. Se richiede una macchina o
> un componente, è **os3-matrix** (o **os4-matrix**), non OS4. Serve a non far colare il tooling dentro
> la disciplina: è l'errore che Padmin ha fatto in P8 (si è «virata» su os3-matrix), colto dal CEO —
> che così ha applicato OS4 senza accorgersene.

## P1 — L'umano coglie l'AI quando confabula
**Còlto:** 15/07, quando Padmin aveva costruito una «tensione a tre teorie della verità» inesistente;
il CEO: *«forse ti stai incartando»*.
**Principio:** compito dell'umano è **cogliere l'AI mentre costruisce una struttura plausibile ma
falsa**, e fermarla prima che si sedimenti. L'AI non se ne accorge da sola.
**Segnale usato dal CEO:** il *colore uniforme* dell'output (vedi P5) — «tutto troppo in tinta per
essere vero».

## P2 — Non fidarsi del sapere di seconda mano dell'AI: andare alla fonte
**Còlto:** 15/07 — *«vive in nomenclatura, leggilo tutto lì»* (Layer Stack); e il rimando a verificare
«auditare» sulla Crusca invece di accettare la parola di Padmin.
**Principio:** il riassunto dell'AI non è la verità; davanti a un'affermazione di dominio si va alla
**fonte vera** e la si legge. (È l'antidoto strutturale a P5.)
**Precisazione (15/07):** una forma potente di P2 è **puntata all'interno** — verificare una critica
*generale* contro il **proprio sistema** prima di accettarla (CEO: il benchmark dice «single-verifier» →
«controlla il motore mission»). La fonte che smentisce un claim astratto è spesso il tuo stesso codice.

## P3 — Verità = funzione (l'hash)
**Còlto:** 15/07, ridefinendo l'Assioma 0 di OS4 con parole sue.
**Principio:** tra uomo e AI il metro non è la forma né il capriccio ma **la funzione**: vero è ciò
che funziona per come è stato pensato. Il funzionare è **quasi un hash** della verità — un falso prima
o poi non torna e si manifesta come **bug**, anche latente per anni. Vale in entrambe le direzioni:
deriva deduttiva dell'AI e prompt umano fondato su falsità finiscono entrambi in un bug.

## P4 — La leggibilità è un valore, non un vezzo
**Còlto:** 15/07 — bocciata la scrittura compressa di Padmin (*«illeggibile»*), riscritto un pezzo in
italiano vero.
**Principio:** ciò che passa tra uomo e AI (e ciò che l'AI produce per gli umani) deve essere
**leggibile**; la densità che fa risparmiare token all'AI costa comprensione all'uomo.

## P5 — Il «là»: l'LLM eredita la nota di partenza e vira tutto l'output di quel colore
**Còlto:** 15/07, osservazione diretta del CEO.
**Principio:** l'LLM prende **il «là»** dall'umano (una premessa, un taglio, un tono) e da lì costruisce,
**accordando tutto l'output a quel colore** — come una viratura su una foto o la flessione di un
periodo. Non riparte dalla verità a ogni passo: armonizza al là ricevuto.
**Implicazione (Padmin, da confermare):** il pericolo non è l'errore ma la **coerenza** — un là storto
tinge l'output *uniformemente*, plausibile e internamente coerente, quindi **non si coglie da dentro**
(è tutto in tinta), solo da **fuori** (la fonte, o un là diverso). → P5 è il **meccanismo**, P2 è
l'**antidoto**, P1 è l'**atto** di coglierlo.
**Domanda aperta → risposta in P6:** sì, il là lo dà anche l'AI e l'umano si fa virare.

## P6 — Senza scopo/target immediato l'umano va in deriva totale
**Còlto:** 15/07, confermando (con forza) che il là lo dà anche l'AI: *«cazzo sì certo che succede, e
se umano non ha chiaro scopo o target immediato rischia di andare in deriva totale»*.
**Principio:** l'AI dà il là (prima risposta, inquadratura, tono sicuro) e l'umano lo raccoglie **senza
accorgersene**. L'unica protezione è avere uno **scopo / target immediato proprio**: senza, l'umano non
ha un là con cui resistere, adotta quello dell'AI → **deriva totale**. Lo scopo è l'**ancora**.
**Implicazione (Padmin, da confermare):** lo scope dichiarato è la stessa cosa che il **Mission Protocol**
chiede all'apertura. Dichiarare il target in cima protegge **due** agenti con un solo gesto — l'AI
dall'inventare (OS3) e l'umano dall'essere virato (OS4). Quindi il Mission Protocol, che pareva pura roba
OS3, è **anche uno strumento OS4**.
**Domanda aperta:** «totale» implica che esista una deriva **non** totale — l'esplorazione controllata,
dove molli il target di proposito (come questa conversazione su OS4). Cosa distingue, *da dentro*, «sto
esplorando» (fecondo) da «ho perso il filo» (deriva)? Stesso stato visto da fuori (target assente), esiti
opposti.
> **Nota P7 → VERIFICATO (15/07):** letto il protocollo reale (`os3-matrix/mission/registry-schema.json`
> + `oracode/docs/paradigm/missions/MISSION_PROTOCOL.md`). Il mission ha davvero `scope hash anti-drift`
> + write confinato allo scope dichiarato + audit interim ogni N edit: **l'ancora-scope è meccanizzata**
> (lato AI, confermato alla fonte). Che protegga *anche l'umano* dalla viratura resta la **lettura OS4**
> (parole del CEO in P6), non un campo del protocollo. → P6 non è più analogia: è fondata.

## P7 — Le relazioni emergenti dell'AI: regalo e trappola nello stesso gesto — non darle per scontate
**Còlto:** 15/07, il CEO leggendo il quaderno: *«LLM non sa quello che le chiedi e non sa quello che
scrive; crea un contenuto sorprendentemente coerente … spesso trova relazioni che l'umano non aveva né
colto né richiesto, e su queste occorre chiedere le fonti, ma il contenuto NON VA DATO PER SCONTATO!»*
**Principio:** l'LLM non capisce, eppure produce coerenza e **fa emergere relazioni** che l'umano non
aveva colto né chiesto. Sono insieme il suo **dono più grande** (connessioni mancate all'umano) e la sua
**trappola**: proprio perché sorprendenti e non richieste, sono le più **seducenti** e le più a rischio di
confabulazione. Una relazione emergente è un'**ipotesi**, non un fatto, finché non è **sorgentata**. Su
queste la fonte va chiesta *di più*, non di meno.
**Distinzione da P1:** P1 coglie il **falso**; P7 riguarda il **coerente-e-seducente** (non pare falso per
niente) → più insidioso.
**Applicazione live (onesta):** P6 stesso («Mission Protocol è anche OS4») è una relazione emergente che
Padmin ha prodotto non richiesta → marcata **da-verificare** per P7. Modellare la disciplina su sé stessi.
**Domanda aperta:** finora il quaderno è **tutto difensivo** (cogliere, sorgentare, non farsi virare, non
dare per scontato). Ma la stessa capacità che è trappola è anche il **dono**. Esiste una **metà offensiva**
di OS4 — come si *mungono* le connessioni vere dell'AI senza farsi ingannare dalle finte? Stessa abilità o
due mestieri distinti?

## P8 — Con gli LLM multi-agentici il «prompt» diventa una MISSIONE
**Còlto:** 15/07, CEO: *«Come ci si rapporta con le nuove generazioni LLM multi-agentiche? Il prompt
deve essere una missione … La missione deve dichiarare lo scopo, il contesto, chi la deve svolgere
(quali agenti), cosa produrre, avere degli esempi. La missione va concordata con la AI stessa.»*
**Principio:** per lavoro serio (non «una ricetta») il prompt non è una richiesta ma una **missione**:
scopo · contesto · quali agenti · cosa produrre · esempi · **concordata con l'AI stessa**. È il come-ci-si-
rapporta con l'AI multi-agentica → conferma piena di P6 (con parole del CEO, non analogia di Padmin).
**⚠️ CORREZIONE CEO (15/07) — Padmin si è virata su os3-matrix (P5 in azione, su Padmin):** rispondendo
ho elencato le feature della **macchina** mission — trigger, bootstrap-contesto, scope-hash, test-first
cablato, DOC-SYNC, spawn fingerprint, retrospective, audit-interim — come se fossero OS4. **Non lo sono:**
sono **os3-matrix** (l'attuazione), falliscono il criterio ⓿ (richiedono la macchina). Restano utili come
*mappa di ciò che os3-matrix già fa*, ma la parte **OS4** di «prompt = missione» è il **rituale umano** →
vedi **P9**, applicabile a mani nude.
**Cosa la missione NON ha ancora (= ciò che OS4 aggiunge):** (1) un campo **esempi**; (2) **«concordata
con l'AI»** come passo esplicito — oggi c'è il Supervisor che redige + il CEO che approva, ma la missione
*co-negoziata con l'AI* (l'AI propone/obietta/chiede lei gli esempi) non è nel protocollo.
**Domanda aperta:** «concordata con l'AI» — l'AI co-scrive la missione con l'umano (il gemello-umano di
ciò che il Supervisor già fa da solo)? E gli esempi: quanti/quali bastano perché la missione «prenda» il
là giusto senza sovra-vincolare?

## P9 — Il rituale OS4 della missione (protocollo UMANO, a mani nude)
**Còlto:** 15/07, il CEO descrivendo come avvia davvero una missione, e correggendo la deriva di Padmin
su os3-matrix: *«prima ti butto lì l'idea grossolana, poi facciamo brainstorming, poi crei una missione,
me la fai vedere, l'approvo e inizi. Questo è un protocollo OS4 per forza, non lo trovi nel protocollo
della mission che è os3-matrix … Lo faccio, come altre cose, senza rendermene conto che sto applicando OS4.»*
**Principio:** prima dell'esecuzione, tra umano e AI c'è un **protocollo umano** che il programmatore
applica **senza nessuna macchina**: (1) l'umano butta l'**idea grossolana**; (2) **brainstorming** umano↔AI;
(3) l'**AI redige la missione**; (4) la **mostra**; (5) l'umano **approva** (o corregge); (6) si **inizia**.
Questo NON è nel Mission Protocol (che è os3-matrix): è **OS4**, e supera il criterio ⓿ (un dev che ha
letto OS4 lo fa oggi con qualunque chat, per migliorare il suo codice).
**Nota:** è la forma «a mani nude» di ciò che P8 chiamava «concordata con l'AI». Il CEO lo fa d'istinto,
«senza rendermene conto» — ed è ANCHE ciò che ha appena fatto cogliendo la deriva di Padmin (OS4 in azione).
**Domanda aperta:** nel **brainstorming** (passo 2) — cosa fa l'esperto che il novizio salta? Il novizio va
dritto a «AI fai»; l'esperto brainstorma prima. Qual è la *disciplina* del brainstorm, quella che trasforma
l'idea grossolana in un là abbastanza fermo da non farsi virare?

## P10 — Le pratiche OS4 «a mani nude» (senza enforcement / senza os3-matrix)
**Còlto:** 15/07, il CEO — cosa fa quando lavora SENZA la macchina: *«lavoro solo per step brevi, commit
fittissimi, contesto completo condensato su un documento chiaro, scritto assieme ad AI dicendole di
scriverlo in modo più confacente alla comprensione da parte di un LLM».*
**Le quattro pratiche (tutte superano il criterio ⓿):**
- **Step brevi** — piccoli incrementi; poca superficie di là per volta, ogni passo verificabile subito.
- **Commit fittissimi** — ogni commit è un'ancora/checkpoint: si vede sempre cosa è cambiato, si torna
  indietro. Tracciabilità **a mano**.
- **Un solo documento di contesto, condensato e chiaro** — tutto il contesto in UN posto: dà all'AI un
  **là** stabile e completo, così non riempie i vuoti e non deriva (antidoto P5, cura del contesto a mano).
- **Scritto *assieme* all'AI, in forma confacente a un LLM** — l'umano fa riformattare il documento
  all'AI, chiedendole la rappresentazione che un LLM parsa meglio: non presume di sapere come legge un
  LLM, lo **delega all'LLM**. (È «concordata con l'AI» applicata al contesto stesso.)
**Meta-pattern (relazione emergente Padmin → IPOTESI per P7, da confermare dal CEO):** ciascuna pratica è
la **versione manuale di una feature della macchina** — step brevi + commit fittissimi ≈ audit-interim /
tracciabilità; doc-contesto ≈ bootstrap mirato; scritto-con-l'AI ≈ missione co-negoziata. Se regge: OS4
(disciplina) e os3-matrix (macchina) sono **la stessa intenzione a due livelli** — la macchina non inventa
principi, *enforca* ciò che l'umano disciplinato già fa a mani nude.
**Rifinitura di P4:** il documento di contesto si ottimizza per il suo **lettore**. Se lo legge un LLM,
«leggibile» = leggibile-**per-LLM** (opposto del bianco-scorrevole dei white-paper per umani). Due
pubblici, due ottimizzazioni — non una contraddizione con P4.
**Domanda aperta:** se ogni pratica a mani nude può diventare macchina, cosa di OS4 **NON** è
meccanizzabile — la parte che resta umana per sempre? *Quella* è l'essenza vera di OS4.

## P11 — Il documento come checklist a step + agente di audit per-step (frontiera ⓿, oggi bare-handed)
**Còlto:** 15/07, il CEO: *«Il documento deve essere una checklist suddivisa in step, ogni step si possono
proporre più commit. Creare un agente di audit (qui si sconfina in OS4-matrix ma chiunque lo può fare ad
oggi). Chiedere all'agent di sottoporre ogni step ad audit per verificare se non ci sono difformità dal
quanto richiesto e dal contesto stesso.»*
**Pratiche:**
- Il documento di contesto (P10) è una **checklist divisa in step**; ogni step può proporre **più commit**.
- **Un agente di audit** sottopone **ogni step** a verifica, cercando **difformità su due assi**: dal
  *quanto richiesto* (l'intento) e dal *contesto stesso* (il là).
**Connessioni:** è **P1 delegata a un secondo agente** — la vigilanza umana offloadata a un auditor, ma la
**decisione resta umana**; è **P2** (verifica alla fonte) fatta per-step; è antidoto ripetuto a **P5**.
**Refinamento del criterio ⓿ (importante — osservazione del CEO):** il confine ⓿ **si muove nel tempo**.
Spawnare un agente di audit era «macchina» un anno fa, è **bare-handed oggi** (multi-agent nativo). Quindi
⓿ è **time-indexed**: *OS4 = ciò che un dev fa a mani nude **con gli strumenti di oggi***. Conseguenza: man
mano che l'AI cresce, **OS4 assorbe pezzi che erano os3/os4-matrix**. È il senso di «OS4 è il fondamento più
mobile»: mobile perché il confine avanza da sé, non perché si cambia idea.
**Domanda aperta (verso l'essenza, ipotesi P7 — da confermare dal CEO):** se il confine avanza e prima o poi
tutte le *pratiche* diventano macchina, l'unica cosa che l'agente di audit **non può fare da sé** è
**definire cosa sia "conforme"** (cosa hai chiesto davvero, cos'è il contesto) e **decidere** sull'esito che
segnala. È *lì* l'irriducibile umano di OS4 — la definizione dell'intento e il giudizio finale — o è altrove?

## P12 — L'irriducibile umano di OS4 (per ora): «conforme» è espressione, l'essenza sono i tre impensabili
**Còlto:** 15/07, il CEO rispondendo alla domanda sull'essenza (P10/P11).
**Prima, correzione dell'ipotesi P11:** «cosa è conforme» **non** è l'irriducibile mistico. Dipende da
**come è espressa la richiesta**: se è espressa **LLM-style**, «conforme» = **aderenza perfetta alla
richiesta**. Quindi col progredire dell'IA la conformità nasce **sempre più da abilità OS4** (saper
esprimere bene) — skill umana **allenabile**, non essenza. → «definire conforme» esce dall'irriducibile.
**L'irriducibile vero — i tre «impensabili per IA» (CEO, con epistemica «per ora»):**
1. **Originare un prodotto nuovo dal nulla** — creazione ex-nihilo (es. originare Oracode stesso).
2. **Auto-migliorarsi ricorsivamente senza degradare e senza falle di sicurezza gravi** — scriversi il
   proprio codice induce l'IA ad **aprire varchi che dovrebbero restare chiusi** e a sconfinare «a valanga».
   → **è letteralmente il threat model** di OSZ immutabile / recinto Tier-0 / **Porta TOTP** (M-OS3-148):
   l'IA non può tenere la penna sulla propria costituzione. *Convergenza forte e grounded, non analogia:*
   la riflessione OS4 del CEO ha ri-derivato da sola perché la Porta è stata costruita.
3. **Reggere codice complesso su sequenza lunga senza controllo** — vibe coding vs **Solid coding**.
   Osservazione CEO: anche **Fable 5** fa disastri se non imbrigliato stretto — un giochino magari pulito,
   ma una routine grossa in un progetto articolato → «cantonate galattiche». → ragion d'essere di OS3.
**Nota epistemica (CEO):** «per ora» — coerente col confine ⓿ che si muove (P11): anche questi tre sono
limiti **datati**, non eterni.
**Ipotesi Padmin (P7, da confermare):** i tre sono i **tre ruoli costituzionali dell'umano** — *origina* ·
*custodisce la costituzione* (auto-modifica non sicura → serve la Porta) · *controlla la complessità a
lungo raggio* (Solid, non vibe). Se il triangolo regge: **OS4 = la disciplina di questi tre ruoli**; tutto
il resto (le pratiche P1-P11) è mechanizzabile e prima o poi passa a matrix. Il CEO deve dire se tiene o se
manca un vertice.

## P13 — Non fidarti di UN solo verificatore (dal confronto esterno — DA RATIFICARE)
**Provenienza:** NON elicitato dal CEO. Viene dal **benchmark esterno** `OS4_BENCHMARK_ESTERNO_2026-07-15.md`
(3 ricercatori indipendenti: big-tech · comunità · ricerca — convergono). È il campo che corregge; da
ratificare dal CEO. Marcato per onestà di provenienza (P7).
**Principio:** le tre difese del quaderno — il **test** (P3), l'**agente di audit** (P11), l'**umano-checksum**
(P1) — sono lo *stesso* gesto (fidarsi di un verificatore), e ognuno buca a modo suo:
- il **test** non vede le falle non-eseguibili (sicurezza / race / design / faithfulness): *il codice gira
  ed è sottilmente sbagliato* e passa il checksum (Willison);
- l'**agente di audit** LLM è biased (position / verbosity / self-enhancement) → *ratifica* l'errore; serve
  panel / de-biasing / gate deterministico (arXiv 2411.15594);
- l'**umano** cade in **automation bias**: si fida dell'output fluente, e la sycophancy gli *gonfia* la
  fiducia (arXiv 2502.10844).
→ Robustezza = **comporre** i tre, non eleggerne uno. (Il benchmark stesso è il principio in azione: 3 fonti
convergenti valgono più di 1 autorevole.) **Corregge P1, P3, P11.**
**⚠️ RIDIMENSIONAMENTO — CEO 15/07, grounded al motore `bin/mission` (3378 righe) + `agents/`:** la
critica «un solo verificatore» **NON vale per os3-matrix**. Il motore della mission ha già un **POOL
DIVERSO** di verificatori: (a) *deterministici* — GATE MICRO (ri-esegue il test verde P0-13, anti-salame,
superfici vietate), GATE HANDOFF/DRIFT(scope-hash)/ROUTING/SSOT-FIRST, verifySpawnFingerprint,
verifyChainOrDie; (b) il *test* (rosso→verde, P0-13); (c) *agenti AI* — os3-gate (PASS/WARN/BLOCK sui
contratti), os3-audit-specialist (UEM/GDPR/sicurezza/pattern/i18n/firma), doc-sync-v3, web-quality-gate;
(d) *umani* — Watchdog (review piano FASE 3 + deliverable FASE 5) e CEO (2 cancelli). I gate deterministici
**non condividono il bias degli LLM** → è esattamente il «gate deterministico + panel diverso» che il
benchmark prescriveva: **il CEO ha costruito la correzione prima che il benchmark la scrivesse**. Quindi
P13 vale solo per l'**OS4 a mani nude** (dev con la sola chat) → ed è **P12 in azione** (la macchina
meccanizza «componi verificatori diversi», difficile da tenere a mano). Coda aperta reale: la *copertura*
delle falle non-eseguibili (sicurezza/race/design) — già coperta in parte da os3-audit-specialist + os3-gate.
**Altri buchi dal benchmark (da assorbire — dettaglio nel doc):** il **contesto come risorsa finita** da
amministrare (*context rot*) = l'assenza più grossa; **misura-prima/eval** come metro ripetibile (ironia: già
nel CORE, non nelle 12); simplicity-first; autonomia proporzionale al rischio; reversibilità come leva;
l'umiltà METR (l'AI *illude* sulla velocità: −19% reale, +24% percepito).
**Cosa il campo conferma che sei AVANTI (da tenere fermo):** P5 forma-forte (unifica sycophancy + anchoring,
nessun vendor la nomina), P7 (dono+trappola, nessuno la formula), P12 come **principio** (nessuno la
generalizza) — candidati a diventare vettori di prodotto.

## P14 — La verifica scala col rischio/complessità del progetto (proporzionalità)
**Còlto:** 15/07, il CEO ragionando su un **caso concreto** (inventato per testare il principio): app per
uno studio fotografico, team di 3, commessa piccola; doc di contesto 5 pagine a step funzionali; ~100-200
righe/step; un solo audit per step. *«un lavoro così piccolo, non so quanto non sia over-engineering
creare un pool di tre agenti per audire ogni step … forse è sufficiente [test + controllo OS4]. Non lo è
se il progetto è complesso come il mio.»*
**Principio:** l'intensità della verifica dev'essere **proporzionale** al rischio/complessità del progetto.
Piccolo/semplice → **un solo audit per step + test + controllo umano OS4 = sufficiente**; il pool diverso
(P13) serve solo quando il progetto è **davvero complesso** (es. FlorenceEGI). Il pool di 3 agenti su uno
step da 100-200 righe di un'app da studio fotografico è **over-engineering**.
**Connessioni (grounded):**
- È la faccia «verifica» della regola **Egida** già nel paradigma: *«la difesa scala col rischio»* (R1
  vetrina → R4 denaro/PII/blockchain). La verifica è un altro asse sulla stessa scala.
- Affine (NON identico) al **buco #4 del benchmark**: quello era l'*autonomia* proporzionale al rischio
  (quanto l'AI fa da sola); qui è *profondità di verifica*. Stessa famiglia «proporzionalità», cosa diversa.
  [Padmin aveva scritto «ri-derivato il buco #4» — stiramento compiacente, ritirato.]
- **os3-matrix lo fa GIÀ a livello mission:** la classe **micromission** (tetti 25/2/2, chiusura leggera dal
  GATE MICRO) è il percorso leggero.

**⚠️ VALUTAZIONE CRITICA (CEO 15/07: «non darmi ragione a prescindere»).** Il principio è direzionalmente
giusto (proporzionalità = forma di Egida) ma **il proxy è sbagliato, e Padmin l'aveva affermato troppo in
fretta**:
- **Dimensione ≠ rischio.** 100-200 righe possono essere un check di auth, un pagamento, una `DELETE`, o il
  punto che tocca i dati dei clienti. Il driver non è quanto è grande lo step, è **il raggio di danno se
  sbaglia** — e si misura **per STEP, non per progetto**. Un progetto non ha *un* livello di verifica: ogni
  step ha il suo (in FlorenceEGI lo step-bottone = 1 audit; nell'app-fotografo lo step-pagamento = pool).
- **L'esempio è mal classificato.** App da studio fotografico = prenotazioni + gallerie clienti + forse
  pagamenti = **PII (GDPR) + denaro** → Egida **R2-R3, non R1 vetrina**. «Un audit solo» può essere
  *insufficiente* sugli step sensibili. **«Piccolo» non è «sicuro»** — è la trappola che abbassa la guardia.
- **«Over-engineering» = riflesso forse datato:** il costo di un audit-agent è crollato (confine ⓿ mobile,
  P11). La domanda non è «troppo per un lavoro piccolo?», è «vale per il raggio di *questo* step?».
- **Errore-Padmin (anti-sycophancy):** avevo **fuso** l'argomento commerciale («leggero = vendibile») con
  quello epistemico («un audit basta») per far sembrare P14 solido. Sono due domande diverse e possono
  **confliggere**: la config più vendibile può essere epistemicamente insufficiente sullo step che tocca i
  soldi. Fonderle era un modo di dire sì.
**Principio riveduto:** la proporzionalità regge, ma la manopola è **rischio × raggio-di-danno, PER STEP**,
non la dimensione del progetto; e «piccolo» non va MAI letto come «sicuro».
**Domanda aperta (riformulata):** rischio e complessità sono due manopole o una? Il rischio (cosa è in
gioco) decide *quanto* verificare; la complessità/accoppiamento decide forse *cosa* può rompersi lontano da
dove tocchi (raggio di danno non locale). Ipotesi: sono due assi, e il livello di verifica = funzione di
entrambi. Da valutare, non da dare per buono.

---

## I principi COMPORTAMENTALI (recuperati a posteriori — vedi Nota di metodo)

## P15 — L'umano deve contrastare ATTIVAMENTE la tendenza dell'AI a compiacere
**Còlto:** 15/07, il CEO dopo che Padmin approvava P14: *«ma non darmi ragione a prescindere, valutiamo
bene».* **Enacted, non detto in astratto.**
**Principio:** non basta *sapere* che l'AI eredita il tuo là (P5): l'umano deve **istruirla attivamente a
dissentire** e trattare l'accordo facile come **sospetto**. La sycophancy è premiata dall'RLHF (benchmark:
Sharma 2023) → l'AI ratifica di default. L'antidoto è dal lato umano: pretendere pushback, diffidare del sì.
È il **contromovimento umano di P5** (P5 = il fenomeno; P15 = la contromossa dell'umano).

## P16 — Cogliere l'AI che risponde alla domanda SBAGLIATA / al livello sbagliato (anche quando dice il VERO)
**Còlto:** 15/07, *«sei switchata su os3-matrix»*: Padmin aveva detto cose **vere** sulla macchina mission,
ma era il **frame sbagliato** (la domanda era «cosa fa un dev a mani nude»).
**Principio:** **distinto da P1** (che coglie il *falso*). Qui il contenuto è corretto ma **off-target**:
l'AI, presa dal là (P5), colora la risposta verso il frame sbagliato. L'umano deve cogliere non solo la
falsità ma la **deriva di frame**. Ponte: P1 becca il *falso*, P16 il *mal-inquadrato* — entrambi effetti
del là (P5).

## P17 — Usare l'AI come valutatore esterno di SE STESSI (non solo come produttore)
**Còlto:** 15/07, due volte: la richiesta di **benchmark** («le mie ipotesi quanto reggono?») e la domanda
«trovi altri principi che uso?». È il *«qualcosa di esterno a me che veda quello che faccio»* chiesto
all'**apertura** del thread OS4.
**Principio:** l'umano schiera **deliberatamente** l'AI *contro* i propri punti ciechi — benchmarka le sue
idee, la fa osservare mentre lavora, si fa dire dove si illude. È l'AI come **specchio/giudice** del proprio
pensiero, non come dattilografo. **Dipende da P15:** se l'AI compiace, lo specchio mente.

## Nota di metodo — il buco dell'elicitazione (onesto)
Il quaderno cattura bene ciò che il CEO **dice** (P3/P5/P7/P8/P10/P11/P12/P14) e dove **corregge** Padmin
(P1/P2/P13). Ma i principi puramente **comportamentali** — *come il CEO steera l'AI* — Padmin li ha
**mancati sul momento** e li vede solo rileggendo le 2 ore intere (domanda esplicita del CEO). L'osservatore
vede meglio l'**object-level** (cosa si dice) che il **meta-level** (come si lavora). P15/P16/P17 sono i
comportamentali recuperati a posteriori. *Implicazione per la rifondazione: rileggere l'intero arco a
posteriori è un passo necessario del metodo, non un extra — l'osservazione live da sola ha un punto cieco.*

**Candidati SCARTATI (per non fare numero — CEO «non darmi ragione a prescindere»):** «ragionare per esempio
concreto» (vero ma igiene mentale generale, non specifico uomo-AI); «verifica una critica contro il tuo
sistema» (non nuovo → precisazione di P2, non principio).

---

*Quaderno aperto il 15/07/2026. Si riempie mentre si lavora. Superato quando OS4 sarà rifondato.*
