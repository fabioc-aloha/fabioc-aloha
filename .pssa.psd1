@{
    # PSScriptAnalyzer settings - disable noisy rules for this repository
    Rules = @{
        PSAvoidUsingWriteHost = @{ Enable = $false }
        PSUseBOMForUnicodeEncodedFile = @{ Enable = $false }
    }
    ExcludePath = @()
}
