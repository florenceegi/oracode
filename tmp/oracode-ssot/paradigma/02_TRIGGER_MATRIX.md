---
title: Oracode Audit — Trigger Matrix SSOT
slug: oracode-audit-02-trigger-matrix
doc_type: guide
version: 2.0.0
status: current
date: '2026-03-25'
updated_at: '2026-03-25'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- oracode
supersedes:
- /home/fabio/EGI-DOC/docs/_archive/oracode/audit/02_TRIGGER_MATRIX_v1.0.0_20260325.md
superseded_by: null
rag_indexed: true
priority: normal
---

# Oracode Audit — Trigger Matrix SSOT

<!-- Fonte normativa: ../oracode_compliance_audit_v_1.md §4.3 e §8.2 P1-2 -->
<!-- Questa matrice definisce QUANDO una modifica obbliga aggiornamento SSOT -->
<!-- Ultima revisione: 2026-03-13 — Padmin D. Curtis -->

---

## Scopo

Questa matrice risponde alla domanda operativa: **"Ho appena fatto X — devo aggiornare qualcosa in EGI-DOC?"**

Regola base: se la risposta è dubbia, aggiorna. Il costo di un aggiornamento inutile è basso. Il costo di una SSOT desincronizzata è alto (deriva semantica, audit FAIL, bug).

---

## Prerequisiti

| # | Requisito | Dettaglio |
|---|-----------|-----------|
| 1 | Accesso a EGI-DOC | Repository clonato e aggiornato su `main` |
| 2 | Conoscenza del tipo di modifica effettuata | Classificabile secondo i 6 tipi definiti in questo documento |
| 3 | Accesso al CLAUDE.md locale dell'organo impattato | Per verificare se richiede aggiornamento |
| 4 | Fonte normativa letta | `oracode/oracode_compliance_audit_v_1.md` §4.3 e §8.2 P1-2 |

---

## Step 1 — Classificare la modifica

Questa sezione definisce come determinare il tipo di modifica effettuata.

Seguire l'albero decisionale:

```text
Modifica fatta
    │
    ├─ Cambia solo logica interna, output invariato?
    │   └─ Tipo 1 (locale)
    │
    ├─ Cambia output visibile, API, o comportamento utente?
    │   └─ Tipo 2 (comportamentale)
    │
    ├─ Introduce nuovo service/table/model/layer/dipendenza?
    │   └─ Tipo 3 (architetturale)
    │
    ├─ Tocca GDPR, MiCA, ToS, DSA, compliance legale?
    │   └─ Tipo 4 (contrattuale)
    │
    ├─ Rinomina un'entità del dominio?
    │   └─ Tipo 5 (naming)
    │
    └─ Impatta più organi?
        └─ Tipo 6 (cross-project)
```

**Regola del dubbio:** se non sai se una modifica rientra in Tipo 1 o Tipo 2, trattala come Tipo 2. Il costo di un aggiornamento SSOT non necessario è minore del costo della deriva. (P0-1 — Regola Zero: se non sai, chiedi)

---

## Step 2 — Applicare le regole del tipo identificato

Questa sezione dettaglia le azioni richieste per ciascun tipo di modifica.

### Tipo 1 — Modifica locale (fix puntuale, non cambia comportamento visibile)

**Definizione:** Correzione di un bug che non cambia API, flussi, nomi, schema o policy.

**Esempi:** Fix typo in view, correzione calcolo su variabile locale, aggiunta log debug.

| Target SSOT | Aggiornamento richiesto? | Condizione |
|---|---|---|
| CLAUDE.md locale | NO | Salvo che il fix riveli un pattern sbagliato sistematico |
| `EGI-DOC/docs/[organo]/` | NO | Salvo che il fix corregga info errate presenti in doc |
| `debiti_tecnici.md` | SOLO SE il fix chiude un debito documentato | Rimuovere la voce o aggiornare stato |
| Nessun SSOT | REGOLA DEFAULT | Fix locali non richiedono DOC-SYNC — ma l'agente deve dichiararlo esplicitamente |

**Azione DOC-SYNC:** non obbligatoria.

---

### Tipo 2 — Modifica comportamentale (cambia output visibile o API contract)

**Definizione:** Modifica che cambia cosa il sistema restituisce, come si comporta o come altri componenti lo usano.

