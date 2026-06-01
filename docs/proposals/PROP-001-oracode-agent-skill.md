# PROP-001 — Oracode Agent Skill (dottrina single-source, on-demand)

```
@package  oracode/proposals
@author   Padmin D. Curtis (CTO-AI) for Fabio Cherici (CEO)
@version  0.1.0 (proposal)
@date     2026-06-01
@purpose  Eliminare il drift della dottrina duplicata negli agenti e rendere
          disponibile la procedura P0 esatta al point-of-use, senza gonfiare
          il boot-context. Solo leve a valore dimostrato.
@status   PROPOSAL — richiede approvazione CEO + mission per enactment.
          Nessuna modifica a codice/SSOT normativi è stata eseguita.
```

---

## 0. Origine

Analisi del tool MIT `book-to-skill` (progressive-disclosure: SKILL.md leggero
always-on + chapter caricati on-demand). Il tool **as-is non è adottabile** per
formare agenti Oracode (vedi §5). Ma la sua **architettura** risolve un problema
reale e già attivo nel nostro sistema, dimostrato sotto con evidenza.

---

## 1. Problema — dottrina duplicata e GIÀ driftata

Misura sul filesystem (`/home/fabio/.claude/agents/`, 2026-06-01):

- **7 agenti su 11** ri-dichiarano dottrina CORE nei propri prompt (43 righe).
- Concentrazione in `oracode-specialist.md` (21 righe, enumera 12 P0 a mano).

La copia a mano **non è solo a rischio drift — è già divergente in produzione**:

| `oracode-specialist.md` afferma | `CLAUDE_ORACODE_CORE.md` (verità) | Stato |
|---|---|---|
| `P0-0 (No Alpine/Livewire)` | non esiste | inventato |
| `P0-10 (Anti-MongoDB)` | P0-10 = Anti-bypass data layer | sbagliato |
| `P0-9 (i18n 6 lingue)` | i18n completa (istanza Poli = it/en) | stantio |
| copre `P0-0..P0-12` | il CORE arriva a **P0-13 Test-First** | manca 1 P0 |

**Conseguenza operativa concreta:** un agente interrogato su "come applico P0-10"
restituisce oggi la regola **errata**, e ignora del tutto P0-13. L'autorità sulla
dottrina è disallineata dalla dottrina. Nessun gate lo rileva: è prosa nei prompt,
non codice sotto enforcement.

Questo è il caso d'uso che giustifica la proposta. Non è prevenzione di un rischio
teorico; è correzione di un difetto attivo.

---

## 2. Diagnosi della causa

Due cause distinte, due rimedi distinti:

1. **Nessuna single-source per gli agenti.** Ogni agente che ha bisogno di una
   regola la ricopia. N copie → N traiettorie di drift, manutenute a mano.

2. **La procedura completa non esiste da nessuna parte.** Dal P0-8 in giù il CORE
   ha la riga-istruzione, non il metodo con esempi. L'agente che deve *applicare*
   P0-8 improvvisa la procedura → violazione (impact analysis incompleta).

Il CORE always-on è già snello (~2.8K token). Il problema **non è il peso** —
è **assenza di fonte condivisa** + **assenza di profondità procedurale accessibile**.

---

## 3. Proposta — solo le leve a valore dimostrato

### 3.1 Oracode Agent Skill (single-source, on-demand)

Una skill `oracode-doctrine` con la struttura progressive-disclosure:

```
oracode-doctrine/
  SKILL.md                      sempre-on, sottile — indice P0 + pilastri + topic-index
  rules/p0-08-flow-analysis.md  procedura piena P0-8 (4 fasi + esempi), on-demand
  rules/p0-13-test-first.md     i 3 flussi worked-out, on-demand
  rules/...                     una per P0 con profondità reale
  matrix/trigger-doc-sync.md    i 6 tipi con esempi di classificazione, on-demand
  topic-index                   "flow analysis" → p0-08 ; "GDPR" → ... ; deterministico
```

