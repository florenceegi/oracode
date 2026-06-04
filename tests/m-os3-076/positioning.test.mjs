import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
const tpl = readFileSync('/home/fabio/oracode/templates/fx/fximage.v1.js','utf8');
let f=0; const ck=(c,m)=>{try{assert.ok(c,m);console.log('  ✓ '+m);}catch(e){console.error('  ✗ '+e.message);f++;}};
console.log('=== M-OS3-076 — template fx posizionamento robusto ===');
ck(/position:fixed/.test(tpl.replace(/\s+/g,'')), 'canvas position:fixed (insegue il viewport)');
ck(/document\.body\.appendChild\(canvas\)/.test(tpl), 'canvas appeso a body (non al wrapper host)');
ck(!/closest\('figure'\)/.test(tpl), 'niente dipendenza da <figure> contenitore');
ck(/getBoundingClientRect/.test(tpl), 'traccia il rect dell\'img');
// la funzione di place deve aggiornare left/top/width/height del canvas
ck(/canvas\.style\.(left|top|width|height)/.test(tpl), 'aggiorna left/top/width/height del canvas');
// hover legato all'img (non al parent)
ck(/img\.addEventListener\((['"])pointer/.test(tpl), 'hover legato all\'img');
// shader fix mantenuto (no edge invertiti)
ck(/1\.0 - smoothstep\(0\.0/.test(tpl.replace(/\s+/g,' ')), 'shader hover definito (1.0 - smoothstep(0.0,R,d))');
process.exit(f===0?0:1);
