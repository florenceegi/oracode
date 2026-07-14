---
title: "Oracode — Documento Base (radice del paradigma)"
slug: oracode-base
doc_type: ssot-white-paper
status: draft-per-ratifica-CEO
version: 0.2.0
date: '2026-07-14'
author: "Padmin D. Curtis (Supervisor-CTO) per Fabio Cherici (CEO)"
scope: [oracode]
visibility: public
rag: public
---

# Oracode — Documento Base

Questo è il documento radice del paradigma. Descrive Oracode e la sua anatomia — OSZ, OS3 e OS4 — nel loro insieme. È un documento di fonte (SSOT) e ha valore di white paper: è completo, dettagliato e autorevole, e non va compresso. Sta prima di ogni altro documento del paradigma, e gli altri vi rimandano.

Non è un file operativo. I file di sistema `CLAUDE_*`, che vengono caricati nel contesto dell'intelligenza artificiale per guidarne il lavoro, sono una distillazione compressa di questo documento: la verità si scrive qui e da qui discende verso i file operativi, mai il contrario. I lettori di questo documento sono le persone — chi sviluppa, chi valuta il prodotto — e l'intelligenza artificiale quando le viene chiesto di approfondire.

Vale una regola di scrittura. Qui si definiscono i concetti, per esteso. Le liste che cambiano nel tempo — cataloghi di prodotti, elenchi di organi, componenti — e le implementazioni tecniche non stanno in questo documento: se ne dà il concetto e si rimanda al documento specifico. Il criterio è semplice: se una cosa cambia o si esegue, non appartiene al documento base.

---

## 0. Cos'è il Paradigma Oracode

Oracode è un paradigma di sviluppo software AI-native. È il metodo con cui un essere umano e un'intelligenza artificiale costruiscono software insieme, imponendo disciplina epistemica e infrastruttura documentale a qualsiasi sistema costruito con esso. È una metodologia, non un prodotto: è il modo in cui si costruisce, non ciò che si costruisce.

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

---

## 3. OSZ — il Kernel

OSZ, una volta fondato, non si cambia. Per questo contiene soltanto i concetti che non cambiano mai. Tutto ciò che cambia, o che si esegue, vive altrove.

### 3.1 Regola Zero

Regola Zero è il principio fondante: mai dedurre, mai completare le lacune; se non sai, chiedi. Davanti a un'informazione mancante l'intelligenza artificiale non procede: si ferma e chiede. La domanda sostituisce l'invenzione e la verifica sostituisce la deduzione. È l'autorità superiore da cui derivano molte delle regole operative che si trovano in OS3.

### 3.2 I Pilastri Cardinali

I pilastri sono i valori costituzionali del paradigma. Sono sei, più uno.

Il primo è l'intenzionalità esplicita: dichiarare sempre perché si fa ciò che si fa. Il secondo è la semplicità potenziante: scegliere la strada che rende più liberi, senza astrazioni inutili. Il terzo è la coerenza semantica: parole e azioni allineate, dove una funzione fa ciò che il suo nome promette. Il quarto è la circolarità virtuosa: ogni bug diventa un test, ogni soluzione alimenta il sistema. Il quinto è l'evoluzione ricorsiva: ogni risultato migliora il processo, e la documentazione co-evolve con il codice. Il sesto è la sicurezza proattiva: sicurezza per costruzione, non correzione a posteriori. Il settimo, che sta sopra gli altri, è Regola Zero.

### 3.3 I Primitivi

Come un sistema operativo ha i suoi primitivi — processi, thread, memoria, input e output — così OSZ ha i suoi. Sono quattro.

**RAV** è l'unità atomica di valore. È un contenitore tipizzato reso prodotto reale da tre elementi, secondo la formula `RAV = Wrapper<T> + Regole + Audit + Valore`. Il contenuto `T` può essere qualsiasi cosa: un'opera, un diritto, un flusso economico, un bene fisico, un contratto, un servizio, una competenza, una capacità software. Le regole lo governano, l'audit lo certifica, il valore lo rende scambiabile. Il nome interno è RAV; nella forma qualificata pubblica è Oracode_RAV.

Il RAV è un primitivo universale, e le sue istanze concrete sono molte. Un EGI, l'unità di valore dell'ecosistema FlorenceEGI, è un RAV il cui contenuto è un'opera, certificato su blockchain. Una capacità di produzione software è un RAV il cui contenuto è una responsabilità, certificato dalla chiusura standard di una mission. Una competenza verificabile è un RAV il cui contenuto è la competenza stessa. È sempre lo stesso primitivo: cambia solo ciò che contiene.

