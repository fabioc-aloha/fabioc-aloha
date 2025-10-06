<#
.SYNOPSIS
    Automated REPOS.md Generator with Dynamic Categorization

.DESCRIPTION
    This script extends check-forks.ps1 functionality to automatically generate
    a complete REPOS.md file with zero manual intervention. It includes:

    • Dynamic repository categorization using priority-based logic
    • Complete REPOS.md file generation with current data
    • Language distribution charts and statistics
    • Automated date stamping and formatting
    • Full integration with existing check-forks.ps1 data
    • Uses GitHub API data directly - no hardcoded descriptions

.EXAMPLE
    .\auto-update-repos.ps1
    Analyzes repositories and automatically generates updated REPOS.md

.EXAMPLE
    .\auto-update-repos.ps1 -SkipAnalysis
    Generates REPOS.md without re-running analysis (uses existing repo-analysis.json)

.NOTES
    Requirements:
    - GitHub CLI (gh) installed and authenticated
    - PowerShell 5.1 or later
    - Existing check-forks.ps1 in same directory

    Author: Fabio Correa / Alex Finch
    Version: 1.0
    Last Updated: September 3, 2025
#>

param(
    [switch]$SkipAnalysis,  # Skip repository analysis if repo-analysis.json is current
    [int]$Limit = 200
)

Write-Host "🤖 Automated REPOS.md Generator" -ForegroundColor Cyan
Write-Host ("=" * 50) -ForegroundColor Gray

# Step 1: Run repository analysis (unless skipped)
if (-not $SkipAnalysis) {
    Write-Host "📊 Running repository analysis..." -ForegroundColor Yellow
    & ".\check-forks.ps1" -Limit $Limit
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Repository analysis failed. Exiting."
        exit 1
    }
} else {
    Write-Host "⏭️  Skipping analysis - using existing repo-analysis.json" -ForegroundColor Yellow
}

# Step 2: Load repository data
Write-Host "📋 Loading repository data..." -ForegroundColor Yellow
if (-not (Test-Path "repo-analysis.json")) {
    Write-Error "repo-analysis.json not found. Run without -SkipAnalysis flag."
    exit 1
}

$data = Get-Content "repo-analysis.json" | ConvertFrom-Json
$repos = $data.detailed_repositories

# Step 3: Dynamic categorization function (priority-based logic)
function Get-RepositoryCategory($repo) {
    # Core Cognitive Architecture Suite (highest priority)
    if ($repo.name -match '^Catalyst-NEWBORN|^Alex-Cognitive|^Catalyst$') {
        return 'Core Cognitive Architecture Suite'
    }

    # Academic & Research Tools
    if ($repo.name -match '^Catalyst-DBA|^Catalyst-DATA-ANALYSIS') {
        return 'Academic & Research Tools'
    }

    # Entertainment & Creative Projects
    if ($repo.name -match '^Catalyst_DJ') {
        return 'Entertainment & Creative Projects'
    }

    # Enterprise & Microsoft Projects
    if ($repo.name -match '^Catalyst_Fabric|^Catalyst-BRD') {
        return 'Enterprise & Microsoft Projects'
    }

    # Catch remaining Catalyst repos
    if ($repo.name -match '^Catalyst-') {
        return 'Core Cognitive Architecture Suite'
    }

    # Academic & Research Tools (specific repos)
    if ($repo.name -match 'mdword|papercopilot|AIRS|DBA710|AI-Qualitative-Analysis|^BRD$') {
        return 'Academic & Research Tools'
    }

    # AI & Machine Learning Projects
    if ($repo.name -match 'agent-zero|ai-agents|chatterbox|omi|ASI-Arch|generative_ai|Google-AI|data-formulator|Self-Learning-Vibe-Coding') {
        return 'AI & Machine Learning Projects'
    }

    # Business Intelligence & Analytics
    if ($repo.name -match 'Altman|Qualtrics|Investing|XDL_Predictions') {
        return 'Business Intelligence & Analytics'
    }

    # Entertainment & Creative Projects
    if ($repo.name -match '^Spotify$|Comedy|Creative') {
        return 'Entertainment & Creative Projects'
    }

    # Development Tools & Utilities
    if ($repo.name -match 'build-hours|LogoScraper|WallpaperScraper|Profile-Pic|Bing-Wallpaper|mcpservers|SendToQualtricsTool|moleculator') {
        return 'Development Tools & Utilities'
    }

    # Enterprise & Microsoft Projects
    if ($repo.name -match 'Fishbowl|Taylor|^XDL$|CPM|GCXMCP|executive-coach|ChatGPT') {
        return 'Enterprise & Microsoft Projects'
    }

    # Learning & Education
    if ($repo.name -match 'PythonClass|Education|Learning') {
        return 'Learning & Education'
    }

    # Profile & Portfolio
    if ($repo.name -match '^fabioc-aloha$') {
        return 'Profile & Portfolio'
    }

    # Language-based fallback categorization
    if ($repo.language -match 'PowerShell' -and $repo.description -match 'cognitive|architecture') {
        return 'Core Cognitive Architecture Suite'
    }

    if ($repo.language -match 'Python|Jupyter' -and $repo.description -match 'AI|ML|analysis|research') {
        return 'AI & Machine Learning Projects'
    }

    # Fork fallback
    if ($repo.repo_type -eq 'Fork') {
        return 'AI & Machine Learning Projects'
    }

    return '❓ NEEDS_MANUAL_CATEGORIZATION'
}

