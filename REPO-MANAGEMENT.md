# Repository Management Scripts

This directory contains utility scripts for managing and analyzing the GitHub repository portfolio.

## 🔍 check-forks.ps1

A PowerShell script that analyzes all repositories to differentiate between original work and community contributions (forks).

### Features
- **Fork Detection**: Identifies which repositories are forks vs original work
- **Parent Repository Info**: Shows the source repository for forks
- **Export Capabilities**: Can export detailed analysis to JSON
- **Comprehensive Data**: Retrieves language, visibility, description, and update info
- **Error Handling**: Gracefully handles authentication issues and missing repos

### Usage

#### Basic Analysis
```powershell
.\check-forks.ps1
```

#### Export Detailed Analysis
```powershell
.\check-forks.ps1 -ExportJSON
```

### Output
- **Console**: Color-coded summary of original vs forked repositories
- **JSON Export**: Detailed repository information including metadata
- **Repository Categories**: Clear distinction between 🏠 Original and 🍴 Fork repos

### Use Cases
1. **Repository Auditing**: Regular checks to maintain accurate portfolio documentation
2. **Profile Updates**: Ensuring REPOS.md reflects current repository status
3. **Analytics**: Understanding the balance between original work and community engagement
4. **Data Export**: Feeding repository data into other tools or reports

### Requirements
- GitHub CLI (`gh`) installed and authenticated
- PowerShell 5.1 or later
- Access to fabioc-aloha repositories (SSO authentication)

### Output Example
```
🔍 Checking fork status for all repositories...
============================================================

🏠 ORIGINAL REPOSITORIES (35):
  • Catalyst-NEWBORN
  • Alex-Cognitive-Architecture-Paper
  • mdword
  ...

🍴 FORKED REPOSITORIES (9):
  • agent-zero ← facebookresearch/agent-zero
  • omi ← BasedHardware/omi
  • mcpservers ← modelcontextprotocol/servers
  ...
```

This script is essential for maintaining the accuracy of the repository portfolio and ensuring proper categorization in documentation.
