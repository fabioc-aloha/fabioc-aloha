<#
.SYNOPSIS
    Repository Fork Detection Script for fabioc-aloha GitHub portfolio

.DESCRIPTION
    This script analyzes all repositories in the fabioc-aloha GitHub portfolio to differentiate
    between original work and community contributions (forks). It provides detailed information
    about each repository including fork status, parent repositories, and comprehensive metadata.

    Key Features:
    • Dynamic repository discovery from GitHub API (no hardcoded lists)
    • Fork detection with parent repository identification
    • Comprehensive metadata collection for each repository
    • Automatic categorization into REPOS.md sections
    • Language distribution analysis with statistics
    • Always exports detailed JSON file for automation workflows
    • Color-coded console output for easy visual analysis

    The script automatically generates repo-analysis.json containing all necessary data for
    updating REPOS.md documentation, including pre-formatted table headers, statistics,
    and categorized repository listings.

.EXAMPLE
    .\check-forks.ps1
    Performs fork analysis with color-coded console output and saves detailed JSON export

.NOTES
    Requirements:
    - GitHub CLI (gh) installed and authenticated with SSO
    - PowerShell 5.1 or later
    - Access to fabioc-aloha repositories (requires SSO authentication)

    Author: Fabio Correa
    Version: 2.2
    Last Updated: August 10, 2025
#>

# Repository Fork Detection Script
# This script dynamically fetches repositories from GitHub API and identifies forks vs original repositories
# Always exports comprehensive analysis to JSON file for automation

param(
    [int]$Limit = 200
)

Write-Host "🔍 Fetching repository list from GitHub API..." -ForegroundColor Cyan
Write-Host ("=" * 60)

# Resolve target GitHub owner dynamically (no hardcoded usernames)
function Get-GitHubOwner {
    # 1) GitHub Actions env (owner/repo)
    if ($env:GITHUB_REPOSITORY) {
        $parts = $env:GITHUB_REPOSITORY.Split('/')
        if ($parts.Length -ge 2 -and [string]::IsNullOrWhiteSpace($parts[0]) -eq $false) {
            return $parts[0]
        }
    }

    # 2) git remote origin URL
    try {
        $remote = git config --get remote.origin.url 2>$null
        if ($remote) {
            if ($remote -match 'github\.com[:/](?<owner>[^/]+)/') {
                return $Matches.owner
            }
        }
    } catch {}

    # 3) gh authenticated user (fallback)
    try {
        $login = gh api user -q .login 2>$null
        if ($login) { return $login.Trim() }
    } catch {}

    return $null
}

$Owner = Get-GitHubOwner
if (-not $Owner) {
    Write-Host "❌ ERROR: Could not determine GitHub owner. Ensure a git remote is set or GitHub CLI is authenticated." -ForegroundColor Red
    exit 1
}
Write-Host "👤 Target owner: $Owner" -ForegroundColor Cyan

# Dynamically fetch all repositories from GitHub API
try {
    Write-Host "📡 Connecting to GitHub API..." -ForegroundColor Yellow
    $repositories = gh repo list $Owner --json name --limit $Limit | ConvertFrom-Json | Select-Object -ExpandProperty name
    Write-Host "✅ Found $($repositories.Count) repositories" -ForegroundColor Green
} catch {
    Write-Host "❌ ERROR: Failed to fetch repositories from GitHub API" -ForegroundColor Red
    Write-Host "   Make sure GitHub CLI is installed and authenticated with SSO" -ForegroundColor Yellow
    exit 1
}

Write-Host "🔍 Checking fork status for all repositories..." -ForegroundColor Cyan
Write-Host ("=" * 60)

$originalRepos = @()
$forkedRepos = @()
$errors = @()
$repoDetails = @()

