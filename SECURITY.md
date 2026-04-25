# Security Policy

## Supported Scope
This repository is a public template and automated profile generator. It contains:
- PowerShell automation scripts (read-only GitHub API access)
- Markdown documentation and templates

There are **no runtime services** or production deployments managed here. Security focus areas:
- Protection of GitHub credentials (PAT_TOKEN, GITHUB_TOKEN)
- Integrity of automated workflow output (no malicious injection into generated files)
- Safe handling of user-supplied repository metadata (sanitization to remove emojis/unsafe characters)

## Reporting a Vulnerability
If you discover a security issue (leak, injection risk, workflow abuse vector):
1. Do NOT open a public issue.
2. Email: `fabioc@microsoft.com` (primary) and CC `fabio@correax.com` (alternate) with:
   - Summary
   - Reproduction steps
   - Potential impact
   - Suggested remediation (if available)
3. Encrypt if sensitive (PGP key may be provided upon request).

## Initial Response SLA
- Acknowledgement: **72 hours**
- Triage and validation: **7 days**
- Patch or mitigation decision: **14 days**
- Public disclosure: Coordinated once fix merged or mutually agreed timeline.

## Vulnerability Categories Considered
| Category | Relevant? | Notes |
|----------|-----------|-------|
| Secret Exposure | Yes | PAT_TOKEN / GITHUB_TOKEN must never be printed in logs |
| Workflow Injection | Yes | Action steps avoid executing untrusted dynamic code |
| Dependency Risk | Low | Minimal dependencies; no package manager manifests |
| Supply Chain | Low | Only core GitHub Actions + PowerShell scripts |
| Data Integrity | Medium | Generated files must reflect accurate API data |

## Safe Disclosure Expectations
Please avoid exploiting beyond necessary proof of concept and do not mass scan or spam the workflow triggers.

## Remediation Approach
1. Reproduce locally (using `gh` with least-privilege token)
2. Implement fix and add/update documentation (SECURITY.md / TODO.md)
3. Optional: Add test (Pester) for regression prevention
4. Merge & trigger daily automation for validation

## Hardening Roadmap
- Add branch protection requiring status checks before merge
- Add CodeQL or basic script static analysis
- Add OpenSSF Scorecard workflow & badge
- Implement lint + Pester tests for sanitization and safe defaults

## Out of Scope
- Vulnerabilities in external GitHub services (badges, stats images)
- Issues exclusive to forked upstream repositories

Thank you for helping keep this template safe and reliable.