# Step 4: Categorize all repositories
Write-Host "🏷️  Categorizing repositories..." -ForegroundColor Yellow
$categorizedRepos = $repos | ForEach-Object {
    [PSCustomObject]@{
        Name = $_.name
        Category = Get-RepositoryCategory $_
        Type = $_.repo_type
        Visibility = $_.visibility
        Language = if ($_.language) { $_.language } else { '-' }
        LastUpdated = $_.last_updated_formatted
        Description = if ($_.description) { $_.description } else { '-' }
        HtmlUrl = $_.html_url
        Private = $_.private
    }
}

# Step 5: Generate repository table entries
function Get-RepoTableEntry($repo) {
    $typeIcon = if ($repo.Type -eq 'Original') { '🏠' } else { '🍴' }
    $visibilityIcon = if ($repo.Visibility -eq 'Public') { '🌟' } else { '🔒' }
    return "| [**$($repo.Name)**]($($repo.HtmlUrl)) | $typeIcon $($repo.Type) | $visibilityIcon $($repo.Visibility) | $($repo.Language) | $($repo.Description) | $($repo.LastUpdated) |"
}

# Step 6: Generate complete REPOS.md content
Write-Host "📝 Generating REPOS.md content..." -ForegroundColor Yellow

$currentDate = Get-Date -Format "MMMM dd, yyyy 'at' hh:mm tt 'UTC'"
$totalRepos = $repos.Count
$originalCount = ($repos | Where-Object { $_.repo_type -eq 'Original' }).Count
$forkCount = ($repos | Where-Object { $_.repo_type -eq 'Fork' }).Count
$privateCount = ($repos | Where-Object { $_.private -eq $true }).Count
$publicCount = ($repos | Where-Object { $_.private -eq $false }).Count

# Language statistics
$languageStats = $repos | Where-Object { $_.language } |
    Group-Object language |
    Sort-Object Count -Descending |
    ForEach-Object { [PSCustomObject]@{ Language = $_.Name; Count = $_.Count } }

$reposContent = @"
# 📁 Repository Portfolio

> **Last Updated**: $currentDate

> **Fabio Correa's GitHub Repository Collection**
> Comprehensive overview of $totalRepos projects spanning AI research, academic tools, business intelligence, and cognitive architectures.
>
> **🏠 Original Work ($originalCount repos)** | **🍴 Community Contributions ($forkCount forks)** | **🔒 Private ($privateCount)** | **🌐 Public ($publicCount)**

---

"@

# Define category order and icons
$categoryOrder = @(
    @{ Name = 'Core Cognitive Architecture Suite'; Icon = '🧠' },
    @{ Name = 'Academic & Research Tools'; Icon = '📝' },
    @{ Name = 'AI & Machine Learning Projects'; Icon = '🤖' },
    @{ Name = 'Business Intelligence & Analytics'; Icon = '💼' },
    @{ Name = 'Entertainment & Creative Projects'; Icon = '🎵' },
    @{ Name = 'Development Tools & Utilities'; Icon = '🛠️' },
    @{ Name = 'Enterprise & Microsoft Projects'; Icon = '🏢' },
    @{ Name = 'Learning & Education'; Icon = '📚' },
    @{ Name = 'Profile & Portfolio'; Icon = '🌟' }
)

