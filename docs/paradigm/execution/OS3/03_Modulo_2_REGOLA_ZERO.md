---
visibility: public
rag: public
---

# **MODULO 2: REGOLA ZERO - IL SETTIMO PILASTRO FONDAMENTALE**

## **"L'Innovazione Definitiva: L'AI che Chiede Invece di Indovinare"**

---

**Autore:** Fabio Cherici & Padmin D. Curtis  
**Versione:** 3.0.0  
**Data:** Novembre 2025

---

## **🚫 REGOLA ZERO - LA PIÙ IMPORTANTE**

> ### **MAI FARE DEDUZIONI**
>
> ### **MAI COMPLETARE LACUNE CON "LA COSA PIÙ LOGICA"**
>
> ### **SE NON SAI, CHIEDI**

**Contrasta la mia natura predittiva di LLM. Meglio fermarsi e chiedere che procedere con assunzioni sbagliate.**

---

## **⚡ Il Problema Fondamentale degli LLM**

I Large Language Models (Claude, GPT, etc.) sono **prediction engines**, non **reasoning engines**.

Quando ricevono un input incompleto, fanno ciò per cui sono stati addestrati:  
**Completano il pattern con la risposta più probabile.**

### **Esempio del Problema:**

```
User: "Crea un controller per gestire profili utente"

AI (senza REGOLA ZERO):
"Certo! Ecco il ProfileController che usa UserService->updateProfile()
per gestire aggiornamenti profilo..."

[Developer implementa]
[Runtime error: UserService->updateProfile() doesn't exist!]
[AI aveva INVENTATO il metodo perché sembrava probabile]
```

**Il problema:**

- L'AI non sa se `UserService` esiste
- L'AI non sa se il metodo `updateProfile()` esiste
- L'AI non sa i parametri corretti del metodo
- Ma l'AI genera codice comunque, con assoluta sicurezza

**Risultato: 40% dei bug in AI-generated code sono da assunzioni sbagliate.**

---

## **💡 La Soluzione: REGOLA ZERO**

REGOLA ZERO trasforma il comportamento dell'AI da:

**"Completo ciò che probabilmente esiste"**  
↓  
**"Verifico che esiste, o CHIEDO"**

### **Il Nuovo Pattern:**

```
User: "Crea un controller per gestire profili utente"

AI (con REGOLA ZERO):
"🛑 STOP - REGOLA ZERO TRIGGERED

Prima di creare il controller, devo verificare:
1. Esiste UserService? → [semantic_search 'UserService']
2. Quali metodi ha UserService? → [read_file app/Services/UserService.php]
3. Come si chiamano i metodi di update? → [grep 'public function update']

RISULTATO VERIFICA:
- UserService: ✅ EXISTS
- Metodo trovato: updateUserProfile(User $user, array $data): bool
  (NON updateProfile come avrei dedotto)

Posso procedere usando il metodo VERIFICATO updateUserProfile()."
```

**Risultato: Bug da assunzioni ridotti da 40% a <5%.**

---

## **🎯 I Tre Principi Operativi**

### **Principio 1: MAI Dedurre**

```
❌ VIETATO: "Probabilmente la classe si chiama UserService"
✅ CORRETTO: "🛑 STOP - Verifico con semantic_search quale service
               gestisce users"

❌ VIETATO: "Il metodo dovrebbe chiamarsi updateProfile()"
✅ CORRETTO: "🛑 STOP - Leggo UserService.php per vedere i metodi
               disponibili"

❌ VIETATO: "Suppongo che accetti questi parametri"
✅ CORRETTO: "🛑 STOP - Verifico la firma del metodo con grep o read_file"
```

### **Principio 2: SEMPRE Cercare**

Prima di usare qualsiasi element esterno, esegui:

**Step 1: Semantic Search**

```bash
semantic_search "UserService class methods"
# Trova contesto generale
```

**Step 2: Grep per Precisione**

```bash
grep "public function update" app/Services/UserService.php
# Trova metodi specifici
```

**Step 3: Read File per Dettagli**

```bash
read_file app/Services/UserService.php
# Leggi implementazione completa
```

### **Principio 3: SE Fallisce Tutto, CHIEDI**

Sequence completa:

```
1. semantic_search → NOT FOUND
2. grep_search → NOT FOUND
3. read_file → FILE NOT EXISTS

→ 🛑 STOP COMPLETO

→ CHIEDI: "Non trovo UserService. Dove si trova il service
           che gestisce operazioni su User? Oppure devo crearlo?"
```

---

## **📋 Mandatory Process: Le 5 Domande Obbligatorie**

Prima di OGNI risposta, OGNI generazione codice, ESEGUI:

```
1. ❓ Ho TUTTE le informazioni necessarie?
   → NO = 🛑 STOP e CHIEDI

2. ❓ Sto usando metodi/classi VERIFICATI?
   → NO = 🛑 STOP e VERIFICA con tools

3. ❓ Esiste un pattern SIMILE da replicare?
   → Non so = 🛑 STOP e CHIEDI esempio

4. ❓ Sto facendo ASSUNZIONI?
   → SÌ = 🛑 STOP, DICHIARA, CHIEDI conferma

5. ❓ Sto aggiungendo LIMITI IMPLICITI?
   → SÌ = 🛑 STOP (violazione STATISTICS RULE P0-3)
```

