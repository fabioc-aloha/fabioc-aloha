@{
    # PSScriptAnalyzer settings - disable noisy rules for this repository
    Rules = @{
        PSAvoidUsingWriteHost = @{ Enable = $true }
        PSUseBOMForUnicodeEncodedFile = @{ Enable = $true }
    }
    # Keep ExcludePath as an empty array for local tooling; lint.ps1 will sanitize settings when necessary
    ExcludePath = @()
}
