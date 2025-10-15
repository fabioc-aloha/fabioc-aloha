# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2025-10-15

### Added - PowerShell Code Quality
- **PSScriptAnalyzer integration**: Added `lint.ps1` convenience runner with robust version detection
- **Analyzer configuration**: Created `.pssa.psd1` with curated rule set (PSAvoidUsingWriteHost, PSUseBOMForUnicodeEncodedFile, and more)
- **BOM helper utility**: Added `scripts/fix-bom.ps1` to normalize UTF-8 BOM encoding across scripts
- **GitHub Actions**: Added automated lint workflow that runs on all PRs (Windows runner)
- **CHANGELOG.md**: Added this file to track changes

### Added - Workflow Improvements
- **Simplified update workflow**: Replaced 427-line workflow with clean 59-line version
- **Workflow triggers**: Added schedule (daily 6 AM UTC), manual dispatch, and push triggers for automated updates

### Changed - Code Quality Improvements
- **Logging**: Replaced all `Write-Host` calls with `Write-Information` across 6 scripts (check-forks.ps1, auto-update-repos.ps1, refresh-repos.ps1, setup-scheduled-task.ps1, lint.ps1)
- **PowerShell best practices**: Added `ShouldProcess` support to scripts that modify files
- **Function naming**: Renamed `Remove-Emoji` to `Convert-StripEmoji` to follow approved PowerShell verbs
- **Error handling**: Replaced empty catch blocks with proper error handling
- **UTF-8 BOM**: Ensured all PowerShell scripts have UTF-8 BOM encoding for analyzer compliance

### Fixed - Critical Bugs
- **Workflow positional-parameter bug**: Fixed argument parsing error that caused automated update workflow to fail
- **Multi-line string handling**: Eliminated multi-line commit messages and PR bodies that caused parsing issues
- **Workflow corruption**: Cleaned up duplicated and malformed YAML content

### Removed - Repository Cleanup
- **Backup files**: Removed outdated `.github/MEMORY.md.backup` (October 6, 2025 version)
- **Obsolete content**: Cleaned up 427 lines of duplicated/corrupted workflow YAML

### Technical Details
- **Lint status**: All 6 scripts now pass PSScriptAnalyzer with zero issues
- **Workflow validation**: Successfully tested on GitHub Actions (Windows runner)
- **PR integration**: Opened and merged PR #88 with all improvements
- **Branch cleanup**: Successfully deleted source branch after merge
