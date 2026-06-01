---
visibility: public
rag: public
---

# Legacy Stack Policy — Paradigma Oracode Nexus (Livello 1)

> **Chi**: CEO Fabio Cherici · CTO Padmin D. Curtis (AI)
> **Quando**: 2026-04-22
> **Versione**: 1.0.0
> **Mission**: M-094 (child di M-094-SUPERVISOR, parent M-093 Ultra Excellence Audit)
> **Enforcement**: hook PreToolUse Write|Edit di enforcement (meccanismo L1 riusabile, non specifico FlorenceEGI; impl privata OS3 Matrix)

> **Inquadramento Oracode Nexus (Livello 1).** Il ban stack (Alpine/Livewire/Filament per codice nuovo) è **policy di paradigma**: vale per ogni istanza LSO generata via `/project`. L'hook `check-no-legacy-stack.sh` è il meccanismo di enforcement L1, ereditabile da ogni HUB/istanza. Le **tabelle per-organo** e i **path EGI-DOC** sotto sono l'**applicazione concreta nell'ecosistema FlorenceEGI** (HUB/istanza accoppiato, caso unico) — esempio di istanza L2/L3, non parte normativa del paradigma.

---

## 1. Decisione

Tre stack frontend/backend sono **bannati** per codice NUOVO su tutti gli organi di un ecosistema LSO (esempio: istanza FlorenceEGI):

| Stack | Tipo | Motivo ban |
|-------|------|-----------|
| **Alpine.js** | Micro-framework reattivo | Aumenta complessità frontend senza valore rispetto a Vanilla TS. Collision con pattern bundle Vite + TypeScript |
| **Livewire** | Full-stack reactive PHP | Accoppiamento forte server↔view, payload HTML su ogni interazione, debug difficile. Contrario a filosofia Oracode "semplicità potenziante" |
| **Filament** | Admin panel Laravel | Esperienza diretta Fabio (esempio: istanza FlorenceEGI, admin v4 `art.florenceegi.com`): costruito con Filament non girava neanche pagando. Lento, farraginoso. Tutto si fa meglio con Blade + Vanilla TS + Tailwind |

**Legge**: ban universale per **codice nuovo**. Unica eccezione = Strategia Delta su legacy d'istanza (es. EGI, vedi sezione 4).

---

## 2. Stack ammessi per organo

Legenda: ✅ approvato · ❌ bannato (ban M-094) · 🟡 legacy debito (Strategia Delta)

| Organo | React/Next | Vanilla TS + Vite | Blade + Tailwind | Alpine | Livewire | Filament |
|--------|:---------:|:----------------:|:---------------:|:------:|:--------:|:--------:|
| **EGI** (art.florenceegi.com) | ✅ (sezioni moderne) | ✅ | ✅ | 🟡 legacy | 🟡 legacy | ❌ |
| **EGI-HUB** (hub.florenceegi.com) | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| **NATAN_LOC** (natan-loc.florenceegi.com) | ❌ | ✅ (obbligatorio) | ✅ | ❌ (P0-0) | ❌ (P0-0) | ❌ |
| **EGI-HUB-HOME-REACT** (florenceegi.com) | ✅ (obbligatorio) | ✅ | — | ❌ | ❌ | ❌ |
| **EGI-SIGILLO** (egi-sigillo.florenceegi.com) | ✅ (obbligatorio) | ✅ | — | ❌ | ❌ | ❌ |
| **EGI-INFO** (info.florenceegi.com) | ✅ (obbligatorio) | ✅ | — | ❌ | ❌ | ❌ |
| **EGI-Credential** (egi-credential.florenceegi.com) | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| **LA-BOTTEGA** (la-bottega.florenceegi.com) | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| **CREATOR-STAGING** (creator-staging.florenceegi.com) | ✅ (obbligatorio Next 15) | ✅ | — | ❌ | ❌ | ❌ |

