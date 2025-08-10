# TODO

A prioritized checklist of recommended improvements based on a review of the current repository (2025-08-10).

## P1 – Correctness & Drift Prevention

- [ ] Fix fork parent lookup in `check-forks.ps1`
   - [ ] Capture current repo name in a variable and use it inside the `Where-Object` filter
   - [ ] Verify fork entries display `repo ← owner/parent` consistently

- [ ] Remove emojis from JSON export
   - [ ] Strip emojis from `repos_md_format.header_stats` and any other JSON fields
   - [ ] Verify `repo-analysis.json` contains plain text only

- [ ] Clean up `REPO-MANAGEMENT.md`
   - [ ] Remove pasted console output artifacts
   - [ ] Normalize counts to current (44)
   - [ ] Keep purpose/usage/output/maintenance only

## P2 – Template DX & Maintainability

- [ ] Parameterize `check-forks.ps1`
   - [ ] Add `param([string]$User='fabioc-aloha', [int]$Limit=200, [switch]$NoEmojiJson)`
   - [ ] Use `$User` in `gh repo list` and follow-up API calls; gate emoji removal on `$NoEmojiJson`
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

## P3 – Automation & Polish

- [ ] (Optional) Minimal renderer for `REPOS.md`
   - [ ] Small script to refresh header stats (and optionally section headers) from `repo-analysis.json`
   - [ ] Confirm reduced manual drift for public/private and original/fork counts

- [ ] (Optional) Scheduled refresh (GitHub Actions)
   - [ ] Weekly workflow to run analysis and open a PR if `repo-analysis.json` changes
   - [ ] Confirm automated upkeep without forcing changes into `main`

- [ ] README badges and cross-links
   - [ ] Add License and Contributing badges
   - [ ] Add a small link to `MEMORY.md`

- [ ] Pin minimal `gh` version in docs
   - [ ] Note a baseline GitHub CLI version (e.g., `>= 2.55`) used with `--jq` features
   - [ ] Confirm fewer CLI incompatibility surprises for users

- [ ] Decide tracking policy for `repo-analysis.json`
   - [ ] Choose policy: Track snapshots via script/PR OR generate-on-demand and `.gitignore`
   - [ ] Update `.gitignore`/docs accordingly

---

## Quick Acceptance Checks
- [ ] Running `check-forks.ps1` shows proper parent arrows for forks
- [ ] `repo-analysis.json` has zero emojis and valid JSON
- [ ] README/REPOS/REPO-MANAGEMENT show the same counts
- [ ] New users can follow `TEMPLATE-SETUP.md` without confusion about the config file
- [ ] Git warns less about CRLF/LF due to `.gitattributes`
