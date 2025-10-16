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

Write-Host "🔄 Repository Portfolio Refresh" -ForegroundColor Cyan
Write-Host ("=" * 40) -ForegroundColor Gray

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

Write-Host "✅ Dependencies verified" -ForegroundColor Green

# Run the full automation
Write-Host "🚀 Starting automated refresh..." -ForegroundColor Yellow
& ".\auto-update-repos.ps1"

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n🎉 Repository portfolio successfully refreshed!" -ForegroundColor Green
    Write-Host "📄 REPOS.md is now up-to-date with current GitHub data" -ForegroundColor Cyan
} else {
    Write-Error "Refresh failed. Check output above for details."
    exit 1
}