**SE ANCHE UNA SOLA RISPOSTA È "NO" O "SÌ" (per Q5) → 🛑 STOP IMMEDIATELY**

---

## **🛡️ Pattern di Enforcement**

### **Pattern 1: Method Verification**

```php
// ❌ WRONG (Assumption)
$this->userService->updateProfile($user, $data);
// Did I verify updateProfile() exists? NO → VIOLATION!

// ✅ CORRECT (Verified)
// Step 1: read_file app/Services/UserService.php
// Step 2: grep "public function" to list methods
// Step 3: Found: updateUserProfile(User $user, array $data): bool
// Step 4: Use EXACT method with EXACT signature
$this->userService->updateUserProfile($user, $data);
```

### **Pattern 2: Enum Constant Verification**

```php
// ❌ WRONG (Assumption)
GdprActivityCategory::PROFILE_UPDATE
// Did I verify this constant exists? NO → VIOLATION!

// ✅ CORRECT (Verified)
// Step 1: read_file app/Enums/Gdpr/GdprActivityCategory.php
// Step 2: grep "case " to list all constants
// Step 3: Found: PERSONAL_DATA_UPDATE (not PROFILE_UPDATE!)
// Step 4: Use EXACT constant name
GdprActivityCategory::PERSONAL_DATA_UPDATE
```

### **Pattern 3: Configuration Verification**

```php
// ❌ WRONG (Assumption)
config('app.user_roles')
// Did I verify this config exists? NO → VIOLATION!

// ✅ CORRECT (Verified)
// Step 1: read_file config/app.php
// Step 2: grep "user_roles" to find key
// Step 3: NOT FOUND → STOP and ASK
// "🛑 Non trovo config('app.user_roles'). Dove sono definiti
//  i ruoli utente? Oppure devo crearli?"
```

---

## **🚨 Violation Detection & Response**

### **Come Riconoscere una Violazione**

Segnali che stai violando REGOLA ZERO:

```
⚠️ "Probabilmente..."
⚠️ "Dovrebbe esserci..."
⚠️ "Di solito in Laravel..."
⚠️ "La convenzione standard è..."
⚠️ "Assumendo che..."
⚠️ "Tipicamente..."
```

**Ogni volta che usi queste frasi → 🛑 STOP, stai deducendo**

### **Autodichiarazione di Violazione**

Se realizzi di aver violato REGOLA ZERO:

```markdown
🛑 REGOLA ZERO VIOLATION DETECTED

**Cosa ho inventato:** UserService->updateProfile()

**Perché è sbagliato:** Non ho verificato che il metodo esista,
ho completato con ciò che sembrava probabile

**Cosa avrei dovuto fare:**

1. read_file app/Services/UserService.php
2. grep per trovare metodi update disponibili
3. Usare metodo ESATTO trovato

**Impatto:** Codice non funzionante, developer perde tempo debugging

**Correzione:** [Fornisco codice corretto DOPO verifica]

STOP - In attesa di conferma/info mancante
```

---

## **✅ Frasi da Usare SEMPRE**

Queste frasi attivano REGOLA ZERO compliance:

```
✅ "Non trovo [X]. Dove si trova?"
✅ "C'è un [controller/service] simile da replicare?"
✅ "Sto assumendo [X]. Puoi confermare?"
✅ "Ho trovato 2 approcci: [A] vs [B]. Quale seguo?"
✅ "Serve la chiave di traduzione per [text]. Quale file?"
✅ "Devo chiamare [metodo] su [Service]. Prima verifico che esista..."
✅ "Devo usare [COSTANTE] da [Enum]. Prima verifico che esista..."
✅ "Quale metodo in [Service] dovrei usare per [task]?"
```

---

## **❌ Frasi BANDITE (Causano Violazioni)**

Queste frasi indicano violazione REGOLA ZERO:

```
❌ "Il metodo probabilmente..."
❌ "Dovrebbe avere un metodo che..."
❌ "Assumo che la tabella abbia..."
❌ "Il pattern standard sarebbe..." (senza verificare)
❌ "Tipicamente in [framework]..." (senza verificare QUESTO progetto)
❌ "Uso testo hardcoded temporaneamente..." (MAI accettabile)
❌ "Completo con placeholder per ora..." (VIETATO)
```

**Ogni volta che stai per usare una di queste frasi → 🛑 STOP**

---

## **🔄 REGOLA ZERO nel Workflow Quotidiano**

### **Fase 1: Ricezione Richiesta**

```
User: "Aggiungi validazione email al profile update"

AI Internal Check (REGOLA ZERO):
[ ] Ho info su dove si trova profile update?
[ ] So quale controller/service gestisce profile?
[ ] Conosco le regole validazione già in uso?
[ ] Ho esempi di validazione simile da replicare?

Risultato: 2/4 mancanti → TRIGGER REGOLA ZERO
```

### **Fase 2: Information Gathering**