**Esempi:** Cambio logica di prezzo, modifica response API, cambio flusso autenticazione.

| Target SSOT | Aggiornamento richiesto? | File specifico |
|---|---|---|
| CLAUDE.md locale | SÌ se cambia pattern operativo | Sezione architettura o flussi |
| `EGI-DOC/docs/[organo]/` | SÌ | `.md` del componente/area impattata |
| `EGI-DOC/docs/ecosistema/` | SÌ se impatta altri organi | `OS3_SETUP_ECOSYSTEM.md` o file dedicato |
| P0-11 enforcement | OBBLIGATORIO | Task non chiusa senza questo aggiornamento |

**Azione DOC-SYNC:** obbligatoria su EGI-DOC.

---

### Tipo 3 — Modifica architetturale (nuovo componente, nuova dipendenza, nuovo schema DB)

**Definizione:** Introduce una struttura non esistente prima: nuovo service, nuova tabella, nuovo modello, nuovo package, nuovo layer.

**Esempi:** Nuova migration, nuovo Service, nuovo agente Claude, nuovo endpoint pubblico.

| Target SSOT | Aggiornamento richiesto? | File specifico |
|---|---|---|
| CLAUDE.md locale | SÌ — sezione architettura/file critici | Aggiornare struttura repository |
| `EGI-DOC/docs/[organo]/` | SÌ — documento architettura specifico | Es. `02_Architettura_Tecnica.md` per EGI |
| `EGI-DOC/docs/ecosistema/` | SÌ se introduce dipendenza cross-organo | `OS3_SETUP_ECOSYSTEM.md` |
| TARGET_MATRIX | SÌ se nasce un nuovo organo/target | Aggiungere T-00N — vedi `oracode/audit/01_TARGET_MATRIX.md` |
| TRIGGER_MATRIX (questo file) | SÌ se introduce nuovo tipo di trigger | Aggiungere riga |

**Azione DOC-SYNC:** obbligatoria su EGI-DOC + aggiornamento CLAUDE.md.

---

### Tipo 4 — Modifica contrattuale/compliance (GDPR, MiCA, DSA, ToS, policy legale)

**Definizione:** Cambia ciò che il sistema è autorizzato a fare o obbligato a fare per ragioni legali, normative o contrattuali.

**Esempi:** Nuova clausola ToS, cambio trattamento dati GDPR, modifica flusso pagamento.

| Target SSOT | Aggiornamento richiesto? | File specifico |
|---|---|---|
| `EGI-DOC/docs/egi/` | SÌ — obbligatorio | `03_Compliance_e_Governance.md` |
| `EGI-DOC/docs/egi/debiti_tecnici.md` | SE introduce debito compliance | Aggiungere voce |
| CLAUDE.md locale | SÌ — aggiungere vincolo nella checklist pre-risposta | |
| Approvazione Fabio | OBBLIGATORIA prima dell'implementazione | Non è SSOT ma è prerequisito |

**Azione DOC-SYNC:** obbligatoria su EGI-DOC + approvazione Fabio prima dell'implementazione.

---

### Tipo 5 — Modifica naming dominio (rinomina entità, concetto, termine business)

**Definizione:** Un'entità del dominio cambia nome — nel codice, nella UI o nella documentazione.

**Esempi:** "Egili" → "AI Credits", "Patron" → "Mecenate", rename Model/Table.

| Target SSOT | Aggiornamento richiesto? | File specifico |
|---|---|---|
| CLAUDE.md locale | SÌ — sezione Terminologia/Coerenza Semantica | |
| `EGI-DOC/docs/[organo]/` | SÌ — ogni doc che usa il vecchio termine | Grep obbligatorio per trovare tutte le occorrenze |
| `EGI-DOC/docs/oracode/` | SÌ se è termine del framework | `index.md` Oracode |
| Tutti i CLAUDE.md dell'ecosistema | SÌ se è termine condiviso cross-organo | |

**Comando di verifica obbligatorio:**

```bash
grep -r "vecchio_termine" /home/fabio/EGI-DOC/docs/ --include="*.md"
```

**Azione DOC-SYNC:** obbligatoria — grep + aggiornamento su tutti i file impattati.

---

### Tipo 6 — Modifica cross-project (impatta più organi simultaneamente)

**Definizione:** Una modifica in un organo che cambia come altri organi si comportano o che richiede coordinamento tra repository.

