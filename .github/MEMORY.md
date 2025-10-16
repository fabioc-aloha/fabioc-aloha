# Project Memory

A living summary of the repository's purpose, key decisions, notable changes, and follow‑ups. Keep this updated when making non-trivial changes.

**Last updated**: 2025‑10‑06

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
- **Simplified setup**: Provide TEMPLATE-SETUP.md only (dropped `template-config-example.ps1`)
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
- **Portfolio refresh**: Successfully updated 54 repositories with new workflow

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
- **`REPOS.md`**: Auto-generated portfolio documentation (54 repositories)
- **`TEMPLATE-SETUP.md`**: Guide for customizing and using this as a template
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
- **Documentation sync**: Script analyzes 54 repositories and updates REPOS.md
- **Minimal intervention**: Process maximizes automation
- **Memory anchor**: Preferred method for ongoing repository maintenance

## 9) Philosophy
- **Documentation honesty**: only claim what's implemented
- **Professional presentation**: clean layout, badges, clear calls-to-action
- **Keep it lightweight**: focus on readability and ease-of-use
- **Data-driven**: GitHub API as single source of truth; no hardcoded data

## 10) Template usage
- **One-click template**: https://github.com/fabioc-aloha/fabioc-aloha/generate
- **Setup guide**: Follow `TEMPLATE-SETUP.md` to personalize

## 11) Quick status
- **Visibility**: Public | **Template**: Enabled | **License**: MIT
- **Portfolio**: 54 repositories (40 original, 14 forks)
- **Automation**: Fully operational, read-only, data-driven
