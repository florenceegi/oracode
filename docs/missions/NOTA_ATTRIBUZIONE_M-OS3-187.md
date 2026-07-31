# M-OS3-187 — nota di attribuzione

Il documento `docs/paradigm/standards/ULTRA_ECCELLENZA_E_ULTRA_ENTERPRISE.md` e i
quattro rimandi che lo collegano ai punti dove il termine era uno slogan nudo sono
lavoro di **M-OS3-187**, ma risultano nel commit **`d055162`**, che è di M-OS3-185.

Perché: mentre scrivevo, la sessione di M-OS3-185 ha fatto un `git add` esteso e li ha
raccolti. È lo stesso incidente di attribuzione già capitato oggi in os3-matrix, dove
due file di M-OS3-175 sono finiti in un commit di M-OS3-176.

Non c'è nulla da riparare nel contenuto: i file sono giusti e tracciati. Quello che si
perde è la **contabilità** — M-OS3-185 risulta aver prodotto 226 righe che non ha
scritto, e M-OS3-187 risulta non aver prodotto nulla.

**Causa comune, e non è la sessione che l'ha fatto:** più sessioni lavorano sullo
stesso repository e `git add -A` (o `git add <cartella>`) raccoglie anche ciò che sta
scrivendo un'altra. Finché lo staging è condiviso, capiterà ancora.

*2026-07-31 — Claude (CTO AI) for Fabio Cherici*
