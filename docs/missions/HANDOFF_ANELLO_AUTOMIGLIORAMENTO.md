# HANDOFF — Anello di Auto-Miglioramento del Nexus

> **Per**: la nuova sessione che costruirà l'Anello.
> **Da**: sessione 270ecfe1 (recinto preventivo go-live), 2026-06-25.
> **Validità**: fino all'apertura della mission di build dell'Anello. **CONSUMATO** quando il design end-to-end è ratificato dal CEO e la prima mission figlia è aperta.
> **Regola d'oro nel leggere questo doc**: è un riassunto orientativo. Ogni fatto operativo (path, stato, comando) **verificalo alla fonte** prima di agire (REGOLA ZERO). Non dedurre dall'handoff: usalo come mappa, non come verità.

---

## 0. TL;DR (leggi prima questo)

- **Obiettivo finale**: l'**Anello di Auto-Miglioramento** — un errore reale (UEM in EGI) → segnale al Nexus → agenti autonomi diagnosticano e correggono in sandbox → fix testato e valutato → propagato agli SSOT via DOC-SYNC → "l'intelligenza sale" → **l'umano (CEO) ratifica TUTTO, inclusa l'evoluzione di Nexus stesso**.
- **Stato**: l'Anello è **ancora tutto da costruire**. Quello che esiste è la **precondizione di sicurezza** — il *recinto* — che impedisce agli agenti autonomi di scrivere fuori scope o toccare la costituzione. Recinto **completo e LIVE** su locale (WSL) + Milano (oracode-dev). Vedi §4.
- **Prossimo passo**: analisi profonda + **design end-to-end dell'Anello** (engineer-* su SSOT, mai a memoria), poi build a mission. Il CEO deve dare l'ok esplicito su quale fetta attaccare per prima (il *segnale* UEM→Nexus, oppure il design completo del loop).
- **FASE 0 già chiusa**: M-NEXUS-000 ha prodotto il pattern SSOT e la denylist Tier-0 (vedi §5).

---

## 1. Da dove siamo partiti — il background (Satya Nadella)

L'innesco concettuale è stato un post di **Satya Nadella** (CEO Microsoft) su "frontier ecosystem vs frontier model": il vantaggio non è il modello di frontiera in sé, ma l'**ecosistema** che lo circonda e il **loop** che lo fa migliorare (analogia Waze — regime non-asintotico: più lo usi, più migliora, senza plateau). Abbiamo verificato la tesi in modalità steelman (bagno di umiltà), e il CEO ha chiesto: **"siamo oltre Nadella?"**

Da lì il ragionamento del CEO (testuale, parafrasato):
1. In **EGI** c'è già un tool che intercetta un errore (UEM) e lo notifica a Telegram.
2. **Oracode Nexus** gira / girerà su `code.florenceegi.com` (il dev-box Milano, code-server + Claude Code).
3. **E se** l'info del bug venisse segnalata a un tool su `code.florenceegi`, che un agente legge ogni N minuti → un agente diagnostica → corregge in sandbox → testa → propaga? **Non saremmo a un'automazione notevole, forse oltre quella predetta da Nadella?**

Questa è la mission: il **miracolo**. "Ogni cosa che si impara andrà messa alla prova; sarà quella l'intelligenza che sale; e l'umano darà consenso anche all'evoluzione di Nexus stesso."

---

## 2. Come lavorare col CEO (Fabio Cherici) — NON negoziabile

Questo è il layer relazionale. Caricato a ogni sessione da `~/.claude/CLAUDE.md`, ma qui condensato perché è cruciale.

- **Lingua**: rispondi in **ITALIANO**, semplice, ordinato. No gergo di processo, no liste frastagliate fini a sé.
- **Stile**: in questa sessione è attivo **CAVEMAN MODE** (terse). Sostanza tecnica intatta, fronzoli via. (Si disattiva con "stop caveman"/"normal mode". I documenti/commit si scrivono in prosa normale.)
- **MAI proporre di fermarsi/chiudere sessione o giornata** — la pausa la decide il CEO. No wrap-up, no "infermiera". Produci e prosegui col prossimo step. (Corretto esplicitamente in questa sessione: avevo proposto pause, NON va fatto.)
- **MAI accondiscendente**: prendi posizione e difendila, non flip-floppare. Quando il CEO corregge e sei d'accordo → **cambia davvero** comportamento, non solo "hai ragione".
- **Gate CEO**: mai implementare un piano/spec senza ok esplicito; mai sovrascrivere una sua decisione ESPLICITA col tuo giudizio (semmai segnala); prima di contraddirlo su un sistema che ha progettato, **rileggi il suo design**.
- **Rileggi il suo brief parola per parola** prima di domandare. Mai attribuirgli affermazioni che non ha fatto.
- **Le azioni tecniche le esegui TU**: mai chiedere al CEO di toccare codice/flag/env/DB. Lui genera i segreti, tu li usi (`read -rs`, mai in chiaro).
- **No quick-fix, no scorciatoie, no compromessi** sulla qualità.
- **REGOLA ZERO**: info mancante → verifica alla fonte (file/comando/grep) o CHIEDI. Mai dedurre architettura/infra/codice da stringhe o da memoria. (In questa sessione: avevo dedotto che il Telegram handler non esistesse → il CEO: "smetti di dedurre e indaga". Esisteva eccome.)

