# Repository Fork Detection Script
# This script identifies which repositories are forks vs original repositories
# Usage: .\check-forks.ps1 [-UpdateREADME] [-ExportJSON]

param(
    [switch]$UpdateREADME,  # Automatically update REPOS.md with fork status
    [switch]$ExportJSON     # Export results to JSON file for other tools
)

$repositories = @(
    "Catalyst-NEWBORN", "Alex-Cognitive-Architecture-Paper", "Catalyst-DBA", "Catalyst-DOG-TRAINER",
    "Catalyst-ADHD", "Catalyst-BRD", "Catalyst-DATA-ANALYSIS", "Catalyst", "mdword", "papercopilot",
    "AIRS", "DBA710", "AI-Qualitative-Analysis", "BRD", "ASI-Arch", "agent-zero", "ai-agents-for-beginners",
    "chatterbox", "generative_ai_project", "omi", "Self-Learning-Vibe-Coding", "Google-AI-Edge-Gallery",
    "Altman-Z-Score", "Qualtrics", "XDL_Predictions", "Investing", "Spotify", "Catalyst_DJ", "Comedy",
    "Creative", "mcpservers", "LogoScraper", "WallpaperScraper", "Profile-Pic", "SendToQualtricsTool",
    "Bing-Wallpaper-Fetcher", "Fishbowl_POC", "Fishbowl", "Catalyst_Fabric", "Taylor", "XDL",
    "CPMXDLFunction", "PythonClass", "fabioc-aloha"
)

Write-Host "🔍 Checking fork status for all repositories..." -ForegroundColor Cyan
Write-Host "=" * 60

$originalRepos = @()
$forkedRepos = @()
$errors = @()
$repoDetails = @()

foreach ($repo in $repositories) {
    try {
        Write-Host "Checking: $repo" -ForegroundColor Yellow
        
        # Get comprehensive repo information
        $repoInfo = gh api "repos/fabioc-aloha/$repo" --jq '{
            name: .name,
            fork: .fork,
            private: .private,
            language: .language,
            description: .description,
            updated_at: .updated_at,
            parent: .parent.full_name
        }' | ConvertFrom-Json
        
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

Write-Host "`n" + "=" * 60
Write-Host "📊 SUMMARY RESULTS" -ForegroundColor Cyan
Write-Host "=" * 60

Write-Host "`n🏠 ORIGINAL REPOSITORIES ($($originalRepos.Count)):" -ForegroundColor Green
$originalRepos | Sort-Object | ForEach-Object { Write-Host "  • $_" -ForegroundColor White }

Write-Host "`n🍴 FORKED REPOSITORIES ($($forkedRepos.Count)):" -ForegroundColor Magenta
$forkedRepos | Sort-Object | ForEach-Object { 
    $parent = ($repoDetails | Where-Object { $_.name -eq $_ }).parent
    $parentText = if ($parent) { " ← $parent" } else { "" }
    Write-Host "  • $_$parentText" -ForegroundColor White 
}

if ($errors.Count -gt 0) {
    Write-Host "`n❌ ERRORS ($($errors.Count)):" -ForegroundColor Red
    $errors | Sort-Object | ForEach-Object { Write-Host "  • $_" -ForegroundColor White }
}

# Export to JSON if requested
if ($ExportJSON) {
    $exportData = @{
        timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"
        total_repos = $repositories.Count
        original_count = $originalRepos.Count
        forked_count = $forkedRepos.Count
        error_count = $errors.Count
        original_repos = $originalRepos | Sort-Object
        forked_repos = $forkedRepos | Sort-Object
        errors = $errors | Sort-Object
        detailed_info = $repoDetails
    }
    
    $exportData | ConvertTo-Json -Depth 5 | Out-File -FilePath "repo-analysis.json" -Encoding UTF8
    Write-Host "`n📄 Exported detailed analysis to repo-analysis.json" -ForegroundColor Cyan
}

Write-Host "`n✅ Analysis complete!" -ForegroundColor Cyan
Write-Host "📋 Use this information to update REPOS.md with accurate fork status" -ForegroundColor White
Write-Host "💡 Run with -ExportJSON to save detailed analysis" -ForegroundColor Yellow
