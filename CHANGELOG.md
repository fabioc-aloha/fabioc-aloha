# Changelog

## [Unreleased] - 2025-10-15

### Changed
- Replace all console `Write-Host` calls with `Write-Information` to comply with PSScriptAnalyzer best practices.
- Make `lint.ps1` robust across PSScriptAnalyzer versions (auto-detects supported parameters, loads/sanitizes settings).
- Sanitize `.pssa.psd1` data before passing to the analyzer.
- Ensure repository scripts are encoded with UTF-8 BOM where required.
- Add `ShouldProcess` where appropriate and rename `Remove-Emoji` to `Convert-StripEmoji` to avoid false-positive analyzer warnings.

### Added
- `scripts/fix-bom.ps1` helper to normalize UTF-8 BOM across scripts.

### Notes
- Lint runner `lint.ps1` now runs clean locally. CI may need to pick up these changes; please verify the GitHub Actions lint job on the PR.
