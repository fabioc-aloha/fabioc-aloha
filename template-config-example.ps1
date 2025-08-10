# Template Configuration
# Copy this to template-config.ps1 and customize for your setup

# Personal Information
$TEMPLATE_USERNAME = "your-github-username"
$TEMPLATE_NAME = "Your Full Name"
$TEMPLATE_TITLE = "Your Professional Title"
$TEMPLATE_LOCATION = "Your City, State/Country"
$TEMPLATE_EMAIL = "your.email@domain.com"
$TEMPLATE_LINKEDIN = "your-linkedin-username"

# Repository Categories (customize these for your projects)
$TEMPLATE_CATEGORIES = @{
    "Core Projects" = @()
    "Web Development" = @()
    "Data Science & AI" = @()
    "Tools & Utilities" = @()
    "Learning Projects" = @()
    "Open Source Contributions" = @()
    "Profile & Documentation" = @()
}

# Repository Patterns (regex patterns to categorize your repos)
$TEMPLATE_PATTERNS = @{
    "^api|^service|^backend" = "Backend Services"
    "^ui|^frontend|^web|^react|^vue|^angular" = "Web Development"
    "^ml|^ai|^data|^analytics" = "Data Science & AI"
    "^tool|^util|^script|^cli" = "Tools & Utilities"
    "^learn|^tutorial|^practice|^course" = "Learning Projects"
    "^contrib|^fork" = "Open Source Contributions"
    "^$($TEMPLATE_USERNAME)$" = "Profile & Documentation"
}

# Badge Colors and Styles
$TEMPLATE_BADGE_STYLE = "for-the-badge"  # flat, flat-square, for-the-badge, plastic, social
$TEMPLATE_THEME = "tokyonight"  # default, dark, radical, merko, gruvbox, tokyonight, etc.

# Skills and Technologies (for badges)
$TEMPLATE_SKILLS = @(
    @{ Name = "Your Primary Skill"; Level = "Expert"; Color = "blue" }
    @{ Name = "Your Secondary Skill"; Level = "Advanced"; Color = "green" }
    @{ Name = "Your Tech Stack"; Level = "Proficient"; Color = "orange" }
)

Write-Host "Template configuration loaded!" -ForegroundColor Green
Write-Host "Edit this file with your personal information and run the setup script." -ForegroundColor Yellow
