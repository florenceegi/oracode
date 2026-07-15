---
title: "Oracode — Documento Base (radice del paradigma)"
slug: oracode-base
doc_type: ssot-white-paper
status: draft-per-ratifica-CEO
version: 0.6.0
date: '2026-07-14'
author: "Padmin D. Curtis (Supervisor-CTO) per Fabio Cherici (CEO)"
scope: [oracode]
visibility: public
rag: public
---

# Oracode — Documento Base

Questo è il documento radice del paradigma. Descrive Oracode e la sua anatomia — OSZ, OS3 e OS4 — nel loro insieme. È un documento di fonte, un SSOT, e ha valore di white paper: è completo, dettagliato e autorevole, e non va compresso. Sta prima di ogni altro documento del paradigma, e gli altri vi rimandano.

Un SSOT, cioè una *Single Source of Truth* — fonte unica di verità — è il documento che fa da fonte autorevole per un pezzo di conoscenza. Ogni concetto si definisce in un solo posto, il suo SSOT, e tutto il resto vi rimanda invece di ripeterlo. L'SSOT non è un dettaglio organizzativo: è esso stesso uno strumento del paradigma, perché senza una fonte unica la conoscenza si duplica, le copie divergono, e chi legge — persona o intelligenza artificiale — non sa più quale versione è quella vera. La disciplina degli SSOT è ciò che tiene la conoscenza di un sistema coerente nel tempo.

Questo documento non è un file operativo. I file di sistema `CLAUDE_*`, che vengono caricati nel contesto dell'intelligenza artificiale per guidarne il lavoro, sono una distillazione compressa di questo documento: la verità si scrive qui e da qui discende verso i file operativi, mai il contrario. I lettori di questo documento sono le persone — chi sviluppa, chi valuta il prodotto — e l'intelligenza artificiale quando le viene chiesto di approfondire.

Vale una regola di scrittura. Qui si definiscono i concetti, per esteso. Le liste che cambiano nel tempo — cataloghi di prodotti, elenchi di organi, componenti — e le implementazioni tecniche non stanno in questo documento: se ne dà il concetto e si rimanda al documento specifico. Il criterio è semplice: se una cosa cambia o si esegue, non appartiene al documento base.

---

## 0. Cos'è il Paradigma Oracode

Oracode è un paradigma di sviluppo software AI-native. È il metodo con cui un essere umano e un'intelligenza artificiale costruiscono software insieme, imponendo disciplina epistemica e infrastruttura documentale a qualsiasi sistema costruito con esso. È una metodologia, non un prodotto: è il modo in cui si costruisce, non ciò che si costruisce.

Per capire cosa sia un paradigma aiutano gli esempi già noti a chi programma. La programmazione a oggetti, l'OOP, è stata il paradigma del periodo in cui il problema dominante era dominare la complessità del dominio: ha dato al codice il concetto di oggetto, di classe, di ereditarietà. I principi SOLID sono stati il paradigma del periodo in cui il problema dominante era la manutenibilità: hanno dato regole su come scrivere classi che restano modificabili nel tempo. Prima ancora, la programmazione strutturata aveva risolto il problema del codice ingovernabile. Ogni paradigma risponde al problema dominante della sua epoca, e non sostituisce i precedenti: vi si stratifica sopra. Oracode è il paradigma per l'epoca in cui il codice, in gran parte, lo scrive un'intelligenza artificiale. Quello che l'OOP ha fatto per il dominio e SOLID per la manutenibilità, Oracode si propone di farlo per la collaborazione tra uomo e AI.

Il problema che risolve nasce da due asimmetrie tra l'essere umano e l'intelligenza artificiale. La prima è di velocità: un'AI produce codice, documentazione e decisioni a un ritmo che rende impossibile la revisione umana in tempo reale. La seconda è di degradazione: un'AI può violare al minuto quarantacinque una regola per cui era stata corretta al minuto dodici, perché la degradazione non è un errore occasionale ma una proprietà della generazione statistica. Queste due asimmetrie sono la ragione per cui la disciplina non può restare un insieme di istruzioni che l'AI legge e spera di seguire: deve diventare enforcement meccanico. Oracode codifica questa disciplina.

Oracode è distribuito con licenza MIT: i principi sono pubblici e liberi.

---

## 1. La linea tra MIT e commerciale

Il paradigma Oracode è gratuito. La sua attuazione — ciò che fa rispettare meccanicamente i principi — è un prodotto commerciale. La linea tra le due cose è netta.

È gratuito, con licenza MIT, l'insieme dei documenti che esprimono i principi: questo documento base e l'anatomia OSZ, OS3 e OS4. Chi scarica la versione MIT scarica i principi.

