# ORACODE PARADIGM

**Versione:** 2.1 — Draft di lavoro
**Autore:** Fabio Cherici
**Revisione nomenclatura:** Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
**Data originale:** 14 maggio 2026
**Data revisione:** 25 maggio 2026
**Aggiornamento:** 25 maggio 2026 — Template architetturali boot context (sezione 8.1) + 22 maggio 2026 — Decisione commerciale MIT/OS3 Matrix (sezione 2)
**Stato:** Documento in costruzione, non pubblico
**Allineamento:** LSO Nomenclature v2.1.0 (22 maggio 2026)

---

## Indice

**Macroarea uno — Cosa Oracode è**

1. Oracode System
2. L'articolazione interna — paradigma e OS3 Matrix
3. LLM, non AI
4. La natura degli LLM
5. Una nota sull'orizzonte
6. Perché Oracode
7. I sei pilastri orientativi
8. REGOLA ZERO
9. Sistema di priorità P0/P1/P2/P3
10. Le tredici regole P0 universali
11. Strategia Delta
12. La firma Oracode

**Macroarea due — Come si lavora con Oracode**

1. /project — la concezione di un nuovo progetto
2. /mission — l'unità di lavoro
3. Mission Protocol e Bootstrap
4. DOC-SYNC come principio operativo
5. Trigger Matrix
6. Enforcement via hook — il principio
7. Modello operativo CEO/CTO
8. Agenti specializzati come principio organizzativo

**Macroarea tre — Forme architetturali**

1. I quattro livelli di applicazione
2. Applicazione singola Oracode-disciplinata
3. Oracode in profondità
4. LSO mono-organo
5. LSO multi-organo
6. Esempi e casi reali
7. Disaccoppiamento tra Oracode e LSO

**Macroarea quattro — Strumenti specializzati di Oracode**

1. Cosa è uno strumento Oracode
2. La penisola
3. Pattern di costruzione di uno strumento Oracode
4. Processo di ammissione e certificazione
5. Catalogo e governance
6. Strumenti del paradigma — la famiglia Ultra
7. Strumenti del paradigma — knowledge base specializzate
8. Strumenti del paradigma — template e boilerplate
9. Componenti di OS3 Matrix — enforcement via hook, gate e organ index
10. Componenti di OS3 Matrix — gestione operativa
11. Componenti di OS3 Matrix — agenti specializzati e infrastruttura SSOT
12. Contributi di terze parti alla penisola

---

# MACROAREA UNO — COSA ORACODE È

## 1. Oracode System

Oracode System è un sistema di sviluppo software con LLM, pensato per chi costruisce per durare. Non è strumento adatto a dilettanti, ma per coloro che fanno dello sviluppo software il proprio lavoro: per produrre, assieme ad un LLM, codice che regge il tempo.

Oracode vive dentro una gerarchia di autorità a tre livelli — la **triade OSZ / OS3 / OS4** — che ne governa l'evoluzione:

**OSZ (Kernel).** Il sistema operativo dell'organismo cognitivo. È la verità assoluta: i principi costituzionali che non si negoziano, non si aggiornano per convenienza, non si piegano alle contingenze del momento. OSZ è l'orizzonte regolatorio di tutto il sistema. Se un dubbio sorge tra una regola operativa e un principio kernel, il principio kernel vince. Sempre.

**OS3 (Execution).** Il protocollo operativo AI-Human. Qui vivono le regole P0-P3, i pilastri, gli hook, il DOC-SYNC, tutto ciò che governa il rapporto quotidiano tra chi scrive e l'LLM. OS3 si aggiorna per allinearsi a OSZ — mai il contrario.

**OS4 (Education).** L'educazione epistemica dell'umano. La formazione di chi entra in contatto con il paradigma: onboarding, manifesti, pattern pedagogici, cultura del codice. OS4 si aggiorna per allinearsi a OSZ — mai il contrario.

**Regola immutabile:** OSZ è la verità assoluta. OS3 e OS4 si aggiornano per allinearvisi — mai il contrario.

Questa gerarchia è il fondamento concettuale di Oracode e va mantenuta in qualsiasi applicazione del paradigma. Il *contenuto* specifico di OSZ (cosa il kernel governa) può essere dominio-specifico; la *struttura* tre-livelli è universale.

## 2. L'articolazione interna — paradigma e OS3 Matrix

Oracode si articola formalmente in due piani interni. Non sono due prodotti distinti — sono due facce della stessa cosa, e servono ragioni diverse.

**Oracode-paradigma** è il pensiero puro: le regole epistemiche, i pilastri, la triade OSZ/OS3/OS4, i pattern architetturali (Mission Protocol, DOC-SYNC, RAG, Helping), gli standard (SEO, A11y, GDPR), la disciplina documentale, Strategia Delta. Tutto ciò che è trasferibile a qualsiasi dominio come metodologia. Le Macroaree uno, due e tre di questo documento descrivono in massima parte Oracode-paradigma.

**OS3 Matrix** (alias OSMx) è lo strumento di enforcement: il software che fa rispettare le regole del paradigma al piano OS3, dove l'AI opera come co-autore a velocità non verificabile dall'umano in tempo reale. Hook bloccanti, gate validator, agenti specializzati, DOC-SYNC v2 come software runtime, SSOT registry, Mission Protocol enforcement automatico. La Macroarea quattro di questo documento descrive sia strumenti del paradigma sia componenti di OS3 Matrix, e li distingue.

Questa separazione è giustificata da un problema che non esisteva prima dell'era AI.

*Asimmetria di velocità.* Un LLM produce codice, documentazione, decisioni architetturali a una velocità che rende impossibile la revisione umana in tempo reale. In un'ora di lavoro, un LLM può generare cinquanta file, dieci migration, duecento edit. L'umano non può leggere duecento edit in tempo reale e verificare che ciascuno rispetti REGOLA ZERO, ogni P0, ogni naming convention. Servono gate che lo facciano meccanicamente.

*Asimmetria di degradazione.* Un LLM non "impara" dalle correzioni precedenti nella stessa sessione in modo affidabile. Può violare una regola P0 al minuto quarantacinque anche se è stato corretto per la stessa violazione al minuto dodici. La degradazione non è errore — è proprietà strutturale della generazione statistica. L'umano, corretto una volta, raramente ripete lo stesso errore nello stesso contesto. Servono gate che non "correggano" ma impediscano — hook fail-closed, non istruzioni interpretabili.

Il rapporto tra i due piani è questo: il paradigma prescrive, la Matrix enforcea. Senza il paradigma, la Matrix non ha regole da far rispettare. Senza la Matrix, le regole restano indicazioni interpretabili — fragili sotto la pressione di un LLM che produce a cento volte la velocità dell'umano.

```
Oracode-paradigma                OS3 Matrix
─────────────────               ─────────────────────────
Definisce regole P0             Implementa hook che le enforcano
Prescrive DOC-SYNC              Esegue drift detection runtime
Disegna Mission Protocol        Enforcea fasi e counter
Impone standard SEO/A11y        Esegue gate Lighthouse bloccante
Stabilisce naming               Verifica naming via agent
```

Se la Matrix si rompe, le regole restano valide — perdono solo l'enforcement automatico. Se il paradigma cambia, la Matrix si aggiorna per riflettere il cambio.

Una precisazione necessaria. Non esiste OS4 Matrix né OSZ Matrix. OS4 (Educazione) opera sull'umano a velocità umana — servono pattern pedagogici, non gate meccanici. OSZ (Kernel) è costituzionale e immutabile — un kernel che ha bisogno di un tool per far rispettare sé stesso non è un kernel, è una policy. L'enforcement automatico serve solo dove c'è un agente che produce a velocità incontrollabile con degradazione possibile — l'LLM, che vive nel piano OS3. Esiste solo OS3 Matrix.

**Conseguenza commerciale della distinzione.** Questa separazione ha implicazioni economiche dirette. Oracode-paradigma è MIT-licensed, pubblico e gratuito — distribuito al pari di OOP e SOLID, come cornice di sviluppo AI-native disponibile a chiunque voglia adottarla. OS3 Matrix è prodotto commerciale di Florence EGI S.R.L., con pricing definito separatamente. Il modello è open-core applicato al paradigma stesso: il pensiero è libero, lo strumento che lo enforce a un LLM in produzione è commerciale. Questa scelta protegge contemporaneamente la natura aperta del paradigma (un paradigma chiuso non si afferma) e il valore industriale dello strumento di enforcement (che è ciò che separa adozione dichiarata da adozione verificabile). La decisione strategica è del 22 maggio 2026, formalizzata in dettaglio nella Nomenclatura LSO v2.1.0 (§1.1.B e §4.1).

## 3. LLM, non AI

Una precisazione terminologica è necessaria fin dall'inizio. Lavoriamo con LLM — Large Language Model — non con AI in senso generico. Sotto l'etichetta "intelligenza artificiale" convivono famiglie tecnologiche profondamente diverse: sistemi simbolici che ragionano per regole, motori di reinforcement learning che ottimizzano per obiettivi, reti di visione che riconoscono pattern. Gli LLM sono una famiglia precisa, e Oracode si occupa di loro perché loro sono ciò che lo sviluppatore software ha sotto mano nel 2026 quando dice "lavoro con l'AI".

## 4. La natura degli LLM

Gli LLM hanno una natura che vale la pena nominare senza eufemismi. Non ragionano: predicono. Non deducono logicamente: completano statisticamente. Non verificano la verità di ciò che producono: generano la sequenza più probabile dato il contesto. Questo, applicato alla scrittura di prosa, al brainstorming, alla traduzione, è esattamente ciò che serve — ed è ciò per cui sono stati progettati. Applicato al codice di produzione, che deve compilare, funzionare, reggere casi limite, essere sicuro e manutenibile per anni, la stessa natura diventa la sorgente principale di errori. Lo stesso meccanismo che rende un LLM brillante nello scrivere un saggio gli fa inventare un metodo di una classe che non esiste, perché statisticamente quel nome di metodo era plausibile.

## 5. Una nota sull'orizzonte

Vale la pena, sull'orizzonte, una nota di chi scrive. Lavorando in modo intensivo con gli LLM ho avuto modo di vedere con chiarezza un paradosso: sono oggi gli unici strumenti che permettono scrittura di codice a velocità prima impensabili, e sono al contempo strumenti per natura inadatti a un compito così delicato — la statistica predittiva non è il metodo del rigore informatico. L'impatto industriale che stanno comunque avendo è abbastanza grande da rendere ragionevole aspettarsi, in un futuro non lontano, la nascita di modelli pensati specificatamente per lo sviluppo software.

Oracode si colloca consapevolmente in questa traiettoria. È risposta al presente — al problema concreto dello sviluppo professionale con i modelli che oggi abbiamo — e al contempo, forse, primo contributo a delineare quali discipline un modello pensato per lo sviluppo software dovrà incarnare. È accaduto altre volte nella storia del software: paradigmi nati come regole esplicite e protocolli esterni hanno finito per informare il design degli strumenti delle generazioni successive, che li hanno integrati nativamente. Oracode oggi è protocollo. Domani, se la traiettoria che descrive si rivelerà giusta, sarà uno dei riferimenti su cui chi costruirà quei modelli vorrà confrontarsi.

## 6. Perché Oracode

Il nome è composto da due parole: oracolo e codice. La premessa originale era semplice: scrivere codice che si autospieghi, codice che un umano e un LLM possano comprendere altrettanto bene e che resti quindi facilmente scalabile nel tempo.

Questo approccio ha fatto da pettine a tutti i limiti dei vari modelli LLM applicati alla produzione di codice. Lasciato a se stesso, un LLM produceva qualcosa di terribile... metodi inventati che assomigliano a quelli che esistono, costanti riempite con valori plausibili, error handling generico che maschera i problemi invece di esporli, traduzioni hardcoded che bloccano qualunque internazionalizzazione successiva. Non per cattiva volontà del modello — per natura statistica, esattamente quella descritta sopra.

