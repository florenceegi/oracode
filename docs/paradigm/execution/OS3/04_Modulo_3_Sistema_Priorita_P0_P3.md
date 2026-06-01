---
visibility: public
rag: public
---

# **MODULO 3: SISTEMA DI PRIORITÀ P0-P3**

## **"La Gerarchia Decisionale: Cosa è Negoziabile e Cosa No"**

---

**Autore:** Fabio Cherici & Padmin D. Curtis  
**Versione:** 3.0.0  
**Data:** Novembre 2025

---

## **🎯 Il Problema della Paralisi Decisionale**

Nel development moderno, developer e AI partner devono prendere centinaia di micro-decisioni ogni giorno:

- "Devo usare UEM o log generico per questo errore?"
- "Posso hardcodare questa stringa temporaneamente?"
- "Questo metodo service esiste o devo verificarlo?"
- "Devo applicare il Protocollo Fortino Digitale ora o dopo?"
- "Posso usare `take(10)` qui o viola qualche regola?"

**Senza un framework di priorità chiaro, ogni decisione diventa:**

- ⏱️ Un bottleneck temporale
- 🤔 Una fonte di incertezza
- 🎲 Una scommessa sul "è abbastanza importante?"

**Risultato: Paralisi decisionale o (peggio) decisioni inconsistenti.**

---

## **⚡ La Soluzione: Sistema P0-P3**

OS3 introduce un sistema di priorità a 4 livelli che risponde a una domanda fondamentale:

> **"Se violo questa regola, cosa succede?"**

| Priorità | Nome          | Significato     | Conseguenza Violazione    |
| -------- | ------------- | --------------- | ------------------------- |
| **P0**   | **BLOCKING**  | Non negoziabile | STOP totale del lavoro    |
| **P1**   | **MUST**      | Core principles | Code non production-ready |
| **P2**   | **SHOULD**    | Best practices  | Debt tecnico accumulato   |
| **P3**   | **REFERENCE** | Context & info  | Opportunity cost          |

**Con P0-P3, ogni decisione ha una risposta immediata: guardo la priorità.**

---

## **🚨 P0 - BLOCKING: Le Regole Sacre**

### **Definizione**

> **"Violazione P0 = STOP immediato. Non si procede. Non si discute. Si corregge."**

Le regole P0 sono i **boundaries non negoziabili** di OS3. Sono poche, precise, e assolutamente critiche.

### **Le 13 Regole P0 Universali**

1. **P0-1: REGOLA ZERO** - Anti-Deduzione (vedi Modulo 2). Informazione mancante → STOP, chiedi. Mai dedurre, mai completare
2. **P0-2: Translation Keys Only** - No Hardcoded Text. Ogni stringa visibile passa per il sistema i18n. Chiavi atomiche
3. **P0-3: Statistics Rule** - No Hidden Limits. Parametri statistiche sempre espliciti. Mai default nascosti
4. **P0-4: Anti-Method-Invention** - Verify Before Use. Prima di chiamare un metodo, verifica che esista (grep o lettura file)
5. **P0-5: UEM-First Rule** - Error Handling Sacred. Errori dal gestore centralizzato. Mai try/catch improvvisati, mai solo log
6. **P0-6: Anti-Service-Method-Invention** - Service Methods Verified. Verifica nel filesystem che service e firma esistano
7. **P0-7: Anti-Enum-Constant-Invention** - Enum Constants Verified. Verifica che la costante esista come case dell'enum
8. **P0-8: Complete Flow Analysis** - Prima di modificare qualcosa di non triviale, mappa il flusso completo in 4 fasi (Flow Mapping → Type Tracing → All Occurrences → Impact Analysis)
9. **P0-9: i18n completa** - Ogni nuova stringa disponibile in tutte le lingue target fin dal primo commit
10. **P0-10: Anti-bypass data layer** - Accesso al database sempre tramite service factory o repository. Mai query raw quando esiste un'astrazione
11. **P0-11: DOC-SYNC** - Task non chiusa finché la documentazione SSOT non è aggiornata con il codice
12. **P0-12: Anti-Infra-Invention** - URL, path, branch, config di deploy: verifica dalla fonte. Mai dedurre nomi plausibili
13. **P0-13: Test-First Discipline** - Ogni feature/fix/refactor produce o aggiorna test. Task non chiusa senza test verde

