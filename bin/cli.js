#!/usr/bin/env node

/**
 * Oracode CLI — AI governance framework for Claude Code
 * Usage:
 *   npx oracode init     → interactive setup wizard
 *   npx oracode health   → check SSOT documentation alignment
 *   npx oracode gate     → validate before push
 *
 * @author Fabio Cherici — FlorenceEGI
 * @license MIT
 */

import { readFileSync, writeFileSync, mkdirSync, existsSync, chmodSync } from 'fs';
import { join, dirname, resolve } from 'path';
import { fileURLToPath } from 'url';
import { createInterface } from 'readline';
import { execSync } from 'child_process';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const PKG_ROOT = resolve(__dirname, '..');

const rl = createInterface({ input: process.stdin, output: process.stdout });
const ask = (q) => new Promise((r) => rl.question(q, r));

const ORACODE_DIR = '.oracode';

// ─── Commands ───────────────────────────────────────────────────────────────

const commands = {
  init: runInit,
  health: runHealth,
  gate: runGate,
  help: runHelp,
};

const cmd = process.argv[2] || 'help';
if (commands[cmd]) {
  commands[cmd]().then(() => process.exit(0)).catch((e) => { console.error(e.message); process.exit(1); });
} else {
  console.log(`Unknown command: ${cmd}\nRun 'oracode help' for usage.`);
  process.exit(1);
}

// ─── Init Wizard ────────────────────────────────────────────────────────────

