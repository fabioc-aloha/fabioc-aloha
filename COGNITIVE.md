# Cognitive System for this Repository

Last updated: 2025-08-10

## Purpose

A quick why: what this document is and how it keeps the repo consistent.

This document explains the repo’s lightweight “cognitive system” — how working memory, long‑term memory, and automation connect to keep decisions, tasks, and outputs consistent.

## Architecture

What the parts are and the role each one plays.

- Working memory: `.github/copilot-instructions.md`
  - Operating rules, priorities, and where to look first
- Long‑term memory: `MEMORY.md`
  - Canonical summary of purpose, decisions, notable changes, and constraints
- Task memory: `TODO.md`
  - Prioritized tasks with acceptance checks and quick validation steps
- Data source of truth: `repo-analysis.json`
  - Machine‑readable portfolio data; JSON is emoji‑free by design
- Scripts: `check-forks.ps1`, `verify-analysis.ps1`
  - Generate and validate the JSON and parent/fork relationships

These are “synapses”: explicit references between the above files so the workflow is navigable and consistent.

## Diagram

A high‑level map of components and how information flows between them.

```mermaid
flowchart LR
  F[Working memory<br/>.github/copilot-instructions.md]
  A[Long‑term memory<br/>MEMORY.md]
  B[Task memory<br/>TODO.md]
  C[Script<br/>check-forks.ps1]
  G[Verifier<br/>verify-analysis.ps1]
  D[Source of truth<br/>repo-analysis.json]
  E[Docs<br/>REPOS.md / README.md / REPO-MANAGEMENT.md]
  H[Optional scheduler<br/>weekly-analysis.yml]

  F --> A
  F --> B
  A -->|read| B
  B -->|run| C
  C -->|write/inspect| D
  G --> D
  D -->|update| E
  E -->|record| A
  E -->|tick| B
  H -. triggers .-> C
  H -. PR .-> E

  classDef data fill:#e8f7ff,stroke:#36c;
  classDef docs fill:#f7f7e8,stroke:#888;
  classDef mem fill:#eef7ee,stroke:#2a7a2a;
  classDef scripts fill:#fff0e6,stroke:#cc6600;
  class A,B,F mem;
  class D data;
  class E docs;
  class C,G scripts;
```

## How it works (flow)

A step‑by‑step routine to follow when updating the portfolio.

1) Read `MEMORY.md` → 2) Read `TODO.md` → 3) Run `check-forks.ps1` → 4) Inspect `repo-analysis.json` → 5) Update docs (`REPOS.md`, `README.md`, `REPO-MANAGEMENT.md`) → 6) Record decisions in `MEMORY.md` → 7) Check off acceptance checks in `TODO.md`.

### Flow diagram

```mermaid
flowchart TD
  s1[1. Read MEMORY.md]
  s2[2. Read TODO.md]
  s3[3. Run check-forks.ps1]
  s4[4. Inspect repo-analysis.json]
  s5[5. Update docs: REPOS.md / README.md / REPO-MANAGEMENT.md]
  s6[6. Record decisions in MEMORY.md]
  s7[7. Tick acceptance checks in TODO.md]

  s1 --> s2 --> s3 --> s4 --> s5 --> s6 --> s7
```

### Update cycle (sequence)

Shows the interactions between people, scripts, and files during an update.

```mermaid
sequenceDiagram
  participant U as User
  participant WM as Working memory (.github/copilot-instructions.md)
  participant LT as Long-term (MEMORY.md)
  participant TD as Tasks (TODO.md)
  participant SC as Script (check-forks.ps1)
  participant JS as Data (repo-analysis.json)
  participant VF as Verifier (verify-analysis.ps1)
  participant DC as Docs (REPOS/README/REPO-MGMT)

  U->>WM: read rules
  WM->>LT: consult context
  LT->>TD: select priorities
  TD->>SC: run analysis
  SC->>JS: write data
  VF->>JS: validate data
  JS-->>DC: update counts
  DC->>LT: record changes
  DC->>TD: tick checks
```

## Guardrails

Simple rules that keep the system reliable and in sync.

- Single source of truth for counts/stats: `repo-analysis.json` (no manual duplication)
- Canonical roles:
  - `MEMORY.md` = authoritative context/decisions
  - `TODO.md` = prioritized actions + acceptance checks
  - `.github/copilot-instructions.md` = operating rules and pointers
- JSON cleanliness: no emojis in JSON; emojis OK in Markdown/console
- Drift prevention: docs show the same counts; verify after each script run

## Risks and failure modes

Where things can go wrong and what to watch for.

- Drift: numbers in README/REPOS/REPO-MANAGEMENT diverge from `repo-analysis.json`
- Duplication: repeating the same facts across docs without a reference
- Incomplete verification: skipping parent arrows or private/public splits after changes

## Improvement opportunities

Small, low‑risk enhancements to increase clarity and reduce drift.

- Add “Update cadence” to `.github/copilot-instructions.md` (explicit 1→7 flow above)
- Stamp “Last updated” at the top of `MEMORY.md` and `TODO.md` (already present; keep current)
- Add a tiny “Working memory synced” checkbox per milestone in `TODO.md`
- Add a brief “Verification” section in `REPO-MANAGEMENT.md` pointing to `verify-analysis.ps1`
- Optional: scheduled weekly check to run analysis and open a PR when `repo-analysis.json` changes

## Operational cadence (fast path)

A fast checklist for day‑to‑day updates.

- Run analysis script and regenerate JSON
- Verify: parent arrows, counts (total/original/fork/private/public), JSON is emoji‑free
- Sync docs: `REPOS.md`, `README.md`, `REPO-MANAGEMENT.md`
- Record meaningful changes in `MEMORY.md`; tick acceptance checks in `TODO.md`

## Acceptance checks (quick)

Quick end‑of‑run validations to make sure everything aligns.

- Console shows correct fork arrows: `repo ← owner/parent`
- `repo-analysis.json` has zero emojis and valid JSON
- README/REPOS/REPO-MANAGEMENT show the same counts
- `MEMORY.md` reflects notable changes this iteration
