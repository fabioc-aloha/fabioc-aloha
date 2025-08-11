# enhance-with-claude.ps1
# Claude Sonnet 4 integration for repository description enhancement

param(
    [string]$Model = "claude-3-5-sonnet-20241022",
    [string]$InputFile = "repo-analysis.json"
)

Write-Host "🤖 Claude Sonnet 4 Enhancement Script"
Write-Host "======================================"

# Check if input file exists
if (-not (Test-Path $InputFile)) {
    Write-Host "❌ Input file '$InputFile' not found, skipping AI enhancement"
    exit 0
}

# Check for Claude API key
if (-not $env:CLAUDE_API_KEY) {
    Write-Host "⚠️ CLAUDE_API_KEY not found, skipping AI enhancement"
    Write-Host "💡 Add CLAUDE_API_KEY secret to enable AI-powered descriptions"
    exit 0
}

Write-Host "🔑 Claude API key found, proceeding with enhancement..."

# Read existing data
try {
    $repoData = Get-Content $InputFile -Raw | ConvertFrom-Json
    Write-Host "📊 Found $($repoData.repositories.Count) repositories to enhance"
}
catch {
    Write-Host "❌ Failed to parse input file: $($_.Exception.Message)"
    exit 1
}

# Create Claude prompt
$prompt = @"
You are Alex Finch, a professional repository manager assistant. Analyze this GitHub repository data and enhance the descriptions with professional, technical language.

Guidelines:
- Keep descriptions concise (1-2 sentences)
- Focus on purpose, technology stack, and use case
- Maintain professional, technical language
- For forks, mention original purpose plus customizations
- For original projects, highlight unique value and tech stack

Repository data:
$($repoData | ConvertTo-Json -Depth 10)

Return ONLY valid JSON with the same structure but enhanced 'description' fields.
"@

# Prepare API request
$headers = @{
    'x-api-key' = $env:CLAUDE_API_KEY
    'Content-Type' = 'application/json'
    'anthropic-version' = '2023-06-01'
}

$body = @{
    model = $Model
    max_tokens = 4000
    messages = @(
        @{
            role = 'user'
            content = $prompt
        }
    )
} | ConvertTo-Json -Depth 10

# Make API call
try {
    Write-Host "🌐 Calling Claude API..."
    $response = Invoke-RestMethod -Uri 'https://api.anthropic.com/v1/messages' -Method Post -Headers $headers -Body $body -TimeoutSec 60

    if ($response.content -and $response.content[0].text) {
        $enhancedText = $response.content[0].text.Trim()

        # Clean up response (remove markdown formatting if present)
        $enhancedText = $enhancedText -replace '^```json\s*', '' -replace '\s*```$', ''

        # Parse and validate JSON
        $enhancedData = $enhancedText | ConvertFrom-Json

        if ($enhancedData.repositories) {
            # Save enhanced data
            $enhancedData | ConvertTo-Json -Depth 10 | Set-Content $InputFile -Encoding UTF8
            Write-Host "✅ Repository descriptions enhanced with Claude Sonnet 4!"
            Write-Host "📈 Enhanced $($enhancedData.repositories.Count) repository descriptions"
        }
        else {
            Write-Host "⚠️ Invalid JSON structure from Claude, keeping original data"
        }
    }
    else {
        Write-Host "⚠️ Empty response from Claude, keeping original data"
    }
}
catch {
    Write-Host "⚠️ Claude API call failed: $($_.Exception.Message)"

    # Try to get more details from the response
    if ($_.Exception.Response) {
        try {
            $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
            $responseBody = $reader.ReadToEnd()
            Write-Host "📝 API Response: $responseBody"
        }
        catch {
            Write-Host "📝 Could not read error response"
        }
    }

    Write-Host "🔄 Continuing with original data"
}

Write-Host "🎯 Claude enhancement process complete"