---

## 3. La Dottrina del Supervisor (come orchestrare il lavoro)

Sei il **CTO-orchestratore grounded**: TRIAGE → POOL → SINTESI MISURATA → CORREZIONE.
- **Design/architettura/tradeoff** → `engineer-*` (su SSOT/ADR/fonti lette e citate). MAI design di dominio a memoria.
- **Codice di produzione** → `dev-*` (php-laravel, typescript-node, python, sql, frontend, algorand…). I dev NON sono dattilografi di un tuo design: il design nel loro prompt è un artefatto engineer/SSOT citato per path.
- **Test** → `dev-testing-qa`. **Difesa/collaudo** → DeepDebug.
- **Misura-prima**: output ad alta posta → metro esterno (`engineer-evaluator`), non fiducia.
- **Spawn agenti UNO ALLA VOLTA** (seriale, anti rate-limit 429).
- L'audit di chiusura usa `os3-audit-specialist` (tende a degenerare in testo di dottrina → dagli prompt **direttivo**: "USA i tool, produci verdetto PASS/WARN/BLOCK con finding per path").

---

## 4. Cosa è stato costruito: il RECINTO (precondizione, COMPLETO + LIVE)

Il recinto è il presupposto di sicurezza dell'autonomia: impedisce a un agente autonomo di scrivere fuori dal suo scope o di toccare i file costituzionali. Costruito in 3 mission **chiuse**:

- **M-OS3-121** (os3-matrix): recinto preventivo per-file — 2 chokepoint (Write/Edit + Bash) + writeset + deny-set Tier-0 + detective.
- **M-OS3-122** (os3-matrix): hardening (fail-closed) + disgiunzione multi-mission (U6). U4b (firma) → BACKLOG per decisione motivata (firma sha256 senza chiave = tamper-evident non tamper-proof; il namespace neutro + detective già coprono).
- **M-OS3-123** (os3-matrix): **go-live** su LIVE. Record: `os3-matrix/docs/missions/M-OS3-123_GOLIVE_RECORD.md`.

