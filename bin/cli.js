#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const readline = require('readline');
const { execSync } = require('child_process');

const ORACODE_DIR = path.join(require('os').homedir(), '.oracode');
const LICENSE_PATH = process.env.ORACODE_LICENSE_PATH || path.join(ORACODE_DIR, 'license.json');

const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
const ask = (q) => new Promise(resolve => rl.question(q, resolve));

const COLORS = {
  green: '\x1b[32m', yellow: '\x1b[33m', red: '\x1b[31m',
  cyan: '\x1b[36m', bold: '\x1b[1m', reset: '\x1b[0m', dim: '\x1b[2m'
};

function log(msg) { console.log(msg); }
function ok(msg) { log(`${COLORS.green}✓${COLORS.reset} ${msg}`); }
function warn(msg) { log(`${COLORS.yellow}!${COLORS.reset} ${msg}`); }
function err(msg) { log(`${COLORS.red}✗${COLORS.reset} ${msg}`); }
function header(msg) { log(`\n${COLORS.bold}${COLORS.cyan}${msg}${COLORS.reset}`); }
function dim(msg) { log(`${COLORS.dim}  ${msg}${COLORS.reset}`); }

function findOracodeRepo() {
  let dir = __dirname;
  while (dir !== path.dirname(dir)) {
    if (fs.existsSync(path.join(dir, 'templates', 'CLAUDE_ORACODE_CORE.md'))) return dir;
    dir = path.dirname(dir);
  }
  return null;
}

function readLicense() {
  if (!fs.existsSync(LICENSE_PATH)) return null;
  try {
    const lic = JSON.parse(fs.readFileSync(LICENSE_PATH, 'utf8'));
    if (lic.product !== 'os3-matrix') return null;
    const expires = new Date(lic.expires);
    if (expires < new Date()) return { ...lic, expired: true };
    return { ...lic, expired: false };
  } catch { return null; }
}

function copyRecursive(src, dest) {
  if (!fs.existsSync(src)) return;
  const stat = fs.statSync(src);
  if (stat.isDirectory()) {
    fs.mkdirSync(dest, { recursive: true });
    for (const item of fs.readdirSync(src)) {
      if (item === '.git' || item === 'node_modules' || item === '__pycache__') continue;
      copyRecursive(path.join(src, item), path.join(dest, item));
    }
  } else {
    fs.mkdirSync(path.dirname(dest), { recursive: true });
    fs.copyFileSync(src, dest);
  }
}

function replacePlaceholders(filePath, vars) {
  if (!fs.existsSync(filePath)) return;
  let content = fs.readFileSync(filePath, 'utf8');
  for (const [key, value] of Object.entries(vars)) {
    content = content.replace(new RegExp(`\\{\\{${key}\\}\\}`, 'g'), value);
  }
  fs.writeFileSync(filePath, content);
}