Davanti a un sistema di cui si conoscono i limiti, le scelte possibili sono due. Cercare un sistema diverso, oppure conoscere il sistema esistente meglio che puoi e costruire intorno regole, modus operandi, protezioni che lo incanalino. La prima scelta, allo stato attuale, non è praticabile: gli LLM sono — per ora — l'unico strumento disponibile per scrittura di codice a velocità non umane. Rimane la seconda, e da qui nasce la necessità di Oracode System.

Si è sviluppato nell'arco di circa tre anni, a ritmo esponenzialmente crescente man mano che le regole si consolidavano, testandosi su oltre un milione di righe di codice in produzione distribuite su dieci progetti enterprise di un unico ecosistema. La parola "unico ecosistema" non va letta come un singolo stack tecnico: i dieci progetti coprono Laravel e PHP per il backend di alcuni di essi, FastAPI e Python per i layer di intelligenza artificiale, React e TypeScript per le SPA di frontend, PostgreSQL con estensioni vettoriali per la memoria operativa, blockchain Algorand per la certificazione crittografica. Stack diversi, problemi diversi, ma un unico paradigma applicato attraverso tutti. Funziona da Formula 1 del paradigma: è in condizioni operative estreme che le regole vengono messe alla prova davvero, ed è da lì che le tecnologie poi scendono nell'industria. Le imperfezioni emergono dove sarebbero invisibili in contesti più semplici.

La verifica esterna — Oracode applicato fuori dall'ecosistema di origine — è arrivata su un caso isolato e documentato: un sito web per un'azienda di oreficeria, sviluppato in circa sedici ore di lavoro effettivo (log git verificabile su richiesta) contro la stima di duecento-quattrocento giornate-persona di un'agenzia tradizionale. Punteggi Lighthouse tra 91 e 100 su tutte le dimensioni rilevanti. Non un campione statistico — un singolo caso di trasferibilità verificato, che conferma la struttura senza pretendere di dimostrarla esaustivamente.

È esito contro-intuitivo per chi pensa alla disciplina come freno — è esito esattamente attendibile per chi pensa alla disciplina come canale.

## 7. I sei pilastri orientativi

Oracode si poggia su sei pilastri orientativi. Non sono regole bloccanti — sono principi che orientano la scrittura del codice e che, presi insieme, definiscono cosa significa "fatto bene" in Oracode. Le regole bloccanti, le P0, derivano da questi pilastri ma sono cose distinte: i pilastri vivono nel pensiero di chi scrive, le P0 vivono come gate meccanici nel sistema.

**Intenzionalità Esplicita.** *Dichiara sempre perché fai quello che fai.* Ogni decisione tecnica, ogni scelta architetturale, ogni riga di codice ha un perché, e quel perché va dichiarato. Non basta sapere cosa stai facendo — devi sapere e rendere esplicito perché lo stai facendo. L'intenzione non resta implicita, non si lascia all'interpretazione, non si tratta come "ovvia". Si dichiara, e diventa interrogabile. Nel codice questo si traduce in DocBlock chiari, nomi di funzione che dicono lo scopo, commenti sul "perché" quando il codice da solo non basta. L'intenzionalità esplicita è il fondamento di tutto il resto, perché rende il codice leggibile non solo a chi lo legge oggi ma a chi lo leggerà tra cinque anni — e a un LLM che dovrà ragionare su di esso.

**Semplicità Potenziante.** *Scegli sempre la strada che ti rende più libero.* Di fronte a una scelta tecnica, la semplicità non significa banalità: significa massima libertà futura senza sacrificare l'efficacia presente. Una soluzione semplice si modifica facilmente quando il contesto cambia. Una soluzione complessa si modifica con dolore. La semplicità si paga in disciplina al momento della scrittura — costa più pensare a una soluzione semplice che a una complicata — ma si ripaga in libertà nel tempo. L'LLM tende per natura a soluzioni elaborate: sa generare codice complesso velocemente, e quella stessa facilità è trappola. Semplicità Potenziante è il pilastro che contrasta questo automatismo.

**Coerenza Semantica.** *Fa' che parole e azioni siano allineate.* I nomi che usi, le strutture che costruisci, le promesse che le tue funzioni fanno e le azioni che effettivamente compiono devono appartenere allo stesso universo semantico. Una funzione chiamata `updateUser()` deve aggiornare un utente — non aggiornarne anche le notifiche, non scrivere log di sistema, non inviare email. Se fa altre cose, va rinominata o spezzata. Per un LLM la coerenza semantica è ancora più importante che per un umano: l'LLM ragiona per pattern semantici, e l'incoerenza nei nomi degrada la sua capacità di scrivere e leggere codice. Coerenza Semantica è disciplina di linguaggio applicata al software.

**Circolarità Virtuosa.** *Crea valore che ritorna amplificato.* Ogni soluzione dovrebbe non solo risolvere il problema immediato, ma alimentare il sistema in modo che il prossimo problema simile sia più facile da risolvere. Un bug trovato genera un test che impedirà il bug di ripresentarsi. Una feature implementata bene genera un pattern riutilizzabile. Un errore gestito una volta genera una struttura di error handling che gestirà mille errori futuri. La Circolarità Virtuosa è il pilastro che trasforma il lavoro quotidiano in capitale accumulato — invece di consumo lineare di tempo, è investimento composto in capacità del sistema.

**Evoluzione Ricorsiva.** *Usa ogni successo per migliorare il sistema.* Ogni risultato ottenuto deve diventare input per migliorare il processo che lo ha generato. Non basta raggiungere obiettivi — bisogna estrarre la lezione e applicarla al modo di lavorare futuro. Una mission chiusa con successo genera pattern che entrano nella conoscenza del sistema. Un errore evitato per fortuna genera regola per evitarlo per disciplina la prossima volta. L'Evoluzione Ricorsiva è il pilastro che impedisce di rifare ogni volta gli stessi passaggi: il sistema impara da sé stesso e migliora a ogni ciclo.

**Sicurezza Proattiva.** *Integra la sicurezza come principio architetturale.* La sicurezza non è patch finale, non è controllo che si fa "se c'è tempo". È principio che pervade ogni decisione di design, dall'architettura più alta alla riga di codice più bassa. Validazione degli input, autorizzazione, protezione dei dati, gestione dei segreti, conformità normativa — tutto entra nel pensiero di chi scrive fin dall'inizio. Costa più scrivere così — sembra che la "vera" feature stia altrove — ma è l'unico modo di costruire codice che regge nel tempo. La Sicurezza Proattiva è il pilastro che riconosce che il software vive in un mondo ostile, e che gli ostili sono sia esterni (attacchi) sia interni (errori onesti che amplificano se non protetti).

Insieme, i sei pilastri non sono lista da spuntare — sono lente attraverso cui guardare ogni decisione tecnica. Chi scrive Oracode si chiede, davanti a ogni scelta: *la mia intenzione è esplicita? la mia soluzione mi lascia libero? il nome che ho scelto corrisponde a quello che fa? sto generando valore che ritorna o solo risolvendo? sto imparando qualcosa che il sistema porterà avanti? sto integrando sicurezza o aggiungendola dopo?* Quando le sei domande hanno risposta affermativa, il codice è coerente con il paradigma. Quando una sola risposta è no, c'è lavoro da fare.

## 8. REGOLA ZERO

C'è un settimo pilastro, ed è di natura diversa dai precedenti. Non orienta lo stile di scrittura — vincola il rapporto con l'LLM stesso. Si chiama REGOLA ZERO, e dice questo:

**Mai dedurre. Mai completare lacune. Se non sai, chiedi.**

REGOLA ZERO contrasta la natura predittiva degli LLM nel suo aspetto più pericoloso. Un LLM, di fronte a un'informazione mancante, non si ferma — completa con la sequenza statisticamente più probabile. Ti dice che il metodo `updateProfile()` esiste perché "in genere" esiste in classi che gestiscono utenti, anche se non l'ha mai verificato. Ti suggerisce di importare `App\Services\NotificationService` perché "tipicamente" un sistema così strutturato ha quel service, anche se nel codebase non c'è. Ti propone una costante `MAX_RETRIES = 3` perché "di solito" è quel valore, anche se non l'ha mai letta.

Questa è la sorgente principale degli errori in codice generato da LLM. Non sono bug di logica — sono **invenzioni di sostanza presentate come fatti**. L'LLM non mente per malizia, mente per natura: completa il pattern con quello che sembra plausibile, e lo presenta con la stessa sicurezza con cui presenta i fatti che sa davvero.

REGOLA ZERO interrompe questo automatismo. Davanti a un'informazione mancante, l'LLM Oracode-disciplinato non procede — si ferma e chiede. *"Devo chiamare un metodo di UserService per aggiornare il profilo. Prima di scrivere il codice, verifico quali metodi ha UserService."* O ancora: *"Sto per usare la costante MAX_RETRIES, ma non l'ho letta dal codice. Mi confermi che esiste, o devo cercarla?"*. La domanda sostituisce l'invenzione. La verifica sostituisce la deduzione. La sicurezza arrogante diventa cautela onesta.

REGOLA ZERO non è una P0 in mezzo ad altre — è il principio dal quale derivano molte P0 specifiche. Anti-method-invention (non inventare metodi), Anti-service-method-invention (non inventare metodi di service), Anti-enum-constant-invention (non inventare costanti enum), e altre P0 dominio-specifiche (per esempio Anti-blockchain-invention nei progetti che usano blockchain), sono tutte applicazioni di REGOLA ZERO a contesti specifici. Il principio è uno; le sue manifestazioni operative sono molte.

REGOLA ZERO ha conseguenze profonde sul modo di lavorare. Chi scrive con LLM rispettando REGOLA ZERO scrive più lentamente all'inizio — perde tempo a verificare cose che "potrebbe assumere". Ma il tempo perso in verifica è tempo guadagnato in debug evitato. La velocità di scrittura cala del trenta per cento. La velocità di consegna del codice funzionante sale del trecento per cento. È il paradosso operativo del paradigma: la disciplina sembra freno, è invece canale.

## 9. Sistema di priorità P0/P1/P2/P3

Una regola Oracode non è uguale a un'altra. Alcune sono bloccanti — violarle significa che il sistema si rompe, e quindi non si procede finché non sono rispettate. Altre sono importanti ma non bloccanti — violarle produce codice meno buono, ma il sistema continua a funzionare. Altre ancora sono best practice — andrebbero seguite, ma il loro mancato rispetto è materia di review, non di stop. Per non confondere questi livelli, Oracode adotta un sistema di priorità a quattro gradini, semplice e definitivo.

**P0 — BLOCCANTE.** *"Se violo questa regola, il sistema si rompe immediatamente."* Una violazione P0 ferma il lavoro. Non si procede, non si discute, si corregge. Le regole P0 sono poche — devono essere così critiche che la loro violazione compromette davvero qualcosa di sostanziale. Sono le linee rosse del paradigma. In un sistema Oracode che attiva l'infrastruttura di enforcement (livello due o superiore), le P0 sono enforced meccanicamente: OS3 Matrix (sezione 2 di questa macroarea) le implementa come hook che bloccano l'esecuzione quando la regola è violata.

**P1 — MUST.** *"Se violo questa regola, il codice non è production-ready."* Una violazione P1 non blocca lo sviluppo ma rende il codice non rilasciabile in produzione. Sono i principi fondamentali della qualità: i sei pilastri orientativi, la firma, la documentazione completa, la conformità GDPR dove serve. Si possono violare temporaneamente in fase di esplorazione, ma vanno rispettate prima del deploy.

**P2 — SHOULD.** *"Se violo questa regola, accumulo debito tecnico."* Una violazione P2 non blocca nulla e non impedisce il deploy — produce solo codice meno mantenibile. Sono best practice come il principio DRY, il rispetto stretto di SOLID, l'estrazione di pattern riutilizzabili. Vanno seguite quando si può, vanno riviste in refactoring quando si è violate.

**P3 — REFERENCE.** *"Informazione di contesto."* Sono pattern avanzati, esempi, case study, riferimenti culturali del paradigma. Non sono regole — sono background che arricchisce la comprensione e suggerisce direzioni di miglioramento, senza vincolare.