async function runInit() {
  console.log('');
  console.log('  ╔══════════════════════════════════════╗');
  console.log('  ║         ORACODE — Setup Wizard       ║');
  console.log('  ║   AI governance for Claude Code      ║');
  console.log('  ╚══════════════════════════════════════╝');
  console.log('');

  // Detect workspace
  const cwd = process.cwd();
  console.log(`  Workspace: ${cwd}`);
  console.log('');

  // Step 1: Project structure
  const projectMode = await ask('  Single project or multi-project ecosystem? [single/multi] ');
  const isMulti = projectMode.trim().toLowerCase().startsWith('m');

  let projectDirs = [];
  if (isMulti) {
    const dirs = await ask('  Project directories (comma-separated, relative to workspace):\n  > ');
    projectDirs = dirs.split(',').map(d => d.trim()).filter(Boolean);
  } else {
    projectDirs = ['.'];
  }

  // Step 2: Feature groups
  console.log('');
  console.log('  Which feature groups do you want to enable?');
  console.log('  (Each group installs multiple hooks automatically)');
  console.log('');
  const useSecurity = (await ask('  [1] Security (secrets, .env, rm protection, git-main guard)? [Y/n] ')).trim().toLowerCase() !== 'n';
  const useCodeQuality = (await ask('  [2] Code quality (immutable values, legacy guard, MiCA-SAFE, P0-4 method check, i18n)? [Y/n] ')).trim().toLowerCase() !== 'n';
  const useAudit = (await ask('  [3] Audit (static audit on write, audit on complete, deep audit)? [Y/n] ')).trim().toLowerCase() !== 'n';
  const useNervousSystem = (await ask('  [4] Nervous system (SSOT reflex, living check, cross-project guard)? [Y/n] ')).trim().toLowerCase() !== 'n';
  const useMission = (await ask('  [5] Mission protocol (tracking, report guard, stats guard, reinject)? [Y/n] ')).trim().toLowerCase() !== 'n';
  const useDeploy = (await ask('  [6] Deploy pipeline guard (monitors push + deploy status)? [Y/n] ')).trim().toLowerCase() !== 'n';

  // Backward compat
  const useEnvGuard = useSecurity;
  const useImmutableGuard = useCodeQuality;
  const useLegacyGuard = useCodeQuality;
  const useGate = useAudit;

  // Step 3: Configuration
  let immutableValues = [];
  if (useImmutableGuard) {
    console.log('');
    console.log('  Define immutable values (empty line to finish):');
    console.log('  Format: pattern | description');
    console.log('  Example: COMMISSION_RATE = 0.035 | Business commission rate');
    while (true) {
      const line = await ask('  > ');
      if (!line.trim()) break;
      const [pattern, desc] = line.split('|').map(s => s.trim());
      if (pattern) immutableValues.push({ pattern, description: desc || pattern });
    }
  }

  let legacyFiles = [];
  if (useLegacyGuard) {
    console.log('');
    console.log('  Define legacy file patterns (empty line to finish):');
    console.log('  Example: services/legacy_payment.py');
    while (true) {
      const line = await ask('  > ');
      if (!line.trim()) break;
      legacyFiles.push(line.trim());
    }
  }

  const maxFileLines = parseInt(await ask('\n  Max file lines (default 500): ') || '500', 10);

  // ─── Generate ───────────────────────────────────────────────────────────

  console.log('');
  console.log('  Generating Oracode configuration...');

  // Create .oracode directory
  const oracodeDir = join(cwd, ORACODE_DIR);
  mkdirSync(join(oracodeDir, 'hooks'), { recursive: true });
  mkdirSync(join(oracodeDir, 'agents'), { recursive: true });

  // Config file
  const config = {
    version: '0.1.0',
    project_mode: isMulti ? 'multi' : 'single',
    project_dirs: projectDirs.map(d => resolve(cwd, d)),
    max_file_lines: maxFileLines,
    immutable_values: immutableValues,
    legacy_files: legacyFiles,
    features: {
      env_guard: useEnvGuard,
      immutable_guard: useImmutableGuard,
      legacy_guard: useLegacyGuard,
      audit_static: useAudit,
      gate: useGate,
      nervous_system: useNervousSystem,
      mission_protocol: useMission,
    },
  };

  writeFileSync(join(oracodeDir, 'config.json'), JSON.stringify(config, null, 2));
  console.log('  ✓ config.json');

  // Copy and parameterize hooks
  const hooksDir = join(PKG_ROOT, 'hooks', 'templates');
  const projectDirsStr = projectDirs.map(d => resolve(cwd, d)).join(' ');

  const hookMap = [
    // Security group
    { file: 'env-guard.sh', enabled: useSecurity, trigger: 'PreToolUse', matcher: 'Write|Edit', msg: 'oracode: checking secrets...' },
    { file: 'rm-guard.sh', enabled: useSecurity, trigger: 'PreToolUse', matcher: 'Bash', msg: 'oracode: protecting active files...' },
    { file: 'git-main-guard.sh', enabled: useSecurity, trigger: 'PreToolUse', matcher: 'Bash', msg: 'oracode: protecting main branch...' },
    // Code quality group
    { file: 'immutable-values-guard.sh', enabled: useCodeQuality, trigger: 'PreToolUse', matcher: 'Write|Edit', msg: 'oracode: checking immutable values...' },
    { file: 'legacy-guard.sh', enabled: useCodeQuality, trigger: 'PreToolUse', matcher: 'Write|Edit', msg: 'oracode: checking legacy files...' },
    { file: 'mica-guard.sh', enabled: useCodeQuality, trigger: 'PreToolUse', matcher: 'Write|Edit', msg: 'oracode: MiCA-SAFE check...' },
    { file: 'os3-preflight-guard.sh', enabled: useCodeQuality, trigger: 'PreToolUse', matcher: 'Write|Edit', msg: 'oracode: preflight rules reminder...' },
    { file: 'hardcoded-strings-guard.sh', enabled: useCodeQuality, trigger: 'PreToolUse', matcher: 'Write|Edit', msg: 'oracode: checking i18n...' },
    { file: 'p04-method-guard.sh', enabled: useCodeQuality, trigger: 'PreToolUse', matcher: 'Write|Edit', msg: 'oracode: P0-4 method existence check...' },
    // Audit group
    { file: 'os3-audit-static.sh', enabled: useAudit, trigger: 'PostToolUse', matcher: 'Write|Edit', msg: 'oracode: auditing file...' },
    { file: 'os3-audit-on-complete.sh', enabled: useAudit, trigger: 'PostToolUse', matcher: 'TodoWrite', msg: 'oracode: audit on task complete...' },
    // Nervous system group
    { file: 'ssot-reflex-guard.sh', enabled: useNervousSystem, trigger: 'PostToolUse', matcher: 'Write|Edit', msg: 'oracode: checking doc alignment...' },
    { file: 'cross-project-guard.sh', enabled: useNervousSystem, trigger: 'PreToolUse', matcher: 'Write|Edit', msg: 'oracode: cross-project context...' },
    // Mission group
    { file: 'mission-report-guard.sh', enabled: useMission, trigger: 'PostToolUse', matcher: 'Bash', msg: 'oracode: checking mission reports...' },
    { file: 'mission-stats-guard.sh', enabled: useMission, trigger: 'PostToolUse', matcher: 'Bash', msg: 'oracode: checking mission stats...' },
    { file: 'os3-mission-reinject.sh', enabled: useMission, trigger: 'PreToolUse', matcher: 'Agent', msg: 'oracode: injecting mission context...' },
    // Deploy group
    { file: 'deploy-pipeline-guard.sh', enabled: useDeploy, trigger: 'PostToolUse', matcher: 'Bash', msg: 'oracode: monitoring deploy...' },
  ];

  const activeHooks = [];

  for (const hook of hookMap) {
    if (!hook.enabled) continue;
    const src = join(hooksDir, hook.file);
    if (!existsSync(src)) continue;

    let content = readFileSync(src, 'utf-8');
    content = content.replace(/\{\{ORACODE_DIR\}\}/g, oracodeDir);
    content = content.replace(/\{\{PROJECT_DIRS\}\}/g, projectDirsStr);
    content = content.replace(/\{\{MAX_FILE_LINES\}\}/g, String(maxFileLines));

    const dest = join(oracodeDir, 'hooks', hook.file);
    writeFileSync(dest, content);
    chmodSync(dest, 0o755);
    activeHooks.push(hook);
    console.log(`  ✓ hooks/${hook.file}`);
  }

  // Copy agent templates (all 8)
  const agentsSrc = join(PKG_ROOT, 'agents', 'templates');
  const agentFiles = [
    { file: 'os3-audit-specialist.md', enabled: useAudit },
    { file: 'os3-gate.md', enabled: useAudit },
    { file: 'organ-gap-scout.md', enabled: useNervousSystem },
    { file: 'oracode-alignment-interpreter.md', enabled: useNervousSystem },
    { file: 'oracode-specialist.md', enabled: true },
    { file: 'ssot-living-agent.md', enabled: useNervousSystem },
    { file: 'node-ts-specialist.md', enabled: true },
    { file: 'corporate-finance-specialist.md', enabled: true },
  ];

  let agentCount = 0;
  for (const agent of agentFiles) {
    if (!agent.enabled) continue;
    const src = join(agentsSrc, agent.file);
    if (!existsSync(src)) continue;
    let content = readFileSync(src, 'utf-8');
    content = content.replace(/\{\{MAX_FILE_LINES\}\}/g, String(maxFileLines));
    content = content.replace(/\{\{ORACODE_DIR\}\}/g, oracodeDir);
    writeFileSync(join(oracodeDir, 'agents', agent.file), content);
    agentCount++;
    console.log(`  ✓ agents/${agent.file}`);
  }

  // Copy cron scripts (standalone, not Claude hooks)
  const cronScripts = [
    { file: 'os3-deep-audit.sh', enabled: useAudit },
    { file: 'ssot-living-check.sh', enabled: useNervousSystem },
  ];
  mkdirSync(join(oracodeDir, 'cron'), { recursive: true });
  for (const cs of cronScripts) {
    if (!cs.enabled) continue;
    const src = join(hooksDir, cs.file);
    if (!existsSync(src)) continue;
    let content = readFileSync(src, 'utf-8');
    content = content.replace(/\{\{ORACODE_DIR\}\}/g, oracodeDir);
    const dest = join(oracodeDir, 'cron', cs.file);
    writeFileSync(dest, content);
    chmodSync(dest, 0o755);
    console.log(`  ✓ cron/${cs.file}`);
  }

  // Mission registry
  if (useMission) {
    const registry = { counter: 1, last_updated: new Date().toISOString().split('T')[0], missions: [] };
    writeFileSync(join(oracodeDir, 'mission-registry.json'), JSON.stringify(registry, null, 2));
    console.log('  ✓ mission-registry.json');
  }

  // SSOT Registry
  if (useNervousSystem) {
    const ssotRegistry = { _meta: { version: '1.0.0', updated: new Date().toISOString() }, documents: [] };
    writeFileSync(join(oracodeDir, 'ssot-registry.json'), JSON.stringify(ssotRegistry, null, 2));
    console.log('  ✓ ssot-registry.json (empty — add your docs)');
  }

  // ─── Register hooks in Claude Code settings ─────────────────────────────

  const claudeSettingsPath = join(process.env.HOME || '~', '.claude', 'settings.json');
  let settingsUpdated = false;

  if (existsSync(claudeSettingsPath) && activeHooks.length > 0) {
    try {
      const settings = JSON.parse(readFileSync(claudeSettingsPath, 'utf-8'));
      if (!settings.hooks) settings.hooks = {};

      for (const hook of activeHooks) {
        const triggerKey = hook.trigger;
        if (!settings.hooks[triggerKey]) settings.hooks[triggerKey] = [];

        const hookPath = join(oracodeDir, 'hooks', hook.file);

        // Check if already registered
        const exists = settings.hooks[triggerKey].some(entry =>
          entry.hooks?.some(h => h.command === hookPath)
        );

        if (!exists) {
          // Find matching matcher group or create new
          let matcherGroup = settings.hooks[triggerKey].find(entry => entry.matcher === hook.matcher);
          if (!matcherGroup) {
            matcherGroup = { matcher: hook.matcher, hooks: [] };
            settings.hooks[triggerKey].push(matcherGroup);
          }
          matcherGroup.hooks.push({
            type: 'command',
            command: hookPath,
            timeout: 10,
            statusMessage: hook.msg,
          });
        }
      }

      writeFileSync(claudeSettingsPath, JSON.stringify(settings, null, 2));
      settingsUpdated = true;
      console.log('  ✓ Claude Code settings.json updated');
    } catch (e) {
      console.log(`  ⚠ Could not update Claude Code settings: ${e.message}`);
      console.log('    You may need to register hooks manually.');
    }
  }

  // ─── Summary ──────────────────────────────────────────────────────────

  console.log('');
  console.log('  ══════════════════════════════════════');
  console.log('  Oracode initialized successfully!');
  console.log('  ══════════════════════════════════════');
  console.log('');
  console.log(`  Config:  ${oracodeDir}/config.json`);
  console.log(`  Hooks:   ${activeHooks.length} active`);
  console.log(`  Agents:  ${agentCount} installed`);
  if (settingsUpdated) {
    console.log('  Claude:  hooks registered in settings.json');
  }
  console.log('');
  console.log('  Next steps:');
  if (useImmutableGuard && immutableValues.length === 0) {
    console.log('  → Add immutable values to .oracode/config.json');
  }
  if (useLegacyGuard && legacyFiles.length === 0) {
    console.log('  → Add legacy file patterns to .oracode/config.json');
  }
  if (useNervousSystem) {
    console.log('  → Add your SSOT documents to .oracode/ssot-registry.json');
  }
  console.log('  → Start using Claude Code — Oracode is watching.');
  console.log('');

  rl.close();
}

