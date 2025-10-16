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

[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [int]$Limit = 200
)

Write-Information "🔍 Fetching repository list from GitHub API..." -InformationAction Continue
Write-Information ("=" * 60) -InformationAction Continue

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
    } catch {
        # Ignored - fallback to other lookup methods
        Write-Verbose "Get-GitHubOwner: git remote lookup failed: $($_.Exception.Message)"
    }

    # 3) gh authenticated user (fallback)
    try {
        $login = gh api user -q .login 2>$null
        if ($login) { return $login.Trim() }
    } catch {
        # Ignored - will return $null if no gh auth
        Write-Verbose "Get-GitHubOwner: gh api user lookup failed: $($_.Exception.Message)"
    }

    return $null
}

$Owner = Get-GitHubOwner
if (-not $Owner) {
    Write-Information "❌ ERROR: Could not determine GitHub owner. Ensure a git remote is set or GitHub CLI is authenticated." -InformationAction Continue
    exit 1
}
Write-Information "👤 Target owner: $Owner" -InformationAction Continue

# Dynamically fetch all repositories from GitHub API
try {
    Write-Information "📡 Connecting to GitHub API..." -InformationAction Continue
    if ($PSCmdlet.ShouldProcess("GitHub: $Owner", "List repositories")) {
        $repositories = gh repo list $Owner --json name --limit $Limit | ConvertFrom-Json | Select-Object -ExpandProperty name
        Write-Information "✅ Found $($repositories.Count) repositories" -InformationAction Continue
    } else {
        Write-Information "Skipping repository listing due to ShouldProcess/WhatIf." -InformationAction Continue
        $repositories = @()
    }
} catch {
    Write-Information "❌ ERROR: Failed to fetch repositories from GitHub API" -InformationAction Continue
    Write-Information "   Make sure GitHub CLI is installed and authenticated with SSO" -InformationAction Continue
    exit 1
}

Write-Information "🔍 Checking fork status for all repositories..." -InformationAction Continue
Write-Information ("=" * 60) -InformationAction Continue

$originalRepos = @()
$forkedRepos = @()
$errors = @()
$repoDetails = @()

foreach ($repo in $repositories) {
    try {
    Write-Information "Checking: $repo" -InformationAction Continue

    # Get comprehensive repo information for REPOS.md update capability
    if ($PSCmdlet.ShouldProcess("GitHub: $repo", "Fetch repository metadata")) {
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
    } else {
        Write-Information "Skipping metadata fetch for $repo due to ShouldProcess/WhatIf." -InformationAction Continue
        continue
    }

        # Sanitize emojis from string fields to keep JSON machine-friendly
        function Convert-StripEmoji([string]$s) {
            if ([string]::IsNullOrEmpty($s)) { return $s }
            # Remove surrogate pair emojis and common symbol ranges, plus variation selector
            $s = [regex]::Replace($s, '([\uD83C-\uDBFF][\uDC00-\uDFFF])', '')
            $s = [regex]::Replace($s, '[\u2600-\u27BF\uFE0F]', '')
            # Remove malformed UTF-8 characters and broken emoji encodings
            $s = [regex]::Replace($s, '[\u0080-\u009F]', '')
            $s = [regex]::Replace($s, '[≡ƒ∩Γâ][^\x20-\x7E]', '')
            return $s.Trim()
        }

        $repoInfo.name = Convert-StripEmoji $repoInfo.name
        $repoInfo.language = Convert-StripEmoji $repoInfo.language
        $repoInfo.description = Convert-StripEmoji $repoInfo.description
        $repoInfo.parent = Convert-StripEmoji $repoInfo.parent
        $repoInfo.visibility = Convert-StripEmoji $repoInfo.visibility
        $repoInfo.repo_type = Convert-StripEmoji $repoInfo.repo_type
        if ($repoInfo.topics) {
            $repoInfo.topics = @($repoInfo.topics | ForEach-Object { Convert-StripEmoji $_ })
        }

        $repoDetails += $repoInfo

        if ($repoInfo.fork -eq $true) {
            $forkedRepos += $repo
            $parentInfo = if ($repoInfo.parent) { " (from $($repoInfo.parent))" } else { "" }
            Write-Information "  🍴 FORK$parentInfo" -InformationAction Continue
        } else {
            $originalRepos += $repo
            Write-Information "  🏠 ORIGINAL" -InformationAction Continue
        }
    } catch {
        $errors += $repo
        Write-Information "  ❌ ERROR: $($_.Exception.Message)" -InformationAction Continue
        Write-Verbose "Error details: $($_.Exception.ToString())"
    }
}

Write-Information ("`n" + ("=" * 60)) -InformationAction Continue
Write-Information "📊 SUMMARY RESULTS" -InformationAction Continue
Write-Information ("=" * 60) -InformationAction Continue

Write-Information "`n🏠 ORIGINAL REPOSITORIES ($($originalRepos.Count)):" -InformationAction Continue
$originalRepos | Sort-Object | ForEach-Object { Write-Information "  • $_" -InformationAction Continue }

Write-Information "`n🍴 FORKED REPOSITORIES ($($forkedRepos.Count)):" -InformationAction Continue
$forkedRepos | Sort-Object | ForEach-Object {
    $name = $_
    $parent = ($repoDetails | Where-Object { $_.name -eq $name }).parent
    $parentText = if ($parent) { " ← $parent" } else { "" }
    Write-Information "  • $name$parentText" -InformationAction Continue
}

if ($errors.Count -gt 0) {
    Write-Information "`n❌ ERRORS ($($errors.Count)):" -InformationAction Continue
    $errors | Sort-Object | ForEach-Object { Write-Information "  • $_" -InformationAction Continue }
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

if ($PSCmdlet.ShouldProcess('repo-analysis.json', 'Write JSON export')) {
    $exportData | ConvertTo-Json -Depth 6 | Out-File -FilePath "repo-analysis.json" -Encoding UTF8
}
Write-Information "`n📄 Exported comprehensive analysis to repo-analysis.json" -InformationAction Continue
Write-Information "   └─ Includes categorized repositories, language stats, and REPOS.md formatting data" -InformationAction Continue

Write-Information "`n✅ Analysis complete!" -InformationAction Continue
Write-Information "🔍 Analyzed $($repositories.Count) repositories dynamically fetched from GitHub API" -InformationAction Continue
Write-Information "📊 Statistics: $($originalRepos.Count) Original | $($forkedRepos.Count) Forks | $(($repoDetails | Where-Object { $_.private }).Count) Private | $(($repoDetails | Where-Object { -not $_.private }).Count) Public" -InformationAction Continue
Write-Information "📋 Use this information to update REPOS.md with accurate fork status and categories" -InformationAction Continue
Write-Information "📄 Comprehensive analysis saved to repo-analysis.json for automation" -InformationAction Continue