Il sistema P0-P3 risolve il problema della paralisi decisionale. Davanti a ogni scelta, chi scrive Oracode si chiede: *che priorità ha questa regola?* Se è P0, si rispetta sempre. Se è P1, si rispetta prima del deploy. Se è P2, si rispetta se il tempo lo permette. Se è P3, si tiene presente. Niente è "abbastanza importante" o "abbastanza secondario" — ogni regola ha la sua casella, e ogni casella ha il suo trattamento.

Una nota su come le P0 si comportano in pratica. Esistono tre modi in cui una P0 può manifestarsi quando si tenta di violarla: **BLOCK** (l'azione viene rifiutata, fine), **ASK** (il sistema chiede conferma all'umano: "sei sicuro di voler procedere?", l'umano decide), **WARN** (il sistema avvisa ma non blocca, lasciando traccia per audit successivo). I tre livelli corrispondono a gradi diversi di certezza che la regola valga in quel caso specifico. Una violazione di "non chiamare metodo che non esiste" è BLOCK — è sempre errore. Una scrittura su un file che fa parte di codice legacy è ASK — può essere errore o può essere migrazione voluta. Un nome di classe duplicato cross-organo è WARN — può essere intenzionale (alias volontario) o può essere svista. La granularità nel modo di enforcement è parte del paradigma — le implementazioni concrete dei gate vivono in OS3 Matrix (Macroarea quattro, sezioni 9-11).

## 10. Le tredici regole P0 universali

Le regole P0 di Oracode sono il cuore operativo del paradigma. Sono poche, precise, e sono state ricavate empiricamente: ognuna nasce da un errore concreto fatto in produzione, da un bug pagato in tempo perso, da una situazione in cui ci si è accorti che "questo non deve succedere mai più". Ogni regola P0 è cicatrice di qualcosa che è andato storto e che è stato codificato perché non vada storto di nuovo.

Le regole P0 elencate qui sono **universali**: si applicano a qualunque codice Oracode, indipendentemente dal dominio. Esistono anche P0 dominio-specifiche, codificate dalle singole istanze del paradigma (per esempio, un'applicazione che lavora con blockchain avrà P0 specifiche al suo dominio), ma quelle vivono nei boot context delle istanze, non qui.

**P0-1 — REGOLA ZERO.** Mai dedurre. Mai completare lacune. Se non sai, chiedi. È il principio fondamentale, dichiarato sopra. Si materializza operativamente nelle P0 che seguono.

**P0-2 — Translation keys only.** Mai testo hardcoded nel codice. Ogni stringa visibile all'utente passa attraverso un sistema di internazionalizzazione (chiavi di traduzione). Mai concatenazioni con interpolazione (`__('key', ['name' => $name])` è permesso solo dove la struttura della chiave lo richiede atomicamente). Questa regola sembra burocratica — fino al giorno in cui l'applicazione deve supportare una seconda lingua, e si scopre che metà del codice ha testo hardcoded sparso ovunque. Quel giorno il refactoring costa settimane. La regola P0-2 lo evita per default.

**P0-3 — Statistics Rule.** I parametri delle statistiche sono sempre espliciti, mai default nascosti. Nessun `->take(N)` implicito, nessuna aggregazione con parametri assunti. Se un calcolo dipende da una soglia, da un limite, da un campione — quel valore è dichiarato nel codice come parametro esplicito, non come default di un framework che chi legge potrebbe non conoscere. Le statistiche che producono numeri sbagliati perché un default nascosto ha troncato il dataset sono tra gli errori più insidiosi: i numeri escono, sembrano plausibili, e nessuno si accorge che sono falsi.

**P0-4 — Anti-Method-Invention.** Prima di chiamare un metodo, verifica che esista. Letteralmente: `grep` o lettura del file per confermare la presenza del metodo nella classe. È REGOLA ZERO applicata al singolo metodo. L'LLM tende a inventare metodi che "sembrano dover esistere" — questa regola lo blocca.

**P0-5 — UEM-First.** Gli errori non si gestiscono inline con `try/catch` improvvisati. Esiste un sistema centralizzato di gestione errori (vedi Macroarea quattro, sezione 6, famiglia Ultra) che riceve, classifica, logga, e risponde agli errori in modo strutturato. Ogni eccezione passa da lì. L'error handling non è dispersione di `try/catch` per il codebase — è funzione architetturale centralizzata.

**P0-6 — Anti-Service-Method-Invention.** Variante di P0-4 specifica ai service. Prima di chiamare un metodo su un service, verifica nel filesystem che il service esista e che abbia quel metodo con quella firma. Gli LLM hanno particolare propensione a inventare metodi di service che "sembrano dover esistere" — questa regola tiene il guardrail dove serve.

**P0-7 — Anti-Enum-Constant-Invention.** Variante di REGOLA ZERO applicata alle costanti enum. Prima di usare `MyEnum::SOMETHING`, verifica che `SOMETHING` esista come case dell'enum. Spesso gli LLM completano con valori plausibili (`UserStatus::ACTIVE`) quando l'enum vero ha valori diversi (`UserStatus::APPROVED`).

**P0-8 — Complete Flow Analysis.** Prima di modificare qualcosa di non triviale, mappa il flusso completo: entry point, processing, exit point, tipi di dati che passano, punti di possibile fallimento. Quattro fasi obbligatorie. Una modifica fatta senza aver capito il flusso che si tocca produce regressioni invisibili che si manifestano in produzione.

**P0-9 — Internazionalizzazione completa.** Se l'applicazione supporta più lingue, ogni nuova stringa deve essere disponibile in tutte le lingue supportate fin dal primo commit. Non si fa "lo faccio dopo per le altre lingue". Si fa adesso, per tutte. Il "dopo" non arriva mai, e il prodotto si trova in stato perennemente parziale.

**P0-10 — Anti-bypass del data layer.** L'accesso al database passa sempre attraverso il service factory del progetto, mai direttamente attraverso il driver del DB. Se esiste un `get_db_service()`, lo usi. Se esiste un repository pattern, ci passi. Mai `MongoDBService` direttamente, mai query raw quando esiste un'astrazione di accesso. Il data layer esiste per un motivo — bypassarlo produce codice che smette di funzionare quando il data layer evolve, e che nel frattempo aggira le protezioni che il data layer offre.

**P0-11 — DOC-SYNC obbligatorio.** Una task non è chiusa finché la documentazione SSOT non è aggiornata coerentemente con il codice modificato. Codice e documentazione viaggiano insieme. La documentazione "che si farà dopo" non esiste — esiste solo documentazione fatta adesso o documentazione mai fatta.

**P0-12 — Anti-Infrastructure-Invention.** REGOLA ZERO applicata all'infrastruttura. Prima di citare URL, path, branch, nomi di server, configurazioni di deploy, verifica dalla fonte (filesystem, configurazione cloud, sistema di gestione segreti). L'LLM tende a inventare nomi plausibili. In produzione, un URL inventato significa downtime.

**P0-13 — Test-First Discipline.** Ogni feature, fix e refactor produce o aggiorna i test corrispondenti. Una task non si chiude senza test verde. Una feature nuova nasce accompagnata da test che ne verificano comportamento atteso ed edge case. Un bug fixato deve essere accompagnato dal test che, prima del fix, falliva e dopo il fix passa — è il Pilastro Circolarità Virtuosa operazionalizzato. Un refactor deve lasciare il sistema con test verdi: se il refactor cambia comportamento, i test cambiano insieme al codice e l'intenzione del cambiamento è documentata. Questa regola completa il circolo: P0-8 (Complete Flow Analysis) identifica gli edge case, P0-13 li cattura nei test, Strategia Delta governa il rapporto col codice legacy (si aggiungono test solo quando si tocca il codice legacy per altra ragione).

Le P0 elencate qui sono il set canonico universale. Il set può evolvere — nuove P0 emergono dall'esperienza, vecchie P0 si rivelano coperte da altre e vengono assorbite. La versione corrente del set canonico è quella codificata in questo documento, allineata alla Nomenclatura LSO v2.0.0. In caso di divergenza tra questo documento e l'enforcement in produzione (gli hook di OS3 Matrix), il paradigma ha autorità: se un hook enforcea una regola diversa da quella dichiarata qui, è l'hook che va aggiornato, non la regola. Il paradigma prescrive, la Matrix enforcea — non il contrario.

## 11. Strategia Delta

Quando Oracode si introduce in un codebase, sorge subito una domanda: cosa si fa con il codice esistente, che è stato scritto prima del paradigma e che non rispetta le sue regole? Due risposte sbagliate sono comuni. Una è il refactoring totale: si riscrive tutto rispettando il paradigma. L'altra è la coesistenza incondizionata: si lascia tutto com'è e si applicano le regole solo al codice nuovo, senza criteri chiari di transizione.

Strategia Delta è la terza via, e dice questo:

**Codice nuovo: tutte le regole Oracode. Codice legacy: resta dove è, si tocca solo quando si tocca per altra ragione.**

Questa regola protegge da entrambi i rischi opposti. Dal rischio del refactoring nevrotico: rompere ciò che funziona per estetica del paradigma, sprecando settimane di lavoro per zero valore di business. E dal rischio del debito tecnico non gestito: lasciare il codice legacy peggiorare nel tempo senza piano di miglioramento.

Operativamente Strategia Delta significa due cose:

**Una.** Codice nuovo è scritto rispettando tutte le regole del paradigma. P0, P1, P2 dove ha senso, P3 quando il tempo lo permette. Nessuna scorciatoia "perché tanto è solo per ora". L'esperienza dimostra che "solo per ora" diventa "per sempre" nell'ottanta per cento dei casi.

**Due.** Codice legacy si modifica solo quando c'è una ragione operativa per modificarlo — un bug, una feature da aggiungere, un'evoluzione del contesto. In quel momento, la modifica include la migrazione della parte toccata verso il paradigma. Non si riscrive tutto il file — si modernizza la parte che si sta toccando, lasciando il resto al prossimo tocco. Il refactoring avviene per **occasione**, non per **principio**.

Strategia Delta è quella che permette a un codebase di migrare verso Oracode in modo organico, senza interruzioni di servizio e senza investimenti dedicati di refactoring puro. È coerente con il pilastro della Semplicità Potenziante: massima libertà di evoluzione, minimo costo immediato.

## 12. La firma Oracode

Ogni file scritto sotto Oracode porta una firma. La firma non è ornamento — è dichiarazione di paternità, di standard applicato, di data di scrittura. Serve a chi leggerà il file in futuro per sapere: chi l'ha scritto, sotto quale versione del paradigma, quando, con quale scopo.

La forma canonica della firma è descritta nei dettagli pratici (template per diversi linguaggi, varianti per progetti specifici) come strumento, nella Macroarea quattro sezione 8. Qui interessa il principio: la firma è dichiarazione di responsabilità autoriale, e si applica a ogni file nuovo, e a ogni file legacy quando viene toccato per la prima volta sotto Strategia Delta.

I campi essenziali della firma corrispondono a cinque domande che il futuro lettore si porrà:

- **@package** — *Dove sta questo file?* Identifica il modulo, il package, la posizione architetturale.
- **@author** — *Chi l'ha scritto, e sotto quale paradigma?* Combina l'identità dell'autore con la versione di Oracode applicata.
- **@version** — *In quale versione del prodotto è entrato questo file?*
- **@date** — *Quando è stato scritto?*
- **@purpose** — *Perché esiste?* È l'incarnazione del primo pilastro (Intenzionalità Esplicita) nella firma stessa.

La firma è P1: la sua assenza non blocca lo sviluppo, ma rende il file non production-ready.

---

# MACROAREA DUE — COME SI LAVORA CON ORACODE

Oracode non è solo principio di scrittura del codice — è anche disciplina di organizzazione del lavoro che produce il codice. Le regole P0 e i pilastri orientativi dicono "come si scrive". Le sezioni che seguono dicono "come si organizza il processo di scrittura". Senza questa seconda parte, le regole resterebbero sospese: applicate occasionalmente, ignorate quando comodo. La struttura del lavoro è ciò che rende le regole effettivamente operative.

Una nota importante prima di entrare nelle sezioni. Quello che si descrive qui sono **principi di lavoro** — i criteri secondo cui un sistema Oracode organizza il flusso di sviluppo, e appartengono a Oracode-paradigma (§1.1.A della Nomenclatura). Gli **strumenti concreti** che incarnano questi principi (il Mission Registry come file JSON, il sistema DOC-SYNC v2 come runtime autonomo, gli hook come script eseguibili) appartengono a OS3 Matrix e vivono nella Macroarea quattro, sezioni 9-11. Qui parliamo del *cosa* e del *perché*; lì del *come operativo*.

## 1. /project — la concezione di un nuovo progetto

Il primo livello dell'organizzazione del lavoro Oracode è `/project`. È il momento in cui un nuovo progetto Oracode viene concepito, prima ancora che la prima riga di codice sia scritta.

In `/project` succede tutto quello che precede l'apertura di una mission di sviluppo:

- Si capisce cosa il committente ha bisogno
- Si analizza il dominio applicativo
- Si decide se l'applicazione sarà singola, organismo mono-organo, o organismo multi-organo (vedi Macroarea tre per le forme architetturali)
- Si stabilisce l'architettura tecnica generale
- Si scelgono gli stack tecnologici e i vincoli
- Si decide quali parti del paradigma Oracode si applicheranno (livello uno sempre, livelli successivi se la complessità lo giustifica)
- Si definiscono le P0 dominio-specifiche, se il dominio le richiede
- Si selezionano gli strumenti specializzati dalla Macroarea quattro che saranno adottati (quali librerie Ultra, quale sistema di enforcement, quali knowledge base specializzate)
- Si crea il boot context iniziale dell'applicazione (i file di configurazione che gli LLM leggeranno all'inizio di ogni sessione)
- Si pianificano le prime mission di sviluppo

`/project` si chiude quando il boot context è pronto e la prima mission può aprirsi su basi solide. Solo a quel punto il codice comincia a essere scritto.

Una nota importante sulla diagnostica del dominio. Non tutti i progetti meritano lo stesso livello di applicazione del paradigma. Un'applicazione semplice e di breve durata può richiedere solo le regole P0 base. Un sistema enterprise destinato a vivere dieci anni richiede tutto il paradigma fino alla profondità massima. La diagnostica del dominio fatta in `/project` decide questa profondità, e la decisione è esplicita: si dichiara nel boot context "questa applicazione applica Oracode al livello X". Successive mission lavorano coerentemente con quel livello, senza essere costrette a complessità che non servono né a perdere disciplina dove serve.

## 2. /mission — l'unità di lavoro

Sotto `/project` vive `/mission`, l'unità discreta di lavoro Oracode. Ogni cambiamento al codice — sia esso una feature nuova, un bug fix, un refactor, una migrazione legacy — passa attraverso una mission.

Una mission ha caratteristiche definite:

- **È numerata.** Ogni mission ha un identificatore univoco (per esempio M-152, M-153) registrato in un Mission Registry centrale (lo strumento concreto è descritto nella Macroarea quattro, sezione 10). La numerazione è progressiva e immodificabile: una volta assegnato un numero, resta.
- **Ha scope dichiarato.** All'apertura, la mission dichiara cosa farà, su quali parti del codice agirà, e quali altri organi o moduli potrebbero essere impattati (cross-organo o no).
- **Ha fasi sequenziali.** Apertura, analisi requisiti, piano, esecuzione, chiusura. Ogni fase ha output che alimenta la successiva.
- **Ha report obbligatorio.** Alla chiusura, la mission produce documentazione di cosa è stato fatto, perché, e con quali esiti. Il report serve a chi rivedrà il lavoro mesi dopo per capire il contesto.
- **È integrata con DOC-SYNC.** Codice modificato e documentazione associata viaggiano insieme attraverso la mission, non separati.

Le mission sono il battito del lavoro Oracode. Niente si modifica fuori da una mission aperta. Questa regola, che sembra burocratica, è in realtà liberatoria: garantisce che ogni cambiamento abbia tracciabilità, contesto, scopo dichiarato.

## 3. Mission Protocol e Bootstrap

Il Mission Protocol formalizza le fasi della mission e definisce un meccanismo di bootstrap che orienta l'LLM all'inizio di ogni mission.

Il bootstrap è cruciale. Un LLM che apre una mission senza contesto è cieco. Un LLM che apre una mission con contesto pieno ma generico è confuso. Il Mission Protocol di Oracode prepara un contesto **calibrato sulla mission specifica**: legge il boot context globale dell'applicazione, lo arricchisce con i file rilevanti per la mission corrente, lo presenta all'LLM in forma strutturata.

Esiste un meccanismo di **bootstrap retrospective**: alla chiusura di ogni mission, il sistema osserva quali parti del contesto sono state effettivamente usate e quali no, e affina il bootstrap delle mission future. Le informazioni ridondanti si potano, le informazioni mancanti si aggiungono. Il Mission Protocol impara dal proprio uso.

L'implementazione concreta del Mission Protocol — gli script che gestiscono apertura, fasi, chiusura, l'agent semantico del bootstrap retrospective — sono componenti di OS3 Matrix e vivono nella Macroarea quattro, sezione 10.

## 4. DOC-SYNC come principio operativo

DOC-SYNC è il principio che mantiene allineate la documentazione (gli SSOT, Single Source of Truth) e il codice. Quando il codice cambia, la documentazione associata cambia con esso. Quando la documentazione cambia, il codice ne riflette la coerenza.

Esistono due modi in cui un sistema Oracode può implementare DOC-SYNC:

- **DOC-SYNC riflesso.** Il sistema osserva quando un file legato a un SSOT viene modificato e segnala automaticamente che la documentazione associata potrebbe aver bisogno di aggiornamento. È reattivo: rileva drift, non lo previene.
- **DOC-SYNC attivo.** Un agente semantico verifica la coerenza tra codice e documentazione, identifica drift, propone aggiornamenti. È proattivo: cerca incoerenze, non aspetta che emergano.

Entrambi i modi sono enforced da P0-11: una mission non si chiude finché DOC-SYNC non è stato eseguito e la documentazione è allineata. Questa regola sembra pesante — costa tempo. Ma il costo è basso comparato al costo di documentazione disallineata che si scopre mesi dopo: ci si trova a leggere documentazione che non descrive più il sistema, e si perde fiducia in tutta la documentazione del progetto.

Il principio DOC-SYNC descritto qui è Oracode-paradigma — dice *cosa* deve succedere. Il software DOC-SYNC v2 che lo implementa (drift detection autonoma, coverage check nativa, analisi semantica, re-indexing RAG) è OS3 Matrix, ed è descritto nella Macroarea quattro, sezione 10.

## 5. Trigger Matrix

Non tutte le modifiche al codice hanno lo stesso impatto. Alcune sono locali (un fix puntuale che non cambia il comportamento esterno). Altre sono architetturali (introducono nuovi service, cambiano contratti). Altre ancora sono contrattuali (toccano GDPR, normative, terms of service).

La Trigger Matrix di Oracode classifica ogni modifica in sei tipi, ciascuno con conseguenze diverse:

- **Tipo 1 — Locale.** Fix puntuale, output invariato. Nessun DOC-SYNC richiesto.
- **Tipo 2 — Comportamentale.** Cambia output, API, behavior visibile. DOC-SYNC obbligatorio sui documenti dell'organo.
- **Tipo 3 — Architetturale.** Nuovo endpoint, model, service, dipendenza. DOC-SYNC obbligatorio su organo e su boot context.
- **Tipo 4 — Contrattuale.** Tocca GDPR, normative, compliance, ToS. DOC-SYNC obbligatorio più **approvazione esplicita** del CEO prima della modifica.
- **Tipo 5 — Naming dominio.** Rinomina entità o concetti del dominio. DOC-SYNC esteso a tutti gli organi impattati con grep cross-organo.
- **Tipo 6 — Cross-project.** Impatta schemi condivisi o altri organi. DOC-SYNC più approvazione esplicita del CEO.

Davanti a ogni modifica, chi sviluppa si pone la domanda: *che tipo è?* La risposta orienta automaticamente la procedura. Niente è lasciato all'arbitrio del momento.

## 6. Enforcement via hook — il principio

Le regole Oracode non sono solo dichiarate — sono enforced meccanicamente attraverso un sistema di **hook**: gate che intercettano le azioni dell'LLM e le validano contro le regole. Se un'azione violerebbe una regola P0, l'hook blocca l'azione prima che venga eseguita.

Esistono due famiglie di hook:

- **PreToolUse hook.** Si attivano prima che un'azione dell'LLM venga eseguita. Possono bloccare (BLOCK), chiedere conferma (ASK), o avvisare e lasciar passare (WARN). Sono il sistema preventivo: impediscono che azioni potenzialmente sbagliate vadano in produzione.
- **PostToolUse hook.** Si attivano dopo che un'azione è stata eseguita. Non possono annullarla — possono solo registrarla, segnalarla, analizzarla. Sono il sistema osservativo: aggiungono tracciabilità e propongono correzioni successive.

Il design del sistema di enforcement segue un principio chiaro: **fail-closed dove serve, fail-open dove non serve**. Una violazione di una regola critica blocca l'azione (fail-closed). Una situazione ambigua chiede all'umano (ASK). Una situazione che è probabilmente intenzionale ma vale la pena registrare passa con warning (WARN).

L'ordine di esecuzione degli hook all'interno di una catena è materia di design dell'istanza specifica. Il paradigma non impone un'ordinazione canonica delle regole P0 — ogni progetto Oracode definisce nel proprio boot context quale precedenza ha senso per il proprio dominio.

Una distinzione importante: quanto descritto qui — il *principio* di enforcement meccanico, la classificazione BLOCK/ASK/WARN, il design fail-closed — è Oracode-paradigma. Dice *cosa* deve esistere. Gli hook concreti — i file `.sh` con la loro logica di check, la libreria di check riusabili, il meccanismo di catena, i gate validator pre-push — sono componenti di OS3 Matrix, descritti nella Macroarea quattro, sezione 9. È la stessa separazione che attraversa tutto il paradigma: il pensiero prescrive, lo strumento enforcea.

## 7. Modello operativo CEO/CTO

Oracode codifica esplicitamente il rapporto tra chi decide architetturalmente (CEO, in senso lato — può essere un Founder, un Product Owner, un Tech Lead con autorità decisionale) e chi esegue tecnicamente (CTO, in senso lato — può essere un'AI come Padmin, un team di sviluppatori, o entrambi).

Le decisioni di tipo costituzionale — definizione delle Interface stabili, scelta dei valori immutabili, applicazione di Strategia Delta a parti specifiche del codebase, refactoring di codice legacy — sono **prerogativa del CEO** e richiedono approvazione esplicita prima dell'esecuzione. Non sono delegabili.

Le decisioni di tipo esecutivo — implementazione di una feature secondo specifica, fix di un bug noto, rispetto delle regole P0 e dei pilastri — sono **prerogativa del CTO** che opera in autonomia all'interno del perimetro definito dalle decisioni costituzionali.

Questa divisione di responsabilità non è gerarchia formale — è separazione di ambiti. Il CEO non decide come si scrive una funzione: questo è ambito CTO. Il CTO non decide se introdurre un nuovo organo nell'organismo: questo è ambito CEO. La chiarezza dei perimetri evita micro-management dall'alto e iniziative non autorizzate dal basso.

## 8. Agenti specializzati come principio organizzativo

Un'istanza Oracode di medie o grandi dimensioni si avvale di **agenti specializzati**: sotto-istanze dell'LLM configurate per ambiti specifici. Ogni agente ha uno scope definito e copre un'area di expertise.

Esempi tipici di agenti in un sistema Oracode complesso:

- **Backend specialist**, per il linguaggio di backend principale (Laravel/PHP, Django/Python, Express/Node, eccetera).
- **Frontend specialist**, per i framework UI (React, Vue, Svelte).
- **AI/RAG specialist**, per i layer di intelligenza artificiale interni.
- **DOC-SYNC guardian**, dedicato al mantenimento della coerenza tra codice e documentazione.
- **Oracode specialist**, esperto del paradigma stesso, consulente per le decisioni architetturali — non scrive codice, solo consiglia.
- **Domain specialist**, per domini regolamentati specifici (finanza, sanità, legale).

Gli agenti sono delegabili: quando una mission tocca un ambito specifico, l'agente competente viene consultato o invocato per quella parte. Il coordinamento tra agenti è responsabilità dell'agente principale (l'LLM Supervisor che orchestra la mission), che decide quando delegare e a chi.

Il *principio* che un sistema Oracode usa agenti specializzati per gestire la complessità è Oracode-paradigma. I *file di configurazione* degli agenti (gli `.md` che li definiscono) e il software che li coordina sono componenti di OS3 Matrix, descritti nella Macroarea quattro, sezione 11.

L'esistenza di agenti specializzati è caratteristica del **livello due** dell'applicazione Oracode (vedi Macroarea tre): un sistema piccolo non ne ha bisogno, un sistema grande non può farne a meno.

---

# MACROAREA TRE — FORME ARCHITETTURALI

Oracode è paradigma. LSO è una forma architetturale che può emergere applicando Oracode. Sono cose distinte, e questa distinzione è importante.

Esistono quattro livelli di applicazione di Oracode, ciascuno con caratteristiche proprie e ciascuno applicabile a domini diversi. Le sezioni che seguono descrivono i quattro livelli, e dichiarano esplicitamente quando si applica cosa. Non tutti i progetti Oracode arrivano al livello quattro, e non devono arrivarci: la massima applicazione è esito dove il dominio la sostiene, non destino del paradigma.

## 1. I quattro livelli di applicazione

I livelli sono crescenti: ogni livello presuppone i precedenti e ne aggiunge proprietà. Un progetto Oracode dichiara in fase di `/project` a quale livello arriva, e tutta la sua organizzazione del lavoro è coerente con quella dichiarazione.

**Livello uno — Codice Oracode-disciplinato.** Applicazione singola che rispetta i pilastri orientativi, REGOLA ZERO, le regole P0 universali, la firma, Strategia Delta. Non ha sistema circolatorio attivo, non ha Mission Protocol formale, non ha hook di enforcement automatico. Il rispetto delle regole avviene per disciplina di chi scrive e per code review. È il livello minimo di Oracode, applicabile a qualunque software, anche al più semplice script.

**Livello due — Oracode in profondità.** Applicazione che, oltre al livello uno, attiva l'infrastruttura di enforcement. Le regole non sono più solo orientamento — sono enforced meccanicamente. Si attivano i principi organizzativi (Mission Protocol formale, DOC-SYNC) e il software che li implementa (OS3 Matrix: hook bloccanti, agenti specializzati, gate validator). Si applica quando il sistema ha complessità sufficiente da giustificare l'investimento nell'infrastruttura di enforcement, ma non ha ancora le caratteristiche viventi (no RAG interrogabile dall'utente finale, no AI come sistema nervoso, no memoria operativa che cresce con l'uso).

**Livello tre — LSO mono-organo.** Una singola applicazione che diventa Organismo Software Vivente: ha sistema circolatorio attivo, RAG interrogabile via Helping conversazionale, memoria operativa che cresce nell'uso, AI integrata come sistema nervoso interno. L'applicazione non è più solo strumento — è entità con metabolismo proprio. Si applica quando il dominio sostiene interazione continua, accumulo di esperienza nel tempo, e AI integrata d'uso quotidiano.

**Livello quattro — LSO multi-organo.** Più LSO interconnessi che mantengono ciascuno la propria vitalità individuale ma formano un sistema di livello superiore. Categorizzazione funzionale degli organi, infrastruttura condivisa, mente cross-organo, disaccoppiabilità degli organi. Si applica quando l'ecosistema necessita di una pluralità di applicazioni interconnesse che condividono identità ma mantengono autonomia.

I quattro livelli sono ortogonali alle dimensioni del progetto in linee di codice o numero di utenti. Un progetto da centomila righe di codice può essere livello uno (se è applicazione monolitica senza interazione AI). Un progetto da diecimila righe può essere livello tre (se è un'applicazione con RAG integrato e sistema circolatorio attivo). La discriminante è la natura del dominio, non la scala del codice.

**Nota di disambiguazione.** I quattro livelli di applicazione descritti qui non vanno confusi con i quattro livelli concettuali definiti nella Nomenclatura LSO v2.0.0 (Oracode / Libreria LSO / Organismo / FlorenceEGI). Quelli sono livelli *concettuali*: separano cosa Oracode *è* come entità. Questi sono livelli *applicativi*: descrivono a quale profondità Oracode viene *applicato* a un progetto. Le due tassonomie sono ortogonali e complementari: la prima risponde a "di che tipo di cosa stiamo parlando?", la seconda a "quanto in profondità è stato applicato il paradigma?".

## 2. Applicazione singola Oracode-disciplinata

A livello uno, un'applicazione Oracode è qualunque software costruito rispettando i pilastri e le regole P0 del paradigma, senza ancora infrastruttura di enforcement automatico. È il livello base, e copre la grande maggioranza dei progetti software ragionevoli.

Esempi tipici di applicazione livello uno:

- Uno script di analisi dati che fa una cosa specifica, scritto bene, manutenibile, documentato
- Un piccolo tool da riga di comando con il suo dominio limitato
- Un'applicazione web monolitica di media complessità che fa la sua funzione senza pretese di intelligenza accumulata
- Un microservizio interno che espone API e niente più

Le caratteristiche operative del livello uno:

- I sei pilastri sono applicati come orientamento dello stile di scrittura
- REGOLA ZERO è rispettata da chi scrive (umano o LLM) per disciplina interna
- Le regole P0 sono enforced da code review umana, non da hook automatici
- La firma è presente in ogni file
- La documentazione è curata ma può vivere senza DOC-SYNC formale
- Le mission, se esistono, sono leggere — task tracker generico, non Mission Protocol formale

Una nota importante: il livello uno **non è inferiore** ai livelli più alti. È **adeguato al dominio** di applicazioni che non hanno bisogno di più. Forzare un'applicazione semplice al livello tre o quattro produrrebbe burocrazia senza valore. Strategia Delta opera anche su questa scelta: il livello applicato è quello che il dominio sostiene, niente di più, niente di meno.

## 3. Oracode in profondità

A livello due, l'applicazione attiva l'infrastruttura di enforcement automatico. Le regole Oracode non vivono più solo nel pensiero di chi scrive — vivono nel filesystem del progetto come hook attivi che bloccano o segnalano violazioni in tempo reale.

L'infrastruttura attivata al livello due include due strati distinti:

- **Principi organizzativi** (Oracode-paradigma): Mission Protocol formale con numerazione, registry, bootstrap, retrospective, report obbligatori. DOC-SYNC come principio operativo, riflesso o attivo secondo il livello di maturità dell'infrastruttura.
- **Software di enforcement** (OS3 Matrix): hook bloccanti PreToolUse e PostToolUse che enforcano le regole P0 meccanicamente. Agenti specializzati dove la complessità del progetto lo giustifica. Gate validator pre-push. Infrastruttura SSOT con watches e copertura.

Il livello due è investimento iniziale significativo — costa tempo configurare l'infrastruttura — ma si ripaga rapidamente nei progetti che hanno complessità sufficiente. La soglia tipica oltre la quale il livello due conviene è una dimensione del codebase tale per cui due o più sviluppatori (umani o LLM) lavorano in parallelo, e dove la deriva di un singolo errore può compromettere settimane di lavoro.

Le caratteristiche distintive del livello due, rispetto al livello uno:

- Le violazioni delle P0 sono intercettate dagli hook prima che entrino nel codebase
- Le mission seguono il protocollo formale con bootstrap, fasi, report
- La documentazione è mantenuta allineata al codice automaticamente
- Agenti specializzati gestiscono ambiti specifici riducendo la cognitive load dell'agente principale

Il livello due **non implica** che l'applicazione sia un LSO. Un'applicazione livello due è ancora "strumento", anche se strumento molto disciplinato. Diventa LSO solo se passa al livello tre.

## 4. LSO mono-organo

Al livello tre, l'applicazione cessa di essere strumento e diventa **organismo**. Un Organismo Software Vivente — LSO — è un software che non si limita a funzionare oggi: ha metabolismo proprio. Accumula esperienza dall'uso, mantiene memoria operativa che cresce nel tempo, integra l'intelligenza artificiale non come strumento esterno ma come sistema nervoso interno, e si auto-documenta in modo che chi ci entra dopo trova il sistema già pronto a spiegarsi.

Le caratteristiche distintive di un LSO mono-organo:

**Sistema circolatorio attivo.** L'applicazione ha un flusso continuo di interazioni che alimentano la sua memoria. Ogni uso non è transitorio — lascia traccia nel sistema in forma di esperienza accumulata. Questa memoria diventa risorsa per gli usi successivi.

**RAG interrogabile via Helping.** L'utente può conversare con il sistema in linguaggio naturale, e il sistema risponde non solo da regole codificate ma da conoscenza accumulata nei propri SSOT. Helping non è chatbot — è interfaccia conversazionale alla mente dell'organismo.

**AI come sistema nervoso interno.** L'AI non è feature dell'applicazione — è componente strutturale. Tocca decisioni operative, contesti di errore, generazione di documentazione, supporto agli utenti. È pervasiva, non addizionale.

**Memoria operativa che cresce nell'uso.** Il sistema non si rigenera identico ogni mattina. Conserva quello che ha imparato, e quello che ha imparato modula come si comporta in futuro. È evoluzione continua, non snapshot statico.

Un LSO mono-organo si applica quando il dominio sostiene queste proprietà. Domini tipici:

- Sistemi gestionali per organizzazioni con processi continui (gestione clienti, processi documentali, ticketing)
- Piattaforme che accumulano esperienza dall'uso (sistemi di raccomandazione, learning platform)
- Applicazioni con AI conversazionale come componente centrale (assistenti dominio-specifici)

Domini che **non** sostengono livello tre:

- Siti web statici o quasi-statici (brochure aziendali, landing page)
- Applicazioni transazionali pure (e-commerce semplice, form di contatto)
- Tool da riga di comando o batch processing
- API stateless senza dominio di accumulazione

Forzare un LSO mono-organo su un dominio che non lo sostiene produce sovra-ingegnerizzazione. Il sistema circolatorio gira a vuoto perché non c'è esperienza da accumulare, il RAG è praticamente inutilizzato perché non c'è conoscenza dominio-specifica che evolve, l'AI integrata è feature di marketing senza valore d'uso reale. Per quei domini, livello uno o due sono adeguati.

## 5. LSO multi-organo

Al livello quattro, più LSO mono-organo si interconnettono mantenendo ciascuno la propria vitalità individuale. Il risultato è un Organismo di livello superiore — multi-organo — con proprietà che emergono dall'interazione tra organi.

Le caratteristiche distintive di un LSO multi-organo:

**Organi indipendenti.** Ogni organo è esso stesso un LSO. Ha le sue mission, il suo Mission Registry, il suo DOC-SYNC, il suo CLAUDE.md di boot context, la sua memoria operativa, il suo RAG. Può continuare a vivere autonomamente se scollegato dall'organismo. Questa disaccoppiabilità è proprietà non negoziabile.

**Interfacce stabili come articolazioni.** Gli organi comunicano attraverso interfacce contrattuali — API, schemi di eventi, contratti di payment, protocolli di autenticazione. Le interfacce sono come **articolazioni**, non come collanti: cambiano lentamente, sono stabili nel tempo, permettono ai singoli organi di evolvere senza che il resto del sistema crolli.

**Mente cross-organo.** Sopra ai RAG dei singoli organi può vivere un layer di intelligenza che attraversa l'intero organismo. Un utente che chiede qualcosa attraverso un organo riceve risposta che attinge alla conoscenza di tutti gli organi. La mente cross-organo non si sostituisce ai sistemi nervosi dei singoli organi — li orchestra.

**Infrastruttura condivisa esplicitata.** Quando più organi condividono risorse (database, sistemi di autenticazione, layer di pagamento), la condivisione è dichiarata esplicitamente nel boot context globale dell'organismo. Chi modifica una risorsa condivisa sa di toccare tutti gli organi che la usano.

**Mente di governo dell'organismo.** Il sistema gestisce la coerenza tra organi attraverso meccanismi di governance esplicita — naming conventions cross-organo, organ index, hook che impediscono violazioni cross-progetto, modello operativo CEO/CTO che approva decisioni che toccano più organi.

Un LSO multi-organo si applica quando il dominio richiede una pluralità di applicazioni che condividono identità ma mantengono autonomia. Esempi:

- Ecosistemi di prodotti con identità di marca unitaria ma funzioni distinte
- Suite di tool aziendali interconnessi che attraversano dipartimenti diversi
- Piattaforme di servizi che condividono utenti, pagamenti, autenticazione, ma offrono funzionalità diverse
- Sistemi enterprise con sotto-applicazioni dipartimentali coordinate

Il salto dal livello tre al livello quattro non è incrementale — è qualitativo. Comporta decisioni architetturali, organizzative, commerciali che non si fanno in corso d'opera. Si decide in fase di `/project` se l'applicazione sarà un LSO mono-organo che resterà tale, oppure se sarà nucleo di un futuro LSO multi-organo. La differenza orienta tutte le scelte successive.

## 6. Esempi e casi reali

*Questa sezione conterrà casi reali documentati di applicazione Oracode ai vari livelli. Va popolata progressivamente man mano che casi adeguatamente disaccoppiati e con consenso degli interessati saranno disponibili. Esempi candidati:*

- *Caso A: applicazione livello uno.* Sito web per azienda di oreficeria — sviluppato in circa sedici ore di lavoro effettivo, Lighthouse 91-100 su tutte le dimensioni, log git verificabile. Esempio di applicazione semplice ben fatta con Oracode al livello base.

- *Caso B: ecosistema livello quattro.* Sistema multi-organo per dominio crypto-arte-blockchain con dieci progetti enterprise interconnessi, oltre un milione di righe di codice, stack tecnologici multipli. Esempio di applicazione completa del paradigma fino al livello massimo.

- *Caso C: applicazione livello tre.* Da identificare e documentare quando applicabile.

I casi reali sono materiale prezioso perché dimostrano operativamente che il paradigma funziona. La verità è funzione operativa anche per il paradigma stesso: Oracode è vero nella misura in cui i casi reali che lo applicano funzionano.

## 7. Disaccoppiamento tra Oracode e LSO

C'è una questione che vale la pena affrontare esplicitamente, perché chi conosce un'istanza specifica di Oracode potrebbe portare con sé un'aspettativa errata.

Tra Oracode e LSO non esiste un rapporto di implicazione. Oracode non produce necessariamente LSO, e un LSO non è la dimostrazione che Oracode è stato applicato. Sono due cose distinte: Oracode è paradigma di sviluppo (livello 1.1 della Nomenclatura), LSO è forma architetturale (livello 1.3). Si scelgono separatamente, sulla base di criteri diversi.

Osservativamente, però, quando il dominio applicativo sostiene interazione continua, accumulo di esperienza nel tempo e intelligenza artificiale integrata d'uso quotidiano, applicare Oracode al massimo grado tende a far emergere spontaneamente caratteristiche da Organismo: il codice comincia ad auto-osservarsi, il sistema mantiene memoria operativa che cresce con l'uso, le interfacce diventano stabili come articolazioni più che come API, l'AI smette di essere strumento e diventa sistema nervoso. Non è regola — è gravità. Dove il dominio lo permette, la forma LSO è esito naturale ma non necessario dell'applicazione piena del paradigma.

E va detto, perché è anche più onesto. LSO è la forma che è emersa applicando Oracode al dominio specifico in cui il paradigma è maturato. È una forma — non l'unica possibile. Oracode è strumento, e gli strumenti spesso vanno a finire in posti che chi li ha forgiati non aveva immaginato. C'è da aspettarsi, prima o poi, qualche geniaccio maledetto di quelli che viaggiano tra la trama e l'ordito dei vari repo a giro per il mondo, che trovi nel paradigma applicazioni che oggi non sono state pensate. A me va bene così. Anzi: il disaccoppiamento esplicito tra Oracode e LSO serve esattamente a questo, a tenere aperto lo spazio per quel tipo di scoperte. Il paradigma deve poter respirare oltre la stanza in cui è nato.

---

# MACROAREA QUATTRO — STRUMENTI SPECIALIZZATI DI ORACODE

## 1. Cosa è uno strumento Oracode

Le prime tre macroaree descrivono Oracode come paradigma: cosa è, come si lavora, quali forme può prendere. Sono **pensiero**. Si applicano leggendole, internalizzandole, lasciandosene orientare nelle decisioni di tutti i giorni.

Quello che segue è diverso. Sono **strumenti** — corpus, librerie, knowledge base, sistemi software riusabili — che il paradigma produce o adotta. Non si applicano leggendoli: si installano, si invocano, si configurano. Vivono nel filesystem dei progetti, non nel pensiero di chi scrive.

La distinzione è importante per tre ragioni.

La prima è di onestà strutturale. Confondere paradigma e strumenti produce documenti ibridi in cui regole e implementazioni si mescolano, e dove il lettore non capisce più cosa è principio inviolabile e cosa è scelta tecnica del momento. Tenerli separati permette al paradigma di restare stabile mentre gli strumenti evolvono.

La seconda è di scalabilità dell'ecosistema. Gli strumenti possono essere prodotti da molti — chi ha creato Oracode, chi lo adotta nelle proprie aziende, chi vuole contribuire dall'esterno. Il paradigma è uno solo. Gli strumenti possono essere molti.

La terza — introdotta dalla Nomenclatura v2.0.0 — è di classificazione. Non tutti gli strumenti servono lo stesso scopo. Esistono due famiglie distinte:

- **Strumenti del paradigma** — librerie infrastrutturali (Ultra), knowledge base, template. Arricchiscono il corpo del paradigma, incarnano i suoi pattern, sono mattoni da costruzione. Se li togli, il paradigma resta concettualmente integro ma le istanze devono reinventare le soluzioni.
- **Componenti di OS3 Matrix** — hook bloccanti, gate validator, agenti specializzati come software, DOC-SYNC v2 runtime, infrastruttura SSOT. Sono l'enforcement automatico delle regole del paradigma al piano OS3. Se li togli, il paradigma resta valido ma perde la capacità di far rispettare le proprie regole meccanicamente.

Le sezioni 6-8 di questa macroarea descrivono strumenti del paradigma. Le sezioni 9-11 descrivono componenti di OS3 Matrix. Le sezioni 1-5 si applicano a entrambe le famiglie.

Da questa distinzione nasce anche il vincolo costituzionale di ammissione: per essere considerato **strumento Oracode**, uno strumento deve essere stato costruito **applicando Oracode**. Non basta che serva sviluppatori Oracode. Lo strumento stesso deve incarnare il paradigma nella propria genesi. Una libreria scritta rispettando i sei pilastri, REGOLA ZERO, le P0, il Mission Protocol, con firma e documentazione SSOT — qualifica. Una libreria scritta senza disciplina che dichiara genericamente di essere "compatibile con Oracode" — non qualifica.

Questa è la regola che permette al paradigma di mantenere la propria identità man mano che cresce.

## 2. La penisola

L'insieme degli strumenti specializzati di Oracode forma quella che chiamo **la penisola**: un'estensione che si protende dal continente del paradigma core, e che può ricevere apporti da chiunque rispetti il vincolo costituzionale di ammissione.

La metafora geografica non è ornamento. Dice cose precise.

Una penisola **resta connessa** al continente. Gli strumenti della penisola non vivono indipendentemente — si nutrono delle regole del paradigma, le incarnano, le presuppongono. Senza il continente, la penisola non avrebbe senso.

Una penisola **si protende verso il mare aperto**. È lo spazio dove l'ecosistema cresce. Da quel mare possono arrivare contributi che il continente da solo non avrebbe mai immaginato. Sviluppatori da paesi diversi, da domini diversi, da culture tecniche diverse — tutti possono attraccare nella penisola portando strumenti, purché quegli strumenti rispettino il vincolo costituzionale.

Una penisola **ha confini riconoscibili**. Si sa dove finisce il continente e comincia la penisola. Si sa cosa è acqua e cosa è terra. Confondere la penisola con il continente sarebbe errore — gli strumenti non sono il paradigma, sono espressioni del paradigma. Confondere il mare aperto con la penisola sarebbe altro errore — non tutto quello che è disponibile sul mercato qualifica come "strumento Oracode", solo quello che ha attraccato secondo le regole.

La penisola accoglie due tipi di strumenti:

**Strumenti core.** Quelli costruiti come parte storica del paradigma stesso, garantiti dall'autore principale del paradigma. Appartengono a questa categoria sia gli strumenti del paradigma (le librerie Ultra, le knowledge base, i template) sia i componenti di OS3 Matrix (hook, gate, agenti, DOC-SYNC v2 runtime). La dualità paradigma/Matrix vive *dentro* la penisola, non la spezza.

**Strumenti di terze parti.** Quelli prodotti da sviluppatori esterni al gruppo di lavoro originale, che hanno costruito strumenti Oracode-disciplinati e li hanno candidati alla penisola. Sono valutati attraverso un processo di ammissione (sezione 4) e, se ammessi, entrano nel catalogo come strumenti certificati di terze parti.

I due tipi vivono nella stessa penisola ma con etichette diverse. Un cliente che adotta uno strumento core sa che ha la garanzia dell'autore del paradigma. Un cliente che adotta uno strumento di terze parti sa che ha la garanzia che lo strumento è Oracode-disciplinato, ma non la garanzia che sia mantenuto dall'autore del paradigma. Sono garanzie diverse per cose diverse.

## 3. Pattern di costruzione di uno strumento Oracode

Indipendentemente da chi lo costruisce e dal dominio che copre, uno strumento Oracode deve rispettare i seguenti criteri costitutivi. Sono quelli che ne autorizzano l'ammissione alla penisola.

**Costruzione sotto disciplina del paradigma.** Lo strumento è stato sviluppato applicando le regole P0 universali, i sei pilastri, REGOLA ZERO. Le tracce di questa disciplina sono verificabili nel repository: firma Oracode in ogni file, documentazione SSOT, mission registry presente, hook configurati se il livello dello strumento li richiede.

**Base empirica documentata.** Lo strumento dichiara onestamente su quale base empirica si fonda. Se è una libreria, dichiara su quali progetti è stata testata in produzione. Se è una knowledge base, dichiara su quanti casi è basata e quali sono i gap di copertura noti. Se è un componente di enforcement (hook, gate), dichiara quante violazioni ha intercettato e su quali regole opera. Niente verità universale senza ancoraggio a casi concreti.

**Prescrittività e verificabilità.** Le regole, le funzioni, le interfacce che lo strumento espone sono prescrittive (dicono cosa fare, non solo cosa osservare) e verificabili (esiste un modo per controllare se sono state rispettate). Uno strumento Oracode non offre suggerimenti vaghi — offre regole con criteri di check. Per un componente di enforcement, la verificabilità è intrinseca: o blocca o non blocca.

**Antipattern come divieti codificati.** Lo strumento dichiara esplicitamente cosa non si fa, oltre a cosa si fa. Gli antipattern sono parte integrante del corpus, non note a margine. Hanno priorità (P0, P1, P2) come le regole positive.

**Onestà sui limiti.** Lo strumento dichiara cosa non copre, dove ha gap, quali sono le limitazioni metodologiche. Niente strumento si presenta come totale. La trasparenza sui limiti è parte della disciplina.

**Versionamento esplicito.** Lo strumento ha versione esplicita, changelog, e indicazione di quale versione del paradigma core è compatibile. Quando il core evolve, lo strumento si aggiorna o si segnala come "compatibile con versione X del core".

**Pubblicazione del codice sorgente.** Almeno della parte di codice che incarna la disciplina Oracode. Senza accesso al codice, l'ammissione alla penisola non è verificabile.

Uno strumento che rispetta questi sette criteri è candidato all'ammissione. Uno strumento che ne manca anche uno solo non è ancora pronto. Il rispetto dei criteri è il filtro che protegge l'integrità della penisola.

## 4. Processo di ammissione e certificazione

L'ammissione di uno strumento alla penisola è atto formale. Comprende quattro passaggi.

**Auto-dichiarazione.** L'autore dello strumento dichiara pubblicamente la candidatura, presentando il repository, la documentazione SSOT, la base empirica, la dichiarazione di rispetto dei sette criteri costitutivi.

**Audit di disciplina.** Un audit (manuale o supportato da strumenti automatici) verifica che lo strumento rispetti effettivamente i criteri dichiarati. L'audit guarda il codice — non si fida della dichiarazione — e verifica firma, mission registry, presenza di antipattern codificati, qualità della base empirica.

**Verifica funzionale.** Lo strumento viene provato in un caso reale. Se è una libreria, viene importata in un progetto di test. Se è una knowledge base, viene applicata in un audit reale. La verifica funzionale conferma che lo strumento fa quello che dichiara di fare.

**Certificazione.** Se i tre passaggi precedenti hanno esito positivo, lo strumento viene aggiunto al catalogo della penisola con la sua etichetta (core o terze parti), la sua versione, la versione del paradigma core con cui è compatibile, e la data di certificazione.

Il processo è ripetibile a ogni release maggiore dello strumento. Una nuova versione di uno strumento non eredita automaticamente la certificazione della versione precedente — deve essere ricertificata se i cambiamenti sono significativi.

I dettagli operativi del processo (chi può fare audit, in quale forma si presenta una candidatura, dove vive il catalogo) sono materia di governance, e saranno codificati man mano che l'ecosistema cresce. Per ora il principio è quello dichiarato: l'ammissione non è automatica, ed è ciò che dà valore alla certificazione.

## 5. Catalogo e governance

La penisola ha un **catalogo pubblico** degli strumenti certificati. Il catalogo è esso stesso strumento di governance — la sua esistenza, la sua manutenzione e la sua accessibilità sono parte del paradigma.

Il catalogo include, per ogni strumento:

- Nome canonico e descrizione in una riga
- Autore e affiliazione
- Tipo (core o terze parti) e famiglia (paradigma o OS3 Matrix)
- Versione corrente e data di certificazione
- Versione del paradigma core con cui è compatibile
- Link al repository pubblico
- Link alla documentazione

La governance del catalogo segue tre principi.

**Trasparenza.** Tutte le decisioni di ammissione e di revoca sono pubbliche e motivate. Niente è "approvato a porte chiuse".

**Stabilità delle decisioni.** Uno strumento certificato resta certificato finché non emergono violazioni gravi del paradigma o finché l'autore non lo ritira. Le decisioni non si rivedono per opportunità del momento.

**Apertura della discussione.** Discussioni sul catalogo, sulle ammissioni, sulle revoche avvengono in spazi pubblici (issue tracker del paradigma, forum, mailing list). Niente è materia di canali privati.

La forma operativa concreta del catalogo (sito web, file markdown nel repository del paradigma, registry JSON, eccetera) sarà decisa quando il numero di strumenti certificati lo giustificherà. Nelle prime fasi, il catalogo può essere una pagina semplice; con la crescita dell'ecosistema, evolverà in struttura più articolata.

## 6. Strumenti del paradigma — la famiglia Ultra

La famiglia **Ultra** è il primo gruppo di strumenti del paradigma: librerie infrastrutturali obbligatorie che ogni progetto Oracode di livello due o superiore adotta come fondamenta. Ultra è di Oracode, non di una singola istanza: i nomi, la struttura, i contratti di interfaccia sono parte del paradigma stesso. Ciascuna libreria risolve un problema architetturale ricorrente in modo Oracode-disciplinato.

**Ultra Error Manager (UEM).** Sistema centralizzato di gestione errori. Riceve eccezioni da tutto il codebase, le classifica per gravità, le logga in modo strutturato, e produce risposte appropriate al chiamante. È la libreria che incarna P0-5 (UEM-First). Senza UEM, l'error handling diventa dispersione di `try/catch` ad-hoc; con UEM, è funzione architetturale unitaria.

**Ultra Log Manager (ULM).** Sistema centralizzato di logging strutturato. Produce log JSON-parseable, con livelli di severità, contesto, identificativi di mission e correlation ID. È la libreria che permette l'audit retrospettivo del sistema e l'analisi automatica dei log da parte di agenti specializzati.

**Ultra Translation Manager (UTM).** Sistema centralizzato di internazionalizzazione. Gestisce chiavi di traduzione, fallback, contestualizzazione. È la libreria che rende sostenibile P0-9 (internazionalizzazione completa) — senza UTM, supportare sei lingue significa gestire manualmente migliaia di chiavi sparse.

**Ultra Config Manager (UCM).** Sistema centralizzato di configurazione. Gestisce variabili d'ambiente, configurazioni per ambiente (dev, staging, prod), accessi a segreti, validazione di config alla startup. È la libreria che impedisce a un progetto di scoprire in produzione che una variabile di configurazione era mancante o malformata.

**Ultra User Manager (UUM).** Sistema centralizzato di autenticazione e autorizzazione. Gestisce ruoli, permessi, scope, audit trail di accesso. È la libreria che rende coerente la gestione utenti attraverso tutti gli organi di un LSO multi-organo.

Le librerie Ultra esistono in implementazioni specifiche per gli stack di riferimento (PHP/Laravel, Python/FastAPI, JavaScript/TypeScript). Una nuova istanza Oracode che adotta uno stack diverso ha due strade: portare le librerie Ultra al proprio stack (e candidarle alla penisola come implementazione del nuovo stack), oppure ricostruire equivalenti funzionali rispettando i contratti di interfaccia. Il paradigma non impone uno stack — impone i contratti che le librerie Ultra rispettano.

## 7. Strumenti del paradigma — knowledge base specializzate

Le knowledge base specializzate sono un tipo particolare di strumento del paradigma: non sono codice eseguibile, ma corpus di principi prescrittivi-verificabili applicati a un dominio di sapere specifico. Sono **disciplina codificata** in forma di documento.

Il pattern è quello descritto nella sezione 3 di questa macroarea: triade fondante del dominio, principi prescrittivi con criteri di verificabilità, priorità P0/P1/P2 assegnate, antipattern come divieti, base empirica documentata onestamente, procedura di audit con scoring.

**Oracode-WD — Knowledge base di web design.** Primo caso di knowledge base specializzata della penisola. Codifica principi di web design in forma prescrittiva-verificabile, applicabili da progetti Oracode che producono interfacce web. La triade fondante di Oracode-WD è Bellezza + Coerenza con il soggetto + Efficienza funzionale. La base empirica è di 12 siti analizzati in profondità. Versione corrente in evoluzione, con principi consolidati in P0/P1/P2 e procedura di audit operativa.

Oracode-WD è esempio applicativo importante per due ragioni. La prima: dimostra che la grammatica di Oracode (priorità, prescrittività, antipattern, audit) si trasferisce a domini non strettamente di sviluppo software. Il web design è dominio diverso da PHP o Python, eppure le stesse categorie strutturali funzionano. La seconda: indica una direzione di crescita della penisola. Altre knowledge base specializzate sono candidate naturali: knowledge base SEO Oracode-disciplinata, knowledge base di sicurezza informatica, knowledge base di valutazione finanziaria di codebase, knowledge base di conformità normativa. Ognuna applicherà la grammatica del paradigma al proprio dominio, e ognuna sarà strumento riusabile per progetti Oracode che ne abbiano bisogno.

## 8. Strumenti del paradigma — template e boilerplate

I **template** sono modelli pronti che accelerano l'apertura di nuovi progetti Oracode o di nuove sezioni di lavoro.

### 8.1 Template architetturali di boot context (operativi dal 25 maggio 2026)

La separazione tra Oracode-paradigma e OS3 Matrix (sezione 2 di questa Macroarea) si materializza in tre template distinti che mappano direttamente sul confine repo MIT/commerciale:

**`CLAUDE_ORACODE_CORE.md`** — Boot context del paradigma puro (MIT). Contiene: triade OSZ/OS3/OS4, REGOLA ZERO, 13 regole P0 come istruzioni operative, 6+1 pilastri, Strategia Delta, Trigger Matrix, Layer Stack L0-L11, checklist pre-risposta, soglie Git Safety, protocollo epistemologico. È autosufficiente per il livello 1 di applicazione: un LLM che legge solo questo file produce codice disciplinato senza bisogno di enforcement software. Sede: `/oracode/templates/CLAUDE_ORACODE_CORE.md`.

**`CLAUDE_OS3_MATRIX_TEMPLATE.md`** — Template di enforcement (commerciale). Contiene placeholder per: hook bloccanti, gate validator, agenti specializzati, DOC-SYNC v2 runtime, Mission Registry enforcement, Organ Index. Richiede `CLAUDE_ORACODE_CORE.md` caricato. Da compilare con i componenti di enforcement specifici del progetto. Sede: `/oracode/templates/CLAUDE_OS3_MATRIX_TEMPLATE.md`.

**`CLAUDE_PROJECT_TEMPLATE.md`** — Template di istanza progetto. Contiene placeholder per: CEO/CTO, stack tecnologico, organi, lingue target, P0 dominio-specifiche, sistema circolatorio, stack bannati, valori immutabili, deploy, firma, pattern output. Da compilare con i dati specifici del dominio. Sede: `/oracode/templates/CLAUDE_PROJECT_TEMPLATE.md`.

Come si compongono:

```
Livello 1 (disciplina):  @CLAUDE_ORACODE_CORE.md + sezione progetto compilata
Livello 2+ (enforcement): @CLAUDE_ORACODE_CORE.md + @CLAUDE_OS3_MATRIX.md + sezione progetto compilata
```

### 8.2 Altre famiglie di template

**Template di firma Oracode.** Le forme canoniche della firma per i diversi linguaggi di programmazione (PHP, TypeScript, Python, Rust, Go, eccetera). Ogni nuovo file inizia da un template di firma, che chi sviluppa adatta ai campi specifici del file.

**Template di mission.** Modelli per i diversi tipi di mission (feature, bug fix, refactor, migrazione legacy, audit). Ogni nuovo mission report parte da un template strutturato, che evita di dimenticare sezioni importanti.

**Template di documentazione SSOT.** Modelli per i diversi tipi di documento SSOT (specifica di organo, descrizione di service, documentazione di endpoint API, eccetera). Un nuovo documento SSOT parte da un template, che garantisce coerenza strutturale attraverso tutto il progetto.

### 8.3 Template come propagazione di disciplina

I template non sono solo risparmio di tempo — sono **propagazione di disciplina**. Un template ben fatto incorpora le scelte giuste, e chi lo usa eredita quelle scelte senza doverle ridefinire. È il pilastro Evoluzione Ricorsiva applicato alla scrittura: ogni progetto che usa i template aggiunge esperienza che migliora i template per i progetti successivi.

## 9. Componenti di OS3 Matrix — enforcement via hook, gate e organ index

I componenti che seguono (sezioni 9-11) non sono strumenti opzionali che arricchiscono il paradigma: sono **OS3 Matrix** — il software che fa rispettare le regole del paradigma al piano OS3, dove l'AI produce a velocità non verificabile dall'umano (sezione 2 della Macroarea uno). Sono *strumenti* nel senso che si installano e si configurano, ma il loro scopo è distinto dagli strumenti del paradigma: le librerie Ultra offrono mattoni da costruzione, OS3 Matrix offre guardrail.

**Libreria hook.** Una collezione di script eseguibili (PreToolUse, PostToolUse, PreUserPromptSubmit) che intercettano le azioni dell'LLM e le validano contro le regole. Ogni hook è file dedicato a una verifica specifica: `check-method-exists.sh` per P0-4, `check-service-method-exists.sh` per P0-6, `mica-guard.sh` per regole dominio-specifiche su normative crypto, eccetera. La libreria è estensibile — nuovi hook si aggiungono per nuove regole.

**Gate validator.** Validatori che operano a un livello diverso dagli hook: non intercettano singole azioni AI, ma verificano la coerenza di un'intera unità di lavoro prima che venga pubblicata. Il gate pre-push (OS3 Gate) verifica che il codice rispetti le regole prima del push: emette PASS, WARN, o BLOCK. Il gate CI/CD Lighthouse verifica punteggi di performance e accessibilità. Il gate coverage test verifica che i test esistano e siano verdi. I gate estendono l'enforcement a un livello superiore a quello dei singoli hook.

**Organ Index.** Strumento di indicizzazione cross-organo dei nomi pubblici (classi, service, funzioni esportate). Si interroga prima di creare una nuova classe o service per verificare che il nome non sia già usato altrove nell'ecosistema con significato diverso. Senza Organ Index, evitare collisioni di nomi richiederebbe memoria umana; con Organ Index, è verifica automatica.

**Sistema di catena hook.** Il meccanismo che decide quali hook si attivano per quale azione dell'LLM, in quale ordine, con quale livello di severità (BLOCK, ASK, WARN). Il sistema legge una configurazione di catena specifica del progetto e applica gli hook in sequenza. Al primo BLOCK, l'azione viene rifiutata e gli hook successivi non vengono valutati.

L'implementazione di riferimento di questi componenti è in script bash più moduli Python, gira sui sistemi operativi POSIX, ed è integrata con l'IDE che il progetto Oracode usa (tipicamente VSCode con Claude Code o equivalente). Implementazioni per altri ambienti sono possibili — un team che lavora con un IDE diverso può portare il sistema mantenendo i contratti di interfaccia degli hook.

## 10. Componenti di OS3 Matrix — gestione operativa

I protocolli di lavoro descritti nella Macroarea due (sezioni 2-4) sono principi del paradigma. I componenti che seguono sono il software che li rende operativi meccanicamente.

**Mission Registry.** Strumento di gestione del ciclo di vita delle mission. Contiene il file `MISSION_REGISTRY.json` (o equivalente per stack diversi) che traccia tutte le mission aperte e chiuse del progetto, con i loro metadati: numero, titolo, scope, data di apertura, fasi attraversate, data di chiusura, report tecnico, organi coinvolti. È la fonte di verità sullo stato del lavoro.

**Mission Engine dual-tracking.** Dal bootstrap di OS3 Matrix (M-OS3-001, 25 maggio 2026) il Mission Registry vive in due fonti dati distinte. La prima è la **state machine non-aggirabile** della CLI `bin/mission`, ospitata in HOME utente (`~/.oracode/missions/<ID>/state.json`), condivisa fra tutti i progetti Oracode della macchina; tiene firma crittografica della catena di transizioni, spawn fingerprint reali degli agenti, contatori di edit per audit interim, eventuale flag di sospensione. La seconda è il **Mission Registry del progetto applicativo**, versionato col repo (`<progetto-DOC>/docs/missions/MISSION_REGISTRY.json`), che traccia scope dichiarato, trigger matrix, SSOT impattati, P0 di dominio, esito test, blocco `doc_sync` prodotto da DOC-SYNC v2 alla chiusura. La separazione corrisponde a una distinzione concettuale netta: la state machine è infrastruttura di disciplina (universale, parte di OS3 Matrix), il Mission Registry del progetto è SSOT documentale (specifico al dominio, parte dell'organo). Oggi la sincronizzazione fra le due fonti è esplicita e manuale: ogni transizione di `bin/mission` aggiorna solo `state.json`, e l'operatore riflette la stessa transizione nel registry del progetto con un Edit dedicato. È un debito tecnico riconosciuto (drift osservato in sessione 2 Poli, finding S2-1) la cui chiusura naturale è una futura mission OS3 Matrix che insegni a `bin/mission` a leggere un descrittore `.oracode/project.json` del progetto attivo e propagare la transizione anche al Mission Registry del progetto.

**Mission Protocol enforcement.** Il software che enforcea le fasi obbligatorie del Mission Protocol: counter con prenotazione anti-collisione (nessun numero assegnato due volte), enforcement delle fasi sequenziali (FASE 0 → FASE 6), commit+push immediato del registry a ogni fase critica, blocco della chiusura senza report tecnico.

**Mission Bootstrap.** Script che, all'apertura di una nuova mission, costruisce il contesto calibrato per l'LLM: legge il boot context globale, identifica i file rilevanti per la mission specifica, applica il bootstrap retrospective (cosa è stato usato nelle mission precedenti simili), produce un prompt di apertura strutturato.

**DOC-SYNC v2 runtime.** Il software che implementa il principio DOC-SYNC (Macroarea due, sezione 4). Include: drift detection autonoma via cron periodico, coverage check nativa (verifica che gli SSOT coprano effettivamente la struttura reale del codebase), analisi semantica del diff a chiusura mission per identificare SSOT impattati (diretti e laterali), re-indexing RAG sincrono con sanity check bloccante, audit trail completo. DOC-SYNC v2 non è il *principio* — è il *software* che lo rende operativo senza dipendere dalla disciplina dell'operatore.

**Mission Report Guard.** Hook che blocca il push di mission completate senza report tecnico. È il componente che rende operativa la regola "una mission non si chiude senza report".

## 11. Componenti di OS3 Matrix — agenti specializzati e infrastruttura SSOT

**Agenti specializzati come software.** I file di configurazione (tipicamente `.md`) che definiscono gli agenti specializzati del sistema. Ogni agente ha scope, strumenti disponibili, vincoli operativi, e comportamento codificato. Esempi di agenti core: `doc-sync-v2` (sincronizzazione SSOT autonoma), `os3-audit-specialist` (audit di conformità Oracode), `os3-gate` (validazione pre-push), `oracode-alignment-interpreter` (diagnostica di allineamento semantico), `organ-gap-scout` (identificazione gap evolutivi), `ssot-living-agent` (verifica autonoma dello stato degli SSOT). Il *principio* che servono agenti specializzati è Oracode-paradigma (Macroarea due, sezione 8). Il *software* che li implementa è OS3 Matrix.

**Infrastruttura SSOT (L0 Mielina).** Il sistema che rende tracciabile e verificabile il rapporto tra documentazione e codice. Include: `SSOT_REGISTRY.json` come mappa esplicita (documenti SSOT → file codebase che documentano), watches di copertura con segnalazione automatica di perdita, cron settimanale che verifica la copertura della documentazione rispetto alla struttura reale del codice. L'infrastruttura SSOT è il tessuto connettivo che tiene insieme il principio DOC-SYNC e la sua implementazione: senza di essa, il software DOC-SYNC v2 non saprebbe quali file osservare.

## 12. Contributi di terze parti alla penisola

Le sezioni 6-11 hanno descritto strumenti core della penisola — quelli costruiti come parte storica del paradigma. Esiste anche, per costituzione, lo spazio per strumenti di terze parti: prodotti da sviluppatori esterni al gruppo di lavoro originale, che hanno costruito strumenti Oracode-disciplinati e li hanno candidati all'ammissione.

Al momento della stesura di questo documento, gli strumenti di terze parti certificati nella penisola sono pochi o nessuno. Il paradigma è in fase di consolidamento e la penisola è ancora popolata principalmente dai suoi strumenti fondativi. Ma la costituzione della penisola prevede esplicitamente l'espansione attraverso contributi esterni, e con il tempo questa sezione diventerà la più articolata della macroarea.

I tipi di contributo che la penisola potrà accogliere in futuro includono:

**Strumenti del paradigma di terze parti:**

- **Implementazioni delle librerie Ultra per nuovi stack.** Chi adotta Oracode su un linguaggio o framework non ancora coperto può portare UEM, ULM, UTM, UCM, UUM al proprio stack e candidare l'implementazione.
- **Knowledge base specializzate.** Nuovi corpus di principi prescrittivi-verificabili per domini non ancora coperti — SEO, sicurezza, accessibilità avanzata, sostenibilità ambientale del software, ergonomia conversazionale.
- **Template di progetto per tipologie verticali.** Boot context, mission template, struttura iniziale di SSOT per tipologie specifiche di applicazione (e-commerce, gestionali aziendali, sistemi sanitari, piattaforme educative).

**Componenti OS3 Matrix di terze parti:**

- **Hook specializzati per nuovi domini.** Chi applica Oracode in domini con regole dominio-specifiche (per esempio sanità, finanza, transportation) può sviluppare hook che enforcano regole di quel dominio, e candidarli come componenti riusabili da altri progetti dello stesso dominio.
- **Agenti specializzati pubblicabili.** Configurazioni di agenti LLM calibrati per ambiti specifici (per esempio agenti per compliance GDPR, per audit di sicurezza, per traduzione legale), pubblicabili come pacchetti riusabili.
- **Gate validator di dominio.** Gate che verificano conformità a standard specifici di settore (HIPAA, PCI-DSS, ISO 27001), integrabili nella catena di enforcement esistente.

Ogni contributo passa attraverso il processo di ammissione descritto nella sezione 4. La penisola cresce per riconoscimento di disciplina, non per declamazione di intenti.

---

# CHIUSURA — Stato del documento

Questo documento è draft di lavoro, versione 2.1. La versione 2.1 incorpora la creazione dei template architetturali di boot context (25 maggio 2026) che materializzano la separazione paradigma/Matrix in file operativi. Le modifiche principali rispetto alla versione 2.0:

- Introduzione della triade OSZ / OS3 / OS4 nella Macroarea uno (sezione 1)
- Nuova sezione 2 della Macroarea uno: articolazione interna paradigma / OS3 Matrix con giustificazione filosofica (asimmetrie di velocità e degradazione)
- Set canonico delle tredici P0 universali completato: aggiunte P0-3 (Statistics Rule) e P0-10 (Anti-bypass data layer), ridefinita P0-13 (da Organ Index check a Test-First Discipline)
- Inversione di autorità corretta: il paradigma è autoritativo sugli hook, non il contrario
- Distinzione principio / implementazione esplicitata nella Macroarea due (sezioni 4, 6, 8) e nella Macroarea tre (sezione 3)
- Nota di disambiguazione tra i quattro livelli di applicazione (Macroarea tre) e i quattro livelli concettuali (Nomenclatura LSO)
- Macroarea quattro ristrutturata: sezioni 6-8 = strumenti del paradigma, sezioni 9-11 = componenti OS3 Matrix, con nuova sezione 11 (agenti e infrastruttura SSOT)

Modifiche v2.1 (25 maggio 2026):

- Sezione 8 della Macroarea quattro: aggiunta sottosezione 8.1 con i tre template architetturali di boot context (`CLAUDE_ORACODE_CORE.md`, `CLAUDE_OS3_MATRIX_TEMPLATE.md`, `CLAUDE_PROJECT_TEMPLATE.md`) che materializzano la separazione paradigma/Matrix sul confine repo MIT/commerciale

La struttura in quattro macroaree riflette la maturazione del paradigma attraverso il lavoro di sviluppo iniziale. Le sezioni 1-6 della Macroarea uno sono state scritte con cura e rappresentano la forma stabilizzata. Le altre sezioni sono prime stesure: contengono il pensiero giusto e la struttura corretta, ma necessitano della revisione dell'autore per assumere la voce piena e per eliminare eventuali residui di formulazione che non corrispondono al suo modo di scrivere.

Cose aperte da risolvere nelle revisioni successive:

- Il path canonico dei documenti foundation di Oracode nel filesystem dell'istanza di riferimento.
- La "Regola del Quadro di Riferimento Canonico" emersa in conversazione — va decisa se cristallizzarla e dove.
- I casi reali della sezione 6 della Macroarea tre vanno popolati progressivamente con materiali concreti.
- Le sezioni 4 e 5 della Macroarea quattro (processo di ammissione e governance del catalogo) richiedono codifica operativa man mano che la penisola accoglie strumenti reali.
- Il SEO Oracode-disciplinato come knowledge base candidata alla Macroarea quattro sezione 7 — da sviluppare dopo Oracode-WD.
- Conflitto di naming UUM: questo documento definisce UUM come Ultra User Manager (autenticazione e autorizzazione); la Nomenclatura v2.0.0 definisce UUM come Ultra Upload Manager. Uno dei due necessita di un acronimo distinto. Da risolvere nella prossima revisione congiunta.

Il documento si aggiorna iterativamente con la disciplina dichiarata: l'autore scrive e rivede, Padmin Watchdog corregge grammatica, segnala incongruenze tecniche, suggerisce contenuti mancanti, fa domande operative. Non sostituisce voce.

---

*ORACODE PARADIGM — Draft v2.0 — 22 maggio 2026*
*Documento in costruzione, non pubblico.*