### **Perché Così Poche?**

**Principio: "Regole P0 devono essere così critiche che la loro violazione compromette l'intero sistema."**

Il vincolo non è il numero esatto, ma la natura: le P0 sono **poche e selezionate**, ciascuna nata da una **cicatrice di produzione** — un errore concreto che ha rotto un sistema reale. Se avessimo 50 regole P0, nessuna sarebbe veramente blocking. Tenendole ridotte alle 13 universali, ogni developer sa esattamente cosa non può violare.

### **Enforcement P0**

```
Violazione P0 rilevata
  ↓
🛑 STOP IMMEDIATO
  ↓
Correzione obbligatoria
  ↓
Re-validation
  ↓
Se OK → Proceed
Se NO → Nuovo STOP
```

**Non si passa P0. Si corregge P0.**

### **Esempi di Enforcement**

```php
// ❌ VIOLATION P0-2 (No Hardcoded Text)
return response()->json([
    'message' => 'User updated successfully' // HARDCODED!
]);

// 🛑 STOP - This is P0 violation, non-negotiable
// Correction required before proceeding

// ✅ CORRECTED
return response()->json([
    'message' => __('user.updated_successfully')
]);
```

```php
// ❌ VIOLATION P0-6 (Anti-Service-Method-Invention)
$this->userService->updateProfile($data);
// Did you VERIFY updateProfile() exists? NO → VIOLATION!

// 🛑 STOP - P0 violation
// Execute: read_file app/Services/UserService.php
// Execute: grep "public function update"
// Found: updateUserProfile() not updateProfile()

// ✅ CORRECTED
$this->userService->updateUserProfile($user, $data);
```

---

## **✅ P1 - MUST: Core Principles**

### **Definizione**

> **"Regole P1 sono i principi fondamentali che definiscono la qualità OS3. Violazione = codice non production-ready."**

### **Cosa Include P1**

**I 6+1 Pilastri Fondamentali:**

1. Intenzionalità Esplicita
2. Semplicità Potenziante
3. Coerenza Semantica
4. Circolarità Virtuosa
5. Evoluzione Ricorsiva
6. Sicurezza Proattiva (Protocollo Fortino Digitale)
7. REGOLA ZERO (anche P0)

**Execution Excellence:**

- Tutto funziona al primo tentativo
- Zero placeholder, zero TODO
- Codice completo e testato mentalmente

**Pragmatic Excellence:**

- Soluzioni semplici che funzionano
- Pattern esistenti, non invenzioni

**Documentation Excellence:**

- DocBlock completi sempre
- Firma OS3 in ogni file
- Business logic commentata

**AI-Readable Code:**

- Nomi espliciti e intenzionali
- Codice che racconta una storia
- Comprensibile senza contesto esterno

**Compliance Sempre:**

- GDPR compliance integrato
- OOP puro e design patterns
- Ultra Eccellenza come standard

**Frontend Excellence:**

- SEO ottimizzato sempre
- ARIA accessibility completo
- Schema.org structured data

### **Differenza P0 vs P1**

| Aspetto           | P0                               | P1                                 |
| ----------------- | -------------------------------- | ---------------------------------- |
| **Violazione**    | STOP immediato                   | Procedi ma non production-ready    |
| **Correzione**    | Obbligatoria prima di continuare | Obbligatoria prima di deploy       |
| **Numero regole** | 13 (universali, precisissime)    | ~15-20 (principi ampi)             |
| **Impatto**       | Sistema non funziona             | Sistema funziona ma non eccellente |

### **Esempio P1 Violation (non STOP, ma non production-ready)**

```php
// Violation P1: Documentation Excellence
public function update(Request $request)  // ❌ Missing DocBlock
{
    $user->update($request->all());  // ❌ No validation, no UEM
    return redirect()->back();  // ❌ No success message
}

// ⚠️ Questo NON è P0 violation (compila, gira)
// MA non è production-ready (manca documentazione, error handling, feedback)

// ✅ P1-Compliant
/**
 * Updates user profile with validated data
 *
 * @param Request $request Contains profile data (name, email, etc.)
 * @return RedirectResponse Redirects to profile with success message
 * @throws ValidationException If validation fails
 */
public function update(Request $request): RedirectResponse
{
    try {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email',
        ]);

        $user = $request->user();
        $user->update($validated);

        return redirect()->route('profile.edit')
            ->with('success', __('profile.updated_successfully'));

    } catch (\Exception $e) {
        return $this->errorManager->handle('PROFILE_UPDATE_FAILED', [
            'user_id' => $request->user()->id,
        ], $e);
    }
}
```

