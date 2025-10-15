<#
Small helper to write UTF8-BOM to a list of files flagged by PSUseBOMForUnicodeEncodedFile
Usage: .\scripts\fix-bom.ps1 -Paths @('file1.ps1','file2.ps1')
#>
param(
    [Parameter(Mandatory=$true)]
    [string[]]$Paths
)

foreach ($p in $Paths) {
    if (-not (Test-Path $p)) { Write-Warning "File not found: $p"; continue }
    $content = Get-Content -Raw -LiteralPath $p -Encoding UTF8
    # Write explicit UTF8 BOM bytes then the content to ensure BOM presence across PowerShell versions
    $utf8bom = [System.Text.Encoding]::UTF8.GetPreamble()
    $bytes = $utf8bom + ([System.Text.Encoding]::UTF8.GetBytes($content))
    [System.IO.File]::WriteAllBytes($p, $bytes)
    Write-Output "Wrote UTF8 BOM to: $p"
}
