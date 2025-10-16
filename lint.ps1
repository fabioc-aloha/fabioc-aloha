<#
.SYNOPSIS
    Lint PowerShell scripts using PSScriptAnalyzer and fail on issues.

.DESCRIPTION
    Checks for PSScriptAnalyzer module and runs Invoke-ScriptAnalyzer across repository .ps1 files.
    Exits with code 0 when no issues found, 1 when issues are found, and 2 if PSScriptAnalyzer is missing.

.EXAMPLE
    .\lint.ps1
#>

param(
    [string[]]$Include = @("*.ps1"),
    [string[]]$Exclude = @(".\node_modules\**", ".\.venv\**", ".git\**")
)

Write-Host "🔎 Running PowerShell lint (PSScriptAnalyzer)" -ForegroundColor Cyan

# Check for module
if (-not (Get-Module -ListAvailable -Name PSScriptAnalyzer)) {
    Write-Host "⚠️ PSScriptAnalyzer not found." -ForegroundColor Yellow
    Write-Host "Install it by running: Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force" -ForegroundColor Yellow
    exit 2
}

Import-Module PSScriptAnalyzer -Force

# Find files
$scriptFiles = Get-ChildItem -Path . -Recurse -Include $Include -File | Where-Object {
    foreach ($ex in $Exclude) {
        if ($_.FullName -like (Join-Path (Get-Location) $ex)) { return $false }
    }
    return $true
}

if (-not $scriptFiles) {
    Write-Host "No PowerShell script files found to analyze." -ForegroundColor Yellow
    exit 0
}

Write-Host "Found $($scriptFiles.Count) script(s) to analyze." -ForegroundColor Green

$issues = @()
foreach ($file in $scriptFiles) {
    Write-Host "Analyzing: $($file.FullName)" -ForegroundColor Gray
    $result = Invoke-ScriptAnalyzer -Path $file.FullName -Recurse -Severity Error, Warning -ErrorAction SilentlyContinue
    if ($result) { $issues += $result }
}

if ($issues.Count -eq 0) {
    Write-Host "✅ No lint issues found." -ForegroundColor Green
    exit 0
}

Write-Host "❌ Lint issues detected:" -ForegroundColor Red
$issues | Select-Object @{Name='File';Expression={$_.ScriptName}}, RuleName, Severity, Line | Format-Table -AutoSize

# Write a compact summary
$summary = $issues | Group-Object -Property Severity | ForEach-Object { "$($_.Name): $($_.Count)" }
Write-Host "Summary: $($summary -join ', ')" -ForegroundColor Yellow

exit 1
