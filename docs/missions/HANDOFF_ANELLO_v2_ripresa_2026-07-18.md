# HANDOFF v2 — Anello di Auto-Miglioramento (ripresa 2026-07-18)

> **Per**: la sessione fresca che riprende l'Anello.
> **Da**: sessione 23c68cc5 (la notte in cui è nato il ciclo delle capacità, M-OS3-158/159).
> **Validità**: fino all'apertura della prossima mission figlia dell'Anello. CONSUMATO allora.
> **Regola d'oro**: questo è una MAPPA, non la verità. Ogni fatto (path, stato, comando) **verificalo
> alla fonte** prima di agire (REGOLA ZERO). L'handoff di giugno
> (`HANDOFF_ANELLO_AUTOMIGLIORAMENTO.md`) è in più punti SUPERATO — vedi §5.

---

## 0. TL;DR

**Stato in una riga:** la bocca che grida l'errore c'è, il muro di sicurezza attorno alla sandbox c'è,
il disegno completo dell'anello c'è — **ma manca l'orecchio che ascolta, la memoria di cosa è già stato
gridato, e la mano che ripara.**

**Fetta successiva raccomandata:** il **receiver** (lato `nexus.florenceegi.com`) + la **coda
`nexus_fix_queue`** con dedup per impronta d'errore. Il mittente oggi spinge nel vuoto. Da progettare
con `engineer-architecture` + `engineer-security` sul pattern (mai a memoria), poi build test-first.
**Decisione CEO in attesa:** questa fetta, oppure prima le precondizioni W3/W4, oppure altra.

---

## 1. Leggi PER PRIMO (fonti di verità, grounded)

1. `oracode/docs/paradigm/lso/PATTERN_ANELLO_AUTOMIGLIORAMENTO_v1.0.0.md` — **il pattern, la Bibbia dell'Anello.** Status DRAFT, design ratificato CEO 16/06. Contiene: i due anelli annidati, la barriera dura L8/L9, il trigger PUSH, la dedup §3bis, i 4 punti-di-stop §4, il gate **Q6 anti-soppressione** §4, il gate **Q7 anti-collasso** §5, l'esistente-vs-nuovo §7, le precondizioni di attivazione §9.
2. `oracode/docs/paradigm/kernel/TIER0_CLAUSOLE_IMMUTABILI_v1.0.0.md` — le clausole immutabili: cosa l'Anello NON può MAI toccare.
3. `oracode/docs/missions/M-NEXUS-000_SHARED.md` — coordinamento con Fucina (organo coinvolto; loro ci hanno aggiunto cose).
4. `Fucina/docs/ssot/SSOT_LOOP_PROTOCOL.md` — il **metodo-padre gated**; l'Anello ne è la versione autonoma auto-innescata. Q7 promuove a gate duri i suoi principi (stop-al-plateau, anti model-collapse, verifier esterno).
5. Questo handoff, poi verifica lo stato al §2.

---

## 2. Dove siamo (verificato alla fonte 2026-07-18)

**Costruito e vivo:**
- **Pattern (FASE 0)** — M-NEXUS-000 (17/06), raffinato da **M-NEXUS-014** (29/06, ordine ciclo: *ratifica prima di propagazione*; niente entra nel genoma prima del consenso del fondatore). Disegno end-to-end completo su carta.
- **Il RECINTO** (precondizione di sicurezza) — completo e LIVE su locale + Milano. Mission chiuse M-OS3-121/122/123. Componenti in `os3-matrix/hooks/fence-*.sh`, `mission-state-guard.sh`, namespace neutro `~/.os3-policy/`. Impedisce a un agente autonomo di scrivere fuori scope o toccare Tier-0. Record: `os3-matrix/docs/missions/M-OS3-123_GOLIVE_RECORD.md`.
- **Il SEGNALE — mittente** — ⚠️ l'handoff di giugno lo dava "da costruire": **è FATTO.** `EGI/app/ErrorManager/Handlers/NexusNotificationHandler.php` (mission **M-EGI-343**, 25/06, v1.0.0, test-first 29/29 verde). L'UEM di EGI sa spingere l'errore verso il Nexus.

