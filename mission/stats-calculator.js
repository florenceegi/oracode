#!/usr/bin/env node

/**
 * Oracode Mission Stats Calculator
 *
 * Calculates real statistics for a closed mission by reading git log
 * in the mission's date range + repos. Writes stats directly into
 * the mission registry JSON file.
 *
 * No database needed. The registry IS the source of truth.
 *
 * @author Fabio Cherici — FlorenceEGI
 * @license MIT
 */

import { execSync } from 'child_process';
import { readFileSync, writeFileSync } from 'fs';
import { resolve } from 'path';

/**
 * Calculate stats for a mission by reading git log from its repos.
 * Same metrics as EGI-STAT: lines added/deleted/net, commits, files,
 * weighted commits, cognitive load, productivity index.
 */
export function calculateMissionStats(mission, config) {
  const projectDirs = config.project_dirs || [];
  const repos = mission.organi_coinvolti || mission.projects_involved || [];
  const dateOpened = mission.data_apertura || mission.date_opened;
  const dateClosed = mission.data_chiusura || mission.date_closed;

  if (!dateOpened || !dateClosed || dateClosed === 'pending') {
    return null;
  }

  // Find matching project dirs for this mission's organs
  const targetDirs = [];
  for (const dir of projectDirs) {
    const dirName = dir.split('/').pop();
    for (const organ of repos) {
      if (dirName === organ || dirName.toLowerCase() === organ.toLowerCase() ||
          dir.includes(organ)) {
        targetDirs.push(dir);
        break;
      }
    }
  }

  // If no matching dirs found, use all project dirs
  const dirsToScan = targetDirs.length > 0 ? targetDirs : projectDirs;

  let totalCommits = 0;
  let linesAdded = 0;
  let linesDeleted = 0;
  let filesTouched = new Set();
  let tagCounts = {};

  // Tag weights (same as EGI-STAT tag_system_v2)
  const TAG_WEIGHTS = {
    FEAT: 1.0, FIX: 1.5, REFACTOR: 2.0, TEST: 1.2, DEBUG: 1.3,
    DOC: 0.8, CONFIG: 0.7, CHORE: 0.6, I18N: 0.7, PERF: 1.4,
    SECURITY: 1.8, WIP: 0.3, REVERT: 0.5, MERGE: 0.4, DEPLOY: 0.8,
    UPDATE: 0.6, UNTAGGED: 0.5, ARCH: 1.6, DEBITO: 0.7
  };

  for (const dir of dirsToScan) {
    try {
      // Get commits in date range with stats
      const since = dateOpened;
      const until = dateClosed;
      const gitLog = execSync(
        `git -C "${dir}" log --since="${since}" --until="${until} 23:59:59" --pretty=format:"%H|%s" --numstat 2>/dev/null || true`,
        { encoding: 'utf-8', timeout: 30000 }
      ).trim();

      if (!gitLog) continue;

      let currentMsg = '';
      for (const line of gitLog.split('\n')) {
        if (!line.trim()) continue;

        if (line.includes('|')) {
          // Commit line: hash|message
          const parts = line.split('|');
          if (parts[0] && parts[0].length >= 30) {
            currentMsg = parts.slice(1).join('|');
            totalCommits++;

            // Parse tag from commit message
            const tag = parseTag(currentMsg);
            tagCounts[tag] = (tagCounts[tag] || 0) + 1;
            continue;
          }
        }

        // Numstat line: added\tdeleted\tfilename
        const numstat = line.split('\t');
        if (numstat.length >= 3) {
          const added = parseInt(numstat[0]) || 0;
          const deleted = parseInt(numstat[1]) || 0;
          const filename = numstat[2];
          if (filename && !filename.includes('node_modules') &&
              !filename.includes('vendor') && !filename.includes('package-lock')) {
            linesAdded += added;
            linesDeleted += deleted;
            filesTouched.add(filename);
          }
        }
      }
    } catch (e) {
      // Dir might not be a git repo or might not exist
      continue;
    }
  }

  const linesNet = linesAdded - linesDeleted;
  const linesTouched = linesAdded + linesDeleted;
  const filesCount = filesTouched.size || (mission.files_modified || []).length;

  // Weighted commits
  let weightedCommits = 0;
  for (const [tag, count] of Object.entries(tagCounts)) {
    weightedCommits += count * (TAG_WEIGHTS[tag] || 0.5);
  }

  // Cognitive load (same formula as egi_productivity_v7)
  let cognitiveLoad = 1.0;
  if (totalCommits > 0) {
    const li = Math.log(linesTouched + 1);
    const fm = Math.log(filesCount + 1);
    const dp = Math.log(totalCommits + 1);
    const cl = (li + fm + dp) / 3.0;
    cognitiveLoad = Math.max(1.0, Math.min(3.5, 1.0 + cl / 2.0));
  }

  // Day type multiplier
  const dayTypeMultiplier = getMissionTypeMultiplier(mission.tipo_missione || mission.type);

  // Productivity index (same formula)
  const cappedLines = Math.min(Math.abs(linesNet), 2000);
  const baseScore = (weightedCommits * 10.0) + (cappedLines / 10.0);
  const productivityIndex = cognitiveLoad > 0
    ? (baseScore * dayTypeMultiplier) / cognitiveLoad
    : 0;

  return {
    total_commits: totalCommits,
    lines_added: linesAdded,
    lines_deleted: linesDeleted,
    lines_net: linesNet,
    lines_touched: linesTouched,
    files_touched: filesCount,
    weighted_commits: Math.round(weightedCommits * 100) / 100,
    cognitive_load: Math.round(cognitiveLoad * 100) / 100,
    productivity_index: Math.round(productivityIndex * 100) / 100,
    tags_breakdown: tagCounts,
    calculated_at: new Date().toISOString().split('T')[0],
  };
}

