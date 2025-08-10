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
   - [x] Auto-detect owner from git remote/GitHub Actions/gh auth
   - [x] Add optional `[int]$Limit=200` parameter (default enforced)
   - [x] Always remove emojis from JSON-bound data (no `NoEmojiJson` flag needed)
   - [ ] Confirm the script works for any GitHub user and emits strictly-clean JSON
   - [x] Document `-Limit` usage and emoji-free JSON policy in `REPO-MANAGEMENT.md`

- [x] Simplify setup by removing `template-config-example.ps1`
   - [x] Update MEMORY and setup docs accordingly

- [x] Add `.gitignore`
   - [x] Keep `repo-analysis.json` tracked at repo root (per decision)
    - [x] Ignore `*-back.md` and temp files
    - [ ] Confirm cleaner working tree and commits

 - [x] Add `.gitattributes`
    - [x] Add `* text=auto` to normalize line endings across OS
    - [ ] Confirm fewer CRLF/LF warnings

- [ ] Working-memory sync per milestone
   - [ ] Add a tiny checkbox to tick when `.github/copilot-instructions.md` + `.github/MEMORY.md` + `.github/TODO.md` are aligned after changes

## P3 – Automation & Polish

- [x] Decision: prefer manual analysis; removed weekly GitHub Actions workflow

- [ ] (Optional) Minimal renderer for `REPOS.md`
   - [ ] Small script to refresh header stats (and optionally section headers) from `repo-analysis.json`
   - [ ] Confirm reduced manual drift for public/private and original/fork counts

- [ ] README badges and cross-links
   - [ ] Add License and Contributing badges
   - [ ] Add a small link to `.github/MEMORY.md`

- [ ] Pin minimal `gh` version in docs
   - [ ] Note a baseline GitHub CLI version (e.g., `>= 2.55`) used with `--jq` features
   - [ ] Confirm fewer CLI incompatibility surprises for users

- [x] Decide tracking policy for `repo-analysis.json`
   - [x] Policy: Track snapshots in repo root; do not ignore
   - [x] Update docs accordingly

---

## Quick Acceptance Checks
- [x] Running `check-forks.ps1` shows proper parent arrows for forks
- [x] `repo-analysis.json` has zero emojis and valid JSON
- [x] README/REPOS/REPO-MANAGEMENT show the same counts
- [x] REPO-MANAGEMENT documents owner auto-detection and usage
- [x] New users can follow `TEMPLATE-SETUP.md` without confusion about the config file
- [ ] Git warns less about CRLF/LF due to `.gitattributes` (observe over a couple commits)
