---
title: Agent Deploy & Runtime-Root — Modello (stub public)
slug: agent-deploy-runtime-model
doc_type: stub
status: current
visibility: public
rag: public
---

# Agent Deploy & Runtime-Root — Modello

> **Stub pubblico (M-OS3-048).** Modello (cosa/perché). Il **meccanismo di deploy concreto**
> (script, path sorgente, anchor, risoluzione root) è un SSOT `visibility: private`
> nell'enforcement OS3 Matrix (repo privato) — confine mono.

## Cosa è (modello)

Agenti e hook hanno una **fonte versionata single-source**; la **copia operativa** (nel layer di
deploy locale) è **generata** da quella fonte. I **root** si risolvono a **runtime**, non
hardcoded.

## Principio

**Si edita la fonte, mai la copia.** La copia operativa è un artefatto derivato: modificarla a
mano introduce drift source↔deploy (intercettato dalla regola R3 di `oracode-lint`). Coerente
con Pilastro 3 (Coerenza Semantica) e con la disciplina single-source della dottrina agenti.

## Comandi-skill — deploy e PRECEDENZA (M-OS3-064)

Anche i **comandi-skill** del paradigma (`/project`, `/discovery`) seguono lo stesso modello: fonte
versionata single-source in `oracode/.claude/commands/`, copia operativa in `~/.claude/commands/`,
generata da `bin/deploy-commands` (copia pura **additiva** — aggiorna solo i comandi del paradigma,
preserva gli altri comandi utente; gemello pubblico di `deploy-agents`).

**Regola di precedenza Claude Code (decisiva, verificata):**

```
Enterprise  >  Personal (~/.claude)  >  Project (.claude del workspace)  >  Plugin
```

A parità di nome, esegue **una sola** copia (niente namespacing): la **user-level vince sempre** sulla
project-level, in qualsiasi cartella. **Conseguenza operativa**: la copia che gira è quella in
`~/.claude/commands/` — se non la si rigenera dalla fonte con `deploy-commands`, **drifta** e Claude Code
esegue una versione vecchia mentre il sorgente git aggiornato resta **schermato e non eseguito**.

> **Cicatrice (perché questa regola è documentata):** `/project` girava una copia user-level vecchia,
> priva di un blocco P0-12 (verifica infra-deploy dalla SSOT dell'ecosistema, mai dedotta), mentre la fonte
> aggiornata in `oracode/.claude/commands/project.md` (più recente, git-tracked) era schermata dalla
> precedenza Personal>Project e **non veniva eseguita**. Fix: `deploy-commands` riallinea la copia che gira
> alla fonte versionata. **Dopo ogni modifica a un comando-skill: `deploy-commands`.**

> Implementazione concreta del deploy AGENTI/HOOK (script, anchor, layout): privata (OS3 Matrix).
> Il deploy COMANDI (`bin/deploy-commands`) è invece **pubblico** (vive in oracode, MIT, con la sorgente).