È a pagamento il sistema che rende quei principi operativi e vincolanti, insieme agli strumenti che vi ruotano attorno.

### 1.1 I prodotti

*Qui vengono definiti i concetti. Per cataloghi, componenti e dettagli implementativi si rimanda alla documentazione specifica.*

**Oracode Nexus** è il sistema operativo completo, formato da due elementi:

- Oracode, che definisce i principi e il paradigma, distribuito con licenza MIT;
- Nexus, che rende quei principi operativi e vincolanti.

Nexus è ciò che trasforma Oracode da insieme di documenti a sistema operativo vivo. Chi acquista Oracode Nexus acquista quindi l'intero sistema: Nexus non è un prodotto aggiuntivo o una parte mancante, ma la componente che attua concretamente Oracode.

**Nexus** è il sistema che attua OS3. Non coincide con OS3 e non è il paradigma Oracode.

È composto da hook, gate e agenti che applicano e fanno rispettare il piano operativo definito da OS3. È una componente a pagamento.

Il nome deriva da os3-matrix, denominazione originaria dell'attuatore di OS3. Il repository e l'implementazione tecnica mantengono il nome os3-matrix, mentre nella nomenclatura ufficiale viene utilizzato il termine Nexus.

*Per il catalogo dei componenti si rimanda alla relativa documentazione tecnica.*

**Cockpit** è lo strumento di amministrazione e controllo del sistema. Permette di osservare il funzionamento di Nexus, consultare statistiche e accedere al portale documentale.

È una componente opzionale e non è necessaria per programmare o utilizzare Nexus.

È disponibile su nexus.florenceegi.com, che indica il luogo in cui il servizio viene eseguito, non il nome del prodotto.

*Per i dettagli si rimanda alla documentazione dedicata al Cockpit.*

**Librerie LSO** sono componenti aggiuntivi e riutilizzabili che estendono le funzionalità del sistema. Possono essere acquistate e utilizzate separatamente, in base alle esigenze del progetto.

*Per l'elenco completo si rimanda al catalogo delle Librerie LSO.*

### 1.2 La categoria di mercato

Sul mercato, Oracode Nexus si colloca nella categoria AICP, cioè AI Code Prevention. È un sistema che si interpone tra l'intelligenza artificiale e il codice e impedisce, mentre l'AI scrive, l'ingresso di codice che viola le regole: previene prima, invece di verificare dopo. La pratica di chi lo usa si chiama Solid Coding, l'opposto del cosiddetto vibe coding.

*Per lo stack di naming completo si rimanda al documento dedicato.*

---

## 2. L'anatomia del Paradigma: OSZ, OS3 e OS4

Oracode ha tre sistemi. Insieme costituiscono il paradigma; presi separatamente hanno funzioni distinte.

OSZ è il kernel: il sistema operativo dell'organismo cognitivo, costituzionale e immutabile. Contiene i concetti che non cambiano, cioè l'ontologia, i valori e gli invarianti.

OS3 è l'esecuzione: il protocollo operativo tra l'essere umano e l'intelligenza artificiale, il piano in cui l'AI opera come co-autore, con le regole e i meccanismi che ne disciplinano il lavoro.

OS4 è l'educazione: la formazione epistemica dell'essere umano, che opera sull'umano a velocità umana e con pattern pedagogici.

Tra i tre vige una regola di precedenza, ed è immutabile: OSZ è verità assoluta, mentre OS3 e OS4 si aggiornano per allinearsi a lui, mai il contrario.

C'è poi un secondo rapporto tra i tre, oltre alla precedenza, e conviene tenerlo a mente leggendo ciò che segue. Il kernel detta i principi a un livello di astrazione superiore; sono OS3 e OS4 a verticalizzarli, cioè a renderli concreti e operativi. Regola Zero, per esempio, è un principio di OSZ, e le tredici regole P0 di OS3 ne sono la verticalizzazione; lo stesso vale per l'Audit, che il kernel enuncia come principio e OS3 rende un meccanismo. Quando un concetto vive in OSZ, quindi, non significa che non abbia una forma concreta: significa che la sua forma concreta si trova un piano più in basso, in OS3 o in OS4.

---

## 3. OSZ — il Kernel

OSZ, una volta fondato, non si cambia. Per questo contiene soltanto i concetti che non cambiano mai. Tutto ciò che cambia, o che si esegue, vive altrove.

### 3.1 Regola Zero

Regola Zero è il principio fondante: mai dedurre, mai completare le lacune; se non sai, chiedi. Davanti a un'informazione mancante l'intelligenza artificiale non procede: si ferma e chiede. La domanda sostituisce l'invenzione e la verifica sostituisce la deduzione. È l'autorità superiore da cui derivano molte delle regole operative che si trovano in OS3.