### NATAN_LOC — nota aggiuntiva
P0-0 originale vieta anche React. Frontend obbligatorio: Vanilla TS + Blade. Due bundle separati (`natan/`, `citizen/`) gestiti da Vite.

### EGI — nota legacy 🟡
Esistono sezioni Livewire/Alpine pre-policy (es. istanza FlorenceEGI: art.florenceegi.com, aree AMMk, council). Strategia Delta applicata:
- NON rifattorizzate per decisione CEO (criticità bassa non giustifica effort)
- NON considerate violazioni quando trovate — sono debito tecnico tracciato
- Si migrano SOLO se si tocca la zona per altra ragione (on-touch-only)

---

## 3. Alternative approvate

### 3.1 Admin panel Laravel (ban Filament)
Sostituire con:
- **Controller + Blade views + Vanilla TS components + Tailwind puro**
- Pattern standard: tabelle, form, filtri, modali custom
- Esempio implementazione (istanza FlorenceEGI): EGI-HUB `/superadmin/*` (pannelli CEO)

### 3.2 Interattività frontend (ban Alpine/Livewire)
Sostituire con:
- **Blade statico** per struttura + contenuti
- **Vanilla TS con Vite** per interattività (componenti tipo `class ChatInterface`, `class Modal`)
- **DOMPurify** per qualunque inserimento HTML dinamico (P1)
- **ARIA** su elementi interattivi (P1)

### 3.3 SPA moderne (lato public/interattivo heavy)
- **React 18+ / Next.js 15+** con App Router
- Consumo API backend dell'organo (es. EGI) via fetch/Sanctum cookie
- Approvato (istanza FlorenceEGI): EGI-HUB-HOME-REACT, EGI-SIGILLO, EGI-Credential, CREATOR-STAGING, EGI-INFO

---

## 4. Enforcement automatico

### 4.1 Hook PreToolUse
**Enforcement**: hook PreToolUse di stack-ban (impl privata OS3 Matrix)
**Matcher**: `Write|Edit` su file `.blade.php`, `.ts`, `.tsx`, `.vue`, `.php`
**Azione**: exit code 2 (block) + stderr con pattern violato + alternative

### 4.2 Pattern bloccanti

| Stack | Pattern regex (ERE) |
|-------|---------------------|
| Livewire | `^\s*use\s+Livewire\\` · `@livewire(Styles\|Scripts)?\s*\(` · `@livewireStyles` · `@livewireScripts` · `\bwire:(click\|model\|submit\|loading\|poll\|keydown\|ignore\|init\|target\|key\|navigate\|dirty)\b` · `extends\s+\\?Livewire\\Component` |
| Alpine | `x-(data\|show\|on\|bind\|if\|for\|model\|text\|html\|ref\|cloak\|init\|transition\|effect\|teleport\|intersect)(\.[a-z-]+)?\s*[=">]` · `\bAlpine\.(data\|store\|magic\|directive\|plugin\|start)\s*\(` |
| Filament | `^\s*use\s+Filament\\` · `extends\s+\\?Filament\\` · `\bFilamentPanelProvider\b` · `->filament\s*\(` |

### 4.3 Eccezione Strategia Delta
Hook skippa file preesistenti in:
- `/home/fabio/EGI/resources/views/*`  (path istanza FlorenceEGI)
- `/home/fabio/EGI/app/Livewire/*`  (path istanza FlorenceEGI)
- `/home/fabio/EGI/app/Http/Livewire/*`  (path istanza FlorenceEGI)

File NUOVI sono sempre sotto enforcement, anche sull'organo legacy (es. EGI).

### 4.4 Bypass emergenza
Solo con approvazione CEO via protocollo CEO/CTO dell'istanza (esempio FlorenceEGI: `EGI-DOC/docs/oracode/05_PROTOCOLLO_CEO_CTO.md`):
- `git commit --no-verify` (dopo aver mitigato o documentato la violazione)
- Entry audit nel bypass log dell'istanza (esempio FlorenceEGI: `EGI-DOC/docs/oracode/audit/bypass_log.md`)

