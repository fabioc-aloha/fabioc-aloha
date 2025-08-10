# Repository Management Scripts & Documentation

This directory contains utility scripts and documentati✅ Analysis complete!
📊 Analyzed 44 repositories dynamically fetched from GitHub API
📊 Statistics: 35 Original | 9 Forks | 15 Private | 29 Public
📋 Use this information to update REPOS.md with accurate fork status and categories
📄 Comprehensive analysis saved to repo-analysis.json for automationr managing and analyzing the GitHub repository portfolio for fabioc-aloha.

## 📁 Repository Portfolio Structure

The repository portfolio consists of **dynamically tracked repositories** with live counts from GitHub API:
- **🏠 Original Work**: Independent research and development (typically 80%+ of portfolio)
- **🍴 Community Contributions**: Forks and collaborative projects (typically 15-20% of portfolio)
- **🔒 Private Repositories**: Internal development and proprietary work
- **🌐 Public Repositories**: Open-source contributions and public projects

> **Note**: Repository counts are automatically updated each time the analysis script runs, ensuring documentation always reflects the current state of the portfolio.

## 🔍 check-forks.ps1

A PowerShell script that dynamically fetches and analyzes all repositories from the GitHub API to differentiate between original work and community contributions (forks).

### Features
- **Dynamic Repository Discovery**: Automatically fetches all repositories from GitHub API (no hardcoded lists!)
- **Fork Detection**: Identifies which repositories are forks vs original work
- **Parent Repository Info**: Shows the source repository for forks with full parent names
- **Comprehensive JSON Export**: Exports detailed analysis with all data needed for REPOS.md updates
- **Repository Categorization**: Automatically categorizes repositories into appropriate sections
- **Language Statistics**: Calculates programming language distribution and percentages
- **REPOS.md Formatting**: Provides pre-formatted data for easy documentation updates
- **Error Handling**: Gracefully handles authentication issues and missing repositories
- **Color-Coded Output**: Visual distinction between different repository types
- **Live Data**: Always reflects current repository state from GitHub API
- **Error Handling**: Gracefully handles authentication issues and missing repositories
- **Color-Coded Output**: Visual distinction between different repository types
- **Always Current**: No maintenance needed for repository lists - always reflects latest portfolio

### Usage

#### Run Repository Analysis
```powershell
.\check-forks.ps1
```

The script automatically:
- Fetches all repositories from GitHub API
- Analyzes fork status and parent relationships
- Displays color-coded console output
- **Always saves comprehensive JSON export** for automation

### Output Format
- **Console**: Color-coded summary with clear categorization and live repository count
- **JSON Export**: **Always created** - Comprehensive analysis including:
  - Repository categorization for each section of REPOS.md
  - Language distribution with percentages
  - Pre-formatted table headers and statistics
  - Complete repository metadata (description, language, dates, visibility)
  - Mermaid chart data for language distribution
  - REPOS.md-ready formatting strings
- **Repository Categories**: Clear distinction between 🏠 Original and 🍴 Fork repositories
- **Parent Information**: Shows fork relationships (e.g., `omi ← BasedHardware/omi`)

### Use Cases
1. **Repository Auditing**: Regular checks to maintain accurate portfolio documentation
2. **Profile Updates**: Ensuring REPOS.md reflects current repository status and types
3. **Analytics**: Understanding the balance between original work and community engagement
4. **Data Export**: Feeding repository data into other tools, reports, or analysis systems
5. **Documentation Maintenance**: Keeping the Type column in REPOS.md accurate
6. **Portfolio Growth Tracking**: Automatically detect new repositories as they're created

### Requirements
- **GitHub CLI**: `gh` installed and authenticated
- **PowerShell**: Version 5.1 or later
- **Authentication**: GitHub SSO access to fabioc-aloha repositories
- **Internet Connection**: Active connection for GitHub API access
- **Permissions**: Read access to repository metadata and fork information

### Setup Instructions
1. Install GitHub CLI: https://cli.github.com/
2. Authenticate with GitHub: `gh auth login`
3. Configure SSO access for organization repositories
4. Verify access: `gh repo list --limit 1`

