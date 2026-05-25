---
title: LSO Guard Testing Protocol INDEX
slug: lso-guard-testing-protocol-index
doc_type: index
version: 1.0.0
status: current
date: '2026-05-08'
updated_at: '2026-05-08'
author: Padmin D. Curtis for Fabio Cherici
scope:
- oracode
rag_indexed: true
priority: high
source: docs/lso/LSO_GUARD_TESTING_PROTOCOL_v1.md
---

# LSO Guard Testing Protocol — INDEX

> Sintesi operativa della specifica vincolante per guard di LSO.
> Per approfondimenti: `LSO_GUARD_TESTING_PROTOCOL_v1.md` (on-demand).

---

## 1. Principio fondante

Un guard e una rete di sicurezza. Una rete non testata in fallimento reale non e una rete — e teatro di sicurezza. Un guard che esegue senza errori ma non blocca quando deve e peggio di nessun guard.

Driver: post-mortem DOC-SYNC v2 (2026-04-30, M-148). Guard cercava `status`/`date_closed` nel registry che contiene `stato`/`data_chiusura`. Deployato senza verifica naming.

---

## 2. I 5 criteri di guard funzionante

| # | Criterio | Sintesi | Violazione tipica |
|---|----------|---------|-------------------|
| 1 | **Bloccaggio reale** | Exit 2 + agganciato a punto dove operazione NON e ancora avvenuta (PreToolUse) | PostToolUse con exit 2 = logger con exit code fuorviante |
| 2 | **Coerenza campi** | Campi letti = campi esistenti nel SSOT, stesso naming | Campo inglese vs italiano (causa DOC-SYNC v2 failure) |
| 3 | **Test pos + neg** | Almeno 1 test positivo (guard passa) + 1 negativo (guard blocca) | Test che passa perche non trova niente |
| 4 | **Header documentale** | Nome, tipo, condizione blocco, ref test, versione | Header assente o con campi non verificati |
| 5 | **Idempotenza** | Stesso input → stesso output, sempre | Side effect da file lock, ora del giorno |

Eccezione: guard **passivi** (sola segnalazione) ammessi se dichiarati esplicitamente come tali nell'header.

---

## 3. Test obbligatori

**Test positivo**: setup stato corretto → esegui guard → assert exit 0. DEVE verificare che la logica sia stata effettivamente eseguita su dati reali.

**Test negativo**: setup condizione violata → esegui guard → assert exit != 0 + operazione protetta NON eseguita. Per guard bloccanti, verificare ENTRAMBI: (a) exit code di blocco, (b) operazione impedita.

**Posizione**: `tests/guards/<nome_guard>/test_positive.sh`, `test_negative.sh`, `fixtures/`, `README.md`.

**Esecuzione automatica**: alla modifica del guard + periodica (almeno settimanale).

---

## 4. Policy naming SSOT

Tutti i nuovi SSOT in **italiano** (snake_case: `data_chiusura`, `stato_corrente`). Termini tecnici propri (commit, branch, webhook) restano in inglese. SSOT esistenti: migrazione lazy quando toccati per altra ragione. Guard aggiornati atomicamente con la migrazione del SSOT.

---

## 5. Audit retroattivo

Per ogni guard: header conforme? Campi reali nel SSOT? Test pos/neg esistono e passano? Tipo dichiarato?

Output per guard: **OK** | **BROKEN** | **PARTIAL** | **DEPRECATED**.

Ordine riparazione: (1) Critici — operazioni distruttive, (2) Importanti — integrita documentale, (3) Diagnostici — monitoraggio.

---

## 6. Processo approvazione nuovi guard

5 deliverable obbligatori: codice + header, test positivo, test negativo, README, log verifica coerenza naming.

Gate CEO esplicito prima del deploy. Review positiva ≠ approvazione. Test end-to-end in flusso reale obbligatorio dopo approvazione, prima di status "operativo".

---

## 7. I 7 anti-pattern

| # | Anti-pattern | In una frase |
|---|-------------|--------------|
| 1 | Test che passa perche non trova niente | Query vuota / file assente / input malformato → successo falso |
| 2 | Header dichiarativo non verificato | Campi dichiarati ≠ campi reali nel SSOT |
| 3 | 8/8 PASS senza flusso reale | Suite isolata 100% ≠ evidenza operativa |
| 4 | Approvazione implicita da review | Review positiva ≠ approvazione CEO |
| 5 | Naming inglese in nuovi SSOT | Vietato (§4) |
| 6 | Guard bloccante che e passivo | Dichiara blocco, solo segnala = rotto |
| 7 | Modifica senza re-test | Anche cosmetica → re-test obbligatorio |

---

## 8. Costi operativi

- Audit per guard: 30-90 min. Audit completo (10-20 guard): 5-30 ore.
- Nuovo guard: 2-4 ore oltre al codice (header + test + README + verifica).
- Prezzo dell'alternativa: incidenti come M-148 scoperti a danno avvenuto.

---

*Per dettaglio completo (struttura test, esempi, processo 6.1-6.3, test accettazione protocollo): `docs/lso/LSO_GUARD_TESTING_PROTOCOL_v1.md` (on-demand)*
