# TODO

A prioritized checklist of recommended improvements based on a review of the current repository (2025-08-10).

## Next Improvements (Post-P2)

### Script hardening
- [ ] Add retry/backoff for GitHub API calls; friendly message on rate limits
- [ ] Guard against empty repo lists (avoid divide-by-zero in language percentages)
- [ ] Expand emoji sanitizer to remove ZWJ/zero-width/variation selectors
- [ ] Validate `gh` presence upfront; print guidance if missing

### Verification and tests
- [x] Enhance `auto-update-repos.ps1` with built-in validation and categorization logic
- [ ] Add Pester tests:
   - [ ] JSON schema/shape and required keys
   - [ ] Emoji sanitization invariants
   - [ ] Owner auto-detection order/fallbacks

### Linting and editor experience
- [ ] Add PSScriptAnalyzer and a `lint.ps1` convenience runner
- [ ] Add `.editorconfig` for Markdown/PowerShell formatting hints
- [ ] Add VS Code `tasks.json` entries for “Analyze portfolio” and “Verify analysis”

### Docs polish
- [ ] TEMPLATE-SETUP.md: Troubleshooting (gh auth, execution policy, rate limits)
- [ ] REPO-MANAGEMENT.md: “Analyze → Verify” sequence with expected pass/fail examples

### Maintenance ergonomics
- [ ] Add `make.ps1` (analyze + verify pipeline)
- [ ] Periodically review and trim category regex patterns

### Optional hygiene
- [ ] Add PR/issue templates (lightweight, scope cues)
- [ ] If desired, create `/analysis/` for manual snapshots of `repo-analysis.json`

---

## Quick Acceptance Checks
- [x] JSON export remains emoji-free and valid
- [x] Counts consistent across README/REPOS/REPO-MANAGEMENT
- [x] Working memory stays synced (copilot-instructions + MEMORY + TODO)
- [x] GPT-4o workflow simplification completed (enabled/disabled parameters)
- [x] Claude references removed from all documentation
- [x] Workflow logging fixed to show correct parameter values
- [x] Latest automated updates merged successfully
- [x] Repository synchronized and pushed to simplify-to-gpt4o-only branch
