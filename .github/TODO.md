# TODO

A prioritized checklist of recommended improvements based on a review of the current repository (2025-08-10).

## P1 – Correctness & Drift Prevention

- [x] Fix fork parent lookup in `check-forks.ps1`
   - [x] Capture current repo name in a variable and use it inside the `Where-Object` filter
   - [x] Verify fork entries display `repo ← owner/parent` consistently

- [x] Remove emojis from JSON export
   - [x] Strip emojis from `repos_md_format.header_stats` and any other JSON fields
   - [x] Verify `repo-analysis.json` contains plain text only

- [x] Clean up `REPO-MANAGEMENT.md`
   - [x] Remove pasted console output artifacts
   - [x] Normalize counts to current (44)
   - [x] Keep purpose/usage/output/maintenance only

## P2 – Template DX & Maintainability

- [ ] Improve `check-forks.ps1` UX
   - [ ] Auto-detect owner from git remote/GitHub Actions/gh auth (done)
   - [ ] Add optional `[int]$Limit=200` and `[switch]$NoEmojiJson` parameters if needed later
   - [ ] Confirm the script works for any GitHub user and can emit strictly-clean JSON

- [ ] Clarify `template-config-example.ps1` usage
   - [ ] In `TEMPLATE-SETUP.md`, add a short section explaining how to copy/modify and what it influences
   - [ ] (Optional) Provide a minimal helper script that reads the config and prints a checklist
   - [ ] Confirm new users understand why and how to use the file

- [ ] Add `.gitignore`
   - [ ] Ignore `repo-analysis.json` (or move it to `/artifacts/`)
   - [ ] Ignore `*-back.md` and temp files
   - [ ] Confirm cleaner working tree and commits

- [ ] Add `.gitattributes`
   - [ ] Add `* text=auto` to normalize line endings across OS
   - [ ] Confirm fewer CRLF/LF warnings

- [ ] Working-memory sync per milestone
   - [ ] Add a tiny checkbox to tick when `.github/copilot-instructions.md` + `.github/MEMORY.md` + `.github/TODO.md` are aligned after changes

## P3 – Automation & Polish

- [ ] (Optional) Minimal renderer for `REPOS.md`
   - [ ] Small script to refresh header stats (and optionally section headers) from `repo-analysis.json`
   - [ ] Confirm reduced manual drift for public/private and original/fork counts

- [ ] (Optional) Scheduled refresh (GitHub Actions)
   - [ ] Weekly workflow to run analysis and open a PR if `repo-analysis.json` changes
   - [ ] Confirm automated upkeep without forcing changes into `main`

- [ ] README badges and cross-links
   - [ ] Add License and Contributing badges
   - [ ] Add a small link to `.github/MEMORY.md`

- [ ] Pin minimal `gh` version in docs
   - [ ] Note a baseline GitHub CLI version (e.g., `>= 2.55`) used with `--jq` features
   - [ ] Confirm fewer CLI incompatibility surprises for users

- [ ] Decide tracking policy for `repo-analysis.json`
   - [ ] Choose policy: Track snapshots via script/PR OR generate-on-demand and `.gitignore`
   - [ ] Update `.gitignore`/docs accordingly

---

## Quick Acceptance Checks
- [x] Running `check-forks.ps1` shows proper parent arrows for forks
- [x] `repo-analysis.json` has zero emojis and valid JSON
- [x] README/REPOS/REPO-MANAGEMENT show the same counts
- [ ] New users can follow `TEMPLATE-SETUP.md` without confusion about the config file
- [ ] Git warns less about CRLF/LF due to `.gitattributes`
