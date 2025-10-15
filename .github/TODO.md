# TODO

A prioritized checklist of recommended improvements and completed milestones for the repository.

**Last updated**: 2025-10-15

## ✅ Recently Completed (2025-10-06)

### Data-Driven Architecture Transformation
- [x] Removed all hardcoded descriptions from `auto-update-repos.ps1` (~100 lines)
- [x] Removed `-UpdateDescriptions` parameter and functionality
- [x] Updated WORKFLOW-GUIDE.md to reflect data-driven approach
- [x] Updated README.md Automated Portfolio Management section
- [x] Added troubleshooting guide for missing descriptions
- [x] Categorized `moleculator` repository
- [x] Successfully validated with 54-repository refresh

### GitHub Actions Automation
- [x] Discovered and updated existing GitHub Actions workflow
- [x] Removed deprecated GPT-4o enhancement features from workflow
- [x] Created comprehensive AUTOMATION-GUIDE.md (200+ lines)
- [x] Updated README.md with GitHub Actions automation information
- [x] Updated REPO-MANAGEMENT.md with automation workflow details
- [x] Added automation documentation badges to README

### Documentation Updates
- [x] Synchronized all documentation to reflect data-driven architecture
- [x] Rewrote `.github/MEMORY.md` with current project state
- [x] Updated README automated portfolio section with GitHub Actions details
- [x] Enhanced "What You Get" template section with automation features

---

## 🔜 Next Improvements (Future)

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
- [x] Add `.editorconfig` for Markdown/PowerShell formatting hints
- [x] Add VS Code `tasks.json` entries for "Analyze portfolio" and "Verify analysis"

### Repository metadata
- [x] Add GitHub topics for discoverability
- [ ] Add SECURITY.md security policy
- [ ] Add CODE_OF_CONDUCT.md for community standards

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
