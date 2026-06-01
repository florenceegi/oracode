# Oracode Agent Skill — dottrina single-source, on-demand

```
@package  oracode/paradigm/ssot
@author   Padmin D. Curtis (CTO-AI) for Fabio Cherici (CEO)
@version  1.0.0
@date     2026-06-01
@purpose  SSOT dell'architettura "Agent Skill": come gli agenti Oracode ricevono
          la dottrina normativa da una fonte unica (verbatim dal CORE) e le
          procedure profonde on-demand, senza duplicazione e senza drift.
@status   PRODUCTION (proof minimale) — istituito da M-OS3-029.
```

> Licenza: MIT. Parte del paradigma Oracode pubblico.

---

## 1. Problema

Gli agenti specializzati (`.claude/agents/*.md`) ri-dichiaravano la dottrina P0 nei
propri prompt, **a mano**. N copie → N traiettorie di drift. Misurato in produzione
(2026-06-01) su `oracode-specialist.md`: **5 divergenze** dal CORE — P0-0 inventato,
P0-3 e P0-13 saltati, P0-9 stantio ("6 lingue"), P0-10 sbagliato ("Anti-MongoDB"
invece di "Anti-bypass data layer"). Un agente interrogato rispondeva **errato**.

## 2. Principio

**Single-source verbatim.** La dottrina normativa (REGOLA ZERO, pilastri, 13 P0)
vive in **una** fonte — `CLAUDE_ORACODE_CORE.md` — e viene **proiettata** in una
skill, mai ricopiata a mano negli agenti. Gli agenti **citano dalla skill**.

Due livelli, due meccanismi:

| Livello | Cosa | Meccanismo Claude Code | Caricamento |
|--------|------|------------------------|-------------|
| Norma (sempre valida) | 13 P0, pilastri, REGOLA ZERO | `skills:` frontmatter dell'agente | **preload** all'avvio (affidabile) |
| Procedura profonda | metodo P0-8, flussi P0-13, … | file `rules/` + Skill tool | **on-demand** (token-light) |

Regola di contenuto: **il normativo è verbatim dal CORE, mai parafrasato.** La skill
aggiunge *profondità procedurale ed esempi*, non riscrive la norma. In caso di
divergenza, **vince il CORE** (unico SSOT normativo; la skill è la sua proiezione).

## 3. Implementazione (proof minimale — M-OS3-029)

- Skill `~/.claude/skills/oracode-doctrine/`:
  - `SKILL.md` — sottile, sempre-on: 13 P0 + pilastri + priorità, **verbatim**; topic-index; provenance.
  - `rules/p0-08-flow-analysis.md`, `rules/p0-13-test-first.md` — procedure profonde on-demand.
  - `topic-index.md` — routing deterministico topic → file.
- Agente pilota `oracode-specialist.md`: cablato via `skills: [oracode-doctrine]`;
  rimossa la lista P0 a mano, sostituita da puntatore alla skill (single-source puro).
- Test deterministico `os3-matrix/tests/m-os3-029/test_skill_verbatim.sh`: deriva i
  13 P0 **dal CORE a runtime** e assert che SKILL.md li contenga verbatim + struttura
  skill + agente de-driftato. È il **check anti-drift SKILL.md↔CORE** per costruzione.

### Prova A/B
Agente PRE (lista a mano): P0-10 = "Anti-MongoDB", P0-13 assente, range "P0-0..P0-12".
Agente POST (skill): P0-10 = "Anti-bypass data layer", P0-13 = "Test-First Discipline"
presente, range "P0-1..P0-13", nessuna P0-0 — **citando la skill come fonte**.

## 4. Estensione (mission successive)
Una `rules/p0-NN-*.md` per P0 (anti sovra-frammentazione: una per regola, non più
fine). Cablaggio degli altri agenti dottrina-pesanti (os3-audit, os3-gate, doc-sync)
**dopo** la prova. Agenti codice-pesanti: beneficio marginale, valutare caso per caso.

## 5. Provenance & Attribution

Il **meccanismo** progressive-disclosure adottato qui (SKILL.md sottile sempre-on +
file caricati on-demand + topic-index per il routing) è ispirato al tool open-source:

```
Tool:       book-to-skill
Autore:     Virgilio Borges  (GitHub: virgiliojr94)
Licenza:    MIT — Copyright (c) 2025 virgiliojr94
Repository: https://github.com/virgiliojr94/book-to-skill
```

**Cosa adottiamo:** il *formato e il meccanismo* (progressive disclosure: skill
sottile + chapter/rule on-demand + topic-index deterministico).

**Cosa NON adottiamo:** la pipeline di estrazione documenti PDF→testo (`extract.py`)
— i documenti Oracode sono già markdown, quindi irrilevante per noi.

**Inversione deliberata rispetto al tool:** book-to-skill raccomanda di *sintetizzare*
il contenuto. Per la dottrina normativa noi facciamo il **contrario** — contenuto
normativo **verbatim**, mai parafrasato (la sintesi di un LLM ne farebbe driftare il
significato prescrittivo).

**Ringraziamento.** Riconosciamo e ringraziamo Virgilio Borges per il lavoro su
book-to-skill, che ha ispirato l'architettura di questa skill. Nessuna appropriazione:
usiamo un meccanismo open-source MIT, lo dichiariamo apertamente, ne attribuiamo la
paternità e ne rispettiamo i termini. Dove dovessimo riusare codice o struttura del
tool, la nota di copyright MIT sopra viene mantenuta come richiesto dalla licenza.

---

*Oracode System — SSOT paradigma. Istituito da M-OS3-029. Licenza MIT.*
