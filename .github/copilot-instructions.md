# Copilot Instructions for this Repository

Purpose: Provide concise, opinionated guidance for GitHub Copilot to generate code, docs, and commands that fit this project.

Working memory: This file is the assistant’s working memory for this repo. Before you push, update this file with any new learnings or patterns from the current chat/session so future suggestions stay aligned.

De-duplication: Don’t restate the project’s status or backlog here. For decisions, status, and tasks, consult .github/MEMORY.md and .github/TODO.md and reference them directly.

## Context snapshot
- Repo type: Public profile + reusable template
- Primary languages: Markdown, PowerShell (scripts), some Python/Jupyter in related repos
- OS/shell: Windows, PowerShell (pwsh)
- Tools: GitHub CLI (`gh`), PowerShell 5.1+
- Key docs: `README.md`, `REPOS.md`, `REPO-MANAGEMENT.md`, `TEMPLATE-SETUP.md`, `CONTRIBUTING.md`, `LICENSE`, `.github/MEMORY.md`, `.github/TODO.md`

## Behaviors
- Keep responses short, skimmable, and impersonal.
- Prefer concrete edits and small, safe changes over large refactors.
- Run commands in a terminal and summarize results when needed; avoid dumping long command sequences unless requested.
- Add small, high-value adjacent improvements (links, badges, lint fixes) when low risk.
- Always consult .github/MEMORY.md for current project context/history and .github/TODO.md for prioritized tasks before broad repo scans.
- When proposing or making changes, cross-check acceptance criteria against .github/TODO.md and update it as progress occurs.

## Coding & scripting guidelines
- PowerShell first. Assume pwsh on Windows.
- For repo analysis, use GitHub CLI (gh) with live API data. Do NOT hardcode repo lists. Detect the owner from git remote/GitHub Actions/gh auth.
- Export data as JSON that is emoji-free and machine-friendly.
- When updating/creating scripts, prefer parameters over constants (e.g., `param([string]$User='fabioc-aloha', [int]$Limit=200, [switch]$NoEmojiJson)`).
- Keep functions small and single-purpose; add inline comments for non-obvious logic.

## Documentation guidelines
- Keep counts and stats consistent across README/REPOS/REPO-MANAGEMENT.
- If counts come from automation, read `repo-analysis.json` instead of guessing.
- Use concise headings, tables, and badges. Avoid fluff.
- Place new guidance for template users in `TEMPLATE-SETUP.md`.

## Automation & data rules
- JSON exports must be emoji-free. Emojis are OK in console output and Markdown only.
- `check-forks.ps1` should:
  - Fetch repos via `gh` dynamically (no hardcoded arrays)
  - Auto-detect the GitHub owner from git/CI/gh (no username parameter required)
  - Identify forks and parent repo correctly
  - Categorize repos and compute language stats
  - Always write `repo-analysis.json`
- For feature/backlog details (e.g., parameterization), follow .github/TODO.md instead of repeating specifics here.

## Git & commits
- Use clear, conventional commits, e.g.:
  - `fix: correct fork parent lookup`
  - `docs: sync REPO-MANAGEMENT counts`
  - `chore: add .gitattributes for line endings`
- Keep commits focused; avoid unrelated formatting churn.

## Safety & privacy
- Never include or request secrets/tokens in code or docs.
- Avoid destructive operations. When commands could change remote state, note impact or request confirmation.

## Fast playbooks
- Cognitive cadence (follow in order):
  1) Read `.github/MEMORY.md` (context/decisions)
  2) Read `.github/TODO.md` (priorities/acceptance checks)
  3) Run `./check-forks.ps1`
  4) Inspect `repo-analysis.json` (emoji-free, counts)
  5) Update `REPOS.md`/`README.md`/`REPO-MANAGEMENT.md`
  6) Record notable changes in `.github/MEMORY.md`
  7) Tick acceptance checks in `.github/TODO.md`
- Load context quickly:
  - Read .github/MEMORY.md first for the canonical project summary and recent decisions.
  - Read .github/TODO.md for active priorities, acceptance checks, and next steps.
- Update portfolio data:
  1) Run `./check-forks.ps1`
  2) Inspect `repo-analysis.json` (no emojis, correct counts)
  3) Update `REPOS.md`/`README.md` as needed
- Add a template note:
  - Place details in `TEMPLATE-SETUP.md`; link from README buttons/CTA
- Verify forks have parents in JSON:
  - Use `./verify-analysis.ps1` to check `MissingParents` is 0

## Context anchors
- .github/MEMORY.md: Authoritative, living summary of purpose, key decisions, changes, constraints. Consult first to reduce cognitive load and avoid redundant discovery.
- .github/TODO.md: Prioritized, checkbox-tracked tasks and quick acceptance checks. Use it to drive plans, verify outcomes, and record progress by ticking items when done.

## Don’ts
- Don’t hardcode repository names or counts.
- Don’t add emojis to JSON payloads.
- Don’t change unrelated sections when editing Markdown tables.
- Don’t switch shells—stick to PowerShell syntax in commands.

## References
- Contribution rules: `CONTRIBUTING.md`
- License: `LICENSE` (MIT)
- Working memory: `.github/MEMORY.md`
- Task tracker: `.github/TODO.md`

## Continuous improvement
- Before you push, update `.github/copilot-instructions.md` with any new learnings or patterns from the current chat/session so future suggestions stay aligned.
- Keep .github/MEMORY.md updated when notable changes happen, and reflect new priorities or completions in .github/TODO.md (check off items and adjust acceptance checks as needed).
- Capture concrete rules you applied (e.g., parameter names, JSON cleanliness constraints, verification scripts) and add them above in the relevant sections.
