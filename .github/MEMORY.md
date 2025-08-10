# Project Memory

A living summary of the repository’s purpose, key decisions, notable changes, and follow‑ups. Keep this updated when making non-trivial changes.

Last updated: 2025‑08‑10

## 1) What this project is
- Public GitHub profile repository for Fabio Correa (profile README shown on user profile)
- Also serves as a reusable template so others can bootstrap a professional, automated GitHub profile

## 2) Primary goals
- Present a polished, professional GitHub profile with clear sections, badges, stats, and contact options
- Make it easy for others to “Use this template” and follow a guided setup to personalize their own profile
- Keep documentation honest, concise, and automation-friendly

## 3) Key decisions and rationale
- Make the repo a Template Repository (GitHub setting `is_template=true`)
  - Rationale: Enables one-click reuse by others; aligns with the goal to share a clean, ready profile template
- Add a “Use This Profile Template” section to README
  - Rationale: Clear call-to-action with links to the template generator and setup guide improves discoverability and adoption
- Provide TEMPLATE-SETUP.md and a minimal `template-config-example.ps1`
  - Rationale: Lower barrier to entry; offer a simple, optional way to centralize personalization variables
- License under MIT
  - Rationale: Broad reuse is permitted and encouraged; fits a public template project
- Add CONTRIBUTING.md
  - Rationale: Provide scope and expectations for contributions to keep the template lightweight and focused

## 4) Notable changes in this iteration (2025‑08‑10)
- Enabled template mode via GitHub API
- README: Added “Use this template” section with badges and quick start
- New files added:
  - `TEMPLATE-SETUP.md`: Step-by-step setup instructions for template users
  - `template-config-example.ps1`: Example PowerShell configuration file for personalization
  - `LICENSE`: MIT license
  - `CONTRIBUTING.md`: Contribution guidelines
 - VS Code: Configured Copilot Chat to read `.github/copilot-instructions.md` via `github.copilot.chat.repositoryInstructions` and added fallback `chat.repositoryInstructions`.
 - Copilot repo guidance: Updated `.github/copilot-instructions.md` to make `.github/MEMORY.md` and `.github/TODO.md` the primary context anchors (consult first; update as progress occurs).
 - P1 verifications: Confirmed fork arrow output in console, ensured JSON export is emoji-free, and synchronized counts (44/35/9/15/29) across README/REPOS/REPO-MANAGEMENT.

## 5) Current repo contents (essentials)
- `README.md`: Primary profile content (banner, badges, stats, areas of focus, portfolio link, contact info, and template CTA)
- `TEMPLATE-SETUP.md`: Guide for customizing and using this as a template
- `template-config-example.ps1`: Optional config stub for personalizing template variables
- `LICENSE`: MIT
- `CONTRIBUTING.md`: How to contribute (docs-first guidance)
- `ALEX-CODING.png`: Banner image
 - `.github/copilot-instructions.md`: Repository-level working memory and guidance for Copilot
 - `.vscode/settings.json`: Points Copilot Chat to `.github/copilot-instructions.md`
 - `check-forks.ps1` and `verify-analysis.ps1`: Repo analysis and verification scripts (JSON export, parent checks)

## 6) Constraints and notes
- This is a markdown-first repo; no build required
- External read-only services used: GitHub stats images, Shields.io badges
- Windows line-endings (CRLF) warnings noted by Git when staging; acceptable for this context
 - Copilot Chat is configured via `.vscode/settings.json` to load repository instructions from `.github/copilot-instructions.md`; use “Developer: Show Chat Debug View” to verify system prompt includes repo guidance

## 7) Gaps and follow-ups
- Parameterize `check-forks.ps1` (User/Limit/NoEmojiJson) to improve reuse; document usage in `REPO-MANAGEMENT.md` (tracked in .github/TODO.md)
- Clarify `template-config-example.ps1` usage in `TEMPLATE-SETUP.md` and optionally add a tiny helper script (tracked in .github/TODO.md)
- Add `.gitignore` and `.gitattributes` to reduce noise and CRLF/LF warnings (tracked in .github/TODO.md)
- Decide policy for tracking `repo-analysis.json` (snapshot via PR vs generate-on-demand) and update docs (tracked in .github/TODO.md)
- Optional: README badges (License, Contributing) and a link to `.github/MEMORY.md`; optional scheduled refresh workflow to automate analysis PRs

## 8) How others use this template
- One-click template link: https://github.com/fabioc-aloha/fabioc-aloha/generate
- Then follow `TEMPLATE-SETUP.md` to personalize
- Optionally use `template-config-example.ps1` as a starting point for centralized profile variables

## 9) Philosophy
- Documentation honesty: only claim what’s implemented; avoid overstating capabilities
- Professional presentation: clean layout, badges, and clear calls-to-action
- Keep it lightweight: focus on readability and ease-of-use for the broader community

## 10) Quick status
- Visibility: Public
- Template: Enabled
- License: MIT
- Contributing: Guidelines present
 - Copilot repo instructions: Configured
