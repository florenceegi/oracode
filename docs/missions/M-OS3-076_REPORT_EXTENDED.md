# M-OS3-076 — Report Esteso

## Origine
Circolarità virtuosa: la prima applicazione reale della skill a un secondo organo (Le Vespe) ha messo
alla prova il template e ne ha rivelato il limite — assumeva un wrapper stretto attorno all'immagine
(vero per `MuseumPhoto` di Capasso, falso per le img nude/card di Le Vespe). Il template è stato reso
robusto PRIMA di applicarlo, così la skill mantiene la sua promessa ("drop-in, gli agent non hanno
difficoltà").

## Decisione
Canvas `position:fixed` che insegue il `getBoundingClientRect()` dell'img a ogni frame: una sola
strategia che copre img nuda, card, grid (e anche figure). Costo trascurabile (un getBoundingClientRect
per immagine potenziata per frame, solo mentre visibile). Backward-compatible.

## Nota su Capasso
La copia di Capasso (`fximage.v2.js`) usa ancora l'approccio figure-based: funziona perché lì le immagini
sono in `<figure class="photo">` strette. Re-sync al template 1.1.0 = follow-up opzionale (non urgente).

## Esito
Template 1.1.0, skill allineata, test verdi. Pronto per l'applicazione a Le Vespe (M-LEVESPE-015).