**Interface** è la giuntura stabile. È il contratto fisso tra due parti, che non cambia anche quando cambia ciò che sta dietro. Vale l'immagine del ginocchio: l'osso e il tendine possono cambiare, ma l'articolazione resta stabile. Finché le interfacce restano stabili, si può sostituire qualsiasi organo dietro di esse senza far crollare il sistema.

**Instance** è l'organo sostituibile. È un pezzo che svolge un lavoro e comunica con il resto del sistema soltanto attraverso le interfacce; proprio per questo può essere sostituito, scollegato o aggiornato senza far crollare l'insieme. È il principio SOLID applicato a un intero ecosistema.

**Nerve** è il riflesso deterministico. È il gate, l'hook che scatta al confine: verifica, blocca, segnala, ma non giudica. È come il nervo che ritira la mano dal fuoco prima ancora che il cervello decida. È deterministico, e non è mai l'opinione di un modello.

Su questo punto va corretto un errore della prima versione del kernel. L'intelligenza artificiale che giudica — che ottimizza, che vede il sistema nel suo insieme — non è un nervo: è la mente, e opera in OS3, non nell'anatomia del kernel. L'anatomia possiede i nervi; la mente li usa, ma non è essa stessa un nervo.

### 3.4 Il rapporto tra OSZ e LSO

OSZ definisce i primitivi; un LSO è costruito con istanze di essi. I suoi organi sono istanze di Instance, le sue giunture sono istanze di Interface, i suoi nervi sono istanze di Nerve, e il valore che maneggia è RAV. Il rapporto è di definizione e istanziazione: l'anatomia di un LSO usa i primitivi, non coincide con essi.

### 3.5 Il concetto di LSO

Un LSO, cioè un Living Software Organism, è il prodotto vivente di Oracode applicato a un dominio: un software dotato di un proprio sistema circolatorio, che cattura la propria esperienza, la struttura e la rende riutilizzabile, e in questo modo cresce. Non è un insieme di siti collegati, ma un corpo in cui ogni progetto è un organo, ogni interfaccia un'articolazione e l'intelligenza artificiale il sistema nervoso.

### 3.6 Il concetto di Sistema Circolatorio

Il sistema circolatorio è il meccanismo per cui, all'interno di un LSO, l'esperienza circola e diventa patrimonio riutilizzabile: ogni cosa fatta viene catturata, strutturata e resa disponibile per la volta successiva. È un concetto universale. Gli Egili di FlorenceEGI ne sono un'applicazione, non la definizione.

*Le implementazioni concrete dei meccanismi — Mission Protocol, DOC-SYNC, RAG — appartengono a OS3.*

### 3.7 Il concetto di Audit

L'audit è la prova verificabile di che cosa è una cosa e da dove proviene: è la componente «A» del RAV. È il concetto universale di certificazione, cioè di esistenza, integrità e anteriorità.

*La macchina che lo realizza — l'impronta crittografica ancorata su blockchain, il Sigillo — è un'implementazione, e si rimanda al documento relativo.*

### 3.8 L'immutabilità del kernel

OSZ è immutabile per costruzione, non per un divieto scritto: è un controllo d'accesso meccanico a impedire che l'anello, cioè l'intelligenza artificiale, lo riscriva. Il kernel si evolve solo attraverso una ratifica umana verificata.

*Il meccanismo che realizza questa immutabilità — il recinto Tier-0 e la Porta TOTP — è un'attuazione, e si rimanda al documento relativo.*

---

## 4. OS3 — l'Esecuzione

OS3 è il piano in cui l'intelligenza artificiale opera come co-autore, a una velocità che non consente la verifica in tempo reale. È parte del paradigma, ed è un principio: l'esecuzione va imbrigliata meccanicamente. Non va confuso con Nexus, che ne è l'attuazione, cioè la macchina a pagamento descritta più avanti.

### 4.1 Il sistema di priorità

Le priorità vanno da P0 a P3. P0 indica che il sistema si rompe subito, e impone di fermarsi e correggere prima di procedere. P1 indica codice non pronto per la produzione, da correggere prima del rilascio. P2 indica debito tecnico, da affrontare con un refactoring programmato. P3 è un'indicazione di contesto, consigliata ma non vincolante.

### 4.2 Le tredici regole P0

*Questa sezione è un elenco riassuntivo. Il testo per esteso di ciascuna regola va sviluppato in versione definitiva, coerentemente con il carattere di white paper del documento.*

