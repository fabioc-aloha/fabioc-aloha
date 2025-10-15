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

Write-Information "🔎 Running PowerShell lint (PSScriptAnalyzer)" -InformationAction Continue

# Check for module
if (-not (Get-Module -ListAvailable -Name PSScriptAnalyzer)) {
    Write-Information "⚠️ PSScriptAnalyzer not found." -InformationAction Continue
    Write-Information "Install it by running: Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force" -InformationAction Continue
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
    Write-Information "No PowerShell script files found to analyze." -InformationAction Continue
    exit 0
}

Write-Information "Found $($scriptFiles.Count) script(s) to analyze." -InformationAction Continue

$issues = @()

# Detect Invoke-ScriptAnalyzer parameter support and prepare settings
$settingsPath = "$PWD\.pssa.psd1"
$isaCmd = Get-Command Invoke-ScriptAnalyzer -ErrorAction SilentlyContinue
$supportsSettingsPath = $false
$supportsSettings = $false
if ($isaCmd) {
    $supportsSettingsPath = $isaCmd.Parameters.Keys -contains 'SettingsPath'
    $supportsSettings = $isaCmd.Parameters.Keys -contains 'Settings'
}

$settingsData = $null
if (Test-Path $settingsPath) {
    if ($supportsSettingsPath) {
        Write-Information "Using PSScriptAnalyzer settings (SettingsPath): $settingsPath" -InformationAction Continue
    } elseif ($supportsSettings) {
        Write-Information "Loading PSScriptAnalyzer settings into memory from: $settingsPath" -InformationAction Continue
        # Prefer Import-PowerShellDataFile when available (PowerShell 7+), fall back to dot-sourcing the .psd1
        if (Get-Command Import-PowerShellDataFile -ErrorAction SilentlyContinue) {
            $settingsData = Import-PowerShellDataFile -Path $settingsPath
        } else {
            try {
                $settingsData = . $settingsPath
            } catch {
                Write-Information "Failed to load settings file as data file; analyzer settings will be ignored." -InformationAction Continue
                $settingsData = $null
            }
        }
        # Sanitize settingsData to only include keys accepted by Invoke-ScriptAnalyzer when using -Settings
        if ($settingsData -is [hashtable]) {
            $validKeys = @('CustomRulePath','ExcludeRules','IncludeRules','IncludeDefaultRules','RecurseCustomRulePath','Rules','Severity')
            $sanitized = @{}
            foreach ($k in $settingsData.Keys) {
                if ($validKeys -contains $k) { $sanitized[$k] = $settingsData[$k] }
            }
            $settingsData = $sanitized
        }
    } else {
        Write-Information "PSScriptAnalyzer on this system does not accept settings; proceeding without settings." -InformationAction Continue
    }
} else {
    $settingsPath = $null
}

foreach ($file in $scriptFiles) {
    Write-Information "Analyzing: $($file.FullName)" -InformationAction Continue
    if ($settingsPath -and $supportsSettingsPath) {
        $result = Invoke-ScriptAnalyzer -Path $file.FullName -Recurse -Severity Error, Warning -SettingsPath $settingsPath -ErrorAction SilentlyContinue
    } elseif ($null -ne $settingsData -and $supportsSettings) {
        $result = Invoke-ScriptAnalyzer -Path $file.FullName -Recurse -Severity Error, Warning -Settings $settingsData -ErrorAction SilentlyContinue
    } else {
        $result = Invoke-ScriptAnalyzer -Path $file.FullName -Recurse -Severity Error, Warning -ErrorAction SilentlyContinue
    }
    if ($result) { $issues += $result }
}

if ($issues.Count -eq 0) {
    Write-Information "✅ No lint issues found." -InformationAction Continue
    exit 0
}

Write-Information "❌ Lint issues detected:" -InformationAction Continue
$issues | Select-Object @{Name='File';Expression={$_.ScriptName}}, RuleName, Severity, Line | Format-Table -AutoSize

# Write a compact summary
$summary = $issues | Group-Object -Property Severity | ForEach-Object { "$($_.Name): $($_.Count)" }
Write-Information "Summary: $($summary -join ', ')" -InformationAction Continue

exit 1