### 3.2 I Pilastri Cardinali

I pilastri sono i valori costituzionali del paradigma. Sono sei, più uno:

- **Intenzionalità esplicita** — dichiarare sempre perché si fa ciò che si fa.
- **Semplicità potenziante** — scegliere la strada che rende più liberi, senza astrazioni inutili.
- **Coerenza semantica** — parole e azioni allineate: una funzione fa ciò che il suo nome promette.
- **Circolarità virtuosa** — ogni bug diventa un test, ogni soluzione alimenta il sistema.
- **Evoluzione ricorsiva** — ogni risultato migliora il processo, e la documentazione co-evolve con il codice.
- **Sicurezza proattiva** — sicurezza per costruzione, non correzione a posteriori.
- **Regola Zero** — il settimo, che sta sopra gli altri.

### 3.3 I Primitivi

Come un sistema operativo ha i suoi primitivi — processi, thread, memoria, input e output — così OSZ ha i suoi. Sono quattro.

**RAV** è l'unità atomica di valore, e il suo nome è l'acronimo delle tre cose che lo compongono: **R**egole, **A**udit, **V**alore. Sono i tre elementi che, applicati a un contenitore tipizzato — il `Wrapper<T>` —, lo trasformano da semplice involucro a prodotto reale, secondo la formula `RAV = Wrapper<T> + Regole + Audit + Valore`. Le regole lo governano, l'audit lo certifica, il valore lo rende scambiabile. Il contenuto `T` può essere qualsiasi cosa: un'opera, un diritto, un flusso economico, un bene fisico, un contratto, un servizio, una credenziale, una capacità software. Il RAV si rifà all'oggetto della programmazione a oggetti: `Wrapper<T>` è, letteralmente, una classe generica — un oggetto — ma con le regole economiche incorporate. Il nome interno è RAV; nella forma qualificata pubblica è Oracode_RAV.

Il RAV è un primitivo universale, e le sue istanze concrete sono molte. Nell'ecosistema FlorenceEGI, un EGI è un RAV: concretamente, è un record nella tabella degli EGI. Il suo contenuto può variare senza che cambi la sua natura di RAV: può essere un'opera d'arte, oppure una credenziale, cioè una qualifica di una persona resa verificabile. Fuori da FlorenceEGI, nel dominio della produzione software, una capacità — quello che chiamiamo grano — è a sua volta un RAV. Una capacità non è una riga qualsiasi: è un insieme coeso e funzionale di codice, quello che per buona pratica si committa in blocco, e infatti ogni grano corrisponde a un commit. Il suo contenuto è la responsabilità che quel codice assolve, e la sua certificazione è la chiusura standard della mission che l'ha consegnata. È sempre lo stesso primitivo: cambia solo ciò che contiene e il modo in cui viene certificato.

Vale la pena rendere concreta la parte «Audit» del RAV, cioè la certificazione. Certificare un'unità di valore significa attaccarle una prova verificabile di che cosa è, di chi l'ha fatta e di quando. Per un EGI d'arte, questa prova è un'impronta crittografica del contenuto più una transazione registrata su blockchain: fissano per sempre l'autore e la data, in un modo che nessuno può falsificare o retrodatare. Per una capacità di produzione software — l'insieme coeso di codice che si committa — la prova è la chiusura standard della mission che l'ha consegnata: i test verdi, l'audit del codice superato, la documentazione allineata. Prove diverse per unità diverse, ma con lo stesso ruolo: rendere l'unità di valore dimostrabilmente ciò che dichiara di essere.

**Interface** è la giuntura stabile. È il contratto fisso tra due parti, che non cambia anche quando cambia ciò che sta dietro. Vale l'immagine del ginocchio: l'osso e il tendine possono cambiare, ma l'articolazione resta stabile, e finché resta stabile si può sostituire qualsiasi organo dietro di essa senza far crollare il sistema. È il punto in cui Oracode riprende un principio preciso di SOLID: l'inversione delle dipendenze — si dipende dall'astrazione, cioè dall'interfaccia, non dall'implementazione concreta, così ciò che sta dietro può cambiare senza toccare chi lo usa. La garanzia che qualunque implementazione messa dietro l'interfaccia funzioni davvero al posto delle altre è un secondo principio, la sostituzione di Liskov.

Un esempio concreto, preso dal nostro ecosistema. Molti organi diversi hanno bisogno di **certificare** un valore: quello che vende opere deve provare che un'opera è autentica, quello che gestisce le credenziali deve ancorare una qualifica, quello che pubblica fatti deve provare che sono veri. Nessuno di questi organi contiene dentro di sé la macchina della certificazione. Tutti chiamano lo stesso punto di contatto, sempre uguale: una richiesta che dice «certifica questo» e riceve indietro la prova, e una che dice «verifica questo» e riceve indietro il responso. Quel punto di contatto è l'Interface. Dietro, oggi, la certificazione la fa una certa tecnologia; se domani cambiasse, ogni organo continuerebbe a chiamare la stessa richiesta, senza accorgersi di nulla e senza rompersi. La giuntura è ferma; ciò che sta dietro può cambiare.