// ─── Health Check ───────────────────────────────────────────────────────────

async function runHealth() {
  const script = join(PKG_ROOT, 'nervous-system', 'health-check.sh');
  if (!existsSync(script)) {
    console.error('Health check script not found.');
    process.exit(1);
  }
  const scope = process.argv[3] || 'all';
  try {
    process.env.ORACODE_DIR = join(process.cwd(), ORACODE_DIR);
    execSync(`bash "${script}" "${scope}"`, { stdio: 'inherit', env: { ...process.env } });
  } catch (e) {
    process.exit(e.status || 1);
  }
  rl.close();
}

// ─── Gate ───────────────────────────────────────────────────────────────────

async function runGate() {
  console.log('Oracode Gate — use the oracode-gate agent in Claude Code for AI-powered validation.');
  console.log('For basic pre-push checks, the gate hook runs automatically on git push.');
  rl.close();
}

// ─── Help ───────────────────────────────────────────────────────────────────

async function runHelp() {
  console.log('');
  console.log('  Oracode — AI governance framework for Claude Code');
  console.log('');
  console.log('  Usage:');
  console.log('    npx oracode init      Set up Oracode in your workspace');
  console.log('    npx oracode health    Check documentation alignment');
  console.log('    npx oracode gate      Pre-push validation info');
  console.log('    npx oracode help      Show this help');
  console.log('');
  console.log('  https://github.com/florenceegi/oracode');
  console.log('');
  rl.close();
}
