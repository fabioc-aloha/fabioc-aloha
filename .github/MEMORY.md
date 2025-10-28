# Project Memory

A living summary of the repository's purpose, key decisions, notable changes, and follow‑ups. Keep this updated when making non-trivial changes.

**Last updated**: 2025‑10‑28

## 1) What this project is
- **Type**: Public GitHub profile repository for Fabio Correa (profile README shown on user profile)
- **Secondary purpose**: Reusable template so others can bootstrap a professional, automated GitHub profile
- **Portfolio automation**: Self-maintaining documentation via PowerShell scripts and GitHub API integration

## 2) Primary goals
- Present a polished, professional GitHub profile with clear sections, badges, stats, and contact options
- Make it easy for others to "Use this template" and follow a guided setup to personalize their own profile
- Keep documentation honest, concise, and automation-friendly

## 3) Key decisions and rationale
- **Template Repository**: Make the repo a Template Repository (GitHub setting `is_template=true`)
  - Rationale: Enables one-click reuse by others; aligns with the goal to share a clean, ready profile template
- **README enhancement**: Add a "Use This Profile Template" section to README
  - Rationale: Clear call-to-action with links to the template generator and setup guide improves discoverability and adoption
- **Simplified setup**: Provide TEMPLATE-USER-GUIDE.md only (comprehensive user guide)
  - Rationale: Minimize moving parts; README + setup guide are sufficient
- **MIT License**: License under MIT
  - Rationale: Broad reuse is permitted and encouraged; fits a public template project
- **Contributing guidelines**: Add CONTRIBUTING.md
  - Rationale: Provide scope and expectations for contributions to keep the template lightweight and focused
- **Data-driven approach**: Remove all hardcoded descriptions from `auto-update-repos.ps1` (2025-10-06)
  - Rationale: GitHub API is single source of truth; no manual maintenance of description libraries; cleaner, more maintainable code

## 4) Notable changes in this iteration (2025‑10‑06)
- **Removed hardcoded descriptions**: Eliminated 25+ hardcoded descriptions from `auto-update-repos.ps1`
- **Removed `-UpdateDescriptions` flag**: Script now operates in pure read-only mode
- **Data-driven architecture**: All repository data pulled directly from GitHub API
- **Missing descriptions**: Show as dash (`-`) placeholder instead of auto-generated text
- **Cleaner codebase**: Reduced script by ~100 lines, improved maintainability
- **Updated documentation**: Refreshed WORKFLOW-GUIDE.md and README.md to reflect new approach
- **Added moleculator categorization**: Categorized previously uncategorized repository
- **Portfolio refresh**: Successfully updated 59 repositories with new workflow

## 5) Previous iteration changes (2025‑08‑11 through 2025‑08‑14)
- **GPT-4o Workflow Simplification**: Completed major simplification from multi-LLM system to streamlined GPT-4o only
- **Workflow Architecture**: Removed enhance-with-claude.ps1 and CLAUDE-SETUP.md files
- **Documentation Consistency**: Updated templates to reflect GPT-4o only system
- **AI Assistant Identity**: Established Alex Finch as the dedicated repo manager persona for GitHub Copilot
- **Collaborative repository workflow**: Created streamlined process for repository updates
- **Spotify AI Catalog Integration**: Added 52 AI-curated playlists showcasing cognitive architecture applications
- **Academic paper enhancement**: Enhanced PAPER.md with research questions and hypotheses

## 6) Essential repo contents
- **`README.md`**: Primary profile content with banner, badges, stats, and template CTA
- **`REPOS.md`**: Auto-generated portfolio documentation (59 repositories)
- **`TEMPLATE-USER-GUIDE.md`**: Comprehensive guide for customizing and using this as a template
- **`.github/MEMORY.md`**: This file - project memory and decision log
- **`.github/TODO.md`**: Prioritized tasks and acceptance checks
- **`.github/copilot-instructions.md`**: Repository-level guidance for Copilot
- **`check-forks.ps1`**: Repository analysis script (GitHub API data collection)
- **`auto-update-repos.ps1`**: Automated REPOS.md generator (read-only, categorization)
- **`refresh-repos.ps1`**: One-command wrapper for complete portfolio refresh
- **`WORKFLOW-GUIDE.md`**: Comprehensive workflow documentation
- **`Spotify/CATALOG.md`**: AI-curated playlist catalog (52 playlists)

