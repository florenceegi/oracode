---
title: Agent Deploy & Runtime-Root — Modello (stub public)
slug: agent-deploy-runtime-model
doc_type: stub
version: 1.0.0
status: current
date: '2026-06-01'
updated_at: '2026-06-05'
author: Padmin D. Curtis (AI Partner OS3.0) for Fabio Cherici
scope:
- oracode
supersedes: []
superseded_by: null
visibility: public
rag: public
priority: normal
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

Anche i **comandi-skill** seguono lo stesso modello: fonte versionata single-source in un repo,
copia operativa in `~/.claude/commands/`, generata da un `deploy-commands` (copia pura **additiva** —
aggiorna solo i propri comandi, preserva gli altri comandi utente; gemello di `deploy-agents`).

**Dove vive la fonte (aggiornato il 2026-09-02, M-OS3-216).** I comandi che fanno nascere un
progetto — `/project`, `/discovery`, i quattro pezzi che li compongono e il collaudatore a secco
degli skill — **non stanno piu' qui**: sono applicazioni, e le applicazioni stanno in `os3-matrix`,
il prodotto con licenza. La loro fonte e' `os3-matrix/.claude/commands/`, il loro trasporto e'
`os3-matrix/bin/deploy-commands`. In oracode resta `web-fx-displacement`, che dipende dal materiale
grafico MIT in `templates/fx/`, col suo `bin/deploy-commands`. **I due trasporti scrivono nella
stessa cartella**: e' per questo che sono additivi e non sincronizzanti — uno che sincronizzasse
cancellerebbe i comandi dell'altro.

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
> Il deploy dei COMANDI della nascita e' anch'esso in OS3 Matrix dal 2026-09-02 (M-OS3-216): stava in
> oracode, ed era il pezzo che verifica la licenza a viaggiare dentro il repo pubblico MIT.
