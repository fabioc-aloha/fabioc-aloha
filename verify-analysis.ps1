param(
    [string]$File = 'repo-analysis.json'
)

if (-not (Test-Path -Path $File)) {
    Write-Error "File not found: $File"
    exit 1
}

try {
    $json = Get-Content -Raw $File | ConvertFrom-Json
} catch {
    Write-Error "Failed to parse JSON: $($_.Exception.Message)"
    exit 1
}

$forks = @($json.detailed_repositories | Where-Object { $_.fork -eq $true })
$missingParents = @($forks | Where-Object { -not $_.parent })

$header = $json.repos_md_format.header_stats
$nonAsciiCount = ($header.ToCharArray() | Where-Object { [int][char]$_ -gt 127 }).Count
$hasNonAscii = $nonAsciiCount -gt 0

[pscustomobject]@{
    File             = $File
    Forks            = $forks.Count
    MissingParents   = $missingParents.Count
    HeaderStats      = $header
    HeaderHasNonAscii= $hasNonAscii
} | Format-List
