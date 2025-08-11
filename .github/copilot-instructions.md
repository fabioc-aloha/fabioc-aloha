# Copilot Instructions for this Repository

Purpose: Provide concise, opinionated guidance for GitHub Copilot to generate code, docs, and commands that fit this project.

Working memory: This file is the assistant’s working memory for this repo. Before you push, update this file with any new learnings or patterns from the current chat/session so future suggestions stay aligned.

De-duplication: Don’t restate the project’s status or backlog here. For decisions, status, and tasks, consult .github/MEMORY.md and .github/TODO.md and reference them directly.

## Context snapshot
- Repo type: Public profile + reusable template
- Primary languages: Markdown, PowerShell (scripts), some Python/Jupyter in related repos
- OS/shell: Windows, PowerShell (pwsh)
- Tools: GitHub CLI (`gh`), PowerShell 5.1+
- Key docs: located in the root folder

## Behaviors
- Keep responses short, skimmable, and impersonal.
- Prefer concrete edits and small, safe changes over large refactors.
- Run commands in a terminal and summarize results when needed; avoid dumping long command sequences unless requested.
- Add small, high-value adjacent improvements (links, badges, lint fixes) when low risk.
- Always consult .github/MEMORY.md for current project context/history and .github/TODO.md for prioritized tasks before broad repo scans.
- When proposing or making changes, cross-check acceptance criteria against .github/TODO.md and update it as progress occurs.
 - Keep it KISS/DRY: avoid repeating rules; point to `.github/MEMORY.md` and `.github/TODO.md` instead of restating.

## Coding & scripting guidelines
- PowerShell first. Assume pwsh on Windows.
- For repo analysis, use GitHub CLI (gh) with live API data. Do NOT hardcode repo lists. Detect the owner from git remote/GitHub Actions/gh auth.
- Export data as JSON that is emoji-free and machine-friendly.
- Always sanitize JSON-bound fields to remove emojis; emojis are allowed in console/Markdown only.
- Keep functions small and single-purpose; add inline comments for non-obvious logic.

## Documentation guidelines
- Use concise headings, tables, and badges. Avoid fluff.
- Use mermaid for visualization of concepts when it makes sense.
- Place new guidance for template users in `TEMPLATE-SETUP.md`.

## Git & commits
- Use clear, conventional commits, e.g.:
  - `fix: correct fork parent lookup`
  - `docs: sync REPO-MANAGEMENT counts`
  - `chore: add .gitattributes for line endings`
- Keep commits focused; avoid unrelated formatting churn.

## Safety & privacy
- Never include or request secrets/tokens in code or docs.
- Avoid destructive operations. When commands could change remote state, note impact or request confirmation.

## Cognitive playbooks & meditation (trigger: "meditate")
- Cognitive cadence (follow in order):
  1) Summarize chat history.
  2) Read `.github/MEMORY.md` (context/decisions)
  3) Read `.github/TODO.md` (priorities/acceptance checks)
  4) Record notable learnings in `.github/MEMORY.md`
  5) Update the to-do list in `.github/TODO.md` if needed
- Load context only when needed:
  - Read `.github/MEMORY.md` first for the canonical project summary and recent decisions.
  - Read `.github/TODO.md` for active priorities, acceptance checks, and next steps.
- Meditation trigger:
  - When the user says "meditate", execute the cadence above end-to-end (purely cognitive; do not run scripts), then:
    - Consolidate and connect synapses: ensure counts/statements conceptually match across `README.md`, `REPOS.md`, and `REPO-MANAGEMENT.md`; confirm links/badges remain valid (README ↔ MEMORY ↔ REPOS).
    - Close with a brief quality check (no syntax issues; drift minimized).

## Context anchors & references
- .github/MEMORY.md: Authoritative, living summary of purpose, key decisions, changes, constraints. Consult first to reduce cognitive load and avoid redundant discovery.
- .github/TODO.md: Prioritized, checkbox-tracked tasks and quick acceptance checks. Use it to drive plans, verify outcomes, and record progress by ticking items when done.
- CONTRIBUTING.md: Scope and expectations for contributions.
- LICENSE: MIT license terms.

## Don’ts
- Don’t change unrelated sections when editing Markdown tables.
- Don’t switch shells—stick to PowerShell syntax in commands.

## Continuous improvement
- Before you push, update `.github/copilot-instructions.md` with any new learnings or patterns from the current chat/session so future suggestions stay aligned.
- Keep .github/MEMORY.md updated when notable changes happen, and reflect new priorities or completions in .github/TODO.md (check off items and adjust acceptance checks as needed).
- Capture concrete rules you applied (e.g., parameter names, JSON cleanliness constraints, verification scripts) and add them above in the relevant sections.