foreach ($repo in $repositories) {
    try {
        Write-Host "Checking: $repo" -ForegroundColor Yellow

    # Get comprehensive repo information for REPOS.md update capability
    $repoInfo = gh api "repos/$Owner/$repo" --jq '{
            name: .name,
            fork: .fork,
            private: .private,
            language: .language,
            description: .description,
            updated_at: .updated_at,
            parent: .parent.full_name,
            html_url: .html_url,
            visibility: (if .private then "Private" else "Public" end),
            repo_type: (if .fork then "Fork" else "Original" end),
            last_updated_formatted: (.updated_at | strptime("%Y-%m-%dT%H:%M:%SZ") | strftime("%b %d, %Y")),
            full_name: .full_name,
            default_branch: .default_branch,
            topics: .topics,
            size: .size,
            stargazers_count: .stargazers_count,
            forks_count: .forks_count,
            open_issues_count: .open_issues_count
        }' | ConvertFrom-Json

        # Sanitize emojis from string fields to keep JSON machine-friendly
        function Remove-Emoji([string]$s) {
            if ([string]::IsNullOrEmpty($s)) { return $s }
            # Remove surrogate pair emojis and common symbol ranges, plus variation selector
            $s = [regex]::Replace($s, '([\uD83C-\uDBFF][\uDC00-\uDFFF])', '')
            $s = [regex]::Replace($s, '[\u2600-\u27BF\uFE0F]', '')
            return $s.Trim()
        }

        $repoInfo.name = Remove-Emoji $repoInfo.name
        $repoInfo.language = Remove-Emoji $repoInfo.language
        $repoInfo.description = Remove-Emoji $repoInfo.description
        $repoInfo.parent = Remove-Emoji $repoInfo.parent
        $repoInfo.visibility = Remove-Emoji $repoInfo.visibility
        $repoInfo.repo_type = Remove-Emoji $repoInfo.repo_type
        if ($repoInfo.topics) {
            $repoInfo.topics = @($repoInfo.topics | ForEach-Object { Remove-Emoji $_ })
        }

        $repoDetails += $repoInfo

        if ($repoInfo.fork -eq $true) {
            $forkedRepos += $repo
            $parentInfo = if ($repoInfo.parent) { " (from $($repoInfo.parent))" } else { "" }
            Write-Host "  🍴 FORK$parentInfo" -ForegroundColor Magenta
        } else {
            $originalRepos += $repo
            Write-Host "  🏠 ORIGINAL" -ForegroundColor Green
        }
    } catch {
        $errors += $repo
        Write-Host "  ❌ ERROR: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n" + ("=" * 60)
Write-Host "📊 SUMMARY RESULTS" -ForegroundColor Cyan
Write-Host ("=" * 60)

Write-Host "`n🏠 ORIGINAL REPOSITORIES ($($originalRepos.Count)):" -ForegroundColor Green
$originalRepos | Sort-Object | ForEach-Object { Write-Host "  • $_" -ForegroundColor White }

Write-Host "`n🍴 FORKED REPOSITORIES ($($forkedRepos.Count)):" -ForegroundColor Magenta
$forkedRepos | Sort-Object | ForEach-Object {
    $name = $_
    $parent = ($repoDetails | Where-Object { $_.name -eq $name }).parent
    $parentText = if ($parent) { " ← $parent" } else { "" }
    Write-Host "  • $name$parentText" -ForegroundColor White
}

if ($errors.Count -gt 0) {
    Write-Host "`n❌ ERRORS ($($errors.Count)):" -ForegroundColor Red
    $errors | Sort-Object | ForEach-Object { Write-Host "  • $_" -ForegroundColor White }
}

# Export comprehensive analysis to JSON file (always enabled)
# Create comprehensive export with all data needed for REPOS.md updates
$categorizedRepos = @{
    "Core Cognitive Architecture Suite" = @()
    "Academic & Research Tools" = @()
    "AI & Machine Learning Projects" = @()
    "Business Intelligence & Analytics" = @()
    "Entertainment & Creative Projects" = @()
    "Development Tools & Utilities" = @()
    "Enterprise & Microsoft Projects" = @()
    "Learning & Education" = @()
    "Profile & Portfolio" = @()
}

# Categorize repositories based on name patterns and topics
foreach ($repo in $repoDetails) {
    $category = "Development Tools & Utilities" # Default category

    # Categorize based on repository names and patterns
    switch -Regex ($repo.name) {
        "^Catalyst" { $category = "Core Cognitive Architecture Suite" }
        "^Alex" { $category = "Core Cognitive Architecture Suite" }
        "mdword|papercopilot|AIRS|DBA710|AI-Qualitative|BRD" { $category = "Academic & Research Tools" }
        "ASI-Arch|agent-zero|ai-agents|chatterbox|generative|omi|Self-Learning|Google-AI" { $category = "AI & Machine Learning Projects" }
        "Altman|Qualtrics|XDL_Predictions|Investing" { $category = "Business Intelligence & Analytics" }
        "Spotify|DJ|Comedy|Creative" { $category = "Entertainment & Creative Projects" }
        "Fishbowl|Fabric|Taylor|XDL$|CPM" { $category = "Enterprise & Microsoft Projects" }
        "PythonClass" { $category = "Learning & Education" }
        "fabioc-aloha" { $category = "Profile & Portfolio" }
    }

    $categorizedRepos[$category] += $repo
}

# Calculate language distribution
$languageStats = $repoDetails | Where-Object { $_.language } | Group-Object language |
    Sort-Object Count -Descending | ForEach-Object {
        @{
            language = $_.Name
            count = $_.Count
            percentage = [math]::Round(($_.Count / $repoDetails.Count) * 100, 1)
        }
    }

# Create comprehensive export data
$exportData = @{
    metadata = @{
        timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"
        generated_by = "check-forks.ps1"
        script_version = "2.1"
    github_user = $Owner
    }
    statistics = @{
        total_repos = $repositories.Count
        original_count = $originalRepos.Count
        forked_count = $forkedRepos.Count
        error_count = $errors.Count
        private_count = ($repoDetails | Where-Object { $_.private }).Count
        public_count = ($repoDetails | Where-Object { -not $_.private }).Count
    }
    language_distribution = $languageStats
    repository_categories = $categorizedRepos
    repository_lists = @{
        original_repos = $originalRepos | Sort-Object
        forked_repos = $forkedRepos | Sort-Object
        errors = $errors | Sort-Object
    }
    detailed_repositories = $repoDetails | Sort-Object name
    repos_md_format = @{
        # Keep JSON emoji-free for clean machine consumption; emojis are fine in console/markdown only
        header_stats = "Original Work ($($originalRepos.Count) repos) | Community Contributions ($($forkedRepos.Count) forks) | Private ($(($repoDetails | Where-Object { $_.private }).Count)) | Public ($(($repoDetails | Where-Object { -not $_.private }).Count))"
        table_headers = "| Repository | Type | Visibility | Language | Description | Last Updated |"
        table_separator = "|------------|------|------------|----------|-------------|--------------|"
    }
    mermaid_chart_data = @{
        title = "Programming Languages Distribution ($($repositories.Count) Repositories)"
        data = $languageStats | ForEach-Object { "`"$($_.language)`" : $($_.count)" }
    }
}

$exportData | ConvertTo-Json -Depth 6 | Out-File -FilePath "repo-analysis.json" -Encoding UTF8
Write-Host "`n📄 Exported comprehensive analysis to repo-analysis.json" -ForegroundColor Cyan
Write-Host "   └─ Includes categorized repositories, language stats, and REPOS.md formatting data" -ForegroundColor Gray

Write-Host "`n✅ Analysis complete!" -ForegroundColor Cyan
Write-Host "🔍 Analyzed $($repositories.Count) repositories dynamically fetched from GitHub API" -ForegroundColor Green
Write-Host "📊 Statistics: $($originalRepos.Count) Original | $($forkedRepos.Count) Forks | $(($repoDetails | Where-Object { $_.private }).Count) Private | $(($repoDetails | Where-Object { -not $_.private }).Count) Public" -ForegroundColor White
Write-Host "📋 Use this information to update REPOS.md with accurate fork status and categories" -ForegroundColor White
Write-Host "📄 Comprehensive analysis saved to repo-analysis.json for automation" -ForegroundColor Yellow