**Instance** è l'organo sostituibile. Anche Instance si rifà all'oggetto della programmazione a oggetti, e il nome non è casuale: in OOP un oggetto è, appunto, un'istanza di una classe. Un organo è un pezzo che svolge un lavoro e comunica con il resto del sistema soltanto attraverso le interfacce; proprio per questo può essere aggiunto o sostituito senza che l'organismo vada in errore. Toglierlo, invece, non è sempre indolore: se attorno a quell'organo si è formato un flusso che l'ha reso indispensabile, rimuoverlo rompe l'organismo. È il principio SOLID applicato a un intero ecosistema.

**Nerve** è il riflesso deterministico. È il gate, l'hook che scatta al confine: verifica, blocca, segnala, ma non giudica. È come il nervo che ritira la mano dal fuoco prima ancora che il cervello decida. È deterministico, e non è mai l'opinione di un modello.

Su questo punto va corretto un errore della prima versione del kernel. L'intelligenza artificiale che giudica — che ottimizza, che vede il sistema nel suo insieme — non è un nervo: è la mente, e opera in OS3, non nell'anatomia del kernel. L'anatomia possiede i nervi; la mente li usa, ma non è essa stessa un nervo.

### 3.4 Il rapporto tra OSZ e LSO

OSZ definisce i primitivi; un LSO è costruito con istanze di essi. I suoi organi sono istanze di Instance, le sue giunture sono istanze di Interface, i suoi nervi sono istanze di Nerve, e il valore che maneggia è RAV. Il rapporto è di definizione e istanziazione: l'anatomia di un LSO usa i primitivi, non coincide con essi.

### 3.5 Il concetto di LSO

Un LSO, cioè un Living Software Organism, è il prodotto vivente di Oracode applicato a un dominio: un software dotato di un proprio sistema circolatorio, che cattura la propria esperienza, la struttura e la rende riutilizzabile, e in questo modo cresce. Non è un insieme di siti collegati, ma un corpo: ogni progetto è un organo, ogni interfaccia un'articolazione, e il sistema nervoso è fatto di nervi deterministici, cioè gli hook di Nexus. L'intelligenza artificiale non è il sistema nervoso: opera a un livello superiore, come mente, ma è vincolata da esso, perché sono i nervi a impedirle di rompere le regole.

### 3.6 Il Layer Stack

Oracode non descrive un'applicazione come un blocco unico di codice. La descrive come un **organismo stratificato in undici livelli** — da L1 a L11 — più un prerequisito, L0: ognuno con una funzione biologica e un ruolo architetturale, ognuno che presuppone quello sotto e abilita quello sopra. È l'anatomia di ciò che chiamiamo «vivente».

Su questo asse vanno tenute separate due letture, perché confonderle è una delle fonti principali di errore. La stratificazione dei livelli è **tassonomia universale**: è proprietà del paradigma, e ogni applicazione Oracode ha gli stessi livelli. Quello che si legge *lungo* quell'asse, da un'istanza all'altra, è invece la **maturity**: quanto in alto quell'organismo è salito, e con quanta solidità occupa ciascun livello. La tassonomia dice quali organi ha ogni corpo costruito con Oracode; la maturity dice, di un corpo particolare, quali di quegli organi sono davvero cresciuti e quali ancora abbozzati. Per questo la maturity non appartiene a questo documento: è proprietà dell'istanza, non del paradigma.

I livelli si dividono in due bande, separate da una soglia che è la cosa più importante dello stack: la soglia della **metacognizione**, il passaggio da organismo reattivo a organismo riflessivo — ed è la soglia su cui il paradigma stesso oggi si trova. Sotto stanno i livelli **reattivi**: il metabolismo che tiene allineati codice e documentazione, il controllo di coerenza, il rilevamento del drift, i riflessi che impediscono gli errori, la memoria immunitaria dei test, i contratti leggibili dalla macchina, fino al sistema nervoso che sa in ogni momento lo stato di ogni livello. Un organismo fermo a questa banda vive e si mantiene, ma non si pensa. Sopra la soglia stanno i livelli **evolutivi**: la riflessione, cioè l'auto-osservazione; la riproduzione, cioè la capacità di scindersi in una nuova istanza; e l'auto-governance, cioè la stabilità della specie quando il fondatore non c'è più.

