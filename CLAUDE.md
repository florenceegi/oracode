# Oracode — Paradigma AI-native

> Questo è il repo sorgente del paradigma Oracode.
> Chi clona questo repo e apre Claude Code ha accesso a `/project` per bootstrappare un nuovo progetto.

## Cosa è questo repo

Oracode è un paradigma di sviluppo software AI-native E un framework.
- **Paradigma**: regole, pilastri, disciplina — in `templates/CLAUDE_ORACODE_CORE.md`
- **Framework**: librerie LSO (Ultra, pubbliche), enforcement (OS3 Matrix, commerciale — repo separato)

Questo repo contiene SOLO il paradigma (MIT). L'enforcement vive in `os3-matrix` (privato, licenza commerciale).

## Comando principale

```
/project — Bootstrap completo di un nuovo progetto Oracode
```

Flusso:
1. Rileva cosa e disponibile sul sistema (paradigma, Matrix, librerie)
2. Propone opzioni in base a cosa c'e
3. Installa infrastruttura scelta (paradigma + Matrix se licenziato + librerie LSO)
4. Configura il progetto (dominio, stack, livello)
5. Genera scaffold pronto all'uso

## Struttura del repo

```
templates/
  CLAUDE_ORACODE_CORE.md       — boot context paradigma (MIT)
  CLAUDE_PROJECT_TEMPLATE.md   — template istanza progetto
  PROJECT-DOC/                 — scaffold vuoto per nuovo progetto

.claude/commands/project.md    — skill /project
```

## Ecosistema Oracode

```
oracode (questo repo)          — paradigma MIT, pubblico
os3-matrix                     — enforcement commerciale, privato (Florence EGI S.R.L.)
ultra-* (AutobookNft)          — librerie LSO, pubbliche
```

## Regole per chi lavora SU questo repo

- Contenuto MIT. Nessun riferimento a progetti specifici o a codice commerciale.
- Nessun file di os3-matrix deve finire qui.
- Ogni modifica a template o skill richiede test su scenario reale.
