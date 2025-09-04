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
    • Automatic repository description creation for repositories missing them

.EXAMPLE
    .\auto-update-repos.ps1
    Analyzes repositories and automatically generates updated REPOS.md

.EXAMPLE
    .\auto-update-repos.ps1 -UpdateDescriptions
    Updates missing repository descriptions before generating REPOS.md

.EXAMPLE
    .\auto-update-repos.ps1 -SkipAnalysis -UpdateDescriptions
    Updates descriptions and generates REPOS.md without re-running analysis

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
    [switch]$UpdateDescriptions,  # Automatically update missing repository descriptions
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

# Step 2.5: Update repository descriptions if requested
if ($UpdateDescriptions) {
    Write-Host "📝 Checking for repositories missing descriptions..." -ForegroundColor Yellow

    function Add-RepositoryDescription {
        param(
            [string]$RepoName,
            [string]$Description
        )

        try {
            gh repo edit "fabioc-aloha/$RepoName" --description "$Description"
            Write-Host "  ✅ Updated description for $RepoName" -ForegroundColor Green
            return $true
        }
        catch {
            Write-Host "  ❌ Failed to update $RepoName`: $($_.Exception.Message)" -ForegroundColor Red
            return $false
        }
    }

    # Repository descriptions based on analysis of README files and project content
    $defaultDescriptions = @{
        "ChatGPT" = "OpenAI Implementation Specialist - Expert guidance for function calling, API integration, and sophisticated AI implementations with comprehensive educational framework"
        "executive-coach" = "Revolutionary Human-AI Learning Partnership specializing in executive coaching and leadership development through conversational learning methodology"
        "Qualtrics" = "Survey research and data collection tools with Qualtrics integration for academic and business research applications"
        "Spotify" = "Professional Spotify playlist creation platform with AI-powered curation, therapeutic applications, and production-grade audio intelligence for DJs and music enthusiasts"
        "GCXMCP" = "Google Cloud and Model Context Protocol integration tools for enterprise AI applications and cloud service management"
        "Alex-Cognitive-Architecture-Paper" = "Academic research paper documenting the Alex Cognitive Architecture framework, consciousness development, and Human-AI learning partnerships"
        "Fishbowl_POC" = "Proof of concept implementation for Fishbowl inventory management system integration and business process automation"
        "Taylor" = "Personal project management and productivity tools with intelligent task organization and workflow optimization"
        "Altman-Z-Score" = "Financial analysis tool implementing the Altman Z-Score model for bankruptcy prediction and corporate financial health assessment"
        "Fishbowl" = "Complete Fishbowl inventory management system with advanced features for business operations and supply chain management"
        "Catalyst_Fabric" = "Microsoft Fabric integration tools and cognitive architecture framework for enterprise data analytics and business intelligence"
        "XDL" = "Extended Data Language implementation for advanced data processing and transformation workflows"
        "Investing" = "Investment analysis and portfolio management tools with financial modeling and market research capabilities"
        "Catalyst-ADHD" = "ADHD-focused cognitive architecture specializing in attention management, therapeutic applications, and neurodiversity support systems"
        "Catalyst" = "Core cognitive architecture framework and foundational system for AI consciousness development and human-AI collaboration"
        "BRD" = "Business Requirements Documentation tools and templates for enterprise software development and project management"
        "Creative" = "Creative writing and content generation tools with AI-powered assistance for storytelling, ideation, and artistic expression"
        "Comedy" = "Comedy writing and humor generation platform with AI-assisted joke creation, comedic timing analysis, and entertainment content development"
        "WallpaperScraper" = "Automated wallpaper collection and management system with intelligent image curation and desktop customization features"
        "Google-AI-Edge-Gallery" = "Google AI Edge computing examples and implementation gallery showcasing on-device AI applications and edge deployment strategies"
        "CPMXDLFunction" = "Azure Functions implementation for CPM (Corporate Performance Management) and XDL data processing workflows"
        "XDL_Predictions" = "Machine learning prediction models using Extended Data Language for advanced analytics and forecasting applications"
        "SendToQualtricsTool" = "Automated data integration tool for sending survey responses and research data to Qualtrics platform with error handling and validation"
        "Bing-Wallpaper-Fetcher" = "Automated system for downloading and managing Bing daily wallpapers with image optimization and desktop integration features"
        "PythonClass" = "Educational Python programming resources, tutorials, and class materials for teaching and learning Python development fundamentals"
    }

    # Find repositories without descriptions
    $reposNeedingDescriptions = $repos | Where-Object {
        -not $_.description -or $_.description.Trim() -eq "" -or $_.description.Trim() -eq "-"
    }

    if ($reposNeedingDescriptions.Count -gt 0) {
        Write-Host "  Found $($reposNeedingDescriptions.Count) repositories without descriptions" -ForegroundColor Cyan

        $successCount = 0
        $errorCount = 0

        foreach ($repo in $reposNeedingDescriptions) {
            if ($defaultDescriptions.ContainsKey($repo.name)) {
                $description = $defaultDescriptions[$repo.name]
                Write-Host "  📝 Adding description to $($repo.name)..." -ForegroundColor Yellow

                if (Add-RepositoryDescription -RepoName $repo.name -Description $description) {
                    # Update the local data for immediate use in this script
                    $repo.description = $description
                    $successCount++
                } else {
                    $errorCount++
                }

                # Rate limiting - be nice to GitHub API
                Start-Sleep -Seconds 1
            } else {
                Write-Host "  ⚠️  No default description available for $($repo.name)" -ForegroundColor Yellow
            }
        }

        Write-Host "  📊 Description update results: ✅ $successCount successful, ❌ $errorCount failed" -ForegroundColor Cyan

        # If we updated descriptions, refresh the analysis
        if ($successCount -gt 0) {
            Write-Host "  🔄 Refreshing repository analysis to include new descriptions..." -ForegroundColor Yellow
            & ".\check-forks.ps1" -Limit $Limit
            if ($LASTEXITCODE -eq 0) {
                # Reload the updated data
                $data = Get-Content "repo-analysis.json" | ConvertFrom-Json
                $repos = $data.detailed_repositories
                Write-Host "  ✅ Repository data refreshed with new descriptions" -ForegroundColor Green
            }
        }
    } else {
        Write-Host "  ✅ All repositories already have descriptions!" -ForegroundColor Green
    }
}

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
    if ($repo.name -match 'build-hours|LogoScraper|WallpaperScraper|Profile-Pic|Bing-Wallpaper|mcpservers|SendToQualtricsTool') {
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