Il punto profondo è che questi tre livelli in cima **non sono funzioni aggiuntive: sono il completamento della definizione di «vivente»**. Un software diventa un organismo, e non resta un semplice programma, quando si osserva, si riproduce e si autogoverna. E il loro ordine non è arbitrario: un organismo deve sapere chi è prima di poter trasmettere la propria identità a una figlia, e servono più istanze prima che abbia senso una governance autonoma che sopravvive al fondatore.

Il vertice dello stack si salda a ciò che questo capitolo ha già detto. L'ultimo livello — l'auto-governance — è quello che protegge l'irreversibilità: alcune cose, una volta entrate nel genoma, non possono più uscirne. È esattamente l'immutabilità del kernel di cui si dice poco più avanti (§3.9): lo stack, salendo, arriva a proteggere la propria stessa costituzione. E in basso il sistema nervoso è fatto dei nervi deterministici, cioè del primitivo Nerve. Lo stack e l'immutabilità sono la stessa spina vista dai due capi.

C'è infine un tratto che rende lo stack degno del kernel: **applica Regola Zero a se stesso**. La tassonomia si può affermare, ma la maturity di un'istanza si deve verificare, mai dichiarare — e i cinque stati con cui la si misura esistono proprio per impedire a un organismo di attribuirsi una maturità che non ha.

*Il dettaglio — la tabella dei livelli uno per uno, i sei principi invarianti dello stack, i cinque stati di maturity e la matrice di maturità di una singola istanza — vive nella nomenclatura, e vi si rimanda.*

### 3.7 Il concetto di Sistema Circolatorio

Il sistema circolatorio è la proprietà che rende *vivente* un'applicazione costruita con Oracode, e non un semplice programma che gira. La sua idea è che nulla di ciò che l'organismo fa vada perduto: ogni esperienza viene catturata, strutturata e rimessa in circolo, così che ogni nuovo lavoro parta da una base di conoscenza più ampia del precedente. La crescita non è magica — l'organismo non si riscrive da solo — ma è reale: è accumulo che si sedimenta e torna utile.

Il circolo è fatto di quattro funzioni, ciascuna con un compito preciso.

- Il **Mission Protocol** *cattura*: ogni cambiamento passa da una mission, e la mission lascia un track record delle decisioni, con misure quantitative. È la memoria di cosa si è deciso e perché.
- Il **DOC-SYNC** *struttura*: tiene la documentazione di fonte allineata al codice, così che l'esperienza catturata resti coerente e non invecchi in silenzio.
- Il **RAG interno** *ricorda*: è la memoria operativa dell'organismo, un archivio interrogabile che cresce con l'uso e da cui persone e intelligenza artificiale attingono la conoscenza giusta al momento giusto.
- Il **Sistema di Helping conversazionale** *restituisce*: è la voce del RAG verso chi lo usa. Ogni applicazione Oracode espone la propria memoria attraverso un'interfaccia conversazionale, così che la conoscenza accumulata non resti sepolta ma risponda a chi la interroga.

Cattura, struttura, ricorda, restituisce: è un ciclo, e per questo si chiama circolatorio.

Va aggiunta una precisazione, perché non tutti gli organismi battono allo stesso ritmo. L'infrastruttura circolatoria è sempre presente in un'applicazione Oracode, ma il suo *metabolismo* dipende dal flusso di esperienza che la attraversa. Un'applicazione con interazione continua — utenti che generano contenuti, ordini che si muovono, richieste che si accumulano — alimenta davvero il proprio circolo: il RAG cresce, le mission si sedimentano, l'Helping impara. Un'applicazione quasi statica ha la stessa infrastruttura, sana e funzionante, ma un metabolismo ridotto, perché manca il flusso che la nutre: è viva alla nascita, ma resta a dieta minima per natura del proprio dominio.

Il sistema circolatorio è un concetto universale del paradigma. Gli Egili di FlorenceEGI — un circolo che lega più organi tra loro — ne sono un'applicazione specifica, non la definizione.

*Le implementazioni concrete delle quattro funzioni appartengono all'attuazione: Mission Protocol e DOC-SYNC sono verticalizzati in OS3 (§4.4 e §4.3), il RAG e l'Helping hanno le proprie macchine, e si rimanda ai documenti relativi.*

### 3.8 Il concetto di Audit

Audit, nel kernel, è il principio della **verifica di aderenza che produce una prova**. Il kernel lo enuncia a questo livello astratto; poi il principio si verticalizza in due direzioni, su due oggetti diversi.

Sul **valore**, l'audit è la «A» del RAV (§3.3): verifica che un'unità di valore sia davvero ciò che dichiara, e ne lascia una prova durevole, verificabile da terzi — l'impronta su blockchain per un'opera, la chiusura della mission per una capacità.