## 7) Constraints and notes
- Markdown-first repo; no build required
- External read-only services: GitHub stats images, Shields.io badges
- Windows line-endings (CRLF) acceptable for this context
- Copilot Chat configured via `.vscode/settings.json` to load `.github/copilot-instructions.md`
- Scripts operate in read-only mode; no GitHub data modifications
- `repo-analysis.json` tracked in git for snapshot history

## 8) Collaborative workflow pattern
- **Request pattern**: User says "update my repos" or similar
- **Automated execution**: Assistant runs `refresh-repos.ps1`
- **Documentation sync**: Script analyzes 59 repositories and updates REPOS.md
- **Minimal intervention**: Process maximizes automation
- **Memory anchor**: Preferred method for ongoing repository maintenance

## 9) Philosophy
- **Documentation honesty**: only claim what's implemented
- **Professional presentation**: clean layout, badges, clear calls-to-action
- **Keep it lightweight**: focus on readability and ease-of-use
- **Data-driven**: GitHub API as single source of truth; no hardcoded data

## 10) Template usage
- **One-click template**: https://github.com/fabioc-aloha/fabioc-aloha/generate
- **Setup guide**: Follow `TEMPLATE-USER-GUIDE.md` to personalize

## 11) Quick status
- **Visibility**: Public | **Template**: Enabled | **License**: MIT
- **Portfolio**: 59 repositories (42 original, 17 forked)
- **Automation**: Fully operational, data-driven, hands-free (robust auto-merge + old PR cleanup)

## 12) Subsequent changes (2025‑10‑16)
- Implemented robust auto-merge polling loop (10 attempts, 6s delay)
- Exposed branch name as workflow output for downstream steps
- Added superseded PR auto-close and branch deletion functionality
- Increased merge attempts from 5 → 10 for reliability
- Validated hands-free cycle (PR #98 merged automatically on attempt 1, CLEAN state)
- Future consideration: exponential backoff & telemetry artifact (attempt count, final state)

## 13) Major documentation overhaul (2025‑10‑28)
- **README restructuring**: Reordered sections for maximum impact (About Me → Research Foundation → Portfolio → Featured Projects → Publications)
- **Section optimization**: Removed low-value content (Profile Analytics, Areas of Focus, Working & Communication Style)
- **New high-value sections**: Added Featured Projects (Catalyst, MdWord, Research Tools) and Publications & Speaking
- **Tech Stack condensation**: Reduced from 45 lines of badges to 4 lines of text (90% space reduction)
- **Language refinements**: Professional tone for business/academic opportunities
  - "revolutionizes" → "advances" (defensible claims)
  - "first implementation" → "pioneering implementation" (softer claims)
  - Subtitle: "Creator & Lead Developer, Alex Cognitive Architecture" (accurate positioning)
- **Template documentation**: Created comprehensive TEMPLATE-USER-GUIDE.md (760+ lines)
  - Merged best content from TEMPLATE-SETUP.md
  - Added Mermaid flowchart (Path A: Manual vs Path B: Automated)
  - Detailed PAT token setup with step-by-step instructions
  - AI Assistant configuration section
  - Pro Tips section for best practices
- **File consolidation**: Removed TEMPLATE-SETUP.md (redundant with new guide)
- **Data accuracy**: Fact-checked all documentation, updated repository counts (54 → 59)
  - 59 total repositories (42 original, 17 forked)
  - Updated across README.md, MEMORY.md, WORKFLOW-GUIDE.md, PAPER.md
  - Changed to future-proof "40+ repository ecosystem" in README
- **Cross-reference cleanup**: Updated all links from TEMPLATE-SETUP.md to TEMPLATE-USER-GUIDE.md
- **User context**: Profile optimized for Director @ Microsoft + Doctoral Candidate + Independent Developer
- **Target audience**: Business and academic opportunities (resume complement)
- **Result**: Professional profile with higher value density, easier to scan, action-oriented