---

## 5. Cross-reference

### 5.1 Paradigma (Livello 1) — riferimenti normativi

| Documento | Path |
|-----------|------|
| Oracode Core (boot context, 13 P0) | `oracode/templates/CLAUDE_ORACODE_CORE.md` |
| Standard di paradigma rilocati (M-OS3-022) | `oracode/docs/paradigm/` |
| Gerarchia 3 livelli (SSOT) | `oracode/docs/paradigm/nomenclature/ORACODE_NEXUS_3_TIER.md` |

### 5.2 Istanza FlorenceEGI (Livello 2/3) — esempio applicativo

> EGI-DOC è il caso HUB/istanza **accoppiato** (caso unico). I path sotto sono l'applicazione concreta nell'ecosistema FlorenceEGI, NON riferimento normativo del paradigma.

| Documento | Path |
|-----------|------|
| Ecosystem Core FlorenceEGI (regole P0 istanza) | `CLAUDE_ECOSYSTEM_CORE.md` (root ogni organo) |
| NATAN_LOC P0-0 specifico | `NATAN_LOC/CLAUDE.md` |
| Memory CEO (Filament) | `~/.claude/projects/-home-fabio-NATAN-LOC/memory/feedback_filament_banned.md` |
| Memory CEO (framework rules) | `~/.claude/projects/-home-fabio-NATAN-LOC/memory/feedback_frontend_framework_rules.md` |
| Audit M-093 (F-C2 finding) | `EGI-DOC/audit/M-093_ULTRA_EXCELLENCE_AUDIT_2026-04-20.md` riga 137 |
| Mission M-094 report | `EGI-DOC/docs/missions/M-094_LEGACY_STACK_POLICY.md` |
| Mission registry istanza (L3) | `EGI-DOC/docs/missions/MISSION_REGISTRY.json` entry M-094 — chiavi italiane = legacy, migrazione graduale all'inglese |

---

## 6. Storico decisioni

> Storico dell'**istanza FlorenceEGI** (HUB/istanza accoppiato). Le fonti `CLAUDE_ECOSYSTEM_CORE.md` sono il boot context dell'istanza FlorenceEGI, non del paradigma (boot context paradigma: `oracode/templates/CLAUDE_ORACODE_CORE.md`, vedi §5.1).

| Data | Evento | Fonte |
|------|--------|-------|
| 2026-03-27 | CLAUDE_ECOSYSTEM_CORE.md P0-0 NATAN_LOC: no Alpine/Livewire/React | Memory `feedback_frontend_framework_rules.md` |
| 2026-04-20 | Audit M-093 F-C2 (istanza FlorenceEGI): rilevati `@livewireStyles` + 41 view `wire:` sull'organo EGI — segnalato chiarimento formale pending | `EGI-DOC/audit/M-093_ULTRA_EXCELLENCE_AUDIT_2026-04-20.md` riga 137 |
| 2026-04-21 | Memory aggiornata: Alpine/Livewire/Filament bannati su TUTTI gli organi per codice NUOVO, eccezione Strategia Delta su legacy d'istanza (es. EGI) | Memory `feedback_frontend_framework_rules.md` |
| 2026-04-21 | Filament confermato bannato su tutto l'ecosistema (esperienza admin v4, istanza FlorenceEGI) | Memory `feedback_filament_banned.md` |
| 2026-04-22 | M-094 chiusura: SSOT policy + hook `check-no-legacy-stack.sh` + update CORE | Questo documento |

---

**Versione 1.0.0** — 2026-04-22
**Approvazione**: CEO Fabio Cherici + CTO Padmin D. Curtis (AI)
**Next review**: su qualunque nuovo stack proposto + al completamento M-094-SUPERVISOR