Sul **codice**, l'audit è l'esame che degli agenti fanno del codice prima che diventi definitivo, per controllarne l'aderenza alle buone pratiche e ai principi di Oracode. Questa seconda verticalizzazione vive in OS3, come pezzo dell'imbrigliatura che alza la qualità, ed è descritta lì (§4.5).

Le due si toccano in un punto solo: per una capacità software, la prova che certifica il suo RAV è la chiusura della mission, e il superamento dell'audit del codice è una delle cose che quella chiusura attesta. Restano però due audit distinti — un'opera d'arte prende il primo senza alcun audit di codice.

*Le macchine che realizzano i due audit — gli agenti che verificano il codice, e l'impronta su blockchain per il valore, cioè il Sigillo — sono attuazioni, e si rimanda ai documenti relativi.*

### 3.9 L'immutabilità del kernel

OSZ è immutabile per costruzione, non per un divieto scritto: è un controllo d'accesso meccanico a impedire che l'anello, cioè l'intelligenza artificiale, lo riscriva. Il kernel si evolve solo attraverso una ratifica umana verificata.

*Il meccanismo che realizza questa immutabilità — il recinto Tier-0 e la Porta TOTP — è un'attuazione, e si rimanda al documento relativo.*

---

## 4. OS3 — l'Esecuzione

OS3 è il piano in cui l'intelligenza artificiale opera come co-autore, a una velocità che non consente la verifica in tempo reale. È parte del paradigma, ed è un principio: l'esecuzione va imbrigliata meccanicamente. Non va confuso con Nexus, che ne è l'attuazione, cioè la macchina a pagamento descritta più avanti.

### 4.1 Il sistema di priorità

Le priorità vanno da P0 a P3:

- **P0** — il sistema si rompe subito. Ci si ferma e si corregge prima di procedere.
- **P1** — codice non pronto per la produzione. Va corretto prima del rilascio.
- **P2** — debito tecnico. Va affrontato con un refactoring programmato.
- **P3** — indicazione di contesto. Consigliata, ma non vincolante.

### 4.2 Le tredici regole P0

Ogni regola P0 nasce da un errore concreto avvenuto in produzione: sono cicatrici codificate. Le tredici regole operazionalizzano i pilastri cardinali, e sono:

- **Regola Zero** — mai dedurre; se non sai, chiedi.
- **Chiavi di traduzione** — nessun testo scritto direttamente nell'interfaccia; ogni parola visibile passa dal sistema di traduzione.
- **Regola sulle statistiche** — parametri delle statistiche sempre espliciti, mai valori assunti di nascosto.
- **Divieto di inventare metodi** — prima di chiamare un metodo, verificare che esista.
- **Gestione centralizzata degli errori** — gli errori passano da un gestore unico, mai da soluzioni improvvisate.
- **Verifica dei metodi di servizio** — prima di chiamare un metodo di un servizio, verificare che esista con quella firma.
- **Verifica delle costanti enum** — prima di usare una costante, verificare che esista davvero.
- **Analisi completa del flusso** — prima di una modifica non banale, mappare l'intero flusso interessato.
- **Internazionalizzazione completa** — ogni testo disponibile in tutte le lingue fin dal primo momento.
- **Nessun accesso diretto ai dati** — l'accesso al database passa sempre da un livello di astrazione.
- **DOC-SYNC** — codice e documentazione allineati prima di considerare chiusa un'attività.
- **Divieto di inventare l'infrastruttura** — percorsi, indirizzi e configurazioni si verificano alla fonte, non si deducono.
- **Test-first** — ogni funzionalità, correzione o rifacimento produce o aggiorna un test.

### 4.3 DOC-SYNC — la documentazione viva

DOC-SYNC parte da un principio semplice — codice e documentazione viaggiano insieme, e un'attività non è conclusa finché la documentazione di fonte non è allineata al codice — ma la sua portata è molto più grande di così, e vale la pena dirla per intero.

La maggior parte dei team tratta la documentazione come un peso: la scrive dopo, la lascia invecchiare, e nel dubbio guarda direttamente il codice. In un LSO succede il contrario. La conoscenza viene scritta in SSOT, cioè in fonti uniche di verità; questi SSOT vengono tokenizzati e messi in un RAG, un archivio interrogabile; e quel RAG è disponibile a due lettori insieme. Da un lato le persone che sviluppano, che possono chiedere e ricevere la conoscenza giusta al momento giusto. Dall'altro gli assistenti di intelligenza artificiale, che in un LSO sono presenti per definizione, e che attingono da lì la loro fonte di verità invece di andare a indovinare.

