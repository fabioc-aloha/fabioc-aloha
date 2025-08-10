# TODO

A prioritized list of recommended improvements based on a review of the current repository (2025-08-10).

## P1 – Correctness & Drift Prevention

1) Fix fork parent lookup in `check-forks.ps1`
   - Issue: FORK listing uses an incorrect `Where-Object` scope, so `parent` often resolves empty.
   - Action: Capture current repo name in a variable and use it inside the filter.
   - Success: Fork entries display `repo ← owner/parent` consistently.

2) Remove emojis from JSON export
   - Policy: JSON should be emoji-free for clean machine consumption.
   - Action: Strip emojis from `repos_md_format.header_stats` and any other JSON fields; keep emojis only in console output/markdown.
   - Success: `repo-analysis.json` contains plain text only.

3) Clean up `REPO-MANAGEMENT.md`
   - Issue: Contains pasted console output lines and mixed stats (42 vs 44).
   - Action: Remove console artifacts, normalize counts to current, and keep purpose/usage/output/maintenance only.
   - Success: File is concise, consistent, and free of drift.

## P2 – Template DX & Maintainability

4) Parameterize `check-forks.ps1`
   - Add: `param([string]$User='fabioc-aloha', [int]$Limit=200, [switch]$NoEmojiJson)`.
   - Use `$User` in `gh repo list` and follow-up API calls; gate emoji removal on `$NoEmojiJson`.
   - Success: Script works for any GitHub user and can emit strictly-clean JSON.

5) Clarify `template-config-example.ps1` usage
   - Action: In `TEMPLATE-SETUP.md`, add a short section: how to copy/modify and what sections of README/REPOS it influences.
   - Optional: Provide a minimal helper script that reads the config and prints a checklist.
   - Success: New users understand why and how to use the file.

6) Add `.gitignore`
   - Ignore: `repo-analysis.json` (or move to `/artifacts/`), `*-back.md`, temp files.
   - Success: Cleaner working tree and commits.

7) Add `.gitattributes`
   - Add: `* text=auto` to normalize line endings across OS.
   - Success: Fewer CRLF/LF warnings.

## P3 – Automation & Polish

8) Optional: Minimal renderer for `REPOS.md`
   - Action: Small script to refresh header stats (and optionally section headers) from `repo-analysis.json`.
   - Success: Reduced manual drift for public/private, original/fork counts.

9) Optional: Scheduled refresh (GitHub Actions)
   - Action: Weekly workflow to run analysis and open a PR if `repo-analysis.json` changes.
   - Success: Automated upkeep without forcing changes into `main`.

10) README badges and cross-links
   - Add: License and Contributing badges; small link to `MEMORY.md`.
   - Success: Better discoverability and standard OSS affordances.

11) Pin minimal `gh` version in docs
   - Action: Note a baseline GitHub CLI version (e.g., `>= 2.55`) used with `--jq` features.
   - Success: Users have fewer CLI incompatibility surprises.

12) Decide tracking policy for `repo-analysis.json`
   - Option A: Track it (snapshot) and ensure it’s updated by a script/PR.
   - Option B: Do not track; generate-on-demand and add to `.gitignore`.
   - Success: Clear policy to prevent drift.

---

## Quick Acceptance Checks
- Running `check-forks.ps1` shows proper parent arrows for forks.
- `repo-analysis.json` has zero emojis and valid JSON.
- README/REPOS/REPO-MANAGEMENT show the same counts.
- New users can follow TEMPLATE-SETUP without confusion about the config file.
- Git warns less about CRLF/LF due to `.gitattributes`.