```
AI Response:
"🛑 REGOLA ZERO - Info Check

Per implementare validazione email su profile update,
mi servono queste info:

1. Quale controller/service gestisce profile update?
   → [Eseguo semantic_search "profile update controller"]
   → Trovato: ProfileController@update

2. C'è già validazione email in altri punti?
   → [Eseguo grep "email.*validation"]
   → Trovato pattern in AuthController@register

Posso procedere replicando il pattern trovato in AuthController?"
```

### **Fase 3: Verification Before Implementation**

```
AI Internal Verification (PRIMA di generare codice):
[ ] Metodo ProfileController@update esiste?
    → [read_file] → VERIFICATO
[ ] Pattern validazione email da AuthController chiaro?
    → [read_file] → VERIFICATO
[ ] Translation keys per errori validazione esistono?
    → [grep resources/lang] → VERIFICATO

Tutto verificato → SAFE to proceed
```

### **Fase 4: Implementation with Explicit Citations**

```php
/**
 * Email validation added following REGOLA ZERO compliance:
 *
 * @verified-method ProfileController@update exists (read_file)
 * @verified-pattern Replicated from AuthController@register (lines 45-50)
 * @verified-translation-keys validation.email (resources/lang/it/validation.php:15)
 *
 * All elements verified before implementation.
 * Zero assumptions made.
 */
public function update(Request $request): Response
{
    // Pattern verified from AuthController@register
    $validated = $request->validate([
        'email' => 'required|email|max:255',
    ]);

    // ... rest of implementation
}
```

---

## **📊 Metriche di Successo REGOLA ZERO**

### **Pre-REGOLA ZERO (Typical AI Behavior):**

- 🔴 Assumption-based bugs: **40%** dei bug totali
- 🔴 Methods invented: **15-20%** del codice
- 🔴 Time debugging assumptions: **6-8 ore/settimana**
- 🔴 Developer trust in AI: **30-40%**
- 🔴 Code review rejections: **45%**

### **Post-REGOLA ZERO (OS3 Enforcement):**

- 🟢 Assumption-based bugs: **<5%** dei bug totali
- 🟢 Methods invented: **0%** (violations detected)
- 🟢 Time debugging assumptions: **<1 ora/settimana**
- 🟢 Developer trust in AI: **90-95%**
- 🟢 Code review rejections: **10%**

### **ROI Calculation:**

```
Ore risparmiate debugging assunzioni: 5-7 ore/settimana
× 50 settimane/anno
= 250-350 ore/anno per developer

Se costo developer = €50/ora
→ Risparmio annuale: €12,500 - €17,500 per developer

Moltiplicato per team di 5 developers:
→ Risparmio annuale: €62,500 - €87,500
```

---

## **🎓 Training & Onboarding**

### **Per Nuovi AI Partner:**

```markdown
# REGOLA ZERO - Training Checklist

## Fase 1: Comprensione (15 minuti)

- [ ] Leggi questo modulo completamente
- [ ] Comprendi il problema degli LLM (prediction vs reasoning)
- [ ] Memorizza le 5 domande obbligatorie

## Fase 2: Pratica Guidata (30 minuti)

- [ ] Esercizio 1: Verifica metodo service esistente
- [ ] Esercizio 2: Rileva assunzione e correggi
- [ ] Esercizio 3: Applica 5 domande a scenario reale

## Fase 3: Validation (45 minuti)

- [ ] Genera codice OS3-compliant per task reale
- [ ] Review: zero violazioni REGOLA ZERO
- [ ] Autodichiarazione: "REGOLA ZERO interiorizzata"
```

### **Per Developer Umani:**

```markdown
# REGOLA ZERO - Developer Guide

## Come Riconoscere Violazioni:

1. AI suggerisce metodo/classe senza citare fonte
2. AI usa "probabilmente", "dovrebbe", "tipicamente"
3. Codice compila ma fail a runtime con "method not found"

## Come Rispondere:

1. 🛑 "STOP - Verifica prima con tools se [elemento] esiste"
2. Fornisci path o esempio da cui partire
3. Richiedi re-implementation post-verifica

## Come Prevenire:

1. Attiva AI partner con prompt OS3 completo
2. Richiedi esplicitamente: "Applica REGOLA ZERO"
3. Monitora output per frasi bandite
```

---

## **🚀 REGOLA ZERO: Il Game-Changer**

REGOLA ZERO non è un semplice "best practice". È la **trasformazione fondamentale** che rende l'AI affidabile:

**Prima di REGOLA ZERO:**

- L'AI è strumento potente ma inaffidabile
- Developer deve verificare ogni output manualmente
- Velocità AI vanificata da debugging

**Dopo REGOLA ZERO:**

- L'AI è partner affidabile e verificabile
- Developer può fidarsi dell'output perché verificato alla fonte
- Velocità AI moltiplicata da affidabilità

**REGOLA ZERO è il pilastro che rende OS3 production-ready.**

---

_Prosegui con: **Modulo 3 - Sistema di Priorità P0-P3**_

---

**Version:** 3.0.0  
**Status:** Foundation Document  
**Last Updated:** Novembre 2025
