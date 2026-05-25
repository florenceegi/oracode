# Oracode — Paradigma AI-native

> Questo è il repo sorgente del paradigma Oracode.
> Chi clona questo repo e apre Claude Code ha accesso a `/project` per bootstrappare un nuovo progetto.

## Cosa è questo repo

Oracode è un paradigma di sviluppo software AI-native E un framework.
- **Paradigma**: regole, pilastri, disciplina — in `templates/CLAUDE_ORACODE_CORE.md`
- **Framework**: librerie LSO (Ultra), enforcement (OS3 Matrix), tooling (hook, agenti, CLI)

## Comando principale

```
/project — Bootstrap completo di un nuovo progetto Oracode
```

Flusso:
1. Rileva cosa è disponibile sul sistema (paradigma, Matrix, librerie)
2. Propone opzioni in base a cosa c'è
3. Installa infrastruttura scelta (paradigma + Matrix se licenziato + librerie LSO)
4. Configura il progetto (dominio, stack, livello)
5. Genera scaffold pronto all'uso

## Struttura del repo

```
templates/
  CLAUDE_ORACODE_CORE.md          — paradigma (MIT)
  CLAUDE_OS3_MATRIX_TEMPLATE.md   — enforcement (commerciale, richiede licenza)
  CLAUDE_PROJECT_TEMPLATE.md      — template istanza progetto
  PROJECT-DOC/                    — scaffold vuoto per nuovo progetto

hooks/templates/                  — hook OS3 Matrix (commerciale)
agents/templates/                 — agenti specializzati (commerciale)
bin/                              — CLI e utility
mission/                          — mission protocol
nervous-system/                   — infrastruttura SSOT

.claude/commands/project.md       — skill /project
```

## Regole per chi lavora SU questo repo

Chi modifica il repo oracode stesso (non chi lo usa per creare progetti) segue queste regole:
- Il contenuto di `templates/CLAUDE_ORACODE_CORE.md` è MIT. Nessun riferimento a progetti specifici.
- Il contenuto di `hooks/` e `agents/` è commerciale (OS3 Matrix). Nessun leak nel paradigma.
- Ogni modifica a template o skill richiede test su scenario reale (bootstrap progetto di prova).
