# /discovery — Acquisizione nuovo progetto

Quando ricevi questo comando, guida Fabio (o il Supervisor del progetto) attraverso il ciclo di acquisizione di un nuovo cliente/progetto. L'output di discovery diventa direttamente l'input di `/project` — nessuna traduzione, nessun handoff.

---

## Fase 0 — Intake iniziale

Fabio ha avuto un contatto con un potenziale cliente. Chiedi:

**0.1 Materiale disponibile**
Usa AskUserQuestion:
- "Hai una sbobinatura della telefonata?" (file testo/audio trascritto)
- "Hai un form compilato o appunti scritti?"
- "Hai entrambi?"

Carica tutto il materiale fornito. Leggi integralmente prima di procedere.

**0.2 Analisi e mappa del progetto**
Dal materiale ricevuto, produci:

1. **COSA VUOLE IL CLIENTE** — descrizione in linguaggio semplice, zero gergo tecnico
2. **COSA SERVE DAVVERO** — traduzione tecnica (stack probabile, complessita, organi se multi)
3. **LACUNE** — cosa manca per poter stimare tempi e costi. Sii specifico: non "servono piu dettagli" ma "non sappiamo quanti ruoli utente ci sono" o "non e chiaro se servono notifiche push"

Mostra la mappa a Fabio prima di procedere.

---

## Fase 1 — Form lacune

**1.1 Genera form mirato**
Per ogni lacuna identificata, scrivi una domanda chiara che il cliente possa capire.
Regole:
- Linguaggio da persona normale, zero tecnicismi
- Una domanda per lacuna
- Dove possibile, offri opzioni (non domande aperte)
- Ordina per importanza (le lacune che impattano di piu la stima prima)

Formato output: form numerato, pronto per essere letto al telefono o inviato.

**1.2 Consegna a Fabio**
Mostra il form. Fabio lo usa nella prossima chiamata col cliente.

---

## Fase 2 — Secondo round (ripetibile)

Fabio torna con:
- Sbobinatura della seconda chiamata E/O
- Form compilato E/O
- Sue risposte dirette

**2.1 Integra**
Aggiorna la mappa del progetto (Fase 0.2) con le nuove informazioni.
Segnala lacune residue.

**2.2 Ciclo**
Se lacune critiche rimangono: genera nuovo form (torna a 1.1).
Se lacune sono minori o risolvibili con assunzioni ragionevoli: procedi a Fase 3.
Chiedi sempre a Fabio prima di procedere.

---

## Fase 3 — Stima tempi e costi

**3.1 Riferimento**
Leggi `templates/CALIBRATION_REFERENCE.md` (paradigma): ordini di grandezza REALI per archetipo, calibrati su git
history di progetti Oracode. Usa l'archetipo più vicino come calibrazione.
Se l'organismo ha un registro numerico interno più dettagliato, quello è la fonte primaria (resta privato all'organismo).

ATTENZIONE: la tendenza naturale e SOVRASTIMARE. Se pensi "3 giorni" e l'archetipo dice "~16h per qualcosa di simile", fidati del riferimento. Questi numeri vengono da git, non da stime.

**3.2 Stima**
Produci:
- **Ore di sviluppo stimate** — range (min-max), calibrato sui riferimenti
- **Calendario** — giorni/settimane realistici (considera che non e sviluppo full-time)
- **Costo** — basato sulla tariffa oraria dell'organismo (parametro commerciale; chiedi al responsabile se non nota)
- **Livello Oracode consigliato** — 1/2/3/4 con motivazione

**3.3 Includi nel costo**
- Discovery stessa (tempo gia speso)
- Sviluppo
- MVP di validazione visiva (se concordato)
- Deployment e configurazione
- Un periodo di supporto post-consegna (da definire con Fabio)

---

## Fase 4 — Report cliente

Produci UN DOCUMENTO diviso in due parti.

**PARTE A — Per il cliente** (linguaggio semplice, zero gergo)
- Cosa faremo (descrizione funzionale)
- Come si presenta il risultato (descrizione visiva, se possibile mockup ASCII o riferimenti)
- Tempi (calendario)
- Costo (totale, eventuali fasi)
- Cosa e incluso, cosa non e incluso
- Condizioni per modifiche in corso d'opera (change order = costi aggiuntivi)

**PARTE B — Piano tecnico** (per Supervisor/Padmin)
- Stack scelto
- Livello Oracode
- Architettura (mono/multi organo, DB, infra)
- Librerie LSO da installare
- Rischi tecnici identificati
- Piano mission indicativo (M-001, M-002, ...)
- SSOT da produrre

Mostra ENTRAMBE le parti a Fabio. Fabio approva PRIMA che qualsiasi cosa vada al cliente.

**4.1 Persisti la Parte B (handoff deterministico)**
Dopo l'approvazione, salva la Parte B come artefatto-ponte **`DISCOVERY_REPORT.json`** (REGOLA ZERO: il
handoff non deve dipendere dalla memoria di sessione). Path: `~/.oracode/discovery/<nome-progetto>.json`.
Schema (campi che `/project` riuserà senza ri-chiederli):
```json
{
  "project": "<nome>", "company": "<societa>", "ceo": "<ceo>", "cto": "<cto se noto>",
  "domain": "<descrizione una riga>",
  "stack": {"backend": "...", "frontend": "...", "database": "...", "infra": "..."},
  "languages": "it en", "level": 3, "github_repo": "<owner/repo se noto>",
  "rag": {"runtime": "...", "schema": "..."},
  "lso_libs": ["..."], "ssots_to_produce": ["..."], "mission_plan": ["M-001 ...", "..."],
  "source_mission": "discovery"
}
```
Campi non noti → lascia `null` (NON inventare): `/project` li chiederà esplicitamente.

---

## Fase 5 — Approvazione e handoff

**5.1 Fabio approva Parte A**
Se modifiche richieste: aggiorna e rimostra.
Quando approvato: Parte A e pronta per il cliente.

**5.2 Cliente approva**
Fabio gestisce la comunicazione col cliente.
Quando il cliente approva: il progetto e confermato.

**5.3 Handoff a /project**
La Parte B persistita (`DISCOVERY_REPORT.json`, Fase 4.1) è l'input di `/project`.
`/oracode-configure` legge questo file e **salta le domande già risolte**, chiedendo solo i campi `null`
(es. CTO, repo GitHub se non noti in discovery). Nessuna domanda duplicata. Da qui iniziano gli SSOT del progetto.

**5.4 MVP (se concordato)**
Prima di sviluppo completo, produrre MVP minimo per validazione visiva.
Iterabile: MVP → feedback cliente → aggiustamento → nuovo MVP → accordo → sviluppo pieno.

---

## Note operative

- MAI comunicare direttamente col cliente. Tutto passa da Fabio.
- MAI sottostimare la raccolta dati. Anche 10 pagine richiedono specifiche.
- MAI gonfiare i tempi. Calibra su `CALIBRATION_REFERENCE.md` (archetipi), non su istinto.
- Cambio idea del cliente dopo approvazione = change order con costi aggiuntivi. Non e un problema — e business.
- Il form lacune deve essere comprensibile da una persona non tecnica. Zero acronimi, zero gergo.
- Discovery e lavoro e va fatturato. Includerlo nel costo totale.