### Componenti (tutti in `/home/fabio/os3-matrix/`)
- `hooks/fence-policy.sh` — lib condivisa, 3 funzioni pure **FAIL-CLOSED** (`fence_normalize_path`, `fence_is_tier0`, `fence_in_writeset`). Un errore non apre MAI il recinto.
- `hooks/fence-bash-guard.sh` — chokepoint Bash (PreToolUse): estrae i target di scrittura (`>`, `tee`, `sed -i`, `cp/mv`, `git checkout`, `patch`, `dd of=`, anche path relativi e `cp -t`), Tier-0 deny-always, writeset se mission attiva, comandi opachi fail-closed.
- `hooks/mission-state-guard.sh` v0.4.0 — chokepoint Write/Edit: Tier-0 deny-always **prima** dello skip; writeset in stato executing; fail-closed se la lib manca ma il denyset c'è.
- `bin/project-writeset`, `bin/amend-writeset` (token one-shot CEO), `bin/writeset-overlap`, `bin/tier0-detect` (baseline/check).
- `bin/mission` (motore): `--writeset` all'open; a `--to=executing` proietta il writeset e **rifiuta overlap** fra mission parallele; al close rimuove il proiettato.
- **Namespace neutro** `~/.os3-policy/` (writeset + denyset, FUORI dal write-set dell'agente — difesa CWE-642 anti auto-modifica della policy) + token one-shot in `~/.os3-approvals/`.

### Stato LIVE (verificato 2026-06-25)
- **Locale (WSL DESKTOP-1GTFN0C)**: guard in `/home/fabio/.claude/hooks/`, denyset `/home/fabio/.os3-policy/tier0-denyset`, baseline `tier0-baseline.json` (6 file). Smoke GREEN.
- **Milano (oracode-dev `i-079808547853ab7f6`, eu-south-1a)**: go-live al layer **globale `ssm-user`** via SSM. Audit OS3 **PASS**, smoke A/B/C GREEN. Backup `.pre-golive-20260625_181723`. Vedi §6 per la topologia.
- **Modello fail-closed**: basta che UN hook esca con codice 2 per bloccare il tool. Il recinto è **dormiente finché non c'è un agente autonomo**: per le sessioni umane normali è trasparente (blocca solo Tier-0 e fuori-writeset).

---

## 5. FASE 0 dell'Anello — già chiusa (M-NEXUS-000)

Mission **M-NEXUS-000** (oracode, closed): ha prodotto il paradigma dell'Anello.
- `docs/paradigm/lso/PATTERN_ANELLO_AUTOMIGLIORAMENTO_v1.0.0.md` — il pattern (LEGGILO per primo).
- `docs/paradigm/kernel/TIER0_CLAUSOLE_IMMUTABILI_v1.0.0.md` — le clausole costituzionali immutabili (cosa l'Anello NON può MAI toccare).
- `docs/missions/M-NEXUS-000_SHARED.md` — doc di **coordinamento con la sessione Fucina** (organo pesantemente coinvolto). Rileggilo: Fucina ci ha aggiunto cose.

**Layer L/Tier**: l'Anello tocca L9 (Reflection / "Gamba B", la Soglia 2 L8→L9). Nomenclatura canon M-FUC-040: **"L" = solo maturità (L0-L11)**; **tier = T1/T2/T3** (GLOBALE/HUB/ISTANZA); **rischio = R1-R4**. Non confondere L con tier.

---

## 6. Topologia infra (verificata, NON dedurre)

3 EC2:
- **florenceegi-private** (Stockholm, app, `i-0940cdb7b955d1632`) — NON target recinto.
- **nexus-fabiocherici** (Stockholm, RAG vetrina, `i-0a16a9cfcf84714dc`) — NON target.
- **oracode-dev / Milano** (`i-079808547853ab7f6`, **eu-south-1a**) — il **dev-box = sandbox dell'Anello**.

**Milano (dettaglio critico, verificato via SSM 2026-06-25):**
- Utente dev unico = **`ssm-user`** (gira `code-server@ssm-user` + `claude`, possiede `/srv/oracode/repos/*`). `ec2-user` quasi vuoto.
- Repo sotto **`/srv/oracode/repos/`** (NON /home): os3-matrix, oracode, EGI, FORTINO, DeepDebug, le-vespe-cafe, egi-credential, EGI-DOC, EGI-HUB…
- Config Claude Code globale = **`/home/ssm-user/.claude/`** (unico layer utente) + copie hook **per-organo** dentro ogni repo (congelate allo scaffold, NON si auto-aggiornano).
- **Accesso SSM**: profilo `fabiocherici-deploy`, document **`AWS-RunShellScript`** (NON RunShellCommand), region `eu-south-1`. Scrivere come `sudo -u ssm-user bash -lc` (altrimenti file root-owned in ~ssm-user = rotto).
- Memoria: `~/.claude/projects/-home-fabio-oracode/memory/milano-devbox-topology.md`.
- RDS: `florenceegi-postgres-dev` (Stockholm, condiviso da ~12 organi). **MAI UPDATE/DELETE su DB produzione senza ok CEO esplicito.**
- **Questa sessione gira su WSL locale**, non su EC2.

**L'innesco UEM (il "segnale"):** il vero handler EGI è `/home/fabio/EGI/app/ErrorManager/Handlers/TelegramNotificationHandler.php` (M-EGI-274). È il punto da cui derivare il `NexusNotificationHandler` (UEM → Nexus, non solo Telegram).

---

## 7. Cosa resta da costruire — l'Anello vero (tutto da fare)

Componenti del loop (da progettare con engineer-* su SSOT, poi build con dev-*):
1. **Segnale**: `NexusNotificationHandler` — l'UEM di EGI emette verso il Nexus (un endpoint/coda su `code.florenceegi.com`), non solo Telegram.
2. **Dispatcher + triage**: un agente che legge i segnali (polling ogni N minuti) e classifica/instrada.
3. **Loop auto-fix in sandbox**: agenti che diagnosticano e correggono **dentro il recinto** (Milano), con writeset per-mission.
4. **Eval/quarantena**: il fix va **messo alla prova** (test-first P0-13) e valutato (engineer-evaluator) prima di propagare; quarantena se fallisce.
5. **Propagazione SSOT**: DOC-SYNC v2 porta l'apprendimento agli SSOT ("l'intelligenza che sale").
6. **Circuit-breaker + kill-switch**: `tier0-detect` come canary (AI_CANARY_FAILED → stop), limiti di blast-radius.
7. **Ratifica umana**: il CEO approva TUTTO, inclusa l'evoluzione di Nexus stesso. Niente auto-merge su SSOT/Tier-0.

**Backlog recinto** (non bloccante per iniziare l'Anello): U4b (firma sig_version + HMAC-con-chiave); propagazione T1→T3 delle copie hook per-organo su Milano (Strategia Delta, igiene).

---

## 8. Disciplina operativa (tooling — il "come")

- **Ciclo mission SOLO via `/home/fabio/os3-matrix/bin/mission`** (open/advance/close/finalize). **MAI editare i registry a mano** (c'è un guard che blocca). Hook `mission-registry-guard` blocca anche letture con node/python che nominano il registry → leggi con `jq`/`grep`/`cat`.
- **Le mission si aprono nel project di competenza** (Anello/paradigma → oracode; recinto/motore → os3-matrix; fix EGI → EGI), pena statistiche sballate.
- **FASE 6 close canonica, mai alterata**: reports (technical + extended) + `os3-audit-specialist` (advance→auditing lo richiede registrato) + `doc-sync-v2` + `finalize` (rinfresca stat). `--mission=M-XXX` obbligatorio se >1 mission attiva.
- **GATE**: routing (trigger 3 = serve spawn engineer-* registrato per-mission); SSOT-FIRST (leggi SSOT prima; `--no-ssot-needed` solo waiver motivato per CWD-mismatch).
- **ID mission**: un solo trattino interno valido (es. `M-NEXUS-000`, NON `M-NEXUS-LOOP-000`).
- **Aprire una mission non è veloce**: title/scope/trigger/ID → ok CEO. Non aprirla a cuor leggero.
- **Commit+push senza chiedere** a fine step (per step sui lavori grandi, mai un unico commit finale). **Verifica SEMPRE `git branch --show-current` non vuoto** prima di commit/push.
- **Cross-repo**: `git -C <dir>` o `cd /abs/path &&`; attento alla persistenza CWD tra chiamate Bash.
- **Degradazione sessione**: checkpoint a 3k righe, STOP a 4500+. (Questa sessione è enorme → per questo si apre la nuova.)

---

## 9. Sicurezza operativa

- **MAI** persistere segreti/token in chiaro (`read -rs` + verifica lunghezza). Il CEO genera, Padmin conserva.
- Scaffold-by-copy di un organo: escludi `.env`/segreti + `.gitignore` PRIMA di `git add`; verifica history pulita prima del primo push.
- **MAI** inviare email/comunicazioni esterne a utenti reali senza ordine esplicito CEO.
- **MAI** UPDATE/DELETE su DB di produzione senza ok esplicito CEO.
- Processi in background: **monitorali davvero** e comunica l'esito.

---

## 10. Idee/decisioni del CEO da non perdere

- **Sigillo-LSO on-chain** (memoria `sigillo-lso-on-chain-notarization.md`): sigillare un LSO alla consegna su Algorand come prova anti-manomissione/anti-furto; evidenziale, niente problema-chiavi; ADR futuro via engineer-blockchain.
- **Doppia firma**: il CEO ha chiarito che la regola della doppia firma andava applicata SOLO a scritture su DB, non al deploy (un collega "si era incartato col deploy").
- La preferenza del CEO: **costruire il recinto PRIMA** del loop è stato approvato esplicitamente ("va benissimo aver creato il recinto prima"), ma **l'obiettivo resta l'Anello**.

---

## 11. Primo passo concreto per la nuova sessione

1. Leggi alla fonte: `PATTERN_ANELLO_AUTOMIGLIORAMENTO_v1.0.0.md`, `TIER0_CLAUSOLE_IMMUTABILI_v1.0.0.md`, `M-NEXUS-000_SHARED.md`, questo handoff, e `M-OS3-123_GOLIVE_RECORD.md`.
2. Conferma col CEO **da quale fetta partire**: il *segnale* (handler UEM→Nexus, l'innesco concreto e tangibile) **oppure** il *design end-to-end* del loop prima di toccare codice.
3. Apri la mission nel project giusto (probabile: oracode per il design/paradigma; EGI per l'handler) **solo con ok CEO** su title/scope/trigger/ID.
4. Design con engineer-* su SSOT (architecture, security, evaluator), MAI a memoria. Poi build test-first con dev-*.

> **Timbra questo handoff CONSUMATO** quando il design dell'Anello è ratificato e la prima mission figlia è aperta.