### Sample Output
```
🔍 Fetching repository list from GitHub API...
============================================================
📡 Connecting to GitHub API...
✅ Found 44 repositories

🔍 Checking fork status for all repositories...
============================================================

🏠 ORIGINAL REPOSITORIES (35):
  • Catalyst-NEWBORN
  • Alex-Cognitive-Architecture-Paper
  • mdword
  • papercopilot
  • Catalyst-DBA
  ...

🍴 FORKED REPOSITORIES (9):
  • agent-zero ← facebookresearch/agent-zero
  • omi ← BasedHardware/omi
  • mcpservers ← modelcontextprotocol/servers
  • ai-agents-for-beginners ← microsoft/ai-agents-for-beginners
  ...

✅ Analysis complete!
📊 Analyzed 42 repositories dynamically fetched from GitHub API
� Statistics: 35 Original | 9 Forks | 22 Private | 20 Public
�📋 Use this information to update REPOS.md with accurate fork status and categories
📄 Comprehensive analysis saved to repo-analysis.json for automation
```

## 📝 REPOS.md Structure

The main repository portfolio file follows this structure:

### Header Section
- Portfolio title and description
- Statistics summary (Original/Fork breakdown, Public/Private counts)
- Quick overview of the 42-repository ecosystem

### Repository Categories
1. **🧠 Core Cognitive Architecture Suite** - Catalyst frameworks and Alex systems
2. **📝 Academic & Research Tools** - MdWord, PaperCopilot, research utilities
3. **🤖 AI & Machine Learning Projects** - Both original AI work and community forks
4. **💼 Business Intelligence & Analytics** - Financial tools and enterprise analytics
5. **🎵 Entertainment & Creative Projects** - Spotify integration, creative coding
6. **🛠️ Development Tools & Utilities** - Logo scrapers, wallpaper tools, utilities
7. **🏢 Enterprise & Microsoft Projects** - Internal Microsoft tools and integrations
8. **📚 Learning & Education** - Educational materials and coursework
9. **🌟 Profile & Portfolio** - GitHub profile repository

### Table Structure
Each repository table includes:
- **Repository**: Name with GitHub link
- **Type**: 🏠 Original or 🍴 Fork designation
- **Visibility**: 🌐 Public, 🔒 Private, or 🌟 Public (featured)
- **Language**: Primary programming language
- **Description**: Brief project description
- **Last Updated**: Most recent activity date

## 🔄 Maintenance Workflow

### Regular Updates
1. **Run Analysis**: Execute `.\check-forks.ps1` to get current repository status
2. **Compare Results**: Check against existing REPOS.md for any changes
3. **Update Documentation**: Modify REPOS.md if repository types have changed
4. **Backup**: Always create backup before major changes (`copy-item .\REPOS.md .\REPOS-back.md`)
5. **Commit Changes**: Use descriptive commit messages for portfolio updates

### When to Update
- **New Repository Creation**: Add to appropriate category with correct type
- **Repository Forking**: Change type from 🏠 Original to 🍴 Fork if needed
- **Visibility Changes**: Update privacy status when repositories become public/private
- **Monthly Reviews**: Regular audits to ensure accuracy and completeness

### Error Recovery
- **Backup Files**: REPOS-back.md serves as restoration point
- **Git History**: Use git to revert corrupted files
- **Script Validation**: Always test script changes before applying to documentation

## 🎯 Best Practices

### Documentation Standards
- **Consistent Formatting**: Maintain table structure and emoji usage
- **Accurate Categorization**: Ensure repositories are in appropriate sections
- **Clear Descriptions**: Write concise but informative repository descriptions
- **Regular Updates**: Keep last updated dates current

### Repository Management
- **Type Accuracy**: Correctly identify original work vs community contributions
- **Visibility Tracking**: Monitor public/private status changes
- **Parent Attribution**: Credit original repositories for forks
- **Comprehensive Coverage**: Include all repositories in the portfolio

This documentation system ensures the repository portfolio remains accurate, comprehensive, and professionally presented while providing tools for ongoing maintenance and analysis.