Così la documentazione smette di essere un archivio morto e diventa **viva**: consultabile, interrogabile, e soprattutto è ciò da cui il sistema stesso — persone e AI — si informa per lavorare. È una delle cose che rendono un LSO un organismo e non un semplice programma: un corpo che ricorda ciò che ha imparato e lo rende disponibile a chi vi opera.

*Il software che esegue tutto questo — il rilevamento delle divergenze, il controllo di copertura, la tokenizzazione e la re-indicizzazione nel RAG — appartiene a Nexus.*

### 4.4 Mission Protocol — il vero lavoro del dev

Il Mission Protocol stabilisce che ogni cambiamento al codice passa attraverso una **mission**: un'unità di lavoro numerata, con fasi sequenziali e un registro delle decisioni. Nulla si modifica al di fuori di una mission aperta. Ma dietro questa regola c'è il cambiamento più profondo che Oracode Nexus porta nel modo di lavorare.

Con Oracode Nexus, il dev non scrive più il codice: fa **Solid Coding**, e fare Solid Coding significa, in pratica, **scrivere le mission**. La mission è la vera unità di lavoro del dev — descrive cosa si vuole ottenere, con quale scopo, entro quali confini — e da lì in avanti è il sistema, sotto imbrigliatura, a produrre il codice che la realizza. Il dev non è lasciato solo davanti a un foglio bianco: può scrivere la mission insieme al CTO di Oracode, l'intelligenza artificiale che lo guida a comporre una mission fatta bene, secondo lo standard.

È da qui che nasce **tutta l'imbrigliatura**. La mission è il punto in cui l'intenzione umana entra nel sistema in forma disciplinata; ogni regola, ogni gate, ogni audit di cui parla il resto di questo documento agisce a partire da lì. Chi capisce questo capisce Oracode Nexus: non uno strumento che scrive codice al posto tuo, ma un sistema che sposta il tuo lavoro dal digitare righe al dichiarare, bene, che cosa deve esistere.

*Il motore che enforcia il Mission Protocol appartiene a Nexus.*

### 4.5 L'audit del codice

È qui che vive, concreta, la seconda verticalizzazione del principio di Audit enunciato nel kernel (§3.8). Prima che il codice diventi definitivo, degli **agenti** — intelligenze artificiali specializzate — lo esaminano e ne controllano l'aderenza sia alle buone pratiche standard della programmazione sia ai principi di Oracode. È un rinforzo dell'imbrigliatura: là dove i nervi deterministici bloccano le violazioni nette, l'audit degli agenti giudica la qualità nel suo insieme, quella che un gate meccanico non saprebbe misurare.

È in gran parte da qui che nasce il livello molto alto di qualità del codice prodotto sotto Oracode Nexus: non si spera che il codice sia buono, lo si sottopone ad audit prima che diventi definitivo. E per una capacità software questo audit non resta isolato — il suo superamento è una delle cose che la chiusura della mission attesta, ed è il punto in cui questa verticalizzazione, sul codice, tocca l'altra, sul valore (§3.8).

*Gli agenti che eseguono l'audit appartengono a Nexus.*

### 4.6 Strategia Delta

La Strategia Delta stabilisce come trattare il codice nuovo e quello preesistente. Il codice nuovo segue tutte le regole di Oracode. Il codice legacy resta com'è, e si migra soltanto quando lo si tocca per un'altra ragione, mai per un refactoring di principio. In questo modo si evitano i due rischi opposti: il debito tecnico non gestito e il refactoring nevrotico.

### 4.7 Nexus, l'attuazione di OS3

Nexus non è OS3. È l'insieme dei componenti software che fanno rispettare meccanicamente le regole di OS3, nel piano in cui l'intelligenza artificiale opera. È un prodotto commerciale, e si colloca al livello della software house.

Il suo cuore è il **sistema di enforcement a hook**. Un hook è un controllo che scatta al confine di ogni azione dell'intelligenza artificiale: *prima* che l'azione avvenga, per bloccarla se viola una regola, oppure *dopo*, per verificarne l'esito. Ciò che li rende diversi da una semplice istruzione è che sono **gate fail-closed**: in caso di dubbio o di controllo non superato, l'azione è *negata*, non consentita. Un'istruzione scritta, l'intelligenza artificiale può leggerla e poi ignorarla sotto degradazione; un gate fail-closed non si può ignorare, perché non chiede il permesso di agire — lo concede o lo nega.

Qui il paradigma chiude il cerchio aperto all'inizio (§0). Il problema era la degradazione: l'AI corretta al minuto dodici che al minuto quarantacinque rifà lo stesso errore. La risposta è che ogni regola P0 viene legata a uno o più hook che la fanno rispettare automaticamente, nel momento stesso dell'azione, senza affidarsi all'interpretazione del modello. È la ragione per cui, in Oracode, la disciplina non resta un buon proposito: diventa un cancello. E ogni hook è, concretamente, un'istanza del primitivo Nerve (§3.3) — il riflesso deterministico che verifica e blocca, ma non giudica.

