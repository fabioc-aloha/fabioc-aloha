# 🤖 GitHub Actions Automation Guide

## Overview

Your portfolio automatically updates itself using GitHub Actions! The workflow runs daily and whenever you push changes to the automation scripts.

## How It Works

### 🔄 Automatic Triggers

1. **Daily Schedule**: Runs every day at 6 AM UTC
2. **Manual Trigger**: You can run it manually from the Actions tab
3. **Code Changes**: Runs when you update any automation scripts

### 📋 What Happens Automatically

1. **Repository Analysis** (`check-forks.ps1`)
   - Scans all your GitHub repositories via API
   - Collects metadata (descriptions, languages, dates)
   - Identifies forks and their parent repositories
   - Generates `repo-analysis.json`

2. **Documentation Update** (`auto-update-repos.ps1`)
   - Categorizes repositories into 9 groups
   - Updates `REPOS.md` with current data
   - Generates statistics and visualizations
   - All data pulled from GitHub API (no hardcoded content)

3. **Pull Request Creation**
   - Creates a timestamped branch
   - Commits all changes
   - Opens a PR with detailed summary
   - Labels it for easy identification

4. **Auto-Merge** (enabled by default)
   - Automatically merges the PR when created
   - Deletes the branch after merge
   - Keeps your main branch clean and current
   - Zero manual intervention required

## 🚀 Setup Instructions

### Prerequisites

1. **GitHub Repository Settings**
   - Go to Settings → Actions → General
   - Under "Workflow permissions":
     - ✅ Select "Read and write permissions"
     - ✅ Check "Allow GitHub Actions to create and approve pull requests"

2. **Optional: Personal Access Token (PAT)**
   - **When needed**: Private repositories or enhanced permissions
   - **Create PAT**:
     1. Go to GitHub → Settings → Developer settings
     2. Choose "Personal access tokens" → "Tokens (classic)"
     3. Click "Generate new token (classic)"
     4. Select scopes:
        - `repo` (Full control of private repositories)
        - `workflow` (Update GitHub Action workflows)
   - **Add to repository**:
     1. Go to your repo → Settings → Secrets and variables → Actions
     2. Click "New repository secret"
     3. Name: `PAT_TOKEN`
     4. Value: Paste your token
   - **Verify**: Workflow will use `PAT_TOKEN` if available, otherwise falls back to `GITHUB_TOKEN`

### Enable the Workflow

The workflow is already configured in `.github/workflows/update-repos.yml`!

**To enable it:**
1. Commit the workflow file to your repository
2. Push to GitHub
3. Go to Actions tab and enable workflows if prompted

## 📊 How to Use

### View Workflow Runs

1. Go to your repository on GitHub
2. Click the **Actions** tab
3. See all workflow runs with status indicators

### Manual Trigger

1. Go to Actions tab
2. Click "🤖 Daily Repository Analysis Update"
3. Click "Run workflow" button
4. Select branch (usually `main`)
5. Click green "Run workflow" button

### Review Automated PRs

1. Go to Pull Requests tab
2. Look for PRs labeled `automation`, `daily-update`, `alex-finch`
3. PRs will **auto-merge automatically** after creation
4. Check merge history to see completed updates

> **Note**: Auto-merge is enabled by default. PRs are automatically merged and branches deleted without manual intervention.

## 🎯 What Gets Updated

### Files Changed by Automation

- ✅ `repo-analysis.json` - Raw GitHub API data
- ✅ `REPOS.md` - Portfolio documentation
- ✅ `REPO-MANAGEMENT.md` - Statistics and management info
- ✅ `README.md` - Main profile (if counts change)

### Files NOT Changed

- ❌ `.github/MEMORY.md` - Manual updates only
- ❌ `.github/TODO.md` - Manual updates only
- ❌ Repository descriptions on GitHub - Read-only access

## 🛠️ Customization Options

### Change Schedule

Edit `.github/workflows/update-repos.yml`:

```yaml
on:
  schedule:
    # Run daily at 6 AM UTC
    - cron: '0 6 * * *'
```

Cron syntax:
- `'0 6 * * *'` - Daily at 6 AM UTC
- `'0 */6 * * *'` - Every 6 hours
- `'0 0 * * 1'` - Weekly on Monday at midnight
- `'0 0 1 * *'` - Monthly on the 1st

### Disable Auto-Merge

Auto-merge is **enabled by default** for hands-free operation. To disable and require manual merging:

1. Open `.github/workflows/update-repos.yml`
2. Find the "Auto-merge Pull Request" step (around line 179)
3. Comment out or remove the entire step
4. Commit and push the change

After disabling, PRs will be created but require manual review and merging.

### Change Branch Naming

Edit the branch creation line:

```powershell
$branch = "daily-repo-update-$timestamp"
```

## 🔍 Monitoring & Troubleshooting

### Check Workflow Status

**Green checkmark (✅)**: Success - changes detected and PR created
**Green checkmark with "No changes"**: Success - everything up to date
**Red X (❌)**: Failure - check logs for details

### Common Issues

#### ❌ "PR creation failed (likely due to permissions)"

**Solution**: Enable workflow permissions in repository settings (see Setup Instructions above)

#### ❌ "Authentication failed"

**Solution**:
- Check if GitHub CLI is authenticated
- For private repos, add `PAT_TOKEN` secret
- Verify token has `repo` and `workflow` scopes

#### ❌ "No changes detected but I added repositories"

**Solution**:
- Wait 24 hours for next scheduled run
- Or trigger manually from Actions tab
- New repos may not show immediately in API

### View Detailed Logs

1. Go to Actions tab
2. Click on a workflow run
3. Click on the job name
4. Expand steps to see detailed output

## 📚 Related Documentation

- **[WORKFLOW-GUIDE.md](WORKFLOW-GUIDE.md)** - Local workflow commands
- **[REPO-MANAGEMENT.md](REPO-MANAGEMENT.md)** - Repository management best practices
- **[.github/MEMORY.md](.github/MEMORY.md)** - Project decisions and history

## 🎉 Benefits of Automation

✅ **Always Current**: Portfolio updates daily without manual work
✅ **No Maintenance**: Scripts run automatically in the cloud
✅ **Auto-Merge Enabled**: Changes automatically merged without review needed
✅ **Completely Hands-Free**: Zero manual intervention from PR creation to merge
✅ **Audit Trail**: Complete history of all updates
✅ **Zero Downtime**: Updates happen in background
✅ **Data-Driven**: Pure GitHub API data, no hardcoded content---

*🤖 Powered by GitHub Actions and Alex Finch cognitive architecture*