function parseTag(message) {
  // Bracket tag: [FEAT], [FIX], etc.
  const bracketMatch = message.match(/^\[([A-Z_-]+)\]/);
  if (bracketMatch) return bracketMatch[1];

  // Conventional: feat:, fix:, etc.
  const convMatch = message.match(/^(feat|fix|refactor|test|docs|chore|perf|ci|build|style)[\(:]?/i);
  if (convMatch) return convMatch[1].toUpperCase().replace('DOCS', 'DOC');

  // Merge commit
  if (message.startsWith('Merge ')) return 'MERGE';

  return 'UNTAGGED';
}

function getMissionTypeMultiplier(type) {
  const multipliers = {
    feature: 1.0, bugfix: 1.3, refactor: 1.5,
    docsync: 0.8, audit: 1.1, 'lso-evolution': 1.5
  };
  return multipliers[type] || 1.0;
}

/**
 * Calculate and write stats for all missions missing stats in the registry.
 */
export function enrichRegistry(registryPath, configPath) {
  const registry = JSON.parse(readFileSync(registryPath, 'utf-8'));
  const config = JSON.parse(readFileSync(configPath, 'utf-8'));

  let enriched = 0;
  for (const mission of registry.missions || []) {
    if (mission.stato !== 'completed' && mission.status !== 'completed') continue;
    if (mission.stats && mission.stats.calculated_at) continue; // already has stats

    const stats = calculateMissionStats(mission, config);
    if (stats) {
      mission.stats = stats;
      enriched++;
      console.log(
        `  ${mission.mission_id} | ${stats.total_commits} commits | ` +
        `+${stats.lines_added} -${stats.lines_deleted} = ${stats.lines_net >= 0 ? '+' : ''}${stats.lines_net} net | ` +
        `${stats.files_touched} files | PI:${stats.productivity_index}`
      );
    }
  }

  if (enriched > 0) {
    writeFileSync(registryPath, JSON.stringify(registry, null, 2));
    console.log(`\n  ${enriched} missions enriched with stats.`);
  } else {
    console.log('  All missions already have stats.');
  }
}

// CLI usage
if (process.argv[1] && process.argv[1].includes('stats-calculator')) {
  const registryPath = process.argv[2] || '.oracode/mission-registry.json';
  const configPath = process.argv[3] || '.oracode/config.json';
  console.log('Oracode Mission Stats Calculator');
  console.log(`Registry: ${registryPath}`);
  enrichRegistry(resolve(registryPath), resolve(configPath));
}