Il pattern — un hook meccanico e fail-closed per ogni regola P0 — è universale; l'elenco preciso degli hook è invece specifico del dominio, e cambia da un'applicazione all'altra.

Sull'origine del nome vale una precisazione. Nexus nasce come os3-matrix, cioè l'attuatore di OS3, e da qui deriva il nome storico; il repository e l'implementazione tecnica conservano il nome os3-matrix. Per convenzione, nella nomenclatura ufficiale si scrive Nexus. Chi ne cerca l'origine ritrova comunque il legame: Nexus è l'attuatore di OS3.

*Il catalogo dei componenti — gli hook concreti, i gate, gli agenti di verifica — si rimanda alla documentazione tecnica.*

---

## 5. OS4 — l'Educazione

OS4 opera sull'essere umano, a velocità umana e con giudizio. Non servono gate meccanici, che qui sarebbero paternalistici, ma pattern pedagogici: onboarding, manifesti, formazione. Il suo scopo è che l'operatore impari a usare bene l'intelligenza artificiale.

OS4 è l'altra faccia degli errori. Gli errori di tipo OS3 sono quelli dell'intelligenza artificiale che produce qualcosa di plausibile ma falso; gli errori di tipo OS4 sono quelli dell'essere umano che non sa ancora guidare l'intelligenza artificiale. OS4 si occupa dei secondi.

*Questa sezione va sviluppata a partire dal documento di fondazione di OS4.*

---

## 6. La gerarchia dei ruoli

I ruoli dell'ecosistema si definiscono per funzione e per il meccanismo che opera al loro confine, mai per criteri di semplice appartenenza.

Il Paradigma è il livello delle regole: è Oracode, con licenza MIT.

La Software House è l'acquirente con licenza. A questo livello vivono Nexus, come attuazione, e le Librerie LSO. La sua funzione si riconosce dal meccanismo che opera qui: è il confine di aggregazione delle statistiche globali, perché conta tutto ciò che quel compratore produce.

Il Customer è il cliente. Il meccanismo che lo definisce è la separazione: distingue le funzioni di un cliente da quelle di un altro. Sotto la software house stanno i clienti, non le applicazioni: sono i clienti ad avere le applicazioni.

Le applicazioni che un cliente possiede si distinguono a loro volta in tre forme, a seconda di come è costituito l'organismo software che le realizza: l'Organismo, l'Organo e il Progetto. L'Organismo è un LSO composto da più organi, come FlorenceEGI. L'Organo è un LSO che appartiene a un Organismo. Il Progetto è un LSO composto da un solo organo.

La Libreria LSO, infine, è un repository-strumento della software house, al servizio di tutti i lavori.

*Nota. Alcuni di questi ruoli sono paradigmatici — l'Organismo, l'Organo, il Progetto, l'LSO, che descrivono la struttura dell'organismo software — mentre altri sono più commerciali o di distribuzione, come la Software House e il Customer. È possibile che non trovino posto tutti nello stesso capitolo.*

---

## Rimandi

Restano fuori da questo documento, e si trovano nella documentazione specifica: il catalogo delle Librerie LSO e l'elenco degli organi e delle istanze; le specifiche tecniche di Nexus, del Sigillo e del software DOC-SYNC; il dettaglio del Layer Stack — la tabella dei livelli, i sei principi invarianti, i cinque stati di maturity e la matrice di maturità di una singola istanza —, che vive nella nomenclatura; e lo stack di naming completo, con la categoria di mercato e la pratica.

---

## Note per la ratifica

Tre punti che erano aperti sono stati chiusi in corso di revisione, e li registro qui. Regola Zero e i Pilastri restano in OSZ come principi costituzionali, e si verticalizzano in OS3 nelle tredici P0: non erano un dubbio, ma un'applicazione del rapporto astrazione-verticalizzazione descritto al §2. Il Layer Stack entra nel kernel come concetto (§3.6), mentre il suo dettaglio resta a rimando nella nomenclatura. E il concetto di Audit non unisce più due cose in una: è un solo principio con due verticalizzazioni distinte, sul valore (§3.8) e sul codice (§4.5).

Resta da confermare il nome del file, la sua collocazione nel repository e la sua visibilità pubblica, coerente con la natura MIT del paradigma. Resta aperta anche la collocazione della gerarchia dei ruoli (§6): se debba vivere qui o in un documento a sé.

*Documento Base di Oracode, versione preliminare 0.6.0, 15 luglio 2026. Da ratificare capitolo per capitolo; una volta ratificato, verrà sigillato e distillato nei file operativi.*