- Gli **agenti referenziano la skill**, non ricopiano la dottrina. Le 43 righe
  duplicate si riducono a un puntatore. Il drift di §1 diventa impossibile per
  costruzione: una sola fonte.
- L'agente carica la **procedura esatta solo quando la regola entra in gioco**.
  13 P0 di profondità disponibili al costo di ~1 caricata per volta.

### 3.2 Inversione obbligatoria: verbatim > sintesi per contenuto normativo

`book-to-skill` impone "synthesize, never copy raw text" (Quality Rule 7). Per
dottrina normativa è **da invertire**: le P0 sono prescrittive, la sintesi di un
LLM ne fa driftare il significato. Regola per `oracode-doctrine`:

> Contenuto normativo (P0, pilastri, REGOLA ZERO) = **verbatim dal CORE**, mai
> parafrasato. La skill aggiunge *profondità procedurale ed esempi*, non riscrive
> la norma.

Questa singola regola è ciò che separa "formazione esatta" da "riassunto plausibile".

### 3.3 CORE resta boot-context, non lazy

REGOLA ZERO e l'enforcement P0 **non** si caricano on-demand: devono essere sempre
attivi. Diventano on-demand **solo le procedure dettagliate** dietro ogni regola.
SKILL.md della skill è derivato dal CORE (verbatim) e si rigenera dal CORE — il
CORE resta l'unico SSOT normativo; la skill è la sua proiezione navigabile.

### 3.4 Pattern REPL-navigation per SSOT grandi

Adottare il pattern di `book-to-skill` Step 2.6: su SSOT/registry grandi gli agenti
usano `grep -n` + `sed -n a,b p` invece di `Read` integrale, per navigare al
frammento rilevante senza bruciare context. Riusabile subito dagli agenti LSO.

---

## 4. Misurabilità (KPI, perché è una proposta seria non un'opinione)

| Leva | Baseline oggi | Metrica post-enactment |
|---|---|---|
| Drift dottrina | 4 divergenze provate in 1 agente | divergenze CORE↔agenti = 0 (single-source) |
| Righe duplicate | 43 su 7 agenti | → puntatori; righe normative duplicate = 0 |
| Profondità procedurale | riga-istruzione | token procedurali disponibili a baseline invariato |
| Violazioni P0 | conteggio finding GATE attuale | finding GATE prima/dopo, A/B stessa task |

La 4ª riga è il numero che chiude il caso: stessa task, agente con/senza skill,
si contano i finding del GATE già esistente.

---

## 5. Cosa NON si propone (delimitazione esplicita)

- **NON** adottare `extract.py` / pipeline PDF→testo. Le doc Oracode sono già
  markdown; la pipeline è irrilevante. (Testata su PDF reali: estrazione buona,
  ma fuori scope per noi.)
- **NON** importare la filosofia "synthesize over preserve" sul contenuto normativo
  (vedi §3.2 — invertita).
- **NON** spostare il CORE/enforcement on-demand (vedi §3.3).

Includere queste esclusioni è parte della serietà della proposta: si adotta il
meccanismo, non il pacchetto.

---

## 6. Rischi

| Rischio | Mitigazione |
|---|---|
| SKILL.md diverge dal CORE | generato/validato dal CORE; un check CI confronta i blocchi normativi verbatim |
| Sovra-frammentazione (troppi chapter) | una rule-file per P0, non più fine; topic-index unico punto di routing |
| Agenti non adottano la skill | rimuovere la dottrina ricopiata dai prompt forza il riferimento alla fonte |

---

## 7. Percorso di enactment

Questa proposta **non** è enacted. Richiede, nell'ordine:

1. Approvazione CEO su scope (decisione architetturale — nuovo organo skill).
2. Mission dedicata (FASE 0 → FASE 6 con DOC-SYNC).
3. Prima iterazione minima: SKILL.md (verbatim dal CORE) + 2 rule-file
   (`p0-08`, `p0-13`) + topic-index + bonifica della lista P0 driftata in
   `oracode-specialist.md`. Misura A/B sul GATE.

---

*PROP-001 — proposta di potenziamento Oracode. Status: PROPOSAL.*