# Generate sections for each category
foreach ($categoryInfo in $categoryOrder) {
    $categoryName = $categoryInfo.Name
    $categoryIcon = $categoryInfo.Icon

    $categoryRepos = $categorizedRepos | Where-Object { $_.Category -eq $categoryName } | Sort-Object LastUpdated -Descending

    if ($categoryRepos.Count -gt 0) {
        $reposContent += @"

### $categoryIcon $categoryName

| Repository | Type | Visibility | Language | Description | Last Updated |
|------------|------|------------|----------|-------------|--------------|

"@
        foreach ($repo in $categoryRepos) {
            $reposContent += Get-RepoTableEntry $repo
            $reposContent += "`n"
        }
    }
}

# Add footer sections
$topLanguages = $languageStats | Select-Object -First 5
$languagePercentages = $topLanguages | ForEach-Object {
    "`"$($_.Language)`" : $($_.Count)"
}

$reposContent += @"

---

## 🏠 Original Work vs 🍴 Community Contributions

### **🏠 Original Repositories ($originalCount)**
These represent my **independent research, development, and innovation work**:
- **Core Cognitive Architectures**: Catalyst suite, Alex framework, NEWBORN system
- **Academic Tools**: MdWord, PaperCopilot, AI-Qualitative-Analysis
- **Business Intelligence**: Financial analysis, enterprise analytics, Microsoft integrations
- **Creative Projects**: Entertainment apps, development utilities, personal tools

### **🍴 Forked Repositories ($forkCount)**
These represent **learning, collaboration, and community contributions**:
- **AI/ML Research**: Exploring cutting-edge frameworks (agent-zero, chatterbox, omi)
- **Development Tools**: Contributing to open-source projects (mcpservers, Profile-Pic)
- **Educational Resources**: Learning from community tutorials (ai-agents-for-beginners)

**Philosophy**: Forks demonstrate active engagement with the AI/ML community while original work showcases independent innovation and research contributions.

## 📈 Language Distribution

``````mermaid
pie title Programming Languages Distribution ($totalRepos Repositories)
    $($languagePercentages -join "`n    ")
``````

### 💻 **Top Languages Summary**
$($topLanguages | ForEach-Object { $percentage = [math]::Round(($_.Count / $totalRepos) * 100, 1); "- **$($_.Language) ($percentage%)**: Primary language for $($_.Count) repositories" } | Out-String)
---

<p align="center">
  <em>🚀 "Building the future of human-AI collaboration through ethical cognitive architectures" 🚀</em>
</p>
"@

# Step 7: Write the complete REPOS.md file
Write-Host "💾 Writing REPOS.md file..." -ForegroundColor Yellow
$reposContent | Out-File -FilePath "REPOS.md" -Encoding UTF8

# Step 8: Generate summary report
Write-Host "`n✅ REPOS.md automatically generated!" -ForegroundColor Green
Write-Host "📊 Repository Summary:" -ForegroundColor Cyan
Write-Host "   🏠 Original Work: $originalCount repositories" -ForegroundColor White
Write-Host "   🍴 Community Contributions: $forkCount forks" -ForegroundColor White
Write-Host "   🔒 Private: $privateCount | 🌐 Public: $publicCount" -ForegroundColor White
Write-Host "📝 Categories Generated:" -ForegroundColor Cyan
foreach ($categoryInfo in $categoryOrder) {
    $count = ($categorizedRepos | Where-Object { $_.Category -eq $categoryInfo.Name }).Count
    if ($count -gt 0) {
        Write-Host "   $($categoryInfo.Icon) $($categoryInfo.Name): $count repos" -ForegroundColor White
    }
}

# Check for uncategorized repositories
$uncategorized = $categorizedRepos | Where-Object { $_.Category -eq '❓ NEEDS_MANUAL_CATEGORIZATION' }
if ($uncategorized.Count -gt 0) {
    Write-Host "`n⚠️  Uncategorized Repositories ($($uncategorized.Count)):" -ForegroundColor Yellow
    $uncategorized | ForEach-Object { Write-Host "   - $($_.Name)" -ForegroundColor Red }
    Write-Host "   These repos need manual categorization logic added to the script." -ForegroundColor Gray
}

Write-Host "`n🎉 Automation complete! REPOS.md is now fully up-to-date." -ForegroundColor Green
Write-Host "🔄 To update again, simply run: .\auto-update-repos.ps1" -ForegroundColor Cyan
