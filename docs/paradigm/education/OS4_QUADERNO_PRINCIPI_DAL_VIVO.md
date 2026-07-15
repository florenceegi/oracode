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

---

*Quaderno aperto il 15/07/2026. Si riempie mentre si lavora. Superato quando OS4 sarà rifondato.*