**Esempi:** Migration schema `core` in EGI-HUB, cambio API condivisa, cambio auth flow.

| Target SSOT | Aggiornamento richiesto? | File specifico |
|---|---|---|
| `EGI-DOC/docs/ecosistema/` | SÌ — obbligatorio | `OS3_SETUP_ECOSYSTEM.md` + file dedicato |
| CLAUDE.md di ogni organo impattato | SÌ — sezione dipendenze | |
| TARGET_MATRIX | SÌ — aggiornare stati e note | `oracode/audit/01_TARGET_MATRIX.md` |
| `01_TARGET_MATRIX.md` | SÌ — aggiornare flussi cross-project T-D0N | `oracode/audit/01_TARGET_MATRIX.md` |
| Approvazione Fabio | OBBLIGATORIA | Ogni modifica cross-project richiede approvazione |

**Azione DOC-SYNC:** obbligatoria su ecosistema + approvazione Fabio.

---

## Step 3 — Riepilogo azioni per tipo

Questa tabella sintetizza l'azione DOC-SYNC richiesta per ciascun tipo di modifica.

| Tipo | Nome | DOC-SYNC obbligatorio? | Approvazione Fabio? | Aggiornamento CLAUDE.md? |
|---|---|---|---|---|
| 1 | Locale | NO (salvo eccezioni) | NO | NO (salvo pattern sbagliato sistematico) |
| 2 | Comportamentale | SÌ su EGI-DOC | NO | SÌ se cambia pattern operativo |
| 3 | Architetturale | SÌ su EGI-DOC | NO | SÌ — sezione architettura/file critici |
| 4 | Contrattuale/compliance | SÌ su EGI-DOC | SÌ — prima dell'implementazione | SÌ — checklist pre-risposta |
| 5 | Naming dominio | SÌ su tutti i file impattati | NO | SÌ — sezione Terminologia |
| 6 | Cross-project | SÌ su ecosistema | SÌ | SÌ — sezione dipendenze, ogni organo |

---

## Errori comuni e soluzioni

Questa sezione elenca gli errori più frequenti nell'applicazione della Trigger Matrix.

| # | Errore | Conseguenza | Soluzione |
|---|--------|-------------|-----------|
| 1 | Classificare come Tipo 1 una modifica che cambia output API | SSOT desincronizzata, audit FAIL | Applicare la regola del dubbio: se non è chiaramente Tipo 1, trattare come Tipo 2 |
| 2 | Dimenticare il grep su Tipo 5 (naming) | Occorrenze del vecchio termine rimangono in doc | Eseguire sempre `grep -r "vecchio_termine" /home/fabio/EGI-DOC/docs/ --include="*.md"` |
| 3 | Non dichiarare esplicitamente "nessun DOC-SYNC richiesto" per Tipo 1 | Ambiguità in audit trail | L'agente deve sempre dichiarare esplicitamente che il fix è Tipo 1 e non richiede DOC-SYNC |
| 4 | Procedere con Tipo 4 o Tipo 6 senza approvazione Fabio | Violazione prerequisito obbligatorio | Richiedere approvazione Fabio prima di qualsiasi implementazione |
| 5 | Aggiornare EGI-DOC ma non il CLAUDE.md locale | Agente perde contesto operativo aggiornato | Per Tipo 2, 3, 4, 5, 6: verificare sempre se CLAUDE.md richiede aggiornamento |

---

## Riferimenti

| Documento | Path relativo a `EGI-DOC/docs/` | Relazione |
|---|---|---|
| Oracode Compliance Audit | `oracode/oracode_compliance_audit_v_1.md` | Fonte normativa — §4.3 e §8.2 P1-2 |
| Target Matrix SSOT | `oracode/audit/01_TARGET_MATRIX.md` | Matrice target aggiornata da Tipo 3 e Tipo 6 |
| OS3 Setup Ecosystem | `ecosistema/OS3_SETUP_ECOSYSTEM.md` | Aggiornato da Tipo 2 (cross-organo), Tipo 3 (cross-organo), Tipo 6 |
| Compliance e Governance EGI | `egi/03_Compliance_e_Governance.md` | Aggiornato da Tipo 4 |
| Debiti tecnici EGI | `egi/debiti_tecnici.md` | Aggiornato da Tipo 1 (chiusura debito) e Tipo 4 (debito compliance) |