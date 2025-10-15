#!/usr/bin/env pwsh
<#
.SYNOPSIS
    One-Command Repository Portfolio Refresh

.DESCRIPTION
    Single command to refresh the entire repository portfolio:
    1. Analyzes all GitHub repositories
    2. Categorizes them automatically
    3. Generates updated REPOS.md

    Zero manual intervention required!

.EXAMPLE
    .\refresh-repos.ps1
    Complete repository portfolio refresh

.NOTES
    This is a wrapper around auto-update-repos.ps1 for maximum simplicity
#>

Write-Information "🔄 Repository Portfolio Refresh" -InformationAction Continue
Write-Information ("=" * 40) -InformationAction Continue

# Check dependencies
if (-not (Test-Path "check-forks.ps1")) {
    Write-Error "check-forks.ps1 not found in current directory"
    exit 1
}

if (-not (Test-Path "auto-update-repos.ps1")) {
    Write-Error "auto-update-repos.ps1 not found in current directory"
    exit 1
}

# Check GitHub CLI
try {
    gh auth status | Out-Null
} catch {
    Write-Error "GitHub CLI not authenticated. Run 'gh auth login' first."
    exit 1
}

Write-Information "✅ Dependencies verified" -InformationAction Continue

# Run the full automation
Write-Information "🚀 Starting automated refresh..." -InformationAction Continue
& ".\auto-update-repos.ps1"

if ($LASTEXITCODE -eq 0) {
    Write-Information "`n🎉 Repository portfolio successfully refreshed!" -InformationAction Continue
    Write-Information "📄 REPOS.md is now up-to-date with current GitHub data" -InformationAction Continue
} else {
    Write-Error "Refresh failed. Check output above for details."
    exit 1
}

