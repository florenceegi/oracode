# Oracode — Paradigma AI-native

> Questo è il repo sorgente del paradigma Oracode.
> Contiene le REGOLE, non le applicazioni. I comandi che fanno nascere un progetto (`/project`,
> `/discovery` e i pezzi che li compongono) vivono in `os3-matrix`, che e' il prodotto con licenza:
> clonare questo repo da solo non da' accesso a `/project` (M-OS3-216, decisione CEO 2026-09-02).

## Cosa è questo repo

Oracode è un paradigma di sviluppo software AI-native E un framework.
- **Paradigma**: regole, pilastri, disciplina — in `templates/CLAUDE_ORACODE_CORE.md`
- **Framework**: librerie LSO (Ultra, pubbliche), enforcement (OS3 Matrix, commerciale — repo separato)

Questo repo contiene SOLO il paradigma (MIT). L'enforcement vive in `os3-matrix` (privato, licenza commerciale).

## Come nasce un progetto

Il comando `/project` fa nascere un progetto Oracode, ma **non vive qui**: vive in `os3-matrix`
(`os3-matrix/.claude/commands/`), perche' e' un'applicazione e le applicazioni stanno nel prodotto,
non nel paradigma. Da qui il comando legge il materiale che gli serve — lo scheletro del progetto
nuovo, il boot context del paradigma, la tassonomia delle mission — che restano regole e restano qui.

Il suo flusso:
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

.claude/commands/               — resta solo web-fx-displacement (dipende da templates/fx/)
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