Ogni regola P0 nasce da un errore concreto avvenuto in produzione: sono cicatrici codificate. Le tredici regole sono: Regola Zero; le chiavi di traduzione; la regola sulle statistiche; il divieto di inventare metodi; l'obbligo di gestire gli errori dal gestore centralizzato; il divieto di chiamare metodi di servizio senza verificarli; il divieto di usare costanti enum senza verificarle; l'analisi completa del flusso prima di una modifica non banale; l'internazionalizzazione completa fin dal primo commit; il divieto di accedere ai dati bypassando il livello di astrazione; DOC-SYNC; il divieto di inventare informazioni di infrastruttura; e la disciplina del test-first. Le tredici regole operazionalizzano i pilastri cardinali.

### 4.3 DOC-SYNC

DOC-SYNC è il principio per cui il codice e la documentazione viaggiano insieme: una attività non è conclusa finché la documentazione di fonte non è allineata al codice.

*Il software che esegue questo principio — rilevamento delle divergenze, controllo di copertura, re-indicizzazione — appartiene a Nexus.*

### 4.4 Mission Protocol

Il Mission Protocol è il principio per cui ogni cambiamento al codice passa attraverso una mission numerata, con fasi sequenziali e un registro delle decisioni. Nulla si modifica al di fuori di una mission aperta.

*Il motore che enforcia questo principio appartiene a Nexus.*

### 4.5 Strategia Delta

La Strategia Delta stabilisce come trattare il codice nuovo e quello preesistente. Il codice nuovo segue tutte le regole di Oracode. Il codice legacy resta com'è, e si migra soltanto quando lo si tocca per un'altra ragione, mai per un refactoring di principio. In questo modo si evitano i due rischi opposti: il debito tecnico non gestito e il refactoring nevrotico.

### 4.6 Nexus, l'attuazione di OS3

Nexus non è OS3. È l'insieme dei componenti software — hook, gate e agenti — che fanno rispettare meccanicamente le regole di OS3, nel piano in cui l'intelligenza artificiale opera. È un prodotto commerciale, e si colloca al livello della software house.

Sull'origine del nome vale una precisazione. Nexus nasce come os3-matrix, cioè l'attuatore di OS3, e da qui deriva il nome storico; il repository e l'implementazione tecnica conservano il nome os3-matrix. Per convenzione, nella nomenclatura ufficiale si scrive Nexus. Chi ne cerca l'origine ritrova comunque il legame: Nexus è l'attuatore di OS3.

*Per il catalogo dei componenti si rimanda alla documentazione tecnica.*

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

Seguono i tre livelli dell'organismo software. L'Organismo è un LSO composto da più organi, come FlorenceEGI. L'Organo è un LSO che appartiene a un Organismo. Il Progetto è un LSO composto da un solo organo.

La Libreria LSO, infine, è un repository-strumento della software house, al servizio di tutti i lavori.

*Nota. Alcuni di questi ruoli sono paradigmatici — l'Organismo, l'Organo, il Progetto, l'LSO, che descrivono la struttura dell'organismo software — mentre altri sono più commerciali o di distribuzione, come la Software House e il Customer. È possibile che non trovino posto tutti nello stesso capitolo.*

---

## Rimandi

Restano fuori da questo documento, e si trovano nella documentazione specifica: il catalogo delle Librerie LSO e l'elenco degli organi e delle istanze; le specifiche tecniche di Nexus, del Sigillo e del software DOC-SYNC; il Layer Stack nel suo dettaglio; e lo stack di naming completo, con la categoria di mercato e la pratica.

---

## Note per la ratifica

Restano da confermare alcuni punti, sui quali ho fatto delle scelte provvisorie.

Ho collocato Regola Zero e i Pilastri Cardinali in OSZ, ritenendoli parte della costituzione più che del protocollo di esecuzione. Vanno confermati lì, oppure spostati in OS3.

Ho scritto la gerarchia dei ruoli e accennato al Layer Stack all'interno di questo documento, ma è ancora aperta la decisione se debbano vivere qui o in un documento a sé.

Le tredici regole P0 sono per ora soltanto elencate; se il documento deve essere completo come white paper, vanno sviluppate per esteso.

Restano infine da confermare il nome del file, la sua collocazione nel repository e la sua visibilità pubblica, coerente con la natura MIT del paradigma.

*Documento Base di Oracode, versione preliminare 0.2.0, 14 luglio 2026. Da ratificare capitolo per capitolo; una volta ratificato, verrà sigillato e distillato nei file operativi.*
