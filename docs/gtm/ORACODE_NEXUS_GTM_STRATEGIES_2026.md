# Oracode Nexus — Strategie di Posizionamento e Vendita a Budget ~Zero

> **Autore**: Padmin (CTO AI) for Fabio Cherici
> **Data**: 2026-05-31
> **Metodo**: ricerca multi-agente (28 subagent, 405 ricerche web, ~1M token) — recon su 14 angoli di mercato, verifica adversarial su 12 tattiche, speculazione su 12 idee nuove.
> **Scopo**: elencare le strategie per portare Oracode Nexus al mercato spendendo nulla o pochissimo.
> **Nota epistemica**: ogni canale è classificato con `costo / sforzo / reach / fit`. I claim di "reach di massa" sono stati **stress-testati** e quasi tutti **ridimensionati a nicchia** (sezione 2). Questo documento è onesto sui limiti per non bruciare l'unica occasione.

---

## 0. TL;DR — Le 5 mosse che contano

Se leggi solo una pagina, leggi questa.

1. **Possiedi il canale dove il target vive al 100%**: confeziona Oracode come **plugin Claude Code** (oggi manca `.claude-plugin/plugin.json`) ed entra in **marketplace ufficiale + awesome-list**. Costo: una settimana. È l'unico posto al mondo dove il 100% del target è concentrato. *(§4.A)*
2. **Trasforma il prodotto in canale**: ogni volta che un hook **BLOCCA** un disastro (secret, valore di business, file legacy) è un'impression. Pubblica il **"Block Reel"** — clip di 40 secondi in cui Claude Code prova a fare danni e l'hook lo ferma in rosso. Il blocco è drammatico, screenshot-abile, impossibile da fingere. *(§6, idea #1)*
3. **Possiedi una categoria, non competere in una affollata**: smetti di essere "l'ennesimo tool di AI code review". Nomina il **nemico** ("AI slop / vibe slop") e coniagli contro il **vocabolario** ("rules-as-contracts, not rules-as-prose", "prevent, don't review", "LSO"). Manifesto pubblico modello 12-Factor. *(§3)*
4. **Fatti raccomandare dalle AI stesse (GEO)**: Oracode vive dentro Claude Code; quando un dev chiede a Claude "come controllo il codice AI?", Oracode deve essere la risposta. `llms.txt` + comparison page oneste. Canale auto-distributivo, quasi nessun concorrente lo presidia ancora. *(§6, idea #2)*
5. **Monetizza dove i soldi sono già stanziati**: per le PMI italiane non vendere "AI governance" (gergo da CTO USA) ma "software custom + audit trail, finanziato dal voucher digitale che già esiste". Iscrizione **gratuita** all'Elenco Fornitori 4.0 delle Camere di Commercio → l'incentivo pubblico paga metà del tuo ticket Magicsoft. *(§7)*

**La verità scomoda (dalla verifica adversarial)**: nessun singolo canale porta "massa". Il modello realistico è **decine→poche centinaia di early adopter qualificati**, non migliaia. La crescita arriva da **somma di canali nel tempo + asset SEO/GEO permanenti**, non da un colpo virale. Pianifica di conseguenza.

---

## 1. Le domande che mi sono posto (e le risposte)

Prima di cercare, mi sono dato la cornice. Queste domande hanno guidato le 405 ricerche.

| # | Domanda | Risposta sintetica |
|---|---------|--------------------|
| Q1 | **Chi è esattamente il target e dove vive?** | Dev che usano Claude Code/Cursor. Vivono in 3 posti precisi: marketplace plugin Claude Code, awesome-list GitHub, subreddit r/ClaudeAI (891k) + r/ClaudeCode (292k). Sono **raggiungibili al 100% via canali gratuiti già esistenti**. Vantaggio raro. |
| Q2 | **Qual è il differenziatore difendibile?** | "**Block, not suggest**": Oracode è l'unico enforcement **deterministico PRE-scrittura** sul comportamento dell'agente. I competitor stanno in 3 caselle diverse e vuote rispetto a questa: review post-hoc (CodeRabbit/Greptile), rules-as-prose (.cursorrules — suggerimenti ignorabili), scanner post-commit (Semgrep/Gitleaks). Nessuno combina block + audit trail + doc-drift. |
| Q3 | **Cosa ho che nessun concorrente può copiare?** | La **prova di produzione reale**: 500k+ righe, 7 prodotti live, 40+ mission, zero regressioni non rilevate, da marzo 2026. Impossibile da fabbricare. È contenuto, non marketing. |
| Q4 | **Come si raggiunge la massa con budget zero?** | **Non si raggiunge** con un colpo. Si costruisce: distribuzione nativa (marketplace/list) + un lancio (HN) + asset di contenuto permanenti (GEO/SEO/manifesto) + il prodotto-come-canale. La somma, nel tempo. |
| Q5 | **Come monetizzo un paradigma open, non solo un tool?** | Open-core (MIT = megafono, OS3 Matrix = cassa) + i modelli che hanno arricchito le *metodologie* (DDD, Scrum, 12-Factor): manifesto/libro, certificazione, partner program, community a pagamento, template marketplace. |
| Q6 | **Qual è la leva commerciale più vicina alla cassa?** | **Magicsoft 2.0** su PMI italiane (ticket 8-25k€), perché: (a) deadline EU AI Act + L.132/2025 creano urgenza, (b) i **voucher digitali** pagano metà, (c) Fabio è italiano — vantaggio di lingua/relazione che i concorrenti USA non hanno. |
| Q7 | **Qual è la leva più trasversale e nuova?** | Far sì che **le AI stesse raccomandino Oracode** (GEO) e che **ogni blocco di un hook sia marketing** (product-as-content). Due loop a costo marginale zero che nessun concorrente sta sfruttando. |

---

## 2. ⚠️ Reality check — cosa NON funziona come promesso

La verifica adversarial (12 skeptici, ricerca su evidenze contrarie) ha demolito i miti. **Leggi questo prima di investire tempo.**

- **"Reach di massa" è quasi sempre falso.** Per un dev tool sconosciuto, senza audience, di un founder senza follower:
  - **Show HN**: mediana 2 punti; ~metà dei post prende ≤2; front page = top 3-6% (lotteria). Caso base: 5-50 stars, poche centinaia di visite. Il "500-2000 stars in 24h" è un **outlier non pianificabile**.
  - **Product Hunt 2026**: senza status "Featured" (deciso a mano) → traffico quasi nullo. Caso reale dev-tool: rank #2 / 416 voti → **687 visite, 0 paganti**. La feature "DM ai commentatori" **non esiste più** (rimossa anni fa).
  - **Reddit**: il post "i 19 hook che USO" firmato dall'autore è **esattamente il pattern flaggato come self-promo**. Account nuovo + link install = rimozione/shadowban probabile. Serve 90/10 (di fatto 99/1) e 3-4 settimane di warm-up prima di un solo post.
- **GitHub stars = vanity metric.** Conversione star→revenue notoriamente bassa (~1.4 star per upvote HN). Nessuna delle 4 offerte commerciali converte direttamente da uno spike di stars.
- **README perfetto ≠ traffico.** Cura conversione, non reach. Un repo a 0 stars non converte estranei: serve portarlo a **~100-200 stars dalla propria rete PRIMA** di qualsiasi lancio pubblico.
- **L'angolo EU AI Act NON è terra vergine.** Già presidiato e finanziato: Cycode, Corridor.dev, Augment Code, Endor Labs ($93M), e **Anthropic stessa** sta lanciando una Claude Compliance API. → Usalo, ma sapendo che competi.
- **Non sovravvendere la compliance.** Oracode **non rende "EU AI Act compliant"**: un compliance officer smonta il claim in 30 secondi. Riformula sempre come *"produce artefatti utili come evidenza / supporta la tracciabilità"*, mai *"garantisce compliance"*. Disclaimer legale obbligatorio.
- **awesome-claude-code (hesreallyhim, 45k★) NON accetta PR.** Regola d'oro del repo: submission **solo via Web UI / issue form**. Una PR = ban dell'account. Gate: repo ≥7 giorni, ≥5 stars, account ≥14 giorni.
- **"Lancio coordinato" multi-piattaforma sullo stesso link = voting-ring.** Il detector di HN (priorità da 12+ anni) penalizza. Tieni i canali **indipendenti e sfasati**, mai pompare upvote cross-canale.

> **Cosa vale davvero di un lancio**: backlink SEO ad alta authority + traffico qualificato di CTO/dev + 2-3 conversazioni. NON un'onda di massa. Imposta le aspettative qui.

---

## 3. Posizionamento — la categoria e il nemico

Il challenger senza budget non vince **competendo** nella casella affollata "AI code review": vince **creando la sua casella** (Play Bigger / April Dunford). Sequenza:

1. **Nomina il nemico (già virale, non da inventare)**: *"AI slop" / "vibe slop"* — codice AI scadente che entra in produzione. Termine già in circolazione nel 2026 (Collins "vibe coding" = Word of the Year 2025). Tu sei **l'antidoto strutturale**.
2. **Possiedi il vocabolario** (oggi 0 concorrenti lo rivendicano — verificato):
   - **LSO — Living Software Organism**: "software che conosce le proprie regole come contratti machine-readable, non come prosa".
   - Frasi-arma ripetute identiche ovunque: **"rules-as-contracts, not rules-as-prose"** · **"prevent, don't review"** · **"the AI can't violate what the machine enforces"**.
3. **Ancora a dati duri di terzi** (credibilità): AI = 41% del codice · +45% vulnerabilità · codice AI 1.7-2.74× più bug/vulns · 96% dei dev non si fida ma solo 48% revisiona · solo 12% delle org ha governance AI.
4. **Manifesto pubblico modello 12-Factor / Agile Manifesto**: una pagina statica (GitHub Pages, gratis), numerata, citabile, brandizzata, su dominio dedicato. Il contenuto **esiste già** in `CLAUDE_ORACODE_CORE.md` (6+1 pilastri, 13 P0, layer L0-L11). Un manifesto trasforma un tool in un **movimento** — e rende vendibile tutto ciò che gli sta attorno (corsi, certificazioni, Matrix).

> ⚠️ Su HN: il linguaggio "manifesto/paradigma/sistema nervoso" può leggersi come marketing e attirare ostilità. Nel **primo commento HN** guida con la **meccanica concreta** (cosa un hook letteralmente blocca, un diff reale), il vocabolario di categoria tienilo per il sito/manifesto.

---

## 4. Strategie per canale — distribuzione gratuita

Legenda fit = adattamento a Oracode (1-5). Reach = **realistica post-verifica**.

### A. Distribuzione nativa nell'ecosistema Claude Code — *il ROI più alto*

| Canale | Costo | Sforzo | Reach reale | Fit | Azione |
|--------|-------|--------|-------------|-----|--------|
| **Marketplace plugin ufficiale Anthropic** (`anthropics/claude-plugins-community`) | free | medio | nicchia→media | 5 | Crea `.claude-plugin/plugin.json`, `claude plugin validate`, submit **via form in-app** (mai PR). Posizionati come "governance/enforcement", non "set di skill". |
| **Self-hosted marketplace** (sei TU un marketplace) | free | basso | media | 5 | `.claude-plugin/marketplace.json` nel repo → utenti installano con `/plugin marketplace add fabiocherici/oracode`. Nessuna review, attivabile **oggi**. CTA universale in ogni post/talk. |
| **awesome-claude-code** (hesreallyhim, 45k★) | free | basso | media | 5 | ⚠️ **Solo via issue form, MAI PR** (ban). Gate: repo 7gg, 5★, account 14gg. Categoria "Governance/Guardrails" (quasi vuota). |
| **awesome-list satellite** (rohitg00 toolkit, ComposioHQ, jqueryscript, claudemarketplaces.com, aitmpl.com, tonsofskills) | free | basso | nicchia | 4-5 | Leggi il CONTRIBUTING di ciascuna (alcune PR, alcune form). One-liner sul gap: rohitg00 ammette di NON coprire doc-drift/mission-tracking/business-value — riempi quei 4 vuoti. |
| **Official MCP Registry** (gate read-only come MCP server) | free | medio | media | 3 | Esponi un `oracode-gate` MCP che valida un diff: cavallo di Troia tecnico + teaser di Matrix. |

**Insight chiave**: il marketplace + le list sono **motori di scoperta passivi evergreen**. Il target ci arriva *cercando esattamente quello che fai*. Ma (verifica): da soli portano **decine-centinaia di install**, non migliaia. Sono **baseline igienica + SEO**, non motore di crescita. Il motore è il contenuto amplificabile sopra.

### B. Il lancio (sprint one-shot, non canale ricorrente)

| Canale | Costo | Reach reale | Note dalla verifica |
|--------|-------|-------------|---------------------|
| **Show HN** | free | nicchia, alta varianza | Titolo asciutto, no superlativi, **repo diretto** (non landing). Primo commento 7-passi con la prova reale + open-core dichiarato. Mar-gio mattina ET. Rispondi a OGNI commento 4-6h. **Mai upvote da amici** (ban). Un solo colpo credibile per prodotto: spendilo a README+demo perfetti. |
| **Reddit** (r/ClaudeAI, r/ClaudeCode, r/SideProject, r/coolgithubprojects) | free | nicchia | Value-first per 3-4 settimane PRIMA. Storytelling, non pitch. Repo **solo nei commenti/su richiesta**, mai nel corpo. r/programming + r/ExperiencedDevs = vietato self-promo, solo contenuto tecnico puro. |
| **Indie Hackers + Betalist** (pre-lancio) | free | nicchia | 4-6 settimane di community building PRIMA del giorno-zero. Costruisce la base che dà slancio + evita lancio a freddo. |
| **Product Hunt / DevHunt** | free | nicchia | Secondario, solo per backlink. DevHunt meglio di PH per open-source emergente. Non contarci. |
| **Lobsters** | free | nicchia alto-segnale | Invite-only, senior eng. Cross-pollina con HN. Pochi lead ma qualificatissimi. |
| **console.dev / TLDR (submission gratuita)** | free | media | NON pagare sponsor. Submit del pillar post quando ha già trazione. Un pickup TLDR = migliaia di visite. |

### C. Contenuto / SEO / GEO — gli asset permanenti

| Canale | Costo | Reach | Fit | Azione |
|--------|-------|-------|-----|--------|
| **GEO + llms.txt** (farsi citare da ChatGPT/Claude/Perplexity) | free | media | 5 | `llms.txt` (oggi ASSENTE) + consenti AI crawler + contenuto chunk-friendly. 12-18% delle query info passa già da AI search. Vedi §6 idea #2. |
| **Pillar post-prova** ("Ho dato a Claude 500k righe, ecco cosa ho imparato") | free | media | 5 | Long-form prima persona, 5 disastri evitati, onestà sui limiti. Pubblica sul dominio Oracode PRIMA (link equity), poi syndica. |
| **Comparison pages SEO/GEO** ("Oracode vs .cursorrules / vs CodeRabbit / vs Semgrep") | free | media | 4 | Cambia l'asse: da "chi trova più bug" a **"prevent vs review"**. Onesto (dichiara dove i rivali sono migliori). Le AI citano comparison strutturate. |
| **Syndication** (dev.to/Hashnode/daily.dev, canonical) | free | media | 4 | Pubblica sul dominio, 7-10gg dopo crosspost con canonical_url. +300-500% reach senza penalità SEO. |
| **Build-in-public** (X/LinkedIn, 2-3 post/settimana) | free | media | 4 | Il **mission protocol È già build-in-public strutturato**: ogni mission = micro-contenuto a costo marginale zero. Mostra errori, non solo vittorie. |
| **Report originale "State of AI Code Governance 2026"** | free | media | 4 | Dati propri (40+ mission, classi di edit bloccate) + benchmark di mercato. Chi misura la categoria la possiede (modello Zuora). Citation magnet. |
| **Newsletter alto-segnale** (Latent Space, Pragmatic Engineer, Code With Andrea) | free | massa | 4 | Serve warm intro (Latent Space no cold email). Angolo dato-driven: "zero regressioni su 500k righe". Una citazione = migliaia di CTO. |
| **npm/GitHub SEO** | free | media | 5 | `keywords` in package.json (claude-code-hooks, ai-governance, llm-guardrails…), GitHub topics, About. npm 2025 ordina per keyword-matching oggettivo. Una-tantum. |
| **Stack Overflow / GitHub Discussions answer-seeding** | free | nicchia | 4 | Rispondi a "come impedisco a Claude di modificare X". Diventa il pattern che gli LLM ripropongono. |

### D. Loop auto-propaganti (prova sociale)

| Canale | Costo | Reach | Fit | Azione |
|--------|-------|-------|-----|--------|
| **Badge "Governed by Oracode"** (shields.io) | free | media | 4 | Endpoint badge dinamico con score. shields.io serve 1.6 mld immagini/mese. Ogni badge su un repo altrui = pubblicità permanente + FOMO da status symbol. |
| **good first issue + Hacktoberfest** | free | nicchia | 3 | 8-12 issue ben scoped → contributor diventano evangelisti/stargazer. GitHub Topics curate portano scoperta. |
| **GitHub Sponsors / Polar.sh** | free | nicchia | 3 | Finanzia il free core + testa willingness-to-pay prima dei tier Matrix. |

---

## 5. Strategie per offerta commerciale

### Magicsoft 2.0 (PMI italiane, 8-25k€) — *la cassa più vicina*

| Strategia | Costo | Perché funziona |
|-----------|-------|-----------------|
| **Elenco Fornitori Tecnologie 4.0 (PID/Camere di Commercio)** | free | Iscrizione gratuita via PEC. Le PMI che vincono i **voucher digitali** (fondo perduto 50-70%) devono spendere presso fornitori dell'elenco. **L'incentivo pubblico finanzia metà del tuo ticket.** Ribalta l'economia: progetto da 16k€ costa 8k€ netti alla PMI. |
| **Lead magnet "Calcolatore Voucher + Bandi attivi"** | low | Tool sul sito: la PMI inserisce regione/dimensione → stima incentivo + bandi attivi. Cattura email + posiziona Magicsoft come chi gestisce *finanziamento + sviluppo*. |
| **Partnership commercialisti / consulenti finanza agevolata** | free | Loro hanno già la fiducia della PMI e il flusso di chi cerca incentivi. Revenue share. CAC quasi nullo, lead caldissimi. |
| **Associazioni di categoria (CNA/Confapi/Confartigianato + loro DIH)** | low | Workshop gratuito "come finanziare il tuo software con i voucher 2026": l'associazione porta il pubblico, tu il contenuto + l'accredito. |
| **LinkedIn ABM "povero" (20-30 account a mano)** | free | DM iper-personalizzato = 5× risposta vs cold email. 20-30 account gestibili a mano bastano per la pipeline. Mai template. |
| **Wedge L.132/2025 (Italia primo Stato UE con legge AI)** | low | Garante attivo, sanzioni fino a ~774k€. "Ti costruiamo il software E l'evidence pack, senza piattaforme da 30k€/anno". Vantaggio lingua/cultura. |
| **Comunità dev italiane (Codemotion, GrUSP)** | low | Codemotion Roma 2026 tema = "AI in produzione" (fit perfetto). CFP gratuiti = speaking = lead gen verso CTO/software house italiane. |
| **Productized audit "AI-Governance Audit" (1.5-3k€)** | free | Gateway a basso attrito che converte nei progetti grandi (modello: audit 2.5k€ → maggioranza converte in >25k€). Usa il sistema nervoso a 4 layer come motore. |

### OS3 Matrix (enforcement runtime, enterprise) — *il pricing alto*

| Strategia | Costo | Perché |
|-----------|-------|--------|
| **Open-core developer-led → CISO upsell** | free | Free = utile all'individuo (regola OCV/PostHog), Paid = utile all'azienda (SSO, RBAC, audit log = i 3 must per cui il CISO firma). Il dev champion scalda la vendita verso il buyer enterprise. |
| **Claude Partner Network (Anthropic)** | free | Membership **gratuita**, fondo $100M, Anthropic **paga il co-marketing**. Services Partner Directory = lead-gen enterprise. Nicchia "Code Modernization / AI governance" (early-mover). Candida Florence EGI S.R.L. |
| **IAPP AI Governance Vendor Report (submission gratuita)** | free | La directory che CISO/compliance consultano per shortlist. Categoria "Policy & Compliance" + "Assurance & Auditing". |
| **Wedge EU AI Act / ISO 42001** (riformulato onesto) | free | "Audit trail + human oversight per codice AI-generato, **utile come evidenza** Art. 11/12". Mai "ti rende compliant". Co-marketing con GRC adiacenti (Vanta, Augment) via export OTel — complementari, non concorrenti. |
| **Polar.sh** (merchant-of-record + license-key) | low | Risolve IVA EU + license-key per il founder solo (5% fee). Per-seat/per-repo (NON usage-based: gira locale). |
| **Sub-fornitura B2B2B a software house / system integrator** | free | Vendi la capability "governance AI" in white-label a chi costruisce per PMI ma non ce l'ha. Ogni partner porta il suo portafoglio. Eviti la guerra di prezzo coi generalisti (Zucchetti/Var). |

### Monetizzare il PARADIGMA (modello DDD/Scrum/12-Factor)

| Strategia | Costo | Perché |
|-----------|-------|--------|
| **Manifesto/libro digitale gratuito + versionato** | free | DDD ed Eric Evans: un libro gratuito genera autorità e royalty per 20+ anni e rende vendibile tutto a valle. Il contenuto esiste già. L'amo, non l'esca. |
| **Certificazione "Oracode Certified"** (corso video + esame + badge) | low | Scrum/Scrum Alliance hanno costruito imperi vendendo certificazioni su una *metodologia*. Badge su LinkedIn = marketing gratuito. Corporate training = fascia a margine più alto. Effort alto una volta, poi scala. |
| **Oracode Certified Partner** (white-label + revenue share) | low | Train-the-trainer + revenue share = ogni software house diventa forza vendita. Abbassa l'attrito d'ingresso (paga in % sul venduto). |
| **Marketplace di template/scaffold LSO** | free | Scaffold gratis via `npx oracode init` (amo) + template premium per stack/dominio. Ogni template è una vetrina vivente del paradigma. |
| **Community a pagamento (Skool/Whop)** | low | 100 membri × 29€/mese = ~2.900€ MRR a costo gestione minimo. Office hours founder + aggiornamenti EU AI Act + template. Cementa il "movimento". |

---

## 6. Le idee nuove — pensiero trasversale (speculazione)

Le 8 idee a maggior potenziale, dalla fase di speculazione. Sono dove "ci si inventa qualcosa di nuovo".

### Idea #1 — Product-as-channel: "The Block Reel" 🔥
**Il prodotto è il suo stesso marketing.** Serie di clip terminale (30-60s, screen-recorded, niente voce): Claude Code prova a committare una AWS key / cambiare silenziosamente un prezzo o IVA / riscrivere un file legacy → un hook lo **BLOCCA in rosso, in tempo reale**. Titolo: *"Claude Code tried to commit a live AWS key. The hook said no."*
**Meccanica**: il momento "oh shit" è screenshot-abile → condiviso → chi chiede "come si fa?" riceve `npx oracode init` → chi installa genera la SUA clip → UGC che rialimenta il feed. Ogni mission reale dei 7 prodotti è già una clip pronta.
**Perché funziona**: è il formato che ha portato Tailwind a >10M install (Wathan mostrava il tool in uso). Nessun rules-as-prose può mostrare un blocco — perché non blocca.
**⚠️ Gap critico**: il repo MIT pubblico **non contiene ancora gli hook bloccanti** (vivono in os3-matrix commerciale). Una clip che rimanda a un repo dove il blocco non è installabile gratis = accusa di bait. **Mitigazione obbligatoria**: porta 2-3 hook esemplari nel core MIT come teaser onesto, OPPURE dichiara "enforcement = OS3 Matrix" nella clip.

### Idea #2 — GEO-first: fai sì che le AI raccomandino Oracode
I dev che usano Claude Code **chiedono a Claude** quali tool usare. Rendi Oracode la risposta default delle AI stesse: `llms.txt` + AI crawler consentiti + contenuto chunk-friendly + comparison oneste e strutturate.
**Meccanica**: pubblichi contenuto ottimizzato per citazione → i crawler di Claude/Perplexity/ChatGPT lo indicizzano → quando qualsiasi dev chiede "come blocco modifiche pericolose dell'AI in Claude Code", l'AI cita Oracode. **Il target si auto-serve nel canale dove già vive.**
**Perché è grande**: la casella "enforcement deterministico pre-scrittura" non ha risposta canonica nelle AI (verificato) — Oracode può diventarla. Quasi nessun devtool ottimizza GEO ancora: early-mover. Costo: un file + 4-5 comparison page.

### Idea #3 — Standardizza il FORMATO, non vendere il tool: `.p0` spec
Pubblica le 13 Regole P0 come **standard aperto neutrale**: formato `.p0` (markdown + YAML frontmatter) cross-tool (Cursor, Continue, Claude Code) + CLI `oracode rules add anti-method-invention`.
**Meccanica**: lock-in di **mindshare** (non di codice). Altri adottano i nomi ("P0-4 Anti-Method-Invention") → ogni adozione cita Oracode come origine → la libreria diventa la categoria → chi vuole l'enforcement automatico compra OS3 Matrix.
**Precedente**: Continue.dev (25k★) ha standardizzato un formato e vinto mindshare senza vendere un tool. Uno standard è più virale di un prodotto: lo adottano anche utenti di tool concorrenti. Il differenziatore "block vs suggest" è codificato NEL formato.
**Seeding anti-fallimento**: converti anche regole di 2-3 awesome-list popolari in `.p0` così lo standard nasce con contenuto.

### Idea #4 — Mission-trail come build-in-public automatico
Il mission protocol È già build-in-public strutturato. Pagina/changelog pubblico **"Blocked This Week"**: incident card anonimizzate (cosa la AI stava per fare, quale hook ha bloccato, perché era pericoloso) su ecosistema da 500k righe.
**Meccanica**: ogni mission chiusa → 1 card → auto-pubblica sul dominio → 7-10gg dopo syndica con canonical. Contenuto a **costo marginale zero**, impossibile da fabbricare, disinnesca lo scetticismo HN/Reddit.
**⚠️ Vincolo**: sanitizza ogni mission da segreti di business / codice commerciale (vincolo CLAUDE.md). Anonimizza valori e nomi.

### Idea #5 — Free checker virale: "AI-Hallucination Scanner"
`npx oracode scan` standalone: gira su qualsiasi repo, in 10 secondi segnala quanti metodi/API "fantasma" (allucinati) e secret/valori hardcoded l'AI potrebbe aver introdotto. Output: report + badge condivisibile "X ghost-methods found".
**Meccanica**: l'amo top-of-funnel. Report ansiogeno screenshot-abile → condiviso per paura → chiude con "questi scanner trovano DOPO. Vuoi bloccare PRIMA? → Oracode". Time-to-first-value ≈ zero, no signup (leva PLG di Lovable).
**⚠️ Rischio fatale**: falsi positivi (metodi via reflection/magic methods) distruggono la credibilità all'istante davanti al pubblico tecnico. **Dichiara i limiti in apertura** (regex+AST+LLM) o non spedirlo — è la lezione che ha affondato TheAuditor su HN.

### Idea #6 — Countdown EU AI Act (riformulato onesto)
Pillar page + countdown ancorato al **2 agosto 2026**: "il tuo Copilot/Cursor/Claude non lascia traccia di compliance". Oracode genera nativamente gli artefatti (mission trail, audit, git attribution, doc-sync).
**Meccanica**: SEO/GEO magnet su query che si scalda ogni settimana verso agosto. Doppio funnel: paradigma gratis per dev + compliance a pagamento per PMI (Magicsoft) / enterprise (Matrix). La data fa l'urgenza gratis.
**⚠️ Onestà legale** (dalla verifica): NON dire "ti rende compliant". Cita Art. 12/Art. 50 con fonti, framing "preparazione/evidence", disclaimer "non è consulenza legale". Spazio già contestato — competi, non scoprire.

### Idea #7 — "oracode-lite": hook-trojan gratuito nel marketplace
Impacchetta SOLO i 3 hook più spettacolari (env-guard, immutable-values-guard, legacy-guard) come plugin MIT installabile in 10 secondi. **Non una demo: un guardrail vero** che il dev tiene acceso ogni giorno. Ogni blocco stampa `blocked by Oracode — see why: <url>`.
**Meccanica**: il prodotto diventa il suo canale. Dev installa gratis → un giorno un hook blocca un disastro reale → momento ad altissima carica emotiva ("mi ha appena salvato") → screenshot/tweet → impression organica. Il marketplace fa scoperta evergreen; lo screenshot fa il virale.
**Confine open-core**: lite = i 3 hook che servono al singolo dev; Matrix gata ciò che serve all'azienda (19 hook, gate pre-push, doc-drift, audit multi-team).

### Idea #8 — Founder-led category evangelism (lo "slant" di Fabio)
Fabio come **evangelista della categoria**, non venditore di tool. Un unico POV coerente in OGNI post: *"La code review umana non scala contro l'AI. Serve un sistema immunitario, non più revisori."*
**Meccanica**: storie di guerra concrete ("un hook ha bloccato un secret leak alle 2 di notte — ecco lo screenshot") + serie "old way vs new way" + dati di mercato con commento contrarian. Asset unico: 31 anni di esperienza + ecosistema reale che nessun concorrente può falsificare. Cross-post con canonical verso il manifesto (syndication compounding).

---

## 7. Prerequisiti tecnici — i gap da chiudere PRIMA

La verifica ha trovato blocker concreti. **Niente lancio finché non sono chiusi.**

1. **`.claude-plugin/plugin.json` ASSENTE** → blocca marketplace + self-marketplace. È il gap #1. Mezza giornata.
2. **`llms.txt` ASSENTE** → blocca GEO. Un file. Mezza giornata.
3. **Hook bloccanti non nel core MIT** → bait risk per Block Reel / checker. Decisione strategica: quali 2-3 hook portare nel teaser gratuito senza cannibalizzare Matrix.
4. **README come landing**: GIF/asciinema di un blocco in alto, prova sociale, quickstart 3 righe, badge. (Conversione, non reach — ma necessario.)
5. **`npx oracode init` deve fare "wow in <2 min"** su macchine pulite (Win/mac/Linux) — testare a freddo, un primo run fallito si ritorce contro.
6. **~100-200 stars dalla propria rete** (LinkedIn, contatti, ecosistema FlorenceEGI) PRIMA di qualsiasi lancio pubblico — sotto questa soglia gli estranei non convertono.

---

## 8. Piano sequenziato 90 giorni

**Fase 0 — Fondamenta (settimane 1-3)** *(tutto §7)*
Chiudi i 6 gap tecnici. Pubblica il manifesto LSO (GitHub Pages). Crea `llms.txt` + 2 comparison page oneste. Imposta npm keywords + GitHub topics. Iscriviti all'Elenco Fornitori 4.0 (PEC). Candidati al Claude Partner Network.

**Fase 1 — Distribuzione nativa + warm-up (settimane 3-6)**
Self-marketplace attivo (`/plugin marketplace add`). Submit marketplace ufficiale. Entra nelle awesome-list (via form/issue, rispetta i gate). Porta il repo a ~100-200 stars dalla rete. Inizia build-in-public 2-3 post/settimana. Partecipa genuinamente a Reddit/Indie Hackers (warm-up account).

**Fase 2 — Contenuto-prova + il lancio (settimane 6-10)**
Pubblica il pillar "Ho dato a Claude 500k righe" sul dominio → syndica. Registra e pubblica le prime 3 clip del Block Reel. POI: Show HN (mar-gio mattina ET, repo diretto, presidio 6h). Submit a console.dev/TLDR quando il pillar ha trazione. Cerca warm intro a Pragmatic Engineer/Latent Space.

**Fase 3 — Funnel commerciale (settimane 10-13)**
Lancia il productized audit (1.5-3k€) + lead magnet voucher. LinkedIn ABM su 20-30 PMI. Workshop con un'associazione di categoria. Pillar EU AI Act bilingue (onesto). Apri il programma partner / community a pagamento se la trazione regge.

---

## 9. Metriche oneste (cosa misurare davvero)

Non misurare stars. Misura:
- **Install qualificati** (`npx oracode init` reali) e **retention** (chi tiene gli hook accesi dopo 7gg).
- **Conversazioni qualificate** (DM, email da CTO/PMI) — l'output vero di un lancio.
- **Backlink ad alta authority** (HN/awesome-list/dev.to) e **citazioni AI** (Oracode appare quando chiedi a Claude/Perplexity di governance codice AI?).
- **Pipeline Magicsoft** (€) e **trial→pagante Matrix** — gli unici numeri che pagano l'AWS.

Target realistici primo trimestre: **50-300 install qualificati**, **5-20 conversazioni commerciali**, **1-3 progetti Magicsoft in pipeline**. NON "migliaia di utenti".

---

## 10. Cosa NON fare (anti-pattern dalla verifica)

- ❌ NON aprire PR su hesreallyhim/awesome-claude-code (ban) — solo issue form.
- ❌ NON fare "lancio coordinato" che pompa upvote cross-canale (voting-ring → penalità HN).
- ❌ NON postare su Reddit da account nuovo con link install nel corpo (shadowban).
- ❌ NON dire "Oracode ti rende EU AI Act compliant" (smontabile, danneggia credibilità).
- ❌ NON misurare il successo in GitHub stars (vanity, conversione bassa).
- ❌ NON pagare sponsorizzazioni newsletter/PH (inutile, il contenuto forte entra gratis).
- ❌ NON lanciare su HN senza README+demo+repo impeccabili (un solo colpo credibile).
- ❌ NON pubblicare il Block Reel/checker se il blocco non è installabile gratis o ha falsi positivi (accusa di bait, smontaggio tecnico).

---

## Appendice — Fonti chiave (verificate)

Marketplace/ecosistema: `anthropics/claude-plugins-community`, `code.claude.com/docs/en/plugins`, `clau.de/plugin-directory-submission`, `claudemarketplaces.com`, `github.com/hesreallyhim/awesome-claude-code` · Partner: `anthropic.com/news/claude-partner-network`, `claude.com/partners` · GTM/lancio: `markepear.dev/blog/dev-tool-hacker-news-launch`, `dev.to/iris1031` (GitHub stars playbook), `indieradar.app/blog/open-source-marketing-playbook` · Open-core: `handbook.opencoreventures.com`, `posthog.com/handbook`, `plausible.io/blog/open-source-saas`, `polar.sh` · Category design: `animalz.co/blog/category-creation`, `12factor.net`, `domainlanguage.com/ddd` · GEO: `draft.dev/learn/aeo-geo-for-dev-tools`, `charlesjones.dev/blog/geo-new-seo` · EU AI Act: `augmentcode.com/guides/eu-ai-act-2026`, `digital-strategy.ec.europa.eu` · Italia/PMI: `puntoimpresadigitale.camcom.it`, `incentivi.gov.it`, `grusp.org`, `codemotion.com`, IAPP L.132/2025 · Competitor: `superblocks.com/blog/ai-code-governance-tools`, `endorlabs.com`, `greptile.com/greptile-vs-coderabbit`.

*— Documento generato da ricerca multi-agente. I claim di reach sono stati ridimensionati dalla verifica adversarial: questo documento è ottimista sulle opportunità e pessimista sui tempi, di proposito.*