---

## **🎯 P2 - SHOULD: Best Practices Importanti**

### **Definizione**

> **"Regole P2 sono best practices che migliorano qualità e manutenibilità. Violazione = debt tecnico accumulato."**

### **Cosa Include P2**

**Architecture Patterns:**

- OOP puro & SOLID principles
- Design patterns appropriati
- Repository pattern per data access
- Service layer per business logic

**Ultra Ecosystem Integration:**

- ULM per logging generale
- UEM per error handling structured
- GDPR patterns integrati

**Frontend Patterns:**

- Component-based architecture
- Vanilla JS / TypeScript (NO Alpine, NO Livewire, NO jQuery)
- Progressive enhancement

**Testing Mindset:**

- Code testabile by design
- Mocking-friendly architecture
- Test coverage considerato

**Code Quality:**

- DRY (Don't Repeat Yourself)
- KISS (Keep It Simple, Stupid)
- YAGNI (You Aren't Gonna Need It)
- Meaningful naming conventions

### **Differenza P1 vs P2**

| Aspetto        | P1                      | P2                          |
| -------------- | ----------------------- | --------------------------- |
| **Violazione** | Non production-ready    | Procedi ma accumuli debt    |
| **Correzione** | Pre-deploy obbligatoria | Refactoring consigliato     |
| **Impatto**    | Quality compromessa     | Maintainability compromessa |
| **Urgenza**    | Alta                    | Media                       |

### **Esempio P2 Violation (procedi, ma crei debt)**

```php
// Violation P2: DRY principle
public function updateEmail(Request $request) {
    $user = $request->user();
    $user->email = $request->email;
    $user->save();
    $this->auditLog->log('email_updated', $user->id);
}

public function updateName(Request $request) {
    $user = $request->user();
    $user->name = $request->name;
    $user->save();
    $this->auditLog->log('name_updated', $user->id);
}

// ⚠️ Questo funziona e è P1-compliant
// MA viola DRY (P2) → accumula debt tecnico

// ✅ P2-Compliant (refactored)
public function updateField(Request $request, string $field): Response
{
    $user = $request->user();
    $user->$field = $request->$field;
    $user->save();
    $this->auditLog->log("{$field}_updated", $user->id);

    return response()->json([
        'message' => __("profile.{$field}_updated")
    ]);
}
```

---

## **📚 P3 - REFERENCE: Context & Background**

### **Definizione**

> **"P3 fornisce context, background, esempi avanzati. Non obbligatorio ma prezioso per comprensione profonda."**

### **Cosa Include P3**

**I 12 Pilastri Derivati (OS2):**

**Gruppo Tecnico:**

- Interrogabilità Totale
- Resilienza Progressiva
- Modularità Semantica
- Performance Consapevole

**Gruppo Etico:**

- Dignità Preservata
- Impatto Misurabile
- Sostenibilità Sistemica
- Trasparenza Operativa

**Gruppo Evolutivo:**

- Adattabilità Intelligente
- Apprendimento Composto
- Scalabilità Semantica
- Innovazione Ricorsiva

**Case Studies & Examples:**

- Progetti real-world OS3-compliant
- Pattern library dettagliata
- Anti-patterns e loro correzioni
- Success stories e lessons learned

**Advanced Topics:**

- OS3 per team distribuiti
- OS3 per startup early-stage
- OS3 per enterprise transformation
- OS3 per educational institutions

### **Quando Consultare P3**

```
✅ Quando hai tempo per approfondimento
✅ Quando vuoi ottimizzare oltre P1/P2
✅ Quando cerchi ispirazione per innovazione
✅ Quando prepari training team
✅ Quando pianifichi architettura long-term
```

---

## **🎯 Decision Matrix: Quale Priorità?**

### **Come Classificare una Nuova Regola**

```
Domanda 1: "Se violo questa regola, il sistema si rompe immediately?"
  → SÌ = P0 candidate
  → NO = Vai a Domanda 2

Domanda 2: "Se violo questa regola, il codice è production-ready?"
  → NO = P1 candidate
  → SÌ = Vai a Domanda 3

Domanda 3: "Se violo questa regola, accumulo debt tecnico significativo?"
  → SÌ = P2 candidate
  → NO = P3 (background info)
```

### **Esempi di Classificazione**

| Regola                           | Violazione causa...                                | Priorità |
| -------------------------------- | -------------------------------------------------- | -------- |
| "Non hardcodare text"            | Sistema non i18n-ready (BLOCKING per PA)           | **P0**   |
| "Usa DocBlock completi"          | Codice non self-documenting (not production-ready) | **P1**   |
| "Applica DRY principle"          | Code duplication (debt tecnico)                    | **P2**   |
| "Considera 12 Pilastri Derivati" | Opportunity cost (manca ottimizzazione)            | **P3**   |

---

## **⚖️ Priority Decision Matrix Operativo**

### **Quick Reference per Developer**

```
SCENARIO: "Devo aggiungere logging a questo metodo"

Check P0: Questo è error handling che richiede UEM?
→ SÌ = Usa UEM (P0-5)
→ NO = Continua

Check P1: Il logging è essenziale per audit trail?
→ SÌ = Usa ULM con contesto completo (P1)
→ NO = Continua

Check P2: Il logging migliora debuggability?
→ SÌ = Aggiungi ULM (P2 best practice)
→ NO = Skip (P3 nice-to-have)
```

### **Quick Reference per AI Partner**

```
OUTPUT GENERATION CHECKLIST:

P0 Verification (MANDATORY):
[ ] REGOLA ZERO applied?
[ ] No hardcoded text?
[ ] No hidden limits (Statistics Rule)?
[ ] All methods/enums verified?
[ ] UEM used for error handling?

P1 Verification (PRODUCTION-READY):
[ ] DocBlock complete?
[ ] 6 Pilastri applicati?
[ ] Security (Fortino Digitale) applied?
[ ] AI-readable structure?
[ ] GDPR compliance?

P2 Check (DEBT PREVENTION):
[ ] DRY principle applied?
[ ] SOLID principles respected?
[ ] Design patterns appropriate?
[ ] Code testable?

P3 Bonus (EXCELLENCE):
[ ] Opportunity to apply 12 Pilastri Derivati?
[ ] Advanced patterns applicable?
[ ] Innovation opportunities?
```

---

## **📊 Impact Analysis: P0 vs P1 vs P2 vs P3**

### **Compliance Scenarios**

| Compliance Level      | Risultato        | Delivery Time | Qualità Percepita | Debt Tecnico |
| --------------------- | ---------------- | ------------- | ----------------- | ------------ |
| **P0 + P1 + P2 + P3** | 🏆 ECCELLENTE    | +20%          | 100%              | 0%           |
| **P0 + P1 + P2**      | ✅ OTTIMO        | +10%          | 95%               | 5%           |
| **P0 + P1**           | ✅ BUONO         | baseline      | 85%               | 15%          |
| **P0 only**           | ⚠️ MINIMO        | -15%          | 60%               | 40%          |
| **P0 violated**       | ❌ INACCETTABILE | N/A           | N/A               | BLOCKING     |

### **Interpretazione**

- **P0 only**: Sistema funziona ma non è professionale
- **P0 + P1**: Production-ready standard
- **P0 + P1 + P2**: Enterprise-grade quality
- **P0 + P1 + P2 + P3**: Excellence level (caso esemplare: standard dell'istanza FlorenceEGI)

---

## **🚀 Operatività Quotidiana con P0-P3**

### **Scenario 1: Sprint Planning**

```
Product Owner: "Feature X per il prossimo sprint"

Tech Lead (applica P0-P3):
- P0 violations prevenute: 2 giorni effort
- P1 compliance: 5 giorni effort
- P2 best practices: +1 giorno effort
- P3 excellence: +2 giorni effort (se tempo disponibile)

Decision: P0+P1+P2 (8 giorni) confermato
         P3 posticipato a refactoring phase
```

### **Scenario 2: Code Review**

```
Reviewer checklist:

P0 Check (BLOCKING):
[ ] REGOLA ZERO violations? → Found 1 → REQUEST CHANGES
[ ] Hardcoded text? → None → ✅
[ ] Methods verified? → All verified → ✅
[ ] UEM for errors? → Applied correctly → ✅

P1 Check (PRODUCTION):
[ ] DocBlock complete? → 90% (1 missing) → COMMENT
[ ] Security applied? → ✅
[ ] GDPR compliant? → ✅

P2 Check (DEBT):
[ ] DRY violations? → Minor (2 functions) → COMMENT
[ ] Testability? → Good → ✅

DECISION:
- Block merge (P0 violation found)
- After fix → Approve with P1/P2 comments for future improvement
```

### **Scenario 3: AI Prompt**

```
Developer → AI:
"Create user registration endpoint.
 Apply OS3 standards: P0 mandatory, P1 target, P2 if time permits."

AI Response:
"Understood. Priority enforcement:
 - P0: REGOLA ZERO active, no hardcoded text, UEM for errors
 - P1: Full DocBlock, security (Fortino Digitale), GDPR
 - P2: Will apply if code structure allows without complexity

 Proceeding with P0+P1 guaranteed, P2 best-effort."
```

---

## **🎯 La Golden Rule del Sistema P0-P3**

> **"Se P0 è OK, puoi dormire tranquillo. Se P0 + P1 sono OK, puoi fare deploy. Se P0 + P1 + P2 sono OK, puoi essere orgoglioso. Se P0 + P1 + P2 + P3 sono OK, sei un maestro."**

**Ma ricorda sempre:**

### **P0 VIOLATO = TUTTO FERMO**

Non importa quanto è bello il codice.  
Non importa quanto è performante.  
Non importa quante feature implementa.

**Se P0 è violato, si corregge. Punto.**

---

## **🧬 P0-P3 nel contesto Oracode Nexus**

Il sistema di priorità P0-P3 non vive isolato: dentro **Oracode Nexus** (il sistema completo — paradigma + gerarchia a 3 livelli + ecosistema) si aggancia a due strumenti complementari ormai canonici del core SSOT.

### **Trigger Matrix DOC-SYNC (classificazione 1-6)**

Prima di agire, ogni modifica si classifica per impatto. La matrice decide se la modifica richiede DOC-SYNC (e quindi attiva **P0-11**):

| Tipo | Impatto | DOC-SYNC |
|------|---------|----------|
| 1 — Locale | Fix puntuale, output invariato | NO |
| 2 — Comportamentale | Cambia output, API, behavior visibile | SÌ |
| 3 — Architetturale | Nuovo endpoint, model, service | SÌ + boot context |
| 4 — Contrattuale | GDPR, normative, compliance | SÌ + approvazione CEO PRIMA |
| 5 — Naming | Rinomina entità del dominio | SÌ + grep cross-progetto |
| 6 — Cross-project | Schemi condivisi o altri organi | SÌ + approvazione CEO |

Dubbio tra tipo 1 e 2 → tratta come 2. La classificazione determina quando **P0-11 (DOC-SYNC)** scatta come blocking.

### **Layer Stack L0-L11**

Le P0 sono i punti di aggancio del sistema di priorità al **metabolismo** dell'organismo software (L0-L11):

- **P0-11 (DOC-SYNC)** è il gancio con **L1 Sync** (metabolismo cellulare base) e **L8 Nervous System** (propriocezione documentale): nessuna modifica chiude finché il sistema nervoso documentale non è allineato.
- **P0-13 (Test-First)** è il gancio con **L6 Testing** (memoria immunitaria): i test sono gli anticorpi che rendono permanente ogni cicatrice di produzione.

Riferimento canonico per Trigger Matrix e Layer Stack: il boot context del paradigma (`CLAUDE_ORACODE_CORE.md`). Per la gerarchia operativa a 3 livelli: `docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md`.

---

_Prosegui con: **Modulo 4 - Le 13 Regole P0 Universali (Dettagliate)**_

---

**Version:** 3.0.0  
**Status:** Foundation Document  
**Last Updated:** Novembre 2025