async function main() {
  const command = process.argv[2];
  const isTest = process.argv.includes('--test');
  const testDefaults = {
    projectName: 'AcquaForte', company: 'AcquaForte SRL', ceo: 'Marco Rossi',
    domain: 'Gestionale servizi idraulici per PMI', targetDir: '',
    level: '3', backend: 'Laravel 12', frontend: 'React',
    database: 'PostgreSQL', infra: 'AWS EC2', langs: 'it en'
  };
  const askOrDefault = async (q, key) => isTest ? testDefaults[key] : await ask(q);

  if (command !== 'init') {
    log(`\n${COLORS.bold}oracode${COLORS.reset} — AI-native development paradigm\n`);
    log('Commands:');
    log('  oracode init    Bootstrap a new Oracode project');
    log('');
    rl.close();
    return;
  }

  log(`\n${COLORS.bold}${COLORS.cyan}  ORACODE — Project Bootstrap${COLORS.reset}\n`);

  // --- PHASE 0: Detection ---
  header('Phase 0 — Detection');

  const oracodeRepo = findOracodeRepo();
  if (oracodeRepo) {
    ok(`Oracode paradigm found: ${oracodeRepo}`);
  } else {
    err('Oracode paradigm not found. Run from inside the oracode repo.');
    rl.close();
    return;
  }

  const license = readLicense();
  if (license && !license.expired) {
    ok(`OS3 Matrix license valid (expires ${license.expires})`);
    dim(`Licensee: ${license.licensee.name}, ${license.licensee.company}`);
  } else if (license && license.expired) {
    warn(`OS3 Matrix license EXPIRED (${license.expires})`);
  } else {
    dim('OS3 Matrix: no license found. Paradigm-only mode available.');
  }

  // --- PHASE 1: Project info ---
  header('Phase 1 — Project');

  const projectName = await askOrDefault('  Project name: ', 'projectName');
  if (!projectName.trim()) { err('Project name required.'); rl.close(); return; }

  const company = await askOrDefault('  Company: ', 'company');
  const ceo = await askOrDefault('  CEO/Founder name: ', 'ceo');
  const domain = await askOrDefault('  Domain (one line): ', 'domain');
  const rawTarget = await askOrDefault(`  Target directory [./${projectName}-DOC]: `, 'targetDir');
  const targetDir = rawTarget || `./${projectName}-DOC`;

  // --- PHASE 2: Level ---
  header('Phase 2 — Application Level');
  log('');
  log('  1 — Discipline only (paradigm, no enforcement)');
  log('  2 — Enforcement (adds OS3 Matrix hooks + agents)');
  log('  3 — LSO mono-organ (adds mission protocol, SSOT tracking)');
  log('  4 — LSO multi-organ (adds Organ Index, cross-organ contracts)');
  log('');
  const levelStr = await askOrDefault('  Level [1]: ', 'level') || '1';
  const level = parseInt(levelStr);

  if (level >= 2 && (!license || license.expired)) {
    warn('Level 2+ requires OS3 Matrix license.');
    const proceed = isTest ? 'Y' : (await ask('  Continue without Matrix (level 1)? [Y/n]: ') || 'Y');
    if (proceed.toLowerCase() !== 'y') { rl.close(); return; }
    warn('Falling back to level 1.');
  }

  // --- PHASE 3: Stack ---
  header('Phase 3 — Stack');

  const backend = await askOrDefault('  Backend (e.g. Laravel, FastAPI, Express): ', 'backend');
  const frontend = await askOrDefault('  Frontend (e.g. React, Vue, Blade): ', 'frontend');
  const database = await askOrDefault('  Database (e.g. PostgreSQL, MySQL): ', 'database');
  const infra = await askOrDefault('  Infrastructure (e.g. AWS, Vercel, VPS): ', 'infra');
  const langs = await askOrDefault('  i18n languages [it en]: ', 'langs') || 'it en';

  // --- PHASE 4: Install ---
  header('Phase 4 — Installing');

  const absTarget = path.resolve(targetDir);
  const templateDir = path.join(oracodeRepo, 'templates', 'PROJECT-DOC');

  if (fs.existsSync(absTarget)) {
    err(`Directory already exists: ${absTarget}`);
    rl.close();
    return;
  }

  // Copy scaffold
  copyRecursive(templateDir, absTarget);
  ok('Scaffold created');

  // Copy paradigm boot context
  const coreSrc = path.join(oracodeRepo, 'templates', 'CLAUDE_ORACODE_CORE.md');
  fs.copyFileSync(coreSrc, path.join(absTarget, 'CLAUDE_ORACODE_CORE.md'));
  ok('CLAUDE_ORACODE_CORE.md installed');

  // Copy skills
  const skillsDir = path.join(absTarget, '.claude', 'commands');
  fs.mkdirSync(skillsDir, { recursive: true });
  const oracodeSkills = path.join(oracodeRepo, '.claude', 'commands');
  if (fs.existsSync(oracodeSkills)) {
    for (const f of fs.readdirSync(oracodeSkills)) {
      fs.copyFileSync(path.join(oracodeSkills, f), path.join(skillsDir, f));
    }
    ok('Skills installed (/project, /discovery)');
  }

  // Replace placeholders
  const today = new Date().toISOString().split('T')[0];
  const vars = {
    PROJECT_NAME: projectName,
    COMPANY_NAME: company,
    CEO_NAME: ceo,
    CTO_NAME: 'Padmin D. Curtis (AI Partner)',
    CTO_ROLE: 'AI Partner OS3.0',
    DOMAIN_DESCRIPTION: domain,
    ORACODE_LEVEL: String(level),
    BACKEND_STACK: backend,
    FRONTEND_STACK: frontend,
    DATABASE: database,
    INFRASTRUCTURE: infra,
    TARGET_LANGUAGES: langs,
    DATE: today,
  };

  replacePlaceholders(path.join(absTarget, 'CLAUDE.md'), vars);
  replacePlaceholders(path.join(absTarget, 'docs', 'missions', 'MISSION_REGISTRY.json'), vars);
  replacePlaceholders(path.join(absTarget, 'docs', 'lso', 'SSOT_REGISTRY.json'), vars);
  ok('Placeholders compiled');

  // --- OS3 Matrix (if licensed and level 2+) ---
  if (level >= 2 && license && !license.expired) {
    header('Phase 4b — OS3 Matrix');

    const matrixDir = path.join(require('os').tmpdir(), `os3-matrix-${Date.now()}`);
    try {
      log('  Cloning OS3 Matrix...');
      let cloneUrl = license.repo;
      const ghToken = process.env.GITHUB_TOKEN;
      if (ghToken && cloneUrl.startsWith('https://github.com/')) {
        cloneUrl = cloneUrl.replace('https://github.com/', `https://${ghToken}@github.com/`);
      }
      execSync(`git clone --depth 1 ${cloneUrl} ${matrixDir}`, { stdio: 'pipe' });
      ok('OS3 Matrix cloned');

      // Hooks
      const hooksSource = path.join(matrixDir, 'hooks');
      const hooksDest = path.join(absTarget, '.claude', 'hooks');
      if (fs.existsSync(hooksSource)) {
        copyRecursive(hooksSource, hooksDest);
        const hookCount = fs.readdirSync(hooksDest).filter(f => f.endsWith('.sh')).length;
        ok(`${hookCount} hooks installed`);
      }

      // Agents
      const agentsSource = path.join(matrixDir, 'agents');
      const agentsDest = path.join(absTarget, '.claude', 'agents');
      if (fs.existsSync(agentsSource)) {
        copyRecursive(agentsSource, agentsDest);
        const agentCount = fs.readdirSync(agentsDest).filter(f => f.endsWith('.md')).length;
        ok(`${agentCount} agents installed`);
      }

      // CLI tools
      const binSource = path.join(matrixDir, 'bin');
      const binDest = path.join(absTarget, '.oracode', 'bin');
      if (fs.existsSync(binSource)) {
        copyRecursive(binSource, binDest);
        ok('CLI tools installed');
      }

      // Mission protocol
      const missionSource = path.join(matrixDir, 'mission');
      const missionDest = path.join(absTarget, '.oracode', 'mission');
      if (fs.existsSync(missionSource)) {
        copyRecursive(missionSource, missionDest);
        ok('Mission protocol installed');
      }

      // Nervous system
      const nervousSource = path.join(matrixDir, 'nervous-system');
      const nervousDest = path.join(absTarget, '.oracode', 'nervous-system');
      if (fs.existsSync(nervousSource)) {
        copyRecursive(nervousSource, nervousDest);
        ok('Nervous system installed');
      }

      // Matrix template
      const matrixTemplate = path.join(matrixDir, 'CLAUDE_OS3_MATRIX_TEMPLATE.md');
      if (fs.existsSync(matrixTemplate)) {
        fs.copyFileSync(matrixTemplate, path.join(absTarget, 'CLAUDE_OS3_MATRIX_TEMPLATE.md'));
        ok('OS3 Matrix template installed');
      }

      // Cleanup
      fs.rmSync(matrixDir, { recursive: true, force: true });
      dim('Temporary clone removed');

    } catch (e) {
      warn(`Could not clone OS3 Matrix: ${e.message}`);
      warn('Continuing without enforcement. You can install Matrix later.');
    }
  }

  // --- PHASE 5: Summary ---
  header('Phase 5 — Done');
  log('');

  // Show tree
  function showTree(dir, prefix = '') {
    const items = fs.readdirSync(dir).filter(i => !i.startsWith('.git') || i === '.claude' || i === '.oracode');
    items.sort();
    items.forEach((item, i) => {
      const isLast = i === items.length - 1;
      const fullPath = path.join(dir, item);
      const stat = fs.statSync(fullPath);
      const connector = isLast ? '└── ' : '├── ';
      const nextPrefix = isLast ? '    ' : '│   ';
      log(`  ${prefix}${connector}${item}${stat.isDirectory() ? '/' : ''}`);
      if (stat.isDirectory()) showTree(fullPath, prefix + nextPrefix);
    });
  }

  log(`  ${COLORS.bold}${absTarget}${COLORS.reset}`);
  showTree(absTarget);

  log('');
  ok(`Project ${COLORS.bold}${projectName}${COLORS.reset} ready (Level ${level})`);
  log('');
  log('  Next steps:');
  log(`  ${COLORS.dim}cd ${targetDir}${COLORS.reset}`);
  log(`  ${COLORS.dim}# Open Claude Code${COLORS.reset}`);
  if (level >= 3) {
    log(`  ${COLORS.dim}/discovery   — Start client acquisition cycle${COLORS.reset}`);
    log(`  ${COLORS.dim}/project     — Configure project details${COLORS.reset}`);
  } else {
    log(`  ${COLORS.dim}# Start coding — CLAUDE_ORACODE_CORE.md guides the AI${COLORS.reset}`);
  }
  log('');

  rl.close();
}

main().catch(e => { console.error(e); process.exit(1); });
