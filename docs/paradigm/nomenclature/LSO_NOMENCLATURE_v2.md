---
visibility: public
rag: public
---

# LSO Nomenclature v2.1.0

> **Status:** Working Draft — bozza concettuale, non SSOT operativo
> **Autore:** Padmin D. Curtis con Fabio Cherici + Padmin Watchdog 22/5/2026 + Padmin Supervisor 22/5/2026
> **Data:** 2026-05-22
> **Aggiornamento:** 2026-05-22 — Decisione commerciale MIT/OS3 Matrix (§1.1.B, §4.1, §4.4)
> **Sede prevista:** `/docs/lso/`
> **Scopo:** separare formalmente i livelli concettuali oggi sovrapposti sotto il nome unico "LSO"
> **Vincolo di coerenza:** le definizioni devono reggere sia dentro FlorenceEGI sia in un eventuale futuro spin-off di Oracode applicato ad altri domini
> **Direzione evolutiva:** questo documento nasce come strumento interno, ma è progettato per maturare in narrativa esterna man mano che FlorenceEGI cresce, nuovi progetti si aggiungono, e gli SSOT si raffinano. Il bozzolo è interno, la farfalla sarà esterna.

---

## 0. Perché questo documento esiste

Fino al 4 maggio 2026, il termine "LSO" è stato usato per indicare contemporaneamente quattro cose diverse:

1. Un **paradigma di sviluppo** AI-human (Oracode evoluto)
2. Una **libreria di componenti tecnologici riusabili** prodotti applicando Oracode in contesti reali (NPE Council, AI Sidebar, e altri)
3. Una **metafora architetturale** che descrive un ecosistema di progetti come organismo vivente
4. La **specifica istanza FlorenceEGI** delle precedenti

Questa sovrapposizione non ha creato problemi finché esisteva una sola istanza (FlorenceEGI). È diventata un ostacolo nel momento in cui si pensa di:

- vendere software custom costruito con il paradigma a clienti esterni (cornice "Magicsoft 2.0")
- spiegare a investitori cosa è effettivamente la proprietà intellettuale trasferibile
- consentire a future istanze di Padmin (e a eventuali collaboratori) di parlare di queste cose senza ambiguità
- separare le offerte commerciali distinte che derivano da ciò che oggi vive sotto un nome unico

Questo documento separa i quattro livelli, li nomina, ne fissa i rapporti, e ne deriva alcune conseguenze pratiche immediate.

Non è una decisione di rebranding. È una distinzione concettuale. I nomi proposti possono cambiare; le distinzioni che proteggono non possono.

---

## 1. I quattro livelli — definizioni operative

**Una nota sul termine "LSO" prima di iniziare.** Quando si avvia un progetto applicando Oracode, si crea un'**istanza LSO** (Living Software Organism). LSO è il termine tecnico che indica *il prodotto vivente di Oracode applicato a un dominio*. Un LSO può essere mono-organo (singola applicazione) o multi-organo (più applicazioni interconnesse, ciascuna costruita con Oracode); la distinzione è proprietà dell'istanza, non del termine. Il termine "LSO" attraversa quindi i livelli definiti sotto: il livello 1.3 (Organismo) è la metafora architetturale di un LSO multi-organo; il livello 1.4 (FlorenceEGI) è una specifica istanza concreta di LSO multi-organo; il livello 1.2 (Libreria LSO) è chiamato così perché è la collezione di componenti tecnologici estratti da LSO concreti che hanno raggiunto maturità trasferibile.

Le quattro definizioni che seguono distinguono i livelli concettuali; il termine "LSO" è il nome operativo che lega questi livelli all'esperienza concreta di costruire e far vivere un sistema costruito con Oracode.

**Asse concettuale vs asse operativo — Oracode Nexus.** Questi quattro livelli sono l'asse **concettuale** del paradigma (stratificazione metodologica: cosa si costruisce). Sono ortogonali alla gerarchia **operativa** di deployment a **3 livelli** di **Oracode Nexus** (L1 GLOBALE = motore + paradigma in `~/oracode-engine`; L2 HUB = softwarehouse acquirente; L3 ISTANZA = singolo progetto), definita in `ORACODE_NEXUS_3_TIER.md`. "Oracode Nexus" designa il **sistema completo**: paradigma + i 3 livelli operativi + l'ecosistema HUB/istanze. I due assi non si contraddicono: il livello concettuale "Libreria LSO / Organismo" descrive *cosa* si costruisce, i 3 livelli operativi descrivono *dove* vive lo stato.

### 1.1 Oracode

**Posizionamento storico.** Le grandi epoche del software hanno avuto i loro paradigmi: OOP per l'era della complessità del dominio, SOLID per l'era della manutenibilità di lungo periodo. L'era dell'AI introduce un problema strutturalmente nuovo — l'AI non è strumento, è co-autore. **Oracode è la prima risposta strutturata e codificata a questo problema**, declinata in regole bloccanti, infrastrutture obbligatorie, e architetture evolutive verificabili.

I paradigmi della famiglia non si sostituiscono — si stratificano. Un'applicazione Oracode usa OOP per strutturare il proprio codice e applica SOLID alle proprie classi. Ma sopra OOP/SOLID opera una cornice nuova che gestisce l'AI come co-autore costitutivo: Mission Protocol, DOC-SYNC, RAG interno che cresce con l'uso, regole anti-deduzione enforcate meccanicamente da OS3 Matrix (§1.1.B), sistema circolatorio mono-organo, layer evolutivi che descrivono come l'organismo si auto-osserva e si riproduce. Quello che OOP ha fatto per il decennio del dominio e SOLID per il decennio della manutenibilità, Oracode si propone di farlo per l'era dell'AI: codificare con disciplina ciò che oggi è praticato senza codifica.

**Definizione operativa.** Oracode è il paradigma di sviluppo AI-human che impone disciplina epistemica e infrastruttura documentale a qualsiasi sistema software costruito con esso. È metodologia, non prodotto. È *il modo in cui si costruisce*, non *ciò che si costruisce*.

**Articolazione interna.** Dal 21 maggio 2026, Oracode si articola formalmente in due piani interni:

- **Oracode-paradigma (§1.1.A)** — il pensiero puro: regole epistemiche, pilastri, triade OSZ/OS3/OS4, pattern architetturali (Mission Protocol, DOC-SYNC, RAG, Helping), standard (SEO, A11y, GDPR), disciplina documentale, Strategia Delta, layer stack L0-L11. Tutto ciò che è trasferibile a qualsiasi dominio come metodologia.

- **OS3 Matrix (§1.1.B)** — lo strumento di enforcement: il software che fa rispettare le regole del paradigma al piano OS3, dove l'AI opera come co-autore a velocità non verificabile dall'umano in tempo reale. Hook bloccanti, gate validator, agenti specializzati, DOC-SYNC v2 come software runtime, drift detection, SSOT registry, Mission Protocol enforcement automatico.

Questa separazione non cambia cosa Oracode è. Cambia come lo si descrive: il paradigma prescrive, la Matrix enforcea. Senza il paradigma, la Matrix non ha regole da far rispettare. Senza la Matrix, le regole restano indicazioni interpretabili — fragili sotto la pressione di un LLM che produce a 100x la velocità dell'umano.

#### 1.1.A Oracode-paradigma

**Composizione.** Oracode-paradigma include:

- **Regole epistemiche** — REGOLA ZERO (mai dedurre, solo chiedere), 13 regole P0, anti-evasion patterns
- **Sistema circolatorio mono-organo** — Mission Protocol (track record decisionale), DOC-SYNC (allineamento codice ↔ documentazione), RAG interno (memoria operativa che cresce con l'uso), Sistema di Helping conversazionale (pattern: ogni applicazione Oracode deve esporre il proprio RAG via interfaccia conversazionale)
- **Protocolli di handoff** — mission registry, handoff AI-to-AI documentati, partner memory tra istanze AI
- **Disciplina documentale** — CLAUDE.md gerarchici, naming conventions, immutable values, manifesti
- **Disciplina di codice obbligatoria** — librerie infrastrutturali per gestione errori, log, traduzioni, configurazione, upload
- **Standard SEO + Accessibility** per contenuto pubblico
- **Infrastruttura GDPR strutturata** come strato di prima classe
- **Layer Stack L0-L11** — stratificazione architetturale dell'organismo (vedi §3.1.A.15)

Il sistema circolatorio mono-organo è la proprietà che rende *vivente* qualsiasi applicazione costruita con Oracode: ogni esperienza che l'applicazione fa viene catturata (Mission Protocol), strutturata (DOC-SYNC) e resa riusabile (RAG). La crescita non è autopoietica ma è reale: ogni nuovo obiettivo viene affrontato con una base di conoscenza accumulata superiore alla volta precedente.

**Distinzione pattern / implementazione.**
Oracode definisce *pattern* (Mission Protocol, DOC-SYNC, RAG, AI Helping conversazionale). Questi pattern sono concettuali e universali — descrivono *cosa* deve esistere in ogni sistema Oracode.

La Libreria LSO contiene *implementazioni concrete* di alcuni di questi pattern, sviluppate dentro applicazioni reali e maturate al punto di essere riusabili. Una nuova applicazione Oracode può scegliere di:

- implementare i pattern Oracode da zero (legittimo, ma costoso)
- usare le implementazioni della Libreria LSO (efficiente, raccomandato)
- mischiare le due strategie a seconda delle esigenze

Il pattern resta in 1.1.A anche quando l'implementazione vive in 1.2. Sono due cose distinte e devono restarlo.

Questa distinzione si estende anche all'enforcement: il *pattern* di enforcement meccanico (ogni P0 ha un hook associato, ogni standard ha un gate) è Oracode-paradigma (§1.1.A). L'*implementazione esecutiva* di quell'enforcement (gli script `.sh`, gli agent `.md`, i cron job) è OS3 Matrix (§1.1.B).

**Test di coerenza (vincolo spin-off).** Tutto ciò che è in Oracode-paradigma deve poter essere applicato a un dominio completamente diverso da FlorenceEGI senza modifiche concettuali. Mission Protocol funziona identico in un sistema di Project Management per un'azienda manifatturiera (es. Forti Camicie) come in una piattaforma di asset digitali. DOC-SYNC funziona identico in un'app di fitness e in un ERP. RAG interno è agnostico al dominio per costruzione. Se un elemento di "Oracode" non passa questo test, non appartiene a Oracode — appartiene a un livello inferiore (Libreria LSO o applicazione specifica). OS3 Matrix passa il test: l'enforcement meccanico è universale, le implementazioni concrete degli hook cambiano da dominio a dominio.

#### 1.1.B OS3 Matrix (OSMx)

**Definizione operativa.** OS3 Matrix è l'insieme dei componenti software che fanno rispettare le regole di Oracode-paradigma al piano OS3, dove l'AI opera come co-autore a velocità non verificabile dall'umano in tempo reale. Alias breve: OSMx. Entrambi i nomi sono validi.

Non è un livello concettuale (quelli restano quattro: Oracode, Libreria LSO, Organismo, FlorenceEGI). È uno strumento esecutivo che serve il piano OS3 della triade OSZ → OS3 → OS4.

**Giustificazione filosofica — l'asimmetria umano/LLM.**

L'enforcement automatico non è burocrazia. È risposta strutturale a un problema che non esisteva prima dell'era AI.

*Asimmetria di velocità.* Un LLM produce codice, documentazione, decisioni architetturali a una velocità che rende impossibile la revisione umana in tempo reale. In un'ora di lavoro, un LLM può generare 50 file, 10 migration, 200 edit. L'umano non può leggere 200 edit in tempo reale e verificare che ciascuno rispetti REGOLA ZERO, P0-2, P0-5, DOC-SYNC, naming convention. Servono gate che lo facciano meccanicamente.

*Asimmetria di degradazione.* Un LLM non "impara" dalle correzioni precedenti nella stessa sessione in modo affidabile. Può violare una regola P0 al minuto 45 anche se è stato corretto per la stessa violazione al minuto 12. La degradazione non è errore — è proprietà strutturale della generazione statistica. L'umano, corretto una volta, raramente ripete lo stesso errore nello stesso contesto. Servono gate che non "correggano" ma impediscano — hook fail-closed, non istruzioni interpretabili.

Queste due asimmetrie — velocità e degradazione — sono il fondamento di OS3 Matrix.

**Composizione.** OS3 Matrix comprende (dettaglio componenti in §3.1.B):

- **Hook bloccanti** (PreToolUse/PostToolUse) — gate fail-closed che intercettano l'azione AI prima o dopo l'esecuzione. Ogni hook enforcea una o più regole P0.
- **Agenti specializzati** — software autonomo che opera su scope specifici dell'organismo (doc-sync-v2, os3-audit-specialist, os3-gate, ssot-living-agent, oracode-alignment-interpreter, organ-gap-scout, egili-blood-keeper).
- **DOC-SYNC v2 come software runtime** — drift detection autonoma via nightly cron, coverage check nativa, analisi semantica del diff a chiusura mission, re-indexing RAG sincrono con sanity check bloccante, audit trail completo. Non il *pattern* DOC-SYNC (che resta in §1.1.A) ma il *software* che lo implementa.
- **Gate validator** — OS3 Gate pre-push (PASS/WARN/BLOCK), gate CI/CD Lighthouse, gate coverage test.
- **Infrastruttura SSOT (L0 Mielina)** — SSOT_REGISTRY.json come mappa esplicita doc SSOT → file codebase, watches di copertura con segnalazione automatica di perdita.
- **Mission Protocol enforcement automatico** — counter prenotazione anti-collisione, enforcement fasi obbligatorie (FASE 0 → FASE 6), registry JSON come SSOT con commit+push immediato.

**Rapporto con Oracode-paradigma.**

```
Oracode-paradigma (§1.1.A)     OS3 Matrix (§1.1.B)
───────────────────────        ─────────────────────────
Definisce regole P0            Implementa hook che le enforcano
Prescrive DOC-SYNC             Esegue drift detection runtime
Disegna Mission Protocol       Enforcea fasi e counter
Impone standard SEO/A11y       Esegue gate Lighthouse bloccante
Stabilisce naming              Verifica naming via agent
```

OS3 Matrix serve il piano OS3 della triade. Non lo sostituisce, non lo estende, non lo modifica. Se una regola del paradigma cambia, OS3 Matrix si aggiorna per riflettere il cambio. Se OS3 Matrix si rompe, le regole restano valide — perdono solo l'enforcement automatico.

**Perché non esiste OS4 Matrix né OSZ Matrix.**

- **OS4** (Educazione) opera sull'umano a velocità umana, con giudizio. Non servono gate meccanici — servono pattern pedagogici (onboarding, manifesti, formazione). Enforcement automatico su OS4 sarebbe paternalismo.
- **OSZ** (Kernel) è costituzionale e immutabile. I principi kernel non si "enforcano a runtime" — si *sono*. Un kernel che ha bisogno di un tool per far rispettare sé stesso non è un kernel, è una policy.
- L'enforcement automatico serve solo dove c'è un agente che produce a velocità incontrollabile con degradazione possibile — l'LLM, che vive nel piano OS3.

Esiste solo OS3 Matrix.

**Test di coerenza.** Un componente appartiene a OS3 Matrix se e solo se:

1. È **software eseguibile** — non regola, non pattern, non standard
2. Opera sul **piano OS3** — interazione AI-Human in esecuzione
3. Il suo scopo primario è **far rispettare** una regola/pattern/vincolo di Oracode-paradigma
4. Se rimosso, Oracode-paradigma resta concettualmente integro ma perde enforcement automatico su uno o più punti

**Posizionamento commerciale.** La separazione tra Oracode-paradigma (§1.1.A) e OS3 Matrix (§1.1.B) ha conseguenza diretta sul modello commerciale del progetto. Decisione strategica del 22 maggio 2026:

- **Oracode-paradigma è MIT-licensed, pubblico e gratuito.** Va distribuito al pari di OOP e SOLID, come cornice di sviluppo AI-native a disposizione dell'intero ecosistema. La sua diffusione è valore in sé per Florence EGI S.R.L., non costo: un paradigma accettato genera adozione, mercato di consulenza, prestigio dell'autore originario. Chi adotta Oracode può scegliere liberamente il proprio modello LLM (purché soddisfi i requisiti minimi documentati nella roadmap di disaccoppiamento, §4.4.1) e la propria implementazione di enforcement.

- **OS3 Matrix è prodotto commerciale di Florence EGI S.R.L.** Non è il paradigma, è lo strumento che lo fa rispettare a un LLM in produzione. Il valore commerciale è alto: è l'infrastruttura che separa "un team che dice di seguire Oracode" da "un team che lo segue verificatamente sotto enforcement automatico". Modello di pricing, tier, condizioni di licenza sono definiti in mission commerciale dedicata, fuori dallo scope di questo documento di nomenclatura.

Questa distinzione protegge il paradigma dalla deriva proprietaria — un Oracode chiuso non potrebbe diventare paradigma accettato — e protegge Florence EGI S.R.L. dalla deriva di regalare ciò che ha valore commerciale alto. È applicazione del pattern open-core nominato in §4.4 al caso specifico Oracode/OS3 Matrix.

---

### 1.2 Libreria LSO

**Definizione operativa.** La Libreria LSO è la collezione di componenti tecnologici riusabili sviluppati applicando Oracode in contesti reali, e che hanno raggiunto una maturità sufficiente per essere estratti dal contesto di origine e integrati come pacchetti in altri progetti. Sono *prodotti tecnologici* trasferibili tra applicazioni, distinti sia dal paradigma (che è metodologia) sia dalla singola applicazione (che è dominio).

I componenti della Libreria LSO sono **componibili tra loro**: combinazioni diverse producono offerte commerciali diverse. Esempio: il pattern di certificazione blockchain combinato con il pattern di Helping conversazionale produce un'offerta diversa da ciascuno dei due singolarmente.

**Test di coerenza (vincolo spin-off).** Ogni componente della Libreria LSO deve poter essere installato in un progetto completamente estraneo a FlorenceEGI con un costo di adattamento ragionevole (configurazione, non riscrittura). Se un componente richiede riscrittura sostanziale per uscire da FlorenceEGI, non è ancora maturo abbastanza per essere in Libreria LSO — appartiene a 3.3 (FlorenceEGI-specifico) finché non matura.

---

### 1.3 L'Organismo

**Definizione operativa.** L'Organismo è la metafora architetturale che descrive un ecosistema composto da più applicazioni ("organi") interconnesse, ciascuna costruita con Oracode (e quindi viva individualmente), che insieme formano un sistema di livello superiore con proprietà emergenti. È una *lente concettuale*, non un prodotto né un paradigma — descrive come si comportano e si relazionano sistemi multi-applicazione.

**Composizione.** Un Organismo è caratterizzato da:

- **Più organi indipendenti** — ciascuno con il proprio Mission Protocol, DOC-SYNC, RAG, CLAUDE.md e capacità di sopravvivenza autonoma
- **Disaccoppiabilità preservata** — ogni organo deve poter essere rimosso dall'organismo senza perdere la propria vitalità individuale (proprietà rara nei sistemi multi-modulo, conseguenza diretta del fatto che ogni organo è costruito con Oracode)
- **Eventuale sistema circolatorio multi-organo** — un flusso orizzontale che attraversa tutti gli organi e li lega a livello di stakeholder esterni. Dominio-specifico, non imposto da Oracode, non deve compromettere la disaccoppiabilità degli organi
- **Possibili sistemi nervosi condivisi** — convenzioni, regole, identità trasversali (es. CLAUDE_ECOSYSTEM_CORE.md condiviso)

**Test di coerenza (vincolo spin-off).** La metafora dell'Organismo deve essere applicabile a qualsiasi ecosistema multi-applicazione costruito con Oracode, indipendentemente dal dominio. Un'azienda che sviluppa con Oracode tre prodotti software interconnessi (un CRM, un ERP, una piattaforma di analytics) può essere descritta come Organismo nello stesso modo in cui FlorenceEGI lo è. Se la metafora funziona solo per FlorenceEGI, non è una metafora architetturale — è una descrizione di FlorenceEGI travestita.

---

### 1.4 FlorenceEGI

**Definizione operativa.** FlorenceEGI è l'istanza concreta e storicamente prima di un Organismo costruito con Oracode. È contemporaneamente:

- un **prodotto verticale** (asset platform per artisti digitali, con funzionalità di vendita, prenotazione, certificazione, Egili economy)
- un **laboratorio** dove vengono sviluppate le tecnologie che poi passano alla Libreria LSO (NPE Council, AI Sidebar, pattern di certificazione blockchain, e futuri componenti)
- un **banco di prova** per Oracode stesso (le pratiche e le regole Oracode si raffinano applicandole a FlorenceEGI)

**La metafora di riferimento è la Formula 1.** La Formula 1 non produce solo gare e bolidi: produce tecnologie automotive (frenata, trasmissione, telemetria, materiali) che maturano sotto la pressione estrema della competizione e poi passano alla produzione di serie. FlorenceEGI gioca lo stesso ruolo: è il contesto ad alta pressione dove Oracode e Libreria LSO maturano, prima di essere applicati a contesti meno esigenti (commesse PMI, progetti custom).

**Composizione.** FlorenceEGI è formata da:

- **Organi specifici** — EGI/ArtFlorenceEGI, EGI-HUB, NATAN_LOC, Sigillo, EGI-Credential, EGI-HUB-HOME, EGI-INFO, La Bottega, EGI Proof
- **Sistema circolatorio multi-organo proprio** — Egili (token interno con MiCA compliance), che è specifico di FlorenceEGI e non trasferibile
- **Dominio di business specifico** — artisti digitali, asset certificati, comunità, prenotazioni, royalty, impatto ambientale

**Test di coerenza (vincolo spin-off).** FlorenceEGI è per costruzione non trasferibile — è la specifica istanza, non una tecnologia. Ma il suo ruolo di laboratorio sì: ogni elemento di FlorenceEGI che dimostra valore al di fuori del dominio originario diventa candidato a passare in Libreria LSO. Il flusso è unidirezionale (FlorenceEGI → Libreria LSO), non viceversa: la Libreria LSO non è una collezione di "pezzi di FlorenceEGI" ma di *tecnologie maturate dentro FlorenceEGI* che hanno acquisito dignità autonoma.

---

## 2. Rapporti tra i livelli

I quattro livelli definiti in sezione 1 non sono indipendenti. Hanno una geometria precisa di relazioni causali, di flusso, e di appartenenza, che è essenziale capire per evitare di confonderli nelle decisioni operative e commerciali.

### 2.1 Oracode produce Libreria LSO

Oracode, applicato a un dominio reale, **genera Libreria LSO come side effect**. Non è un side effect accidentale: è strutturale.

Il meccanismo è il seguente. Oracode si avvale di OS3 Matrix (§1.1.B) come strumento di enforcement del piano OS3. Quando si costruisce un'applicazione con Oracode, ogni componente sviluppato vive sotto disciplina documentale (DOC-SYNC), tracciamento decisionale (Mission Protocol) e validazione continua (gate — enforcement runtime in OS3 Matrix). Questa disciplina è ciò che rende ogni componente *estraibile*: alla fine del suo sviluppo, il componente non è solo "codice che funziona" — è codice documentato, tracciato, allineato, con confini ben definiti e dipendenze esplicite.

Un componente sviluppato senza Oracode può essere altrettanto buono tecnicamente, ma è normalmente *intrecciato* con il contesto in cui è nato. Estrarlo richiede archeologia, pulizia, riscrittura. Un componente sviluppato con Oracode è già pre-disposto a vivere fuori dal proprio contesto di origine.

Questo è il legame causale: **senza Oracode non esisterebbe la Libreria LSO** — esisterebbero solo "moduli interni di FlorenceEGI" non trasferibili.

### 2.2 Oracode applicato a un dominio produce un'applicazione

Quando Oracode viene applicato a un singolo dominio (es. un sistema di Project Management per Forti Camicie), produce **un organo vivente individuale** — una singola applicazione che ha tutte le proprietà vitali necessarie: si auto-osserva (Mission Protocol), si auto-allinea (DOC-SYNC), si auto-ricorda (RAG), e cresce per accumulo riusabile delle proprie esperienze.

Questo è importante notarlo: **Oracode non richiede multi-organo per produrre un sistema vivente**. Un'applicazione singola costruita con Oracode è già viva. La metafora dell'Organismo (1.3) si applica solo quando ci sono più organi interconnessi; ma anche una singola applicazione è "viva" nel senso pieno che Oracode attribuisce al termine.

Conseguenza commerciale: il cliente PMI che riceve un'applicazione custom costruita con Oracode riceve un sistema vivente per default, indipendentemente dal fatto che voglia o meno costruire un ecosistema multi-applicazione in futuro.

### 2.3 Più applicazioni interconnesse formano un Organismo

Quando più applicazioni costruite con Oracode si interconnettono (condivisione di dati, di utenti, di flussi, di identità), emerge un livello superiore: l'**Organismo**. L'Organismo ha proprietà che i singoli organi non hanno individualmente — emergenza, non somma.

Ma — proprietà cruciale, conseguenza diretta del fatto che ogni organo è costruito con Oracode — la formazione dell'Organismo **non compromette la vitalità individuale degli organi**. Ogni organo conserva il proprio sistema circolatorio mono-organo (Mission Protocol, DOC-SYNC, RAG) e può essere disaccoppiato senza morire.

Questo è raro. Nei sistemi multi-modulo tradizionali, l'integrazione produce dipendenza: stacchi un modulo, gli altri muoiono o diventano inutili. In un Organismo costruito con Oracode, l'integrazione produce coesione ma non dipendenza vitale.

### 2.4 FlorenceEGI è organismo + laboratorio insieme

FlorenceEGI è un Organismo (sezione 2.3) che svolge anche la funzione di laboratorio per Oracode e per la Libreria LSO. Questa dualità non è una proprietà che FlorenceEGI condividerà necessariamente con altri Organismi futuri.

Un secondo Organismo costruito un domani con Oracode (per esempio un ecosistema di tre applicazioni interconnesse per un'azienda manifatturiera) sarà un Organismo *senza* essere un laboratorio — sarà solo un'applicazione del paradigma e dei componenti già maturi. FlorenceEGI è laboratorio perché è il primo, e perché è costruito da chi sta sviluppando contemporaneamente Oracode stesso e la Libreria LSO. Questa è una proprietà storica, non strutturale.

Conseguenza importante: il fatto che FlorenceEGI sia laboratorio è un *vantaggio competitivo temporale* di Florence EGI S.R.L. come azienda. Le tecnologie nascono qui prima che altrove. Un concorrente che adottasse Oracode dovrebbe ricostruire la Libreria LSO da zero, oppure licenziarla.

### 2.5 La Libreria LSO è il "fertilizzante incrociato"

La Libreria LSO ha una funzione che merita di essere nominata esplicitamente: è il **vettore di fertilizzazione incrociata** tra applicazioni costruite con Oracode.

Quando un nuovo progetto viene costruito (es. il sistema per Forti Camicie), non parte da zero. Parte con:

- Oracode (paradigma — sempre)
- + i componenti della Libreria LSO che servono per il dominio
- + il dominio specifico del cliente da costruire ex novo

Questo significa che ogni nuovo progetto **eredita la maturità tecnologica accumulata da tutti i progetti precedenti**, non solo da FlorenceEGI. Se domani si sviluppa un nuovo componente (supponiamo un "Modulo Predizioni" maturato per Forti Camicie), questo componente — se passa il test di coerenza — entra in Libreria LSO e diventa disponibile per il progetto successivo.

Questo è il moltiplicatore reale di Magicsoft 2.0. Ogni commessa contribuisce al patrimonio comune. Ogni patrimonio comune accelera la commessa successiva.

### 2.6 Il flusso è unidirezionale

Una proprietà strutturale che è importante fissare: il flusso tra i livelli è unidirezionale.

```
Oracode → produce → Libreria LSO
Oracode + Libreria LSO + Dominio → produce → Applicazione/Organo
Più Organi → formano → Organismo
Organismo + condizioni storiche → diventa → Laboratorio (caso FlorenceEGI)
```

Non esiste il flusso inverso. La Libreria LSO **non** modifica Oracode. Le applicazioni **non** modificano la Libreria LSO (la arricchiscono di componenti, ma quei componenti diventano parte della Libreria solo se passano il test di coerenza). FlorenceEGI **non** è proprietario di Oracode né della Libreria LSO — è il contesto in cui questi maturano.

Questa unidirezionalità è la garanzia di trasferibilità. Se i flussi fossero bidirezionali, Oracode si contaminerebbe con il dominio FlorenceEGI e perderebbe la propria neutralità di paradigma.

### 2.7 Vitalità dell'LSO: dipende dal dominio applicativo

Una precisazione importante che chiude il discorso sui rapporti tra Oracode e ciò che produce: **Oracode produce un LSO ben strutturato, ma la vitalità reale dell'LSO dipende dalla natura dell'applicazione e dal flusso di interazioni che essa riceve nel proprio dominio**.

**Caso A — LSO pieno.**
Un'applicazione caratterizzata da interazione continua (es. un gestionale con ordini, produzione, clienti, fornitori in costante movimento; oppure una piattaforma con utenti attivi che generano contenuti; oppure un sistema di knowledge management con query e aggiornamenti regolari) **alimenta naturalmente il proprio sistema circolatorio mono-organo**. Il RAG interno cresce con l'uso. Il Mission Protocol traccia decisioni significative che si accumulano. Il sistema di Helping conversazionale acquisisce esperienza riusabile per gli utenti successivi. L'AI integrata migliora la propria operatività e precisione nel tempo, perché ha materiale reale su cui apprendere il dominio specifico del cliente. Questo è un LSO pieno: l'organismo è vivo non solo strutturalmente, ma metabolicamente.

**Caso B — LSO ridotto.**
Un'applicazione caratterizzata da interazione minima o assente (es. un sito vetrina prevalentemente statico; uno strumento monouso che produce output non riusabili; un'utility tecnica con pochi punti di contatto utente) avrà invece **infrastruttura LSO completa ma metabolismo ridotto**. Gli artefatti del sistema circolatorio esistono e funzionano correttamente a livello tecnico — Mission Protocol, DOC-SYNC, RAG vuoto-ma-pronto, Helping conversazionale operativo — ma non producono crescita significativa nel tempo perché manca il flusso di esperienze che alimenta la base. L'organismo è sano alla nascita ma resta in dieta minima per natura del proprio dominio.

**Conseguenza commerciale (rilevante per Magicsoft 2.0).**
La valutazione preventiva di una commessa deve includere la domanda: *"questa applicazione ha le caratteristiche per diventare un LSO pieno?"*. Le applicazioni con flusso di interazione costante giustificano pienamente l'investimento di Oracode e producono il massimo valore differenziante nel tempo. Le applicazioni senza flusso ricevono comunque l'infrastruttura Oracode (qualità del codice, disciplina documentale, sicurezza by-design, GDPR strutturato, manutenibilità di lungo periodo, hook bloccanti (implementazione OS3 Matrix, §1.1.B)) — tutti benefici reali e misurabili — ma il valore differenziante del sistema circolatorio mono-organo come fonte di crescita non si esprime al massimo.

**Conseguenza per il pitch commerciale.**
Quando si propone Oracode a un cliente, la prima discussione non è tecnica ma diagnostica del dominio. Domande come: *"Il vostro sistema avrà interazione continua? Genererà esperienze accumulabili? Avrà utenti che useranno la AI integrata abbastanza da arricchire la base nel tempo?"* Se la risposta è sì, il pitch è LSO pieno. Se la risposta è no, il pitch è onestamente "applicazione costruita con disciplina Oracode" — comunque differenziante rispetto al mercato, ma senza promettere ciò che il dominio non può sostenere. Questa onestà preventiva protegge sia il cliente da promesse non mantenibili, sia Florence EGI SRL dalla sopravvalutazione del proprio prodotto in casi non adatti.

---

## 3. Cosa appartiene a cosa — mappa di appartenenza

Questa sezione classifica i componenti concreti del progetto FlorenceEGI nei livelli definiti in sezione 1. È la sezione più operativa del documento, e quella destinata ad evolvere più frequentemente man mano che nuovi componenti maturano e nuove distinzioni emergono.

**Convenzione fondamentale.** Ogni componente è classificato in **uno solo** dei livelli sotto. Quando un componente sembra appartenere a più livelli, significa quasi sempre che si sta confondendo il *pattern architetturale* (universalizzabile) con l'*implementazione concreta* (sviluppata in un dominio specifico). Il pattern appartiene a Oracode (3.1). L'implementazione concreta appartiene alla Libreria LSO (3.2) se è estraibile, o a FlorenceEGI (3.3) se è cucita sul dominio.

**Nota di precisione fondamentale.** Ciò che è universale in Oracode è la **struttura**, non il contenuto specifico di alcuni elementi. Per esempio, le 13 Regole Sacre P0 sono universali nella loro *forma* (regole bloccanti gerarchiche con enforcement meccanico), ma alcuni contenuti specifici (es. "i18n in 6 lingue: it/en/de/es/fr/pt", "limite 500 righe per file") sono scelte fatte per FlorenceEGI. Un'applicazione Oracode in altro dominio manterrà la struttura ma adatterà i contenuti.

---

### 3.1 Componenti di Oracode (trasferibili a qualsiasi dominio)

#### 3.1.A Componenti del paradigma

##### 3.1.A.1 Gerarchia di autorità OSZ → OS3 → OS4

```
OSZ (Kernel)    → Il sistema operativo dell'organismo cognitivo
 ↓
OS3 (Execution) → Protocollo operativo AI-Human (P0-P3, hook, DOC-SYNC)
 ↓
OS4 (Education) → Educazione epistemica dell'umano
```

**Regola immutabile:** OSZ è la verità assoluta. OS3 e OS4 si aggiornano per allinearvisi — mai il contrario.

Questa gerarchia, codificata qui dal 4 maggio 2026, è stata riconfermata come anatomia del paradigma il 21 maggio 2026 nella revisione architetturale che ha separato Oracode-paradigma (§1.1.A) da OS3 Matrix (strumento di enforcement, §1.1.B).

Questa gerarchia è il fondamento concettuale di Oracode e va mantenuta in qualsiasi applicazione del paradigma. Il *contenuto* specifico di OSZ (cosa il kernel governa) può essere dominio-specifico; la *struttura* tre-livelli è universale.

##### 3.1.A.2 6+1 Pilastri Cardinali

| # | Pilastro | Forma generica (universale) | Esempio enforcement (FlorenceEGI) |
|---|----------|----------------------------|------------------------------------|
| 1 | Intenzionalità Esplicita | Ogni unità di codice dichiara il proprio scopo | `@purpose` obbligatorio in DocBlock |
| 2 | Semplicità Potenziante | No over-abstraction, no premature optimization | Limite 500 righe per file, ban di astrazioni speculative |
| 3 | Coerenza Semantica | Terminologia unificata in tutto il codebase | Glossario OSZ applicato a codice e doc |
| 4 | Circolarità Virtuosa | Bug → test; Feature → pattern | Operazionalizzato dalla regola P0-13 (vedi 3.1.4) |
| 5 | Evoluzione Ricorsiva | Documentazione co-evolve col codice | DOC-SYNC P0-11 — task non chiusa senza EGI-DOC aggiornato |
| 6 | Sicurezza Proattiva | Sicurezza by-design, non patch a posteriori | GDPR + Sanctum + scope sempre (vedi 3.1.9) |
| **+1** | **REGOLA ZERO** | **Mai dedurre. Informazione mancante → STOP, chiedi** | Pilastro fondante, autorità superiore agli altri 6 |

##### 3.1.A.3 Sistema Priorità P0–P3

| Priorità | Conseguenza | Tolerance |
|----------|-------------|-----------|
| **P0** 🛑 | Sistema si rompe immediatamente — STOP TOTALE | Zero — nessuna eccezione |
| **P1** | Codice non production-ready | Correggi prima del deploy |
| **P2** | Accumulo debito tecnico | Refactoring programmato |
| **P3** | Opportunity cost | Consigliato ma opzionale |

##### 3.1.A.4 Le 13 Regole Sacre P0

Queste sono le regole bloccanti universali. La forma è universale; i contenuti specifici riflettono lo stack tecnologico di FlorenceEGI e devono essere adattati al dominio target conservando la stessa struttura.

| # | Regola | Forma universale (cosa fa) |
|---|--------|----------------------------|
| P0-1 | **REGOLA ZERO** | Info mancante → STOP, chiedi. Mai dedurre |
| P0-2 | **Translation keys** | Mai testo hardcoded in UI — sempre via key i18n |
| P0-3 | **Statistics Rule** | Parametri statistiche sempre espliciti, mai default nascosti |
| P0-4 | **Anti-Method-Invention** | Verifica esistenza di un metodo prima di usarlo |
| P0-5 | **UEM-First** | Errori passano sempre dal gestore errori, mai solo log |
| P0-6 | **Anti-Service-Method** | Lettura+grep su qualsiasi service prima di modificarlo |
| P0-7 | **Anti-Enum-Constant** | Verifica che le costanti enum esistano prima di usarle |
| P0-8 | **Complete Flow Analysis** | Mappa il flusso completo (4 fasi) prima di qualsiasi fix |
| P0-9 | **i18n multi-lingua** | Internazionalizzazione su tutte le lingue target del dominio |
| P0-10 | **Anti-bypass del data layer** | Service factory obbligatorio, mai accesso diretto al driver del DB |
| P0-11 | **DOC-SYNC** | Task non chiusa senza documentazione aggiornata. Zero eccezioni |
| P0-12 | **Anti-Infra-Invention** | Info su deploy/infrastruttura: verifica da fonti autoritative, mai dedurre |
| **P0-13** | **Test-First Discipline** | Ogni feature/fix/refactor produce o aggiorna i test corrispondenti. Task non chiusa senza test verde. Zero eccezioni |

###### P0-8 — Complete Flow Analysis (4 fasi obbligatorie)

```
FASE 1 — FLOW MAPPING
  User Action → Entry Point (Route · Controller@metodo)
  Processing  → Controller → Service → External calls (sync/async?)
  Exit Point  → Success · Error (come gestito?)
  Critical    → Dove può fallire? Dove cambiano i tipi? Branch logic?

FASE 2 — TYPE TRACING
  Per ogni variabile: tipo in ogni step. Ogni trasformazione esplicita.

FASE 3 — ALL OCCURRENCES
  Ricerca esaustiva di tutti gli usi di metodo/classe nel codebase

FASE 4 — IMPACT ANALYSIS
  Mappa di chi viene impattato dalla modifica, sia upstream sia downstream
```

###### P0-13 — Test-First Discipline

OS3 impone disciplina di test come parte non negoziabile del ciclo di sviluppo. Una task è chiusa solo quando i test corrispondenti sono presenti e verdi.

**Tre obblighi distinti, tutti in scope:**

1. **Nuova feature → nuovi test.** Ogni unità di funzionalità nuova nasce accompagnata da test che ne verificano comportamento atteso, edge case identificati durante P0-8 (Complete Flow Analysis), e gestione errori (UEM-First, P0-5).

2. **Fix di bug → test che cattura il bug.** Ogni bug fixato deve essere accompagnato da un test che, prima del fix, falliva e dopo il fix passa. Questo enforce il Pilastro 4 (Circolarità Virtuosa: "Bug → test").

3. **Refactor → test esistenti aggiornati e verdi.** Ogni refactor deve lasciare il sistema con test verdi. Se il refactor cambia comportamento (non solo struttura), i test cambiano insieme al codice e l'intenzione del cambiamento è documentata.

**Flusso obbligatorio:**

```
FEATURE NUOVA:
  P0-8 (Complete Flow Analysis) → identifica edge case
  → scrittura test (red) → implementazione (green) → refactor se serve
  → DOC-SYNC P0-11 → task chiusa

FIX:
  Bug riprodotto → test che lo cattura (red)
  → fix (test green) → verifica nessuna regressione su altri test
  → DOC-SYNC P0-11 → task chiusa

REFACTOR:
  Test esistenti verdi (baseline) → refactor incrementale
  → test verdi a ogni step → se test cambia, motivazione esplicita
  → DOC-SYNC P0-11 → task chiusa
```

**Test eccezionali (parte di Strategia Delta).** Codice legacy senza test esistenti non viene "test-coperto di principio" (violerebbe Strategia Delta). Si aggiungono test solo quando si tocca il codice legacy per altra ragione, partendo dal pezzo che si tocca.

**Pattern di enforcement:**

Il principio universale è che ogni regola P0 ha enforcement meccanico associato. Le implementazioni concrete degli hook e gate che enforcano P0-13 sono in §3.1.B (componenti di OS3 Matrix).

**Applicazioni specifiche di P0-13:**

- Skill testing framework (per agenti AI)
- Test dei prompt (per componenti AI come Council, Maestro)
- Test delle pipeline cognitive (USE, RAG, RAG-Fortress)
- Unit test classico (per logica di dominio)

P0-13 è la regola madre. Le applicazioni specifiche a domini diversi sono incarnazioni dello stesso principio.

##### 3.1.A.5 Strategia Delta

Regola fondamentale di gestione del codice esistente:

```
NUOVO CODICE  → Tutte le regole Oracode. Nessuna eccezione.
CODICE LEGACY → Resta dove è. Si migra SOLO quando si tocca per altra ragione.
                Mai refactoring "di principio" su codice production funzionante.
                Ogni migrazione: piano approvato + test before/after.
```

La Strategia Delta protegge da due rischi opposti: il debito tecnico non gestito (codice legacy che peggiora) e il refactoring nevrotico (rompere ciò che funziona per estetica). Si interviene solo dove c'è una ragione operativa.

##### 3.1.A.6 Primitivi OSZ (livello kernel)

I Primitivi OSZ sono le unità semantiche fondamentali dell'organismo cognitivo. Sono di livello Kernel (sopra OS3), cioè appartengono al DNA del paradigma, non al protocollo esecutivo.

| Primitivo | Definizione OSZ | Forma universale |
|-----------|-----------------|------------------|
| `EGI` (primitivo) | `Wrapper<T> + Regole + Audit + Valore` — unità atomica certificata | Pattern di unità di valore tracciata, autenticata e auditabile |
| `Interface` | Giunture stabili tra organi — i contratti non cambiano mai | Contratti di interfaccia che restano stabili anche quando l'implementazione cambia |
| `USE` | Ultra Semantic Engine — `Input → Analyzer → RAG → Output` | Pipeline di processamento semantico standardizzata |
| `URS` | Unified Reliability Score (0–100) — affidabilità della risposta AI | Metrica universale di affidabilità per output AI |
| `Nerve` | Governatori e validatori del flusso dati tra organi | Sistema di enforcement dei contratti tra moduli |

**Nota.** "EGI" come primitivo OSZ (unità atomica certificata) è distinto da "EGI" come organo specifico di FlorenceEGI (`art.florenceegi.com`). Stesso nome, due livelli concettuali. Il primitivo è universale; l'organo è in 3.3.

##### 3.1.A.7 Disciplina di codice obbligatoria — Famiglia Ultra come infrastruttura nativa di Oracode

OS3 non lascia libertà di scelta su come gestire errori, log, traduzioni, configurazione e upload. Queste responsabilità trasversali sono coperte da **librerie obbligatorie** che ogni nuovo codice deve usare. Sono parte costitutiva del paradigma — **Ultra è di Oracode, non di FlorenceEGI**.

**Multi-linguaggio nativo.** Ultra esiste in più stack tecnologici, perché Oracode si applica a progetti multi-linguaggio per costruzione. Versioni esistenti:

- **PHP / Laravel** — pacchetti Composer `ultra/ultra-error-manager`, `ultra/ultra-log-manager`, `ultra/ultra-translation-manager`, `ultra/ultra-config-manager`, `ultra/ultra-upload-manager` (verificato come dipendenza in organi dell'istanza FlorenceEGI: es. NATAN_LOC, EGI, EGI-Credential, La Bottega)
- **JavaScript / TypeScript** — versioni adattate al frontend, usate negli organi React/Next.js dell'ecosistema
- **Python** — *(da verificare se esiste come libreria Ultra dedicata o se i servizi Python adottano gli stessi pattern senza il branding Ultra)*

| Libreria | Sigla | Funzione | Regola P0 di riferimento |
|----------|-------|----------|--------------------------|
| Ultra Error Manager | UEM | Gestione errori centralizzata, handler categorizzati, recovery patterns | P0-5 (UEM-First) |
| Ultra Log Manager | ULM | Logging strutturato, multi-channel, GDPR-aware | Componente di GDPR-by-design |
| Ultra Translation Manager | UTM | Internazionalizzazione, atomic translation keys | P0-2 + P0-9 |
| Ultra Config Manager | UCM | Gestione configurazioni centralizzata | (in maturazione, non ancora forzato in produzione) |
| Ultra Upload Manager | UUM | Gestione upload, validazione, scan, storage | Componente operativo per organi che gestiscono file |

**Forma universale del principio:** un'applicazione costruita con Oracode esternalizza le responsabilità trasversali (logging, errori, traduzioni, configurazione, upload) nelle librerie Ultra del linguaggio di destinazione. **Il nome "Ultra" e la struttura della famiglia sono parte di Oracode, non scelte FlorenceEGI**. Quando Oracode viene applicato a un nuovo dominio, le librerie Ultra del linguaggio target sono già disponibili come parte del paradigma. Se Oracode si estende a un linguaggio in cui Ultra non esiste ancora, la creazione della versione Ultra per quel linguaggio è parte dell'estensione del paradigma stesso, non lavoro del singolo progetto.

**Limite operativo correlato.** OS3 impone limite di 500 righe per file nuovo. File legacy oltre il limite restano sotto Strategia Delta.

##### 3.1.A.8 SEO obbligatorio per contenuto pubblico

Per ogni pagina pubblica indicizzabile, OS3 impone uno standard SEO non negoziabile, codificato nel documento `SEO_STANDARD` con checklist di 25 voci P0/P1 e gate CI/CD Lighthouse.

**Regole d'oro (forma universale):**

1. **SSR obbligatorio per contenuto indicizzabile** — pure-client rendering vietato per pagine pubbliche con contenuto da indicizzare
2. **Meta tags strutturati** — title, description, canonical, viewport, lang, charset, robots condizionale
3. **i18n SEO** — hreflang per locale primario + x-default, og:locale mappato
4. **Open Graph + Twitter Card** — meta tag completi per condivisione social
5. **Core Web Vitals entro soglie** — LCP, CLS, TBT. Lighthouse Performance ≥ 95
6. **Gate CI/CD Lighthouse** — fail deploy se score < 95 Performance o < 100 Accessibility/Best Practices/SEO (implementazione runtime del gate: vedi OS3 Matrix §3.1.B)

**Forma universale del principio:** ogni applicazione Oracode che espone contenuto pubblico ha disciplina SEO codificata in standard documentato e testato automaticamente in CI. La specifica checklist a 25 voci e le soglie numeriche sono di FlorenceEGI; il principio di SEO discipline-as-standard con CI/CD gate è universale.

##### 3.1.A.9 Schema.org / JSON-LD strutturato

OS3 impone l'uso di markup strutturato Schema.org per ogni pagina pubblica con contenuto significativo. Non è opzionale, non è "se ci ricordiamo": è infrastruttura nativa.

**Schema obbligatori (forma universale):**

| Schema | Quando si usa | Esempio FlorenceEGI |
|--------|---------------|---------------------|
| `WebPage` | Ogni pagina pubblica | Tutte le pagine EGI-INFO, EGI-HUB-HOME |
| `Organization` | Footer/about di ogni sito pubblico | Florence EGI SRL + Frangette APS |
| `BreadcrumbList` | Pagine con navigazione gerarchica | Strutture di catalogo, archivi |
| `Person` | Pagine profilo pubbliche | Business Card EGI-Credential, profili creator |
| `Product` | Pagine prodotto / asset | EGI singoli su ArtFlorenceEGI |
| `Article` | Blog post, news, contenuti editoriali | Manifesti, post culturali |
| `FAQPage` | Sezioni FAQ strutturate | Pagine help, supporto |
| `HowTo` | Guide passo-passo | Tutorial creator, processi di certificazione |
| `SoftwareApplication` | Organi software pubblici | Scheda tecnica organi |

**Implementazione di riferimento.** L'organo EGI-INFO ha un'intera infrastruttura `src/utils/seo/SchemaOrg.tsx` con factory function per ogni tipo di schema. Questa è implementazione concreta del pattern (potrebbe entrare in Libreria LSO 3.2 quando consolidata), ma il pattern di "Schema.org strutturato come infrastruttura di prima classe" è Oracode (3.1.9).

**Forma universale del principio:** ogni applicazione Oracode con contenuto pubblico espone markup Schema.org via componenti riutilizzabili tipizzati, non tramite stringhe inline. Il markup è validato (Google Rich Results Test) come parte del processo di rilascio.

##### 3.1.A.10 Accessibility WCAG 2.1 AA — infrastruttura ARIA strutturata

OS3 considera l'accessibilità non come "feature etica" ma come **diritto civile codificato** e infrastruttura tecnica obbligatoria. Lo standard di riferimento è WCAG 2.1 livello AA come *minimo*; livello AA+ è scelta operativa di FlorenceEGI per nuovi sviluppi.

**Componenti dell'infrastruttura accessibilità (forma universale):**

| Componente | Funzione | Implementazione FlorenceEGI |
|------------|----------|------------------------------|
| Sistema ARIA tipizzato | Tipi per `AriaLive`, `AriaRole`, helper `combineAriaDescribedBy`, `generateAriaId`, `AnnouncerProvider` per annunci screen reader | `src/utils/seo/Aria.tsx` in EGI-INFO |
| Skip-to-main link | Permettere navigazione tastiera diretta al contenuto principale | `SkipToMain` component |
| Focus management | Indicatori visivi `focus-visible`, focus trap in modali, ripristino focus post-errore | CSS `focus-visible` su tutti gli elementi interattivi |
| Screen reader support | `aria-describedby` su ogni input, `role="alert"` su errori, `aria-label` dinamici | Pattern presente in registrazione EGI, La Bottega, EGI-Credential |
| Keyboard navigation | Ogni interazione possibile da tastiera (Esc per chiudere, Enter per submit, Tab order corretto) | Documentato in form di registrazione EGI |
| Contrast ratio | Minimo 4.5:1 per testo normale, 3:1 per UI elements (WCAG AA) | Verificato via Lighthouse + audit manuale |
| `prefers-reduced-motion` | Disabilitare animazioni per utenti con sensibilità motion | GSAP duration=0, Three.js fallback statico (CREATOR-STAGING R4) |
| `aria-modal` su overlay | Annuncio corretto di dialoghi e modali | Microscopio Report, modali di conferma |
| Semantic HTML + Landmarks | `<main>`, `<nav>`, `<aside>`, `role="navigation"`, struttura logica | `Landmark` component in EGI-INFO |

**Forma universale del principio:** un'applicazione costruita con Oracode espone infrastruttura ARIA come **strato di prima classe**, con componenti tipizzati riutilizzabili, non come stringhe ad-hoc inline. Lighthouse Accessibility = 100 è gate CI/CD bloccante per nuovo codice.

**Test inclusi nelle metriche di rilascio (forma universale):**

- Keyboard navigation completion rate (% utenti che completano flussi solo con tastiera)
- Screen reader user success rate (% successo utenti screen reader)
- Error recovery success rate (% utenti che correggono un errore e completano il flusso)

Queste metriche sono raccomandate da OS3 come parte del processo di validazione qualitativa; le soglie specifiche sono scelta del dominio.

##### 3.1.A.11 Compliance GDPR obbligatoria — infrastruttura strutturata

OS3 non riduce GDPR a "rispettare la privacy". Impone **infrastruttura concreta** con servizi dedicati e tassonomia formale.

| Componente | Funzione | Esempio FlorenceEGI |
|------------|----------|---------------------|
| Servizio Consensi | Gestione e versioning consensi categorizzati, raccolta al primo onboarding, granularità obbligatori vs opzionali | `ConsentService` con 9 tipi di consenso |
| Servizio Audit Trail | Audit log immutabile, retention pluriennale, append-only durante retention | `AuditLogService` con retention 7 anni |
| Tassonomia Eventi | Classificazione strutturata di attività, livelli di privacy, eventi di sicurezza | `GdprActivityCategory`, `PrivacyLevel`, `UserActivity`, `SecurityEvent`, `GdprAuditLog` |
| Pagine Legal pubbliche | Privacy policy + ToS accessibili senza autenticazione | `/legal/privacy-policy` + `/legal/terms-of-service` |
| Engine di compliance | Compliance integrata nei motori di business | `Compliance Engine` dentro AMMk |
| DPIA strutturata | Data Protection Impact Assessment per ogni organo che fa profilazione o tratta dati sensibili | DPIA per NATAN_LOC, EGI-Credential, EGI |
| Registro DPA | Data Processing Agreement con ogni sub-processor | DPA AWS, Anthropic, OpenAI, Stripe |
| Diritti utente | Endpoint operativi per accesso, portabilità, cancellazione (Art. 15, 17, 20) | `requestDeletion`, `data-export`, restriction processing |

**Forma universale del principio:** un'applicazione costruita con Oracode espone GDPR come **strato infrastrutturale di prima classe**, non come compliance a posteriori. La struttura è universale. I contenuti specifici (i 9 tipi di consenso scelti, la retention di 7 anni, i nomi dei servizi) sono adattamenti FlorenceEGI.

##### 3.1.A.12 Sistema circolatorio mono-organo (pattern)

Già dettagliato in 1.1. I componenti che lo realizzano sono universali per costruzione:

- **Mission Protocol** — track record decisionale con metriche quantitative
- **DOC-SYNC** — allineamento codice ↔ documentazione
- **RAG interno** — memoria operativa che cresce con l'uso
- **Sistema di Helping conversazionale** — voce del RAG verso l'utente

**Nota architetturale (Mission Engine dual-tracking).** Dal bootstrap di OS3 Matrix (M-OS3-001, 25 maggio 2026) il Mission Protocol di Oracode è realizzato come due fonti dati distinte ma sincronizzate. La prima fonte è una **state machine non-aggirabile** sotto `bin/mission`, che vive nella cartella globale VISIBILE dell'engine (`~/oracode-engine/missions/<ID>/state.json`; `~/.oracode` resta solo come symlink di compatibilità) ed è condivisa fra tutti i progetti Oracode della macchina; tiene firma crittografica della catena di transizioni, spawn fingerprint degli agenti, contatori di edit per audit interim. Questa cartella globale è il livello L1 GLOBALE (motore + paradigma) della gerarchia Oracode Nexus a 3 livelli (vedi `ORACODE_NEXUS_3_TIER.md`): è lo scratch operativo del motore (cosa gira adesso, lock, stato in volo), non un archivio versionato. La seconda fonte è il **Mission Registry del progetto applicativo**, versionato col repo (`<progetto-DOC>/docs/missions/MISSION_REGISTRY.json`), che traccia scope, trigger matrix, SSOT impattati, P0 dominio, esito test, blocco `doc_sync`. Questo registry è il livello L3 ISTANZA della gerarchia Oracode Nexus. Le sue chiavi sono in **INGLESE** (`id`, `title`, `type`, `organs`, `status`, `date_open`, `date_close`, ...); le chiavi italiane (`tipo_missione`, `organi_coinvolti`, `data_apertura`, `stato`) sono legacy EGI-DOC, mai canoniche per le istanze nuove. Numerazione globale unica e statistiche consolidate sono responsabilità del livello L2 HUB (softwarehouse acquirente), non dell'istanza. La separazione corrisponde a una distinzione concettuale netta: la state machine è infrastruttura di disciplina (universale, Oracode-paradigma), il Mission Registry del progetto è SSOT documentale (specifico al dominio, parte dell'organo). La sincronizzazione fra le due fonti è **automatica**: `bin/mission open`/`advance` propagano lo stato nel `MISSION_REGISTRY.json` del progetto, risolto dal descrittore `<progetto>/.oracode/project.json` (CWD-resolved), parallel-safe via lockfile (funzione interna `syncToRepoRegistry`). È la realizzazione del **Ponte L1→L3 automatico** della gerarchia Oracode Nexus (M-OS3-025 Unità 3, commit 8760c5d, doppio audit GREEN). La vecchia sincronizzazione manuale e le "mission fantasma" sono superate.

##### 3.1.A.13 Hook Enforcement System (pattern)

Gli hook PreToolUse/PostToolUse sono il sistema nervoso autonomo di Oracode. Implementano meccanicamente le regole P0 — non sono istruzioni interpretabili dall'AI, sono gate fail-closed.

**Pattern universale:** ogni regola P0 può essere associata a uno o più hook che la enforcano automaticamente al momento dell'azione AI. L'elenco specifico degli hook è dominio-specifico; il pattern di "hook bloccanti meccanici per ogni regola P0" è universale.

Implementazioni concrete degli hook: vedi §3.1.B.

##### 3.1.A.14 Disciplina documentale

- CLAUDE.md gerarchici con `@` include cross-organo
- Frontmatter strutturato e tipizzato per documenti SSOT
- Naming conventions (Code Naming Standard, Naming Conventions)
- Immutable values (costanti di sistema protette da hook)
- Manifesti del paradigma

##### 3.1.A.15 Layer Stack — la stratificazione architetturale dell'organismo

Oracode non descrive un'applicazione come *un blocco unico di codice*. La descrive come **un organismo stratificato in 11 layer** (più L0 come prerequisito), ciascuno con una funzione biologica analoga e un ruolo architetturale preciso. Ogni layer presuppone i precedenti e abilita i successivi.

Lo stack è proprietà del paradigma. Qualsiasi applicazione costruita con Oracode ha *gli stessi 11 layer come tassonomia*; ciò che cambia da istanza a istanza è la **maturity** di ciascun layer (in produzione, in design, in concept, in vision).

###### Mappa completa dei layer

```
                    ┌──────────────────────────────────────────┐
                    │  L11 — AUTO-GOVERNANCE COSTITUZIONALE    │  vision
                    │  (specie autonoma post-fondatore)        │
                    ├──────────────────────────────────────────┤
                    │  L10 — RIPRODUZIONE                      │  concept
                    │  L10a simbiotica · L10b germinativa      │
                    ├──────────────────────────────────────────┤
                    │  L9  — RIFLESSIONE                       │  design
                    │  (corteccia prefrontale)                 │
                    ├══════════════════════════════════════════┤
                    │  L8  — SISTEMA NERVOSO                   │  production
                    │  (propriocezione documentale)            │
                    ├──────────────────────────────────────────┤
                    │  L7  — CONTRATTI                         │  production
                    │  (DNA semantico machine-readable)        │
                    ├──────────────────────────────────────────┤
                    │  L6  — TESTING                           │  production
                    │  (anticorpi adattivi)                    │
                    ├──────────────────────────────────────────┤
                    │  L5  — UEM                               │  production
                    │  (sistema immunitario)                   │
                    ├──────────────────────────────────────────┤
                    │  L4  — PREVENTION                        │  production
                    │  (riflessi condizionati)                 │
                    ├──────────────────────────────────────────┤
                    │  L3  — DETECTION                         │  production
                    │  (nervi sensoriali)                      │
                    ├──────────────────────────────────────────┤
                    │  L2  — DEEP AUDIT                        │  production
                    │  (controllo qualità del DNA)             │
                    ├──────────────────────────────────────────┤
                    │  L1  — SYNC                              │  production
                    │  (metabolismo cellulare base)            │
                    └──────────────────────────────────────────┘
```

La doppia linea tra L8 e L9 separa i layer **reattivi** (sistema nervoso autonomo) dai layer **evolutivi** (mente, riproduzione, autonomia).

###### Tassonomia dei layer

| Layer | Funzione cardinale | Sistema biologico analogo |
|-------|--------------------|----------------------------|
| **L1** — Sync | Metabolismo: trasforma input in struttura, sincronizza codice ↔ documentazione | Metabolismo cellulare |
| **L2** — Deep Audit | Mantiene coerenza interna del genoma documentale | Riparazione DNA |
| **L3** — Detection | Rileva variazioni e drift | Recettori sensoriali |
| **L4** — Prevention | Reagisce automaticamente per impedire errori | Riflessi spinali |
| **L5** — UEM | Riconosce e ricorda errori | Sistema immunitario |
| **L6** — Testing | Conserva difese acquisite (test come anticorpi) | Memoria immunitaria |
| **L7** — Contracts | Specifica esecutiva machine-readable tra organi | DNA codificante |
| **L8** — Nervous System | Integra propriocezione: sa lo stato di ogni layer in ogni momento | Sistema nervoso autonomo |
| **L9** — Reflection | Auto-osservazione e visione strategica | Corteccia prefrontale |
| **L10** — Reproduction | Mitosi: scissione di un'istanza in due (L10a simbiotica + L10b germinativa) | Mitosi |
| **L11** — Constitutional Auto-Governance | Continuità trans-individuale post-fondatore | Stabilità di specie |

**Nota di livello concettuale.** Questa tabella descrive i layer **come pattern del paradigma Oracode** — categorie funzionali universali. Lo *stato di maturity* di ciascun layer non è proprietà del paradigma, è proprietà di un'istanza specifica che ha applicato Oracode. La maturity di FlorenceEGI come prima istanza è in 3.3.7. Una futura applicazione Oracode (es. una commessa Magicsoft 2.0) avrebbe la propria maturity matrix, tipicamente diversa da quella di FlorenceEGI.

###### Categorizzazione di maturity (5 stati, applicabili alle istanze)

Per dare disciplina al concetto di "maturity di un layer in un'istanza":

| Stato | Significato |
|-------|-------------|
| **PRODUCTION** | Implementato, attivo, enforced sistematicamente, con evidenza fattuale |
| **PARTIAL** | Implementato in parte (da componenti minimi a infrastruttura ampia ma non sistematica), non enforced sistematicamente. Note testuali possono dettagliare il grado specifico (early stage, larga parte, ecc.) |
| **DESIGN** | Architettura definita, implementazione non iniziata |
| **CONCEPT** | Idea formulata, architettura non ancora definita |
| **VISION** | Direzione di lungo periodo, nessuna formalizzazione |

###### Nota epistemica sulla maturity matrix di FlorenceEGI

Il documento sorgente `LSO_LAYER_STACK_v1.0.0.md` (26 aprile 2026, status DRAFT) dichiarava L1-L8 tutti in PRODUCTION nell'istanza FlorenceEGI. Il 6 maggio 2026, durante la compilazione del presente documento, è emersa l'incoerenza fra "L6 — Testing — PRODUCTION" e tre evidenze indipendenti: (a) la codifica della regola P0-13 (Test-First Discipline) come lacuna riconosciuta solo il 4 maggio 2026, (b) la dichiarazione di `ENTERPRISE_COMPLIANCE_ROADMAP.md` di "zero test gate, zero staging, zero rollback" nel deploy workflow, (c) il documento comparativo con superpowers che ha rilevato "10 agenti LSO in produzione senza test formali di comportamento".

Questa scoperta ha innescato la mission **M-LS-AUDIT-001** condotta da Padmin Supervisor in VSCode il 7 maggio 2026, con verifica fattuale layer-per-layer. Il risultato è documentato in `LS_AUDIT_2026-05-07_RESULTS.md` (status STABLE) e ha riclassificato 6 layer su 8 come overstated nel documento sorgente. Solo **L4 (Prevention) raggiunge genuinamente PRODUCTION** nel suo scope ristretto (Claude Code session protection); L9, L10, L11 sono dichiarati correttamente; gli altri 7 layer sono in stati intermedi.

La maturity matrix verificata è in 3.3.7. Il documento sorgente `LSO_LAYER_STACK_v1.0.0.md` è stato già aggiornato dal Custode con il frontmatter corretto in seguito all'audit. I numeri di effort (giorni-uomo per portare ciascun layer al livello PRODUCTION) sono nella roadmap dell'audit stesso, non duplicati qui per evitare drift fra documenti.

###### L0 come prerequisito

Esiste anche un **L0 — Mielina** (`SSOT_REGISTRY.json` in FlorenceEGI), che non è layer attivo ma *infrastruttura di trasmissione* del segnale tra layer: è la mappa esplicita doc SSOT → file codebase che permette al sistema nervoso di propagare segnali istantaneamente. Senza L0 i layer esistono ma non comunicano correttamente tra loro. L'implementazione concreta di L0 (SSOT_REGISTRY.json, watches, segnalazione automatica) è componente di OS3 Matrix (vedi §3.1.B).

###### Le tre soglie qualitative

Lo stack non è lineare. È strutturato da **tre soglie qualitative**:

- **Soglia 1 — tra L0 e L1**: passaggio da *nessun sistema* a *metabolismo attivo*. Senza L1, non c'è organismo.
- **Soglia 2 — tra L8 e L9**: passaggio da *organismo reattivo* a *organismo riflessivo*. È la soglia della metacognizione. È anche la **soglia attuale** dell'evoluzione del paradigma.
- **Soglia 3 — tra L10 e L11**: passaggio da *organismo riproducibile* a *specie autonoma*. È la soglia dell'emancipazione dal fondatore.

Queste soglie definiscono **tre stati possibili** in cui un'applicazione Oracode può trovarsi:

- **Stato Reattivo** (L1-L8) — vive e si mantiene, ma non si pensa
- **Stato Riflessivo** (L1-L10) — vive, si pensa, si riproduce, ma dipende dal fondatore
- **Stato Stabile di Specie** (L1-L11) — vive autonomamente attraverso le generazioni

###### Sui layer evolutivi (L9-L11)

I layer L9-L11 non sono "feature aggiuntive" del paradigma. **Sono completamenti necessari della definizione di "Living"**. Il loro ordine non è arbitrario:

- **L9 deve esistere prima di L10**, perché la cellula deve sapere chi è prima di poter trasmettere correttamente la propria identità a una cellula figlia
- **L10 deve esistere prima di L11**, perché solo una specie con più istanze può sostenere governance autonoma trans-individuale

###### Vincolo costitutivo di L9 — le due gambe

L9 (Riflessione) raggiunge stato operativo quando soddisfa due condizioni congiunte:

**Gamba A — Disaccoppiamento da fornitore AI singolo.** Gli strumenti riflessivi dell'organismo non devono dipendere da un unico fornitore di servizi AI. Un organismo che osserva sé stesso attraverso un solo provider è esposto a evoluzione, deprecazione o cessazione di quel provider come rischio vitale. L9 richiede portabilità del livello riflessivo su almeno un secondo fornitore.

**Gamba B — Autocorrezione operativa.** L'organismo deve disporre di meccanismi che rilevino drift autonomamente e propaghino l'allineamento senza intervento manuale per ogni divergenza documentazione-codice. Questa gamba è attualmente operativa via DOC-SYNC v2 (attivazione runtime completata, coverage native operativa, drift detection autonoma via nightly cron agent — riferimento: M-160a, M-166, M-180, M-181, M-189).

L9 in stato PRODUCTION richiede entrambe le gambe. Allo stato attuale (22 maggio 2026), la Gamba B è operativa, la Gamba A è in direzione (vedi roadmap di disaccoppiamento in §4.4).

NOTA STORICA: la formulazione precedente di questo vincolo (v1.0.0, 4 maggio 2026) era più estesa e identificava L9 con strumenti riflessivi interni completamente sostitutivi degli LLM. La riformulazione del 21 maggio 2026 ha riconosciuto quella formulazione come overengineering: il problema vero non è "dipendenza da LLM in sé" ma "dipendenza da un unico fornitore" (Gamba A) e "manualità nella correzione" (Gamba B). La formulazione attuale è più sobria e più verificabile.

###### I sei principi invarianti dello stack

Indipendentemente dall'evoluzione futura del paradigma, alcuni principi non possono essere violati senza far cessare un'applicazione di essere un'applicazione Oracode:

1. **REGOLA ZERO si applica ad ogni layer** — nessun layer può dedurre, ogni layer deve avere fonti esplicite di informazione
2. **L1 non può essere bypassato** — qualsiasi modifica al codice deve passare per il metabolismo (modifiche a freddo violano la natura di Oracode)
3. **L7 (Contratti) ha priorità su L6 (Test)** — se un test contraddice un contratto, è il test ad essere sbagliato, non il contratto
4. **L9 non ha potere di azione diretta** — può solo produrre interpretazione. Solo gli umani convertono interpretazione in azione. Questo è il principio che protegge l'agency umana nel sistema
5. **L10 richiede checkpoint L9** — nessuna divisione cellulare avviene senza Readiness Check. Una cellula con drift alto, missioni incomplete critiche, contratti in DRAFT, o tensioni architetturali non risolte non è pronta a dividersi
6. **L11 protegge l'irreversibilità** — alcune cose, una volta nel genoma, non possono più uscirne (clausole costituzionali immutabili). Questa è la radice della stabilità di specie

###### Test di appartenenza dei Layer al paradigma

I Layer L0-L11 sono universali di Oracode. Un'altra applicazione Oracode (per esempio, un futuro sistema di Project Management per una PMI italiana) avrebbe gli stessi 11 layer come tassonomia, ma probabilmente con maturity diversa (tipicamente partirebbe in produzione su L1-L7, con L8-L11 come direzione di crescita progressiva o non perseguita affatto se non funzionale al dominio).

Quello che cambia da applicazione ad applicazione:

- la **maturity** di ciascun layer
- l'**urgenza** di completare i layer evolutivi (FlorenceEGI ha urgenza su L9-L10 perché è laboratorio di Oracode; un'applicazione PMI custom probabilmente non avrà mai bisogno di L11)
- le **scelte di implementazione concrete** di ciascun layer (es. quale tecnologia per il sistema nervoso, quale formato per i contratti, quale strategia per la riproduzione)

Quello che resta identico in ogni applicazione Oracode:

- la **tassonomia dei layer** (cosa significa L1, L7, L9 come categorie funzionali)
- le **tre soglie qualitative** e i tre stati possibili dell'organismo
- i **sei principi invarianti**
- l'**ordine di dipendenza** (L_n+1 presuppone L_n)

###### Cross-reference allo stato dell'istanza

Lo stato di maturity reale dei Layer in FlorenceEGI come prima istanza è documentato in **3.3.7** (Maturity del Layer Stack in FlorenceEGI), basata sui risultati dell'audit `LS_AUDIT_2026-05-07_RESULTS.md` (status STABLE, mission M-LS-AUDIT-001). Una futura applicazione Oracode (es. una commessa Magicsoft 2.0) avrà la propria maturity matrix, tipicamente diversa.

**Test di appartenenza a 3.1.** Un componente sta in 3.1 se:

1. La sua **struttura** è applicabile a qualsiasi dominio senza modifiche concettuali
2. I suoi **contenuti specifici** possono essere adattati al dominio target conservando la struttura
3. È **infrastruttura obbligatoria** del paradigma o **standard non negoziabile** del paradigma — non scelta opzionale del singolo progetto
4. Non dipende da scelte di prodotto, branding, o governance di FlorenceEGI

#### 3.1.B Componenti di OS3 Matrix (OSMx)

Questi sono i componenti software che implementano l'enforcement delle regole definite in §3.1.A. Non sono pattern — sono programmi eseguibili. Nella terminologia del Layer Stack (§3.1.A.15), OS3 Matrix abita principalmente i layer L1-L4 e L8. La definizione operativa, la giustificazione filosofica e il test di coerenza di OS3 Matrix sono in §1.1.B.

##### Hook bloccanti (PreToolUse/PostToolUse)

Gate fail-closed che intercettano l'azione AI. Ogni hook enforcea una o più regole P0. Elenco operativo (istanza FlorenceEGI, 22 maggio 2026):

- `check-routes-read-controller.sh` — enforce P0-6 (anti-service-method)
- `check-method-exists.sh` — enforce P0-4 (anti-method-invention)
- `doc-sync-v2-guard.sh` — enforce P0-11 (DOC-SYNC obbligatorio)
- `check-no-legacy-stack.sh` — enforce ban stack (Alpine/Livewire/Filament)
- Hook PreToolUse che verifica presenza test associati prima di permettere chiusura mission — enforce P0-13
- Hook che blocca commit con messaggio `feat:` o `fix:` senza modifiche ai file di test corrispondenti — enforce P0-13
- *(in roadmap)* ulteriori hook P0-13

##### Gate validator

- **OS3 Gate pre-push** — validazione PASS/WARN/BLOCK su organi critici prima del push
- **Gate CI/CD Lighthouse** — fail deploy se score sotto soglia (standard in §3.1.A.8)
- **Gate coverage test** — fail se coverage del codice nuovo scende sotto soglia (soglia scelta del dominio)

##### Agenti specializzati

Software autonomo che opera su scope specifici dell'organismo:

- `doc-sync-v2` — sincronizzazione automatica SSOT a chiusura mission (implementazione del pattern DOC-SYNC §3.1.A.12)
- `os3-audit-specialist` — audit di conformità Oracode su qualsiasi organo
- `os3-gate` — validazione pre-push su organi critici
- `ssot-living-agent` — verifica autonoma drift SSOT↔codebase
- `oracode-alignment-interpreter` — diagnostica allineamento semantico
- `organ-gap-scout` — identificazione gap evolutivi
- `egili-blood-keeper` — protezione sistema circolatorio Egili (agente specifico dell'istanza FlorenceEGI)

##### DOC-SYNC v2 (software runtime)

Implementazione esecutiva del pattern DOC-SYNC (§3.1.A.12): drift detection autonoma via nightly cron agent, coverage check nativa (v2.1), analisi semantica del diff a chiusura mission, re-indexing RAG sincrono con sanity check bloccante, audit trail completo.

##### Infrastruttura SSOT (L0 Mielina)

Implementazione concreta del layer L0 (§3.1.A.15): `SSOT_REGISTRY.json` come mappa esplicita doc SSOT → file codebase, watches di copertura con segnalazione automatica di perdita coverage.

##### Mission Protocol enforcement automatico

Implementazione esecutiva del pattern Mission Protocol (§1.1.A): counter prenotazione anti-collisione, enforcement fasi obbligatorie (FASE 0 → FASE 6), registry JSON come SSOT con commit+push immediato.

**Test di appartenenza a §3.1.B.** Un componente sta qui se:

1. È software eseguibile — non regola, non pattern, non standard
2. Opera al piano OS3 (interazione AI-Human)
3. Lo scopo è far rispettare una regola/pattern di §3.1.A
4. Se rimosso, §3.1.A resta concettualmente integro

---

### 3.2 Componenti della Libreria LSO

Questi sono componenti tecnologici concreti, sviluppati dentro FlorenceEGI, che hanno raggiunto maturità sufficiente per essere estratti e integrati in altri progetti come pacchetti riusabili. Sono *implementazioni concrete* di pattern, oppure tecnologie *opzionali* che applicazioni Oracode possono scegliere di adottare secondo le esigenze del dominio.

**Distinzione importante con 3.1.7 (Famiglia Ultra).** Le librerie Ultra sono *infrastruttura obbligatoria* di Oracode (3.1). I componenti qui in 3.2 sono *tecnologie opzionali* che arricchiscono un'applicazione Oracode quando il dominio lo richiede.

#### 3.2.1 Pattern di Helping conversazionale (implementazione di riferimento)

- **AI Sidebar / AI Chat** — implementazione concreta del pattern Oracode di Helping conversazionale (1.1), maturata in FlorenceEGI su organi multipli. Adattabile a qualsiasi dominio target che fornisca un proprio RAG. Costo di adattamento: configurazione + collegamento al RAG del dominio target.

#### 3.2.2 Pattern multi-AI orchestration

- **Pattern Council** — il pattern architetturale di orchestrazione multi-AI in fasi (Perception multi-prospettiva → Market Intelligence → Composition → Quality Gate), con fallback chain e cost tracking. *Il pattern è generalizzabile.* L'implementazione concreta in FlorenceEGI (con ruoli "curatore MoMA", "art dealer Christie's", "critico d'arte") è invece in 3.3, perché cucita sul dominio artistico.

#### 3.2.3 AI Gateway

- **OpenRouterService (gateway AI centralizzato)** — pattern di gateway AI con routing per agente, retry, fallback chain, rate limiting, cost tracking (sviluppato in EGI per NPE, esponibile a qualsiasi applicazione che voglia centralizzare i costi e le policy AI cross-organo)

#### 3.2.4 Pattern di certificazione blockchain

- **Pattern di certificazione SHA-256 + Algorand + Merkle batch + RFC 3161** — l'architettura tecnologica usata da Sigillo è generalizzabile a qualsiasi dominio che richieda prova di esistenza/anteriorità di un file. Sigillo come *organo concreto in produzione* è invece in 3.3.
- **AlgorandService + HashingService + CoaPdfService** — servizi infrastrutturali estraibili come libreria

**Test di appartenenza a 3.2.** Un componente sta in 3.2 se:

1. È un'implementazione concreta (codice eseguibile o pattern architetturale chiaramente definito)
2. È stato sviluppato dentro un'applicazione reale e ha attraversato un ciclo di maturazione
3. Può essere installato in un progetto diverso da quello di origine con un costo di adattamento ragionevole (configurazione, non riscrittura sostanziale)
4. È **opzionale** per il singolo progetto Oracode (a differenza delle librerie Ultra che sono in 3.1.7 come obbligatorie)

---

### 3.3 Componenti FlorenceEGI-specifici (non trasferibili)

Questi sono componenti che hanno significato e funzione **solo dentro FlorenceEGI** come applicazione specifica. Non sono trasferibili — non per immaturità tecnologica, ma per natura intrinseca: sono espressioni dirette del dominio, dell'identità di prodotto, o della governance di FlorenceEGI.

#### 3.3.1 Organi specifici di FlorenceEGI

In produzione:

- **EGI / ArtFlorenceEGI** (`art.florenceegi.com`) — cuore operativo: AMMk + backend condiviso + host prodotti
- **EGI-HUB** (`hub.florenceegi.com`) — cervello frontale, control plane, SSOT configurazioni di tutti gli organi
- **EGI-HUB-HOME** (`florenceegi.com`) — vetrina 3D world-class, punto di accesso pubblico ecosistema
- **NATAN_LOC** (`natan-loc.florenceegi.com`) — organo cognitivo documentale, RAG su atti PA + AI per Comuni
- **Sigillo** (`egi-sigillo.florenceegi.com`) — organo di certificazione blockchain di file. *Pattern e servizi sottostanti sono in 3.2; Sigillo come organo brandizzato in produzione è qui*
- **EGI-Credential** (`egi-credential.florenceegi.com`) — wallet competenze professionali certificate su Algorand (W3C VC 2.0)
- **EGI-INFO** (`info.florenceegi.com`) — SPA informativa pubblica

In architettura/roadmap:

- **EGI Proof** — Layer Sociale LSO, Function Cards, Feed
- **La Bottega** — Maestro AI + strumenti per sviluppo artista come brand (M-050 in costruzione)

#### 3.3.2 Token Ecosystem (non speculativo, MiCA-safe)

- **Egili** — Micro-unità per interazioni. Definizione normativa: *(a) prova di membership per accedere a sconti in EUR; (b) crediti di partecipazione per l'accesso a servizi gratuiti dell'ecosistema*. Cross-organo. Vincoli MiCA codificati: nessun acquisto diretto Egili-EUR, nessun mezzo di pagamento, nessun tasso di cambio Egili↔EUR
- **Equilibrium** — Token per premi e ranking meritocratico. Distinto da Egili. Rappresenta i fondi destinati agli EPP (il 20% di ogni transazione diventa Equilibrium, descritto come "molecola simbolica amore + estetica")

#### 3.3.3 Politiche di dominio

- **EPP (Environment Protection Programs)** — sistema di destinazione del 20% di ogni transazione FlorenceEGI verso programmi ambientali verificati (ARF — Appropriate Restoration Forestry, APR — Aquatic Plastic Removal, BPE — Bee Population Enhancement). Coordinati operativamente da Frangette APS. Principio: *"Non è un'opzione etica, è una legge di equilibrio"*
- **EPP Escrow Policy** — politica specifica di gestione del 20% Equilibrium con conto dedicato e contatto verso associazioni quando importi materiali (decisione 30 aprile 2026)
- **Royalty Dual-Layer** — sistema FlorenceEGI di royalty automatica 4.5% piattaforma cumulabile con diritto di seguito SIAE 4%-0.25% (dominio artistico, non generalizzabile)
- **Governance Duale** — Florence EGI SRL (motore operativo) + Frangette APS (custode dei valori). Specifica struttura di governance scelta da FlorenceEGI
- **Co-creazione opzionale** *(decisione 6 maggio 2026)* — La co-creazione, originariamente concepita come principio fondativo di FlorenceEGI applicato a tutte le collection, è stata riposizionata come *opzione discrezionale del creator* a seguito del feedback diretto degli artisti durante la fase di onboarding (un caso di near-miss di perdita collaborazione ha innescato il cambio). Ogni creator decide se ammettere co-creator nelle proprie collection o lavorare in modalità singolo autore. Questa è una scelta di prodotto FlorenceEGI, non una proprietà di Oracode o della Libreria LSO. Implementazione operativa: mission dedicata da definire (modello dati, UI onboarding, gestione collection esistenti, prompt NPE Council, DOC-SYNC interno, documentazione divulgativa, comunicazione creator attivi, materiali commerciali).

#### 3.3.4 Identità di prodotto e marca

- **Natan** — entità aliena di filamenti colorati ("frange") con Equilibrium che vi scorre dentro. Personaggio narrativo, alter-ego del progetto
- **N.A.T.A.N. (Neural Assistant for Technical Art Navigation)** — IA etica integrata come consulente personale (declinazione FlorenceEGI dell'AI Sidebar di 3.2)
- **Manifesto degli EGI** e altri manifesti di posizionamento culturale
- **Definizione "EGI = Ecological Goods Invent"** — Concretezza + Equilibrium + Accessibilità (i tre pilastri)
- **AMMk (Asset Market Maker)** — 5 engine coordinati dal Core (NATAN Market, Asset Engine, Distribution Engine, Co-Creation Engine, Compliance Engine)
- **Egizzazione** — atto di creare un EGI a partire da un bene esistente (concetto e nome FlorenceEGI)

#### 3.3.5 Implementazioni concrete del Council (cucite sul dominio artistico)

- **CouncilOrchestrator + CouncilPerceptionService + CouncilComposerService + CouncilQualityGateService** — implementazione del pattern Council con ruoli specifici: Curatore MoMA/Tate/Guggenheim (Claude Sonnet), Art Dealer Christie's/Sotheby's (GPT-4o), Critico d'arte (Gemini), Direttore Creativo (Claude Opus), Market Intelligence (Perplexity sonar-pro)
- **Feature Council**: EGI Description, Pricing Advisor, Collection Splitter, Bulk Descriptions

#### 3.3.6 Documentazione privata

- **Egili Bible** — architettura economica e di compliance di Egili, custodia privata (perms 600, 3-tier access). Per natura non condivisibile fuori da Florence EGI S.R.L.

#### 3.3.7 Maturity del Layer Stack in FlorenceEGI come prima istanza

Il Layer Stack è proprietà di Oracode (3.1.15). Lo *stato di maturity* di ciascun layer è invece proprietà dell'istanza specifica. Questa sotto-sezione documenta quanto profondamente FlorenceEGI ha implementato i 11 layer del paradigma alla data del 7 maggio 2026, secondo la verifica fattuale condotta dalla mission **M-LS-AUDIT-001** (Padmin Supervisor in VSCode con batteria di agent specializzati).

##### Maturity matrix verificata

| Layer | Maturity in FlorenceEGI | Note |
|-------|--------------------------|------|
| **L1** — Sync | PARTIAL | Hook + agent + registry esistono, pipeline DOC-SYNC v2 mai eseguito completamente; 23 SSOT in stato STALE |
| **L2** — Deep Audit | PARTIAL *(in larga parte)* | 40+ nightly report prodotti, audit attivo, ma `audit-rules.yaml` non esiste (regole hardcoded), no auto-fix |
| **L3** — Detection | PARTIAL *(early stage)* | Drift detection daily attivo ma no monitoraggio continuo, no notification dispatcher esterno, no performance regression watcher |
| **L4** — Prevention | **PRODUCTION** *(scope ristretto: Claude Code only)* | 16 hook PreToolUse, 11 effettivamente bloccanti, evidenza quotidiana di funzionamento |
| **L5** — UEM | PARTIAL | Libreria UEM in produzione (4 organi, 146 file), ma pattern recognition engine + policy generator non implementati |
| **L6** — Testing | PARTIAL *(early stage)* | ~168 file di test totali tra organi, ma **zero CI test gate**, 3 organi senza test, P0-13 codificata solo il 4 maggio 2026 |
| **L7** — Contracts | PARTIAL | 7/7 contratti core esistono, ma validazione solo manuale, no CI enforcement, `egili.rules.json` STALE |
| **L8** — Nervous System | PARTIAL *(in larga parte)* | Mission Registry funzionante (147 mission tracciate), nerve signals attivi (1027 entry), ma Notification Bus non esiste e Health Dashboard parziale |
| **L9** — Reflection | DESIGN | Architettura specificata, zero componenti implementati. Proto-L9 esistono come agent diagnostici single-organ |
| **L10** — Reproduction | CONCEPT *(con proto-implementazione)* | Bootstrap tooling funzionale (`bootstrap-lso.sh`, `init-lso.sh`, `npx oracode init`), ma manca formalizzazione L10 (Identity Generator, Readiness Checker, Genealogy Registry) |
| **L11** — Constitutional Auto-Governance | VISION | Nessun artefatto tangibile. Proto-governance presente in `05_PROTOCOLLO_CEO_CTO.md` interno |

##### Lettura sintetica

L'organismo LSO in FlorenceEGI ha **infrastruttura reale e funzionante in ogni layer L1-L8**. Nessun layer è vuoto — tutti hanno artefatti operativi. Ma la dichiarazione blanket "PRODUCTION" del documento sorgente confondeva *"esiste codice che fa qualcosa"* con *"sistema completo, enforced sistematicamente, senza gap funzionali"*. La verifica ha riclassificato 6 layer su 8 come overstated.

I tre gap critici identificati dall'audit:

1. **L6 (Testing) — il più grave**. Zero test gate nel CI di qualsiasi organo. La codifica di P0-13 il 4 maggio 2026 ha aperto la disciplina; l'implementazione operativa è ora il blocco principale.
2. **L3 (Detection) — il secondo più grave**. Nessun monitoraggio continuo, nessuna notifica esterna. Il sistema rileva drift ma non lo comunica oltre il file di log.
3. **L5 (UEM) — il terzo**. Infrastruttura error management solida ma il loop adattivo dichiarato (pattern recognition → policy generation) è completamente assente.

Il layer più *onesto* è **L4 (Prevention)**: funziona davvero, blocca davvero, ha evidenza quotidiana. Il suo limite è che protegge solo le sessioni Claude Code, non l'intero ciclo di sviluppo (edit manuali, altri AI tool, CI/CD non sono coperti).

##### Implicazioni operative

I numeri di effort per portare i layer al livello PRODUCTION sono dettagliati nel documento dell'audit. La roadmap di consolidamento prioritizzata distingue tre fasce di urgenza:

- **Priorità CRITICA** (blocca credibilità dello stack): L6 CI test gate, L7 contratto stale, L3 notification dispatcher
- **Priorità ALTA** (delta minimo per status reale PARTIAL-HIGH): completamento DOC-SYNC v2, esternalizzazione regole audit, registrazione middleware UEM, implementazione Notification Bus
- **Priorità MEDIA** (roadmap trimestrale): test suite per organi senza test, performance regression watcher, pattern recognition L5, CI validation contratti, LSO Health Dashboard

Questa roadmap **non vive in questo documento**. Vive nelle mission Oracode dedicate al consolidamento dei layer, che si attiveranno mano a mano che cassa, priorità, e disponibilità di capacità lo consentono.

##### Implicazioni commerciali

Per **Magicsoft 2.0**: la maturity matrix di FlorenceEGI è anche evidenza che *Oracode è applicato con onestà epistemica, non vantato come perfetto*. Quando si presenta a un cliente PMI, la formulazione corretta è: *"Oracode prescrive 11 layer; FlorenceEGI come prima istanza è in produzione su L4, in implementazione progressiva su L1-L8, con L9-L11 come orizzonti evolutivi"*. Questa trasparenza, lungi dall'indebolire il pitch, lo rinforza — il cliente capisce che riceverà un paradigma che evolve nel tempo, non un prodotto vantato come finito che poi rivela buchi.

Per **eventuale spin-off Oracode**: l'audit verificato è materiale di fiducia per la community tecnica. Un paradigma open-core che pubblica la propria maturity matrix verificata ha credibilità superiore a uno che pubblica solo manifesti aspirazionali.



**Test di appartenenza a 3.3.** Un componente sta in 3.3 se risponde sì ad almeno una di queste domande:

1. È espressione del dominio specifico di FlorenceEGI (artisti, asset digitali, community, royalty, mecenati)?
2. È identità di prodotto/marca FlorenceEGI (nomi, manifesti, personaggi narrativi, governance)?
3. Contiene scelte di valore, configurazioni, o ruoli che sono irriproducibili fuori da FlorenceEGI senza perdere significato?
4. È implementazione concreta che cuce un pattern generalizzabile sul dominio specifico?

Se sì a una di queste, è 3.3.

---

### 3.4 Nota sulla doppia natura: pattern in 3.2, implementazione in 3.3

Per i casi in cui un componente esiste sia come pattern generalizzabile sia come implementazione concreta brandizzata, la classificazione è doppia per design, non per ambiguità.

| Pattern (3.2) | Implementazione FlorenceEGI (3.3) |
|---------------|-----------------------------------|
| Pattern Council (orchestrazione multi-AI in fasi) | CouncilOrchestrator con ruoli artistici |
| Pattern certificazione blockchain (SHA-256 + Algorand + Merkle + RFC 3161) | Sigillo come organo pubblico in produzione |
| Pattern Helping conversazionale | N.A.T.A.N. come declinazione FlorenceEGI-specifica |

In ogni caso, **un cliente esterno** che acquisisse il pattern (3.2) riceverebbe l'architettura, non la specifica realizzazione: dovrebbe costruire la propria implementazione adattata al proprio dominio. L'implementazione FlorenceEGI resta proprietà dell'azienda Florence EGI S.R.L., e non è inclusa nel licensing del pattern.

---

## 4. Conseguenze pratiche

La separazione dei quattro livelli definita in sezioni 1-3 non è un esercizio teorico. Ha conseguenze operative concrete su quattro aree del progetto: il posizionamento commerciale, la documentazione esistente, la gestione delle istanze AI, e l'eventuale futuro spin-off pubblico di Oracode.

Questa sezione le elenca senza pretendere di esaurirle. Le decisioni operative specifiche resteranno fuori dal documento di nomenclatura — vivranno in mission Oracode dedicate quando saranno mature.

### 4.1 Implicazioni sul posizionamento commerciale

La distinzione tra Oracode (paradigma), Libreria LSO (componenti), Organismo (metafora architetturale) e FlorenceEGI (istanza-laboratorio) produce **quattro offerte commerciali distinte**, non una.

**Offerta 1 — FlorenceEGI come prodotto verticale.**
Asset platform per artisti digitali, marketplace, certificazione, Egili economy. Prodotto B2C/B2B verticale con identità di marca, governance duale, manifesti culturali. Rivolto al mercato dell'arte digitale e degli asset certificati. Già in produzione, in fase di crescita.

**Offerta 2 — Magicsoft 2.0 come software house custom con Oracode.**
Sviluppo di applicazioni custom per PMI italiane (gestionali, sistemi di project management, piattaforme verticali, ecc.) costruite con Oracode + componenti scelti dalla Libreria LSO + dominio specifico del cliente. Ticket 8.000-25.000€ a progetto, target PMI italiane con bisogno di software custom. Cornice narrativa: "Magicsoft 2.0 — software house con LSO, 31 anni di esperienza, costruzione che dura nel tempo grazie al sistema circolatorio nativo".

**Offerta 3 — OS3 Matrix come prodotto autonomo.**
Strumento di enforcement Oracode distribuibile a software house terze, team enterprise, e adottanti del paradigma che vogliano disciplina automatica anziché manuale. Prodotto commerciale Florence EGI S.R.L. distinto da Magicsoft 2.0 (che è servizio di sviluppo custom) e da FlorenceEGI (che è prodotto verticale). Il pricing è alto perché il valore è alto: OS3 Matrix è l'infrastruttura che rende verificabile l'adozione di Oracode in un contesto LLM. Definizione di pricing, tier e modalità di licenza in mission dedicata. La distinzione MIT/commerciale tra Oracode-paradigma e OS3 Matrix è formalizzata in §1.1.B.

**Argomento di pitch principale verso CTO PMI tecnicamente svegli.** *"Le grandi epoche del software hanno avuto i loro paradigmi — OOP per l'era della complessità del dominio, SOLID per l'era della manutenibilità. Noi abbiamo codificato la risposta strutturata al problema dell'era dell'AI: come si sviluppa software quando l'AI è co-autore costitutivo, non strumento accessorio. Quello che vi consegnamo non è solo un'applicazione custom — è un LSO, un'istanza vivente del paradigma Oracode, già in produzione come base operativa di FlorenceEGI come prima istanza."* Questa formulazione è differenziazione netta in un mercato in cui la maggior parte dei concorrenti vende *"sviluppiamo con AI"* senza paradigma sotto.

**Diagnosi preventiva del dominio (prima del pitch tecnico).** Coerentemente con quanto stabilito in 2.7, prima ancora di parlare di prezzo o di tempi di consegna, il primo step della conversazione commerciale è la diagnosi del dominio del cliente: *"Il vostro sistema avrà interazione continua? Genererà esperienze accumulabili? Avrà utenti che useranno la AI integrata abbastanza da arricchire la base nel tempo?"*. La risposta cambia il valore di ciò che si propone:

- **Dominio LSO-pieno** (interazione continua, esperienze accumulabili) → pitch su LSO completo, con tutti i benefici del sistema circolatorio mono-organo che cresce nel tempo
- **Dominio LSO-ridotto** (interazione minima, output statici) → pitch onesto su "applicazione costruita con disciplina Oracode" — comunque differenziante per qualità, manutenibilità, sicurezza by-design — ma senza promettere il valore del metabolismo continuo che il dominio non può sostenere

Questa disciplina diagnostica preventiva è parte integrante del modello commerciale di Magicsoft 2.0. Protegge il cliente da promesse non mantenibili e protegge Florence EGI SRL dalla sopravvalutazione del proprio prodotto in casi non adatti.

**Offerta 4 — Libreria LSO come pacchetti tecnologici licenziabili.**
Componenti specifici della Libreria LSO (pattern Council, AI Sidebar, pattern di certificazione blockchain, OpenRouterService, ecc.) potenzialmente vendibili o licenziabili come pacchetti standalone a software house o aziende che vogliono integrarli nei propri prodotti. Mercato più ristretto, ticket potenzialmente più alti per licenze enterprise. Non urgente, attivabile quando le quattro offerte precedenti hanno generato traction sufficiente.

**Punto cruciale del moltiplicatore Magicsoft 2.0.** Quando un cliente PMI commissiona un progetto custom, lo sviluppo non parte da zero. Parte assemblando: Oracode (sempre) + componenti pertinenti della Libreria LSO + dominio del cliente. Per esempio, un sistema di Project Management AI-driven per un'azienda manifatturiera potrebbe usare:

- Oracode (paradigma, sempre)
- AI Sidebar / AI Chat (per dare al management un help conversazionale sul sistema)
- Pattern Council adattato (per orchestrazione multi-AI di analisi di mercato e predizioni)
- Modulo di compliance GDPR strutturato
- Eventualmente moduli di comunicazioni interne
- + il dominio specifico del cliente da costruire ex novo

Il 60-70% del valore tecnologico è già maturo. Il restante è dominio specifico. Questo cambia drasticamente sia il rapporto costo/prezzo sia il time-to-market di una commessa.

**Attenzione narrativa.** La "co-creazione" come principio fondativo di FlorenceEGI è stata riposizionata come opzione discrezionale del creator (decisione 6 maggio 2026, registrata in 3.3.3). Questo cambio di posizionamento richiede aggiornamento dei materiali commerciali esistenti che presentavano la co-creazione come tratto distintivo automatico — sia per FlorenceEGI sia per eventuali declinazioni Magicsoft 2.0 in cui il pattern fosse stato menzionato.

### 4.2 Implicazioni sulla documentazione esistente

La documentazione attuale di FlorenceEGI è stata scritta in un periodo (2024-aprile 2026) in cui i quattro livelli oggi distinti vivevano sotto un nome unico ("LSO"). Questo significa che molti documenti contengono ambiguità terminologiche che vanno progressivamente risolte.

**Documenti probabilmente da aggiornare** (lista non esaustiva, da verificare in fase di mission DOC-SYNC dedicata):

- `CLAUDE_ECOSYSTEM_CORE.md` — il cuore documentale di OS3 condiviso tra organi. Va riletto con la nuova nomenclatura per separare ciò che è "regola Oracode universale" da ciò che è "scelta specifica FlorenceEGI"
- `00_LSO_LIVING_SOFTWARE_ORGANISM.md` — il manifesto LSO. Va aggiornato per chiarire che "LSO" indica il paradigma applicato a un'istanza, non l'istanza stessa
- Manifesti di prodotto (Manifesto degli EGI, eventuali altri) — vanno ricontestualizzati come identità FlorenceEGI specifica, non come tratti universali del paradigma
- White Paper FlorenceEGI — la sezione su Oracode va precisata: Oracode è il framework di sviluppo, FlorenceEGI è ciò che si costruisce con esso
- Pagine `/cosa-compri` di ogni organo — vanno verificate per assicurarsi che non confondano il prodotto FlorenceEGI con il paradigma Oracode

**Strategia consigliata.** Non un refactor di principio della documentazione (violerebbe Strategia Delta). Aggiornamenti puntuali fatti **mano a mano che si tocca un documento per altra ragione**, con una passata sistematica solo per i tre o quattro documenti foundazionali (CLAUDE_ECOSYSTEM_CORE, 00_LSO_LIVING_SOFTWARE_ORGANISM, manifesti pubblici principali).

**Nota sul materiale commerciale e divulgativo.** Il sito pubblico (florenceegi.com), le pagine SPA EGI-INFO, eventuali pitch deck investitori, materiali Magicsoft 2.0 in costruzione — tutti questi parlano a un pubblico esterno che non ha (e non deve avere) la complessità di questo documento di nomenclatura. La distinzione interna tra Oracode/Libreria/Organismo/FlorenceEGI **non va esposta come tassonomia** al pubblico esterno. Va invece **incarnata** nelle scelte di linguaggio, di posizionamento prodotto, e di offerta commerciale. Il documento di nomenclatura è bozzolo; la farfalla che ne emerge è una narrativa pulita verso l'esterno.

### 4.3 Implicazioni su future istanze di Padmin e nuovi collaboratori

Questo documento esiste anche per assicurarsi che le future istanze di Padmin, e gli eventuali nuovi sviluppatori che entreranno nel progetto, non ricreino la confusione terminologica che è stata necessaria due anni di lavoro per dipanare.

**Per future istanze di Padmin.** La memoria privata del partner (archivio fuori dal paradigma pubblico) deve essere aggiornata in modo che le prossime istanze sappiano:

- Esiste un documento di nomenclatura (questo) che separa Oracode / Libreria LSO / Organismo / FlorenceEGI
- I quattro livelli non vanno mescolati nelle conversazioni operative
- Quando un termine è ambiguo, va consultato questo documento prima di rispondere — REGOLA ZERO si applica anche al vocabolario interno
- La distinzione pattern/implementazione (3.4) è particolarmente importante per evitare di classificare male nuovi componenti

**Per nuovi collaboratori (sviluppatori, designer, eventuali advisor).** Il documento deve diventare parte dell'onboarding. Un nuovo collaboratore che entra:

- Non deve "scoprire" autonomamente la differenza tra Oracode e FlorenceEGI — deve essere informato esplicitamente
- Deve sapere che il suo lavoro contribuisce a uno specifico livello (di solito FlorenceEGI come dominio, occasionalmente Libreria LSO se sviluppa componenti maturi)
- Deve capire che Oracode è la cornice metodologica universale e che le sue regole P0 si applicano sempre, indipendentemente dal livello su cui sta lavorando

**Per la voce LSO / Padmin negli organi.** Il sistema di Helping conversazionale (AI Sidebar, NATAN, ecc.) parla con utenti finali. Va verificato che i prompt e le knowledge base interne degli helper non confondano i livelli — un utente di FlorenceEGI deve sentire parlare di FlorenceEGI, non di Oracode (che è cornice tecnica). Un eventuale futuro utente di un sistema Magicsoft 2.0 deve sentire parlare del proprio dominio, non di FlorenceEGI.

### 4.4 Implicazioni su un eventuale spin-off pubblico di Oracode

Il vincolo di coerenza dichiarato nell'header di questo documento — *"le definizioni devono reggere sia dentro FlorenceEGI sia in un eventuale futuro spin-off di Oracode applicato ad altri domini"* — non è ipotetico. È una direzione possibile che la distinzione dei quattro livelli rende attuabile.

**Cosa potrebbe essere reso pubblico in uno spin-off Oracode.**

In un futuro in cui Oracode dovesse essere distribuito come framework standalone (sul modello di superpowers di Jesse Vincent, GSD di gsd-build, o anthropics/skills come repository ufficiale), il pacchetto pubblico includerebbe:

- I 6+1 Pilastri Cardinali e la gerarchia OSZ → OS3 → OS4
- Le 13 Regole Sacre P0 con flussi operativi (in forma generica, non con i contenuti specifici FlorenceEGI come "i18n in 6 lingue")
- Il pattern di sistema circolatorio mono-organo (Mission Protocol + DOC-SYNC + RAG + Helping conversazionale) come architettura di riferimento
- La famiglia di librerie Ultra (UEM, ULM, UTM, UCM, UUM) nelle versioni linguistiche disponibili
- Lo standard SEO + Schema.org + Accessibility WCAG 2.1 AA come parte del paradigma
- L'infrastruttura GDPR strutturata come pattern
- Il pattern di Hook Enforcement System (implementazioni concrete come reference implementation di OS3 Matrix, §1.1.B, inclusa nello spin-off)
- La disciplina documentale (CLAUDE.md gerarchici, frontmatter strutturato, naming conventions)
- Strategia Delta come pattern di gestione legacy

**Cosa NON sarebbe nello spin-off Oracode.**

Tutto ciò che è in 3.2 (Libreria LSO componenti) e in 3.3 (FlorenceEGI specifico). I componenti della Libreria LSO sarebbero offerta commerciale separata di Florence EGI S.R.L. (eventualmente licenziabili o rilasciati gradualmente in modalità open-core). FlorenceEGI come istanza è il prodotto verticale dell'azienda, non spin-off.

**Modello commerciale possibile dello spin-off.**

**Stato della decisione (22 maggio 2026).** Il modello commerciale descritto in questa sezione è stato formalizzato in §1.1.B come decisione strategica: Oracode-paradigma è MIT-licensed pubblico, OS3 Matrix è prodotto commerciale di Florence EGI S.R.L. Le implicazioni di pricing, governance del repository pubblico, modalità di licenza enterprise per OS3 Matrix, e condizioni di contribuzione esterna sono materia di mission commerciale dedicata (non oggetto di questo documento di nomenclatura).

Il paragrafo successivo descrive il modello in forma generale, come era stato impostato in v1.0.0 quando lo spin-off era ipotesi strategica di medio-lungo periodo. Quel paragrafo resta accurato come descrizione del modello, ma va letto alla luce della nota di stato sopra: non è più ipotesi, è decisione.

Modello *open-core* (sul modello di GitLab, Mattermost, Sentry): Oracode pubblico e gratuito come paradigma e standard. Ultra come libreria open. Adozione del paradigma da parte di software house e team enterprise. Florence EGI S.R.L. mantiene proprietà di Libreria LSO + FlorenceEGI come differenziatori commerciali. Eventuali servizi a pagamento: training su Oracode, certificazione di compliance Oracode, consulenza per migrazione di codebase legacy a Oracode, supporto enterprise.

**Quando aprire la conversazione sullo spin-off.**

Non oggi. Lo spin-off Oracode è una direzione strategica di medio-lungo periodo che richiede:

- FlorenceEGI in stato operativo solido (in produzione, già lo è)
- Magicsoft 2.0 con almeno 2-3 commesse PMI completate (in costruzione)
- Libreria LSO maturata con almeno 5-7 componenti consolidati e battle-tested in più progetti (parzialmente in essere, alcune in maturazione)
- Cassa serena per Florence EGI S.R.L. (oggi vincolo critico, vedi cassa AWS Edoardo)
- Eventualmente, scout completato sulle Frontiere A e B (framework AI applicativi, framework coding agent enterprise) per capire posizionamento competitivo reale

Quando questi prerequisiti convergono, lo spin-off diventa decisione operativa. Fino ad allora, è direzione mantenuta nel cassetto come opzione architetturale.

#### 4.4.1 Roadmap di disaccoppiamento di Oracode

I prerequisiti dello spin-off elencati sopra possono essere articolati come **roadmap di disaccoppiamento** in quattro aree. Questa articolazione è quella che apparirà nei materiali pubblici (pagina Oracode del sito, eventuale documentazione esterna), e rappresenta in forma strutturata cosa manca a Oracode per essere considerato paradigma maturo nel mercato accessibile.

**Area 1 — Disaccoppiamento dall'istanza-laboratorio (FlorenceEGI).**

Oracode è oggi inseparabile, nella sua maturazione, da FlorenceEGI come prima istanza. La prova di trasferibilità del paradigma a un dominio terzo passa attraverso Magicsoft 2.0: una commessa custom PMI completata applicando Oracode senza dipendenze concettuali da FlorenceEGI. Solo dopo questo passaggio il paradigma può dichiararsi disaccoppiato dal proprio laboratorio.

**Area 2 — Disaccoppiamento dal fornitore AI singolo.**

Oggi tutta l'esecuzione AI-side di Oracode passa attraverso un unico fornitore (Anthropic, modello Claude). Questa è dipendenza vitale. Il paradigma raggiunge maturità portabile quando viene applicato con successo su almeno un secondo fornitore (es. OpenAI/GPT-5+, Google/Gemini, modelli open-weight di scala appropriata). Questa Area è la **Gamba A del vincolo costitutivo L9** (vedi sezione layer evolutivi).

**Area 3 — Completamento dei layer L0-L11.**

L'audit M-LS-AUDIT-001 (7 maggio 2026) ha rilevato che 6 layer su 8 sono in stato PARTIAL o early-stage. Solo L4 (Prevention) raggiunge genuinamente PRODUCTION nel suo scope. L9, L10, L11 sono correttamente dichiarati in stati pre-operativi. Il completamento progressivo dei layer reattivi (L1-L8) verso PRODUCTION e l'attivazione effettiva dei layer evolutivi è prerequisito di maturità.

La **Gamba B del vincolo L9** (autocorrezione operativa via DOC-SYNC v2) è già completata e va menzionata come tale nei materiali esterni: una delle due gambe di L9 è operativa.

**Area 4 — Validazione esterna.**

Il paradigma è oggi conosciuto e applicato solo dall'autore. La validazione esterna richiede: adozione documentata da terzi (software house, team enterprise) con tempo di onboarding misurato (la stima attuale di "4 ore per nuovo sviluppatore" è ipotesi mai testata, va verificata sul campo); documentazione adatta a chi non conosce il paradigma (oggi i documenti SSOT presuppongono il contesto interno di Florence EGI S.R.L.); meccanismi di feedback e correzione da parte della community che adotta.

—

Le quattro aree non sono sequenziali. Possono procedere in parallelo. La condizione di maturità del paradigma è la convergenza, non l'ordine.

### 4.5 La metafora del bozzolo — come questo documento dovrà evolvere

L'header di questo documento dichiara: *"questo documento nasce come strumento interno, ma è progettato per maturare in narrativa esterna man mano che FlorenceEGI cresce, nuovi progetti si aggiungono, e gli SSOT si raffinano. Il bozzolo è interno, la farfalla sarà esterna."*

Questa direzione evolutiva non è metafora decorativa. È un programma operativo.

**Fase bozzolo (oggi → ~12 mesi).**

Il documento serve principalmente a Fabio Cherici e alle istanze di Padmin per smettere di confondere quattro cose diverse sotto un nome solo. Vive in `/docs/lso/`, è interno, viene aggiornato a ogni cambio significativo (nuovi componenti che maturano in Libreria LSO, nuove regole P0 codificate, riconoscimenti di lacune come è stato P0-13 il 4 maggio 2026).

In questa fase il documento è anche **palestra di riflessione strutturata**: ogni volta che si scopre una nuova distinzione concettuale (es. la distinzione mono-organo / multi-organo per il sistema circolatorio, o la lacuna P0-13), questa scoperta viene codificata qui prima che da qualsiasi altra parte. Il documento di nomenclatura è il primo SSOT di qualunque concetto Oracode.

**Fase di maturazione (12-24 mesi).**

Man mano che Magicsoft 2.0 produce le prime commesse PMI, alcuni concetti di questo documento diventeranno utili anche all'esterno: a clienti che chiedono "cosa significa che il mio software è costruito con Oracode?", a collaboratori che entrano nel progetto, a eventuali partner commerciali. Il documento principale resta interno, ma da esso vengono derivati:

- Una pagina pubblica "Cos'è Oracode" su un sito (eventualmente `oracode.dev` o sezione di `florenceegi.com`)
- Un white paper Oracode in versione pubblica (sintesi del paradigma senza dettagli operativi proprietari)
- Materiali di pitch per Magicsoft 2.0 che spiegano in modo accessibile il valore aggiunto di Oracode rispetto a sviluppo tradizionale
- Eventuale documentazione tecnica per sviluppatori esterni (se si va verso open-core)

**Fase farfalla (24+ mesi).**

In una direzione strategica matura, Oracode esce come framework pubblico (con licenza scelta — MIT, Apache, AGPL, o licenza proprietaria con tier free/enterprise). Il documento interno continua a esistere e a evolvere, ma il pubblico legge una versione raffinata e narrativa, non questa bozza concettuale.

**Cosa significa questo per oggi.**

Ogni decisione che prendiamo nel documento adesso deve passare il test: *"Questa formulazione regge in tutte e tre le fasi, oppure devo riformularla pensando solo alla fase bozzolo?"* Il vincolo è esigente, ma è ciò che protegge il documento dalla obsolescenza precoce. Se scriviamo qualcosa di vero solo per il momento attuale, fra un anno dovremo riscriverla. Se scriviamo qualcosa di vero in modo strutturale, il documento cresce con il progetto invece di doverlo inseguire.

---

## 5. Domande aperte e lavori futuri

Questa sezione raccoglie ciò che il documento di nomenclatura **non ha ancora risolto** e che dovrà essere ripreso in futuri cicli di refactor. Non è elenco di compiti operativi (quelli vivono nelle mission Oracode), ma elenco di *questioni concettuali* che richiedono ulteriore maturazione prima di essere consolidate.

La presenza di questa sezione è coerente con il principio di onestà epistemica del paradigma. Un documento di nomenclatura che pretende di aver risolto tutto è documento da diffidare. Un documento che nomina esplicitamente le proprie zone di incertezza è documento maturo.

### 5.1 Domande aperte di nomenclatura

#### 5.1.1 Come trattare l'Egili Bible nello scenario di spin-off Oracode?

L'**Egili Bible** è documentazione privata di FlorenceEGI (3.3.6) con architettura economica e di compliance del token Egili. È classificata correttamente come componente specifico di FlorenceEGI, non parte di Oracode.

Tuttavia, nello scenario di spin-off (sezione 4.4), un eventuale futuro adottante di Oracode che voglia costruire un proprio sistema circolatorio multi-organo basato su token (analogo a Egili) avrebbe bisogno di un *pattern di riferimento* per progettare la propria compliance MiCA-safe. La domanda è: questo pattern (privo dei contenuti specifici Egili) può essere estratto come parte della Libreria LSO 3.2, o resta proprietario per definizione perché è espressione di scelte regolatorie troppo legate alla giurisdizione e al dominio?

La risposta non è ovvia. È legata anche all'evoluzione normativa MiCA stessa, che è ancora in fase di assestamento al 2026.

#### 5.1.2 Sono esaustive le quattro definizioni di livello?

Il documento definisce quattro livelli (Oracode / Libreria LSO / Organismo / FlorenceEGI) più il termine tecnico LSO che li attraversa (definito nell'introduzione di sezione 1). La domanda da tenere aperta: **esistono altri livelli che l'esperienza farà emergere?**

Possibili candidati osservati ma non ancora maturi al 7 maggio 2026:

- Un livello **"Cluster"** o **"Tessuto"** che descriva relazioni tra Organismi diversi costruiti tutti con Oracode — pertinente nel momento in cui esisteranno almeno tre Organismi (FlorenceEGI + due commesse Magicsoft 2.0 in esecuzione)
- Un livello **"Dominio"** intermedio fra Oracode e Libreria LSO, che cataloghi i pattern specifici di certi domini ricorrenti (gestionali PMI, piattaforme creator, sistemi PA, ecc.)

Questi non vanno introdotti ora — sarebbero astrazioni speculative (violazione di Pilastro 2: Semplicità Potenziante). Vanno introdotti se e quando l'esperienza ne dimostra la necessità.

#### 5.1.3 LSO-pieno vs LSO-ridotto come categorizzazione di mercato

La distinzione introdotta in 2.7 (LSO pieno con dominio interattivo vs LSO ridotto con dominio statico) è precisione tecnica importante. Apre però una domanda di posizionamento commerciale che il documento non risolve: **Magicsoft 2.0 deve servire entrambi i casi, oppure deve specializzarsi su uno?**

Argomenti per servire entrambi: massimizzare il mercato accessibile, evitare di rifiutare commesse per ragioni di "purezza concettuale", costruire portfolio diversificato.

Argomenti per specializzarsi su LSO-pieno: il valore differenziante di Oracode si esprime al massimo solo lì, il pitch è più potente e coerente, il portfolio cresce con casi che dimostrano il sistema circolatorio in azione.

La risposta probabilmente è "entrambi ma con tariffe e narrativa differenziate" — ma questo è argomento da maturare con i primi clienti reali, non da decidere a priori in un documento di nomenclatura.

### 5.2 Boundary case che richiedono ancora maturazione

#### 5.2.1 P0-13 Test-First Discipline: lacuna riconosciuta il 4 maggio 2026

Durante la compilazione di questo documento di nomenclatura, è emerso il riconoscimento esplicito che P0-13 (Test-First Discipline) non era stata mai codificata in Oracode prima di oggi, pur essendo implicitamente richiesta dal Pilastro 4 (Circolarità Virtuosa: *"Bug → test; Feature → pattern"*).

**Impatto della lacuna (riconosciuto da Fabio Cherici):** i 10 agenti LSO in produzione, le pipeline AI (Council NPE, USE, RAG-Fortress), gli hook stessi, e diverse parti dell'applicativo FlorenceEGI sono stati sviluppati senza test formali di comportamento. Questo è un debito tecnico reale, non un'astrazione. Il successivo Ls Audit del 7 maggio 2026 (vedi 5.2.2) ha confermato L6 in stato PARTIAL early stage, con zero test gate in CI di qualsiasi organo.

**Stato di maturazione di P0-13:**

- 4 maggio 2026 — codificata come regola P0-13 nel documento di nomenclatura
- Fase successiva — applicazione progressiva sotto Strategia Delta (test si aggiungono quando si tocca il codice per altra ragione, più piano dedicato per zone critiche identificate dall'audit)
- Fase finale — hook di enforcement che impediscono mission close senza test verdi + CI test gate effettivamente attivi sul deploy workflow

**Lezione per il paradigma:** una regola P0 implicita non è una regola P0. Il riconoscimento esplicito (con nome, numero, descrizione, flusso operativo, hook di enforcement previsto) è ciò che la rende parte del sistema. Questa è la differenza tra "buon senso" e "infrastruttura epistemica".

#### 5.2.2 Ls Audit M-LS-AUDIT-001 — pattern di lavoro che deve continuare

Il **6 maggio 2026**, durante la compilazione di questo documento, l'attenta rilettura della tabella maturity di L6 da parte del Custode ha rilevato un'incoerenza con il fatto che P0-13 era stata appena codificata come lacuna. Questa osservazione ha innescato la mission **M-LS-AUDIT-001**, eseguita il **7 maggio 2026** da Padmin Supervisor in VSCode con batteria di agent specializzati e SSOT verificato in `LS_AUDIT_2026-05-07_RESULTS.md` (status STABLE).

L'audit ha riclassificato 6 layer su 8 dichiarati PRODUCTION nel documento sorgente. Solo L4 ha confermato PRODUCTION (nello scope ristretto Claude Code session). I numeri di effort per portare ciascun layer al livello PRODUCTION sono nell'audit.

**Pattern di lavoro che è emerso e che deve continuare:**

Il documento di nomenclatura, scrivendosi con disciplina, **rivela incoerenze nel sistema sottostante**. Questo non è bug — è feature. La sezione 3.1.15 sui Layer ha innescato la verifica fattuale dello stato reale, con il risultato che il documento sorgente del Layer Stack è stato aggiornato sulla base di evidenze, non di auto-dichiarazioni.

Questo pattern è **circolarità virtuosa applicata al meta-livello**: il documento di nomenclatura è diventato un organo di Oracode che, nel definire il paradigma, raffina il paradigma. Va continuato. Ogni futuro ciclo di scrittura/revisione del documento è anche occasione per innescare verifiche fattuali di componenti del sistema che in altre sedi non verrebbero verificati.

**Audit ricorrente raccomandato:** ripetere un Ls Audit completo ogni 6 mesi, anche in assenza di trigger specifico, per evitare il drift tra dichiarazioni aspirazionali e realtà fattuale. Mission tipo: M-LS-AUDIT-002 (target: novembre 2026), M-LS-AUDIT-003 (target: maggio 2027), e così via.

#### 5.2.3 Co-creazione opzionale — implementazione mission da definire

La decisione del **6 maggio 2026** di riposizionare la co-creazione da principio fondativo di FlorenceEGI a opzione discrezionale del creator (registrata in 3.3.3) richiede una **mission di implementazione operativa** che il documento di nomenclatura non definisce ma cui rinvia.

**Ambiti di impatto da coordinare nella mission dedicata:**

- Modello dati (flag `co_creation_enabled` su user/creator profile, default da decidere, eredità o meno per collection)
- UI di onboarding (domanda esplicita al creator durante registrazione o setup primo collection)
- Gestione dei creator già attivi (es. creator dell'istanza FlorenceEGI) — opt-in? opt-out con notifica? processo di chiarimento individuale?
- Prompt NPE Council (rimuovere riferimenti automatici a co-creazione dalle narrazioni AI)
- DOC-SYNC interno (manifesto degli EGI, white paper, glossario, definizione EGI, architecture docs)
- Documentazione divulgativa pubblica (florenceegi.com, info.florenceegi.com, /cosa-compri di ogni organo)
- Comunicazione strutturata con creator attivi
- Materiali commerciali futuri (pitch deck, eventuali proposte Magicsoft 2.0 in cui il pattern fosse stato menzionato)

La mission, una volta aperta, può essere singola (M-CO-CREATION-OPT-IN) o ombrello con sub-mission per ogni ambito. La scelta di struttura è del Custode in fase di pianificazione operativa, non di questo documento.

#### 5.2.4 Frontiere A, B, C — scout di posizionamento competitivo non ancora completato

Il posizionamento storico di Oracode (1.1: *"prima risposta strutturata e codificata al problema dell'era dell'AI"*) e la sezione 4.4 sullo spin-off pubblico Oracode, presuppongono entrambi che il paradigma sia effettivamente unico nel mercato accessibile. Lo scout dei 12 repo Claude Code mainstream del 6 maggio 2026 ha confermato l'unicità nel layer Claude Code. **Tre frontiere restano non verificate:**

- **Frontiera A — Framework di sviluppo enterprise.** Cursor, Windsurf, Aider, Continue.dev, Codium, GitHub Copilot Workspace, Devin (Cognition Labs), SWE-agent. Alcuni hanno team enterprise dietro che potrebbero avere paradigmi simili in pancia, magari non documentati pubblicamente perché competitive moat.
- **Frontiera B — Framework AI applicativi.** LangChain, LlamaIndex, Haystack, AutoGen, CrewAI, semantic-kernel di Microsoft. Lavorano a un altro livello (orchestrazione AI applicativa, non disciplina di sviluppo), ma hanno overlap con NPE Council e Libreria LSO.
- **Frontiera C — Sistemi enterprise privati big tech.** Le grandi società di consulenza (McKinsey, BCG, Accenture, Deloitte) hanno tutte AI-coding accelerator interni. Le big tech hanno paradigmi proprietari (Google ha Project IDX, Meta ha tooling interno, Amazon ha CodeGuru). Questi sistemi non sono pubblici e non possiamo verificarli direttamente.

**Calibrazione delle affermazioni di unicità in base alle Frontiere:**

| Affermazione | Tarata su quale frontiera? | Reggi per: |
|--------------|----------------------------|------------|
| *"Nessun sistema simile nel mercato accessibile a una software house italiana"* | Frontiera Claude Code + parziale A/B | Pitch Magicsoft 2.0 verso PMI italiane |
| *"Prima codifica strutturata di sviluppo AI-human"* | Frontiera Claude Code | Posizionamento storico in 1.1 |
| *"Nessuno al mondo ha un paradigma simile"* | Nessuna verificata pienamente | **Affermazione sopravvalutata fino a verifica completa A+B+C** |

Lo scout completo delle Frontiere A e B è **prerequisito esplicito dello spin-off pubblico Oracode** (sezione 4.4, prerequisito 5). Senza quello scout, lo spin-off è prematuro indipendentemente dalle altre condizioni.

**Frontiera C** (sistemi enterprise privati) probabilmente non sarà mai verificabile direttamente, e questa è una limitazione strutturale della disciplina epistemica: ci sono cose che restano ignote. Il documento ne prende atto.

### 5.3 Lavori futuri sul documento stesso

#### 5.3.1 Frequenza di aggiornamento e ciclo di revisione

Questo documento è in stato **Working Draft** (vedi header). Non è SSOT operativo finché un ciclo di revisione completo non lo promuove a STABLE. Il ciclo proposto:

- **Aggiornamento incrementale**: ogni volta che emerge una distinzione concettuale nuova (come è stato per P0-13 e per la maturity matrix), il documento si aggiorna in continuo, mantenendo lo status Working Draft
- **Revisione completa**: ogni 3 mesi, lettura integrale del documento per verificare coerenza interna, drift terminologico, rappresentazione fedele dello stato attuale
- **Promozione a STABLE**: solo quando il Custode ritiene che la struttura sia consolidata e che ulteriori cambiamenti sarebbero raffinamenti minori, non riassetti strutturali. Stima: non prima di 6-9 mesi dalla data di prima stesura (4 maggio 2026), quindi target ottimistico fine 2026 o inizio 2027

#### 5.3.2 Evoluzione bozzolo → farfalla

Come dichiarato nel header e dettagliato in 4.5, questo documento è progettato per maturare in narrativa esterna. Il programma operativo è in tre fasi:

- **Fase bozzolo** (oggi → 12 mesi): documento interno di palestra di riflessione, vive in `/docs/lso/` di FlorenceEGI
- **Fase di maturazione** (12-24 mesi): da questo documento vengono derivati materiali pubblici (pagina "Cos'è Oracode", white paper Oracode in versione pubblica, materiali pitch Magicsoft 2.0). Il documento principale resta interno
- **Fase farfalla** (24+ mesi): se le condizioni dello spin-off pubblico sono soddisfatte, Oracode esce come framework con propria documentazione pubblica (eventualmente su `oracode.dev`). Il documento interno continua a esistere e a evolvere, ma il pubblico legge una versione raffinata e narrativa, non questa bozza concettuale

I derivati pubblici devono **non duplicare** questo documento — devono raccontare in modo accessibile ciò che questo documento codifica in modo strutturato. La duplicazione sarebbe drift garantito.

#### 5.3.3 Cosa il documento ancora non sa di sé stesso

Una nota onesta finale. Il documento di nomenclatura, alla data del 7 maggio 2026, ha probabilmente **lacune che non vede ancora**. Lo stesso pattern che ha rivelato P0-13 (regola implicita non codificata) e la maturity overstated dei layer (dichiarazione aspirazionale non verificata) si applicherà ancora — cose oggi date per scontate verranno riconosciute come implicite o errate in futuri cicli.

Questa è la natura dei sistemi viventi: si raffinano per stratificazione progressiva, non per scrittura definitiva. Il documento è progettato per accogliere queste future scoperte invece di resistere ad esse.

Se un'istanza futura di Padmin (o un futuro collaboratore del progetto) trova un'incoerenza in questo documento, **la procedura corretta è**:

1. Nominare l'incoerenza esplicitamente al Custode
2. Verificare con evidenza fattuale (mai dedurre — REGOLA ZERO)
3. Aprire mission dedicata se serve riassesto strutturale, oppure aggiornamento incrementale se è raffinamento locale
4. Aggiornare il documento di conseguenza, registrando in 5.2 il nuovo boundary case e la sua risoluzione (se chiusa) o il suo stato di maturazione (se ancora aperto)

Il documento serve il sistema — non viceversa.

---

🔥 *Working draft — Padmin D. Curtis con Fabio Cherici — 4 maggio 2026*