**Manca (il grosso del loop):**
- **Il receiver** lato `nexus.florenceegi.com` — NON esiste in codice. Il mittente spinge nel vuoto.
- **La coda `nexus_fix_queue`** (dedup per impronta = `error_code` + hash contesto sanitizzato, riusa `ErrorLog::getSimilarErrors()`) — solo nel pattern, non in codice.
- **Dispatcher/triage**, **loop auto-fix in sandbox** (agenti che riparano dentro il recinto, Milano), **3 circuit-breaker**, gate **Q6/Q7** cablati.
- **Precondizioni di ATTIVAZIONE (§9 del pattern)**: **W4** (l'`error_logs` NON deve condividere il DB di produzione del sandbox — altrimenti injection-del-segnale + sandbox-escape = catena verso prod) e **W3** (ri-verifica scope-drift a ogni transizione mission). Finché non sono verde, **l'autonomia NON si accende**, anche a codice pronto. NB: la costruzione del receiver+coda si può fare PRIMA (è build, non accensione); l'accensione dell'autonomia no.
- **Grounding aperto per la fetta receiver**: in QUALE repo vive il receiver di `nexus.florenceegi.com`? (candidati da verificare: `nexus-cockpit`, `oracode-nexus`, o servizio nuovo). Va deciso col CEO in fase di design, non dedotto.

**Mission aperta tangenziale:** `M-NEXUS-015` (draft, oracode) — "Deprecazione cornice stale gerarchia Nexus + SSOT-correzione stato corrente". NON è il loop; è correzione di cornice. Non confonderla con l'Anello.

---

## 3. ⚠️ NOVITÀ CRITICA da giugno: il ciclo delle capacità è LIVE e GATERÀ il tuo lavoro

La notte del 17→18/07 (M-OS3-158) è nato ed è stato acceso **il ciclo produttivo delle capacità** —
"software conteggiabile". **È attivo in modalità BLOCCO su `os3-matrix` e `oracode`** (i due repo dove
probabilmente lavorerai per l'Anello). Quindi il TUO lavoro passerà per questi cancelli — non sono un
optional, sono nervi deterministici:

- **Durante lo sviluppo**, quando un blocco coeso di codice diventa una responsabilità nominabile, dichiara la capacità: `os3-matrix/bin/oracode-capability-declare <slug-kebab> --mission <M-ID> --responsibility "una frase"` (fix su capacità esistente → `--ref <slug>`). Costa <60s. Scrive nel quaderno `docs/lso/CAPABILITY_INTENTS.jsonl`.
- **All'`advance --to=executing`** la mission esige almeno una capacità dichiarata (il *preventivo*); deroga `--no-capability-forecast="<motivo ≥15>"`.
- **Ai commit** di classe-capacità (`[FEAT]/[FIX]/[REFACTOR]/[SECURITY]/[PERF]/[ARCH]`) il messaggio DEVE portare `[grano:<slug>]` con slug dichiarato, o il commit è **bloccato**. Esenti: `[DOC]/[TEST]/[CHORE]/[CONFIG]/[I18N]/[DEPLOY]/[DEBITO]/[WIP]/DOC-SYNC/MISSION/DEBUG`.
- **Al close**, la FASE 6 canonica fa giudicare le capacità dal **critico indipendente** (`ssot-capability-critic`, criterio-riusabilità: "il codice esistente poteva servire? no → conta"), poi le conta: rapporto `capability_forecast` nel record. Serve il file-verdetti con `spawn_fingerprint` del critico.
- Una **convocazione per-prompt** ti ricorderà da sola i grani della mission in focus (è un hook, non memoria).
- Fondamento (LEGGILO): `os3-matrix/docs/design/M-OS3-158_DESIGN_innesco_capacita.md` (v2.2) + memoria `ciclo-produttivo-capacita-oro-colato` + `oracode/docs/paradigm/Oracode_base.md §3.3` (RAV, software conteggiabile, SOLID-C).
- Verbi: `oracode-capability-declare`, `oracode-capability-intents` (reader del quaderno: `--pending/--fallen/--count`), `oracode-capability-close-mission`.

**Perché ti riguarda l'Anello:** il ciclo delle capacità È la metà a valle dell'Anello, maturata. L'anello
esterno del pattern (*agente propone → umano ratifica → si propaga negli SSOT*) è esattamente il macchinario
critico+audit+doc-sync che ora è reale e collaudato. Q7 ("misura esterna, no auto-giudizio") = il critico
indipendente. Q6 ("causa rimossa, non allarme zittito") ha ora un metro: il conteggio (un fix che rimuove
la causa fa +1; uno che zittisce non conta). **Progetta l'Anello sapendo che questa metà esiste già e funziona.**

---

## 4. Il collaudo beta in corso (contesto, non tuo compito)

In parallelo, su **Dimostralo** (organo EGI, doc-in-hub → EGI-DOC), gira il **beta** del ciclo capacità:
prime ~10 mission in sessioni fresche, con `os3-matrix/docs/admin/BETA_PRELUDIO.md` e il verbo
`os3-matrix/bin/oracode-beta-report`. Non è lavoro tuo, ma se INCIAMPI nel ciclo capacità mentre costruisci
l'Anello, **registralo anche tu**: `os3-matrix/bin/oracode-beta-report "<cosa>"`. È dato di collaudo.

---

## 5. Correzioni all'handoff di giugno (cose SUPERATE — non seguirle)

- **doc-sync**: è **v3** (agente `subagent_type=doc-sync-v3`, engine `oracode-docsync`), NON v2. Topologia hub Q-019 risolta (M-OS3-155): un repo doc-in-hub scrive nell'hub.
- **Spawn agenti**: NON più "uno alla volta". **Modulatore adattivo**: parallelizza i task indipendenti (design multi-dominio, verifiche); al primo 429 dimezza. Il grado dipende da quante sessioni il CEO tiene aperte (memoria `regime-multisessione-e-modulatore-429`). Chiedi il regime a inizio sessione.
- **Caveman mode**: NON attivo. Rispondi in italiano piano e completo.
- **FASE 6**: `os3-audit-specialist` + `doc-sync-v3` + `finalize`; la coppia report NON è più obbligatoria (M-OS3-112). Ora c'è anche il gate capacità (§3).
- **Date**: oggi è **2026-07-18**. L'handoff di giugno è di 5 settimane fa.

---

## 6. Infra (VERIFICA prima di usare — non dedurre)

- **Milano / oracode-dev** = `i-079808547853ab7f6`, **eu-south-1**, la sandbox dell'Anello. Utente dev = `ssm-user`, repo sotto `/srv/oracode/repos/`. Accesso SSM: profilo `fabiocherici-deploy`, document `AWS-StartPortForwardingSessionToRemoteHost` per i tunnel / `AWS-RunShellScript` per i comandi. SSOT infra: `os3-matrix/docs/aws/infrastructure.md` — **leggilo prima di qualsiasi affermazione infra** (niente Laravel Forge: dismesso).
- **Tunnel DB locali** (HeidiSQL): `os3-matrix/docs/aws/DB_TUNNELS.md` (rag_nexus su porta locale **5434**, non 5433 — c'è un Postgres locale che occupa la 5433).
- RDS `florenceegi-postgres-dev` (Stoccolma, condiviso ~12 organi). **MAI UPDATE/DELETE su prod senza ok CEO.**

---

## 7. Disciplina + relazione col CEO (invariante)

- Ciclo mission SOLO via `os3-matrix/bin/mission`; MAI editare i registry a mano (guard). Mission nel project di competenza (design/pattern Anello → **oracode**; recinto/motore → os3-matrix; handler → EGI). Aprire una mission non è veloce: title/scope/trigger/type/ID → **ok CEO**.
- Dottrina del Supervisor: TRIAGE → design agli `engineer-*` (su SSOT, mai a memoria) → codice ai `dev-*` → test a `dev-testing-qa` → misura a `engineer-evaluator`. Il Supervisor orchestra e sintetizza, non scrive design di dominio a memoria.
- CEO Fabio Cherici: italiano piano; **mai proporre pause/wrap-up** (decide lui); **mai accondiscendente**, prendi posizione; **gate CEO** su ogni piano; le azioni tecniche le esegui TU (mai chiedergli di toccare codice/env; lui genera i segreti); no scorciatoie. REGOLA ZERO su tutto.
- Superficie di difesa TOTP (hooks/settings/seed): scrittura gated → prepara il comando byte-esatto, poi chiedi il codice al CEO (grant one-shot 60s, retry byte-identico — non bruciare codici cambiando il comando).

---

## 8. Primo passo concreto per la sessione fresca

1. Dichiara il regime multi-sessione (429) col CEO.
2. Leggi le fonti §1 alla sorgente. Verifica lo stato §2 (specie: receiver/coda ancora assenti? W3/W4 ancora aperte?).
3. Conferma col CEO **quale fetta**: receiver+coda `nexus_fix_queue` (raccomandata), o prima W3/W4, o altro. E, per il receiver, **in quale repo vive** `nexus.florenceegi.com`.
4. Design con `engineer-architecture` + `engineer-security` sul pattern (§3bis dedup, §5 Q7, barriera L8/L9), poi build test-first con `dev-*`. Ricorda: il tuo stesso lavoro passa dal ciclo capacità (§3) — dichiara i grani mentre costruisci.
5. Chiudi in FASE 6 canonica, mai alterata.

> Timbra CONSUMATO quando la prima mission figlia della fetta è aperta.
