# 🚀 Template Setup Guide

Transform this into your professional GitHub portfolio with a cognitive architecture AI assistant in under 10 minutes!

## 🎯 What You'll Get

✅ **Automated portfolio**: Script generates your repository showcase
✅ **Professional README**: Ready-to-use profile with stats and badges
✅ **Repository management**: Organized, categorized project listings
✅ **AI-powered maintenance**: Alex Finch assistant for streamlined updates
✅ **Cognitive architecture**: Structured memory system for project tracking
✅ **Easy maintenance**: One command updates everything
✅ **Optional automation**: Complete hands-off daily updates (5-minute setup)

## 🏃‍♂️ Quick Start

**First time here?** Choose your path:

### 🆕 Creating Your Portfolio
1. Click the green **"Use this template"** button above
2. Name your new repository: `[your-username]/[your-username]`
   > 💡 This special naming creates your GitHub profile README
3. Set to **Public** (required for profile)
4. Click **"Create repository from template"**
5. Clone your new repository locally
   ```bash
   gh repo clone [your-username]/[your-username]
   cd [your-username]
   ```

> 🎯 **You'll get**: Automated portfolio system + AI assistant with cognitive architecture

### 🤝 Contributing Improvements
1. Click **"Fork"** → **"Create fork"**
2. Clone locally and make improvements
3. Submit pull requests to help others

## ⚡ Setup (4 easy steps)

### Step 1: Install GitHub CLI
**Windows:**
```bash
winget install GitHub.cli
```
**Mac/Linux:** Download from [cli.github.com](https://cli.github.com/)

Then authenticate:
```bash
gh auth login
```

### Step 2: Configure AI Assistant (New!)
The template includes Alex Finch, your AI assistant with a cognitive architecture system:

**Key files to understand:**
- 📋 `.github/copilot-instructions.md` - AI assistant behavior and guidelines (optimized for easy parsing)
- 🧠 `.github/MEMORY.md` - Project decisions and context (enhanced with bold categorization)
- ✅ `.github/TODO.md` - Task tracking and priorities
- 🔄 `COGNITIVE.md` - How the AI system works (includes architecture diagrams)

> 💡 **Pro tip**: These files work together as a "brain" for your AI assistant, keeping everything organized!
### Step 3: Make It Yours
**Required changes:**
- 🖼️ Replace `ALEX-CODING.png` with your banner image
- 📝 Edit `README.md` - update name, bio, skills, contact info
- 🏷️ Update repository descriptions to match your projects
- 🤖 Customize `.github/copilot-instructions.md` with your name and preferences

**Optional (but recommended):**
- 📂 Customize categories in `check-forks.ps1` to match your work
- 🧠 Update `.github/MEMORY.md` with your project history and decisions

### Step 4: Generate Your Portfolio
```powershell
.\check-forks.ps1
```
🎉 **That's it!** This creates `repo-analysis.json` with all your repository data.

## 🛠️ Customization Made Easy

### 🤖 AI Assistant Configuration
Want to customize Alex Finch for your needs? Edit `.github/copilot-instructions.md`:

```markdown
## Identity & Introduction
- **ALWAYS** introduce yourself as "[Your Name]" when asked for your name
- Act as a knowledgeable repo manager with expertise in [your domain]

## Behaviors
- **Name**: When asked for your name, respond with "[Your Name]"
- **Response style**: Keep responses short, skimmable, and impersonal
```

### 🧠 Memory System Customization
The cognitive architecture uses three memory types:

1. **Working Memory** (`.github/copilot-instructions.md`): How your AI behaves
2. **Long-term Memory** (`.github/MEMORY.md`): Project decisions and history
3. **Task Memory** (`.github/TODO.md`): Current priorities and acceptance criteria

> 📚 **Learn more**: Read `COGNITIVE.md` for the complete system overview

### 📂 Repository Categories
Want custom categories? Edit the patterns in `check-forks.ps1`:

```powershell
switch -Regex ($repo.name) {
    "^api|^service" { $category = "Backend Services" }
    "^ui|^web|^frontend" { $category = "Frontend Projects" }
    "^ml|^ai|^data" { $category = "Data Science & AI" }
    "^tool|^util" { $category = "Tools & Utilities" }
    # Add your own patterns here
}
```

### 🏅 Skill Badges
Add your expertise to `README.md`:
```markdown
<img src="https://img.shields.io/badge/Python-Expert-green"/>
<img src="https://img.shields.io/badge/JavaScript-Advanced-blue"/>
<img src="https://img.shields.io/badge/Machine%20Learning-Specialist-orange"/>
```

## 📁 What Each File Does

| File | Purpose | Action Needed |
|------|---------|---------------|
| `README.md` | Your main profile page | ✏️ **Customize heavily** |
| `REPOS.md` | Detailed project showcase | 📝 Update descriptions |
| `check-forks.ps1` | Magic automation script | ▶️ Just run it |
| `repo-analysis.json` | Generated portfolio data | 🤖 Auto-created |
| `[your-banner].png` | Profile header image | 🖼️ Replace with yours |
| **Cognitive Architecture Files** | | |
| `.github/copilot-instructions.md` | AI assistant behavior (enhanced) | 🤖 Customize for your needs |
| `.github/MEMORY.md` | Project memory & decisions (optimized) | 📝 Update with your context |
| `.github/TODO.md` | Task tracking system | ✅ Add your priorities |
| `COGNITIVE.md` | System documentation | 📚 Reference guide |
| `PAPER.md` | Academic research paper | 📄 Optional reading |

## 🔄 Keeping It Fresh

### Monthly Refresh
```powershell
.\check-forks.ps1
```
> 🔄 Updates all your repository stats and data

### As You Build
- 📝 Update project descriptions in `REPOS.md`
- 🆕 Add new repositories and they'll auto-appear
- 🏷️ Use clear, searchable repository names

## 🤖 Optional: Complete Automation Setup

Want your portfolio to maintain itself? Set up **daily automated updates** that handle everything without manual intervention!

### 🎯 What Automation Provides

✅ **Daily repository scanning** (runs at 6 AM UTC)
✅ **Automatic data updates** (repo counts, statistics, timestamps)
✅ **Auto-generated pull requests** with detailed change summaries
✅ **Automatic merging** when validation passes
✅ **Zero maintenance required** - completely hands-off operation

### 🔧 Automation Setup (One-time, 5 minutes)

#### Step 1: Create Personal Access Token
1. **Visit**: https://github.com/settings/personal-access-tokens/new
2. **Configure**:
   - **Name**: `portfolio-automation`
   - **Expiration**: `90 days`
   - **Repository access**: Selected repositories → Your portfolio repo
   - **Permissions**:
     - Contents: `Write` ✅
     - Pull requests: `Write` ✅
     - Metadata: `Read` ✅
     - Actions: `Read` ✅
3. **Generate token** and copy the value

#### Step 2: Add Repository Secret
1. **Visit**: `https://github.com/[USERNAME]/[USERNAME]/settings/secrets/actions`
2. **Click**: "New repository secret"
3. **Name**: `PAT_TOKEN`
4. **Secret**: Paste your token
5. **Save**: Click "Add secret"

#### Step 3: Enable Auto-merge
1. **Visit**: `https://github.com/[USERNAME]/[USERNAME]/settings`
2. **Find**: "Pull Requests" section
3. **Enable**: ✅ "Allow auto-merge"
4. **Save**: Settings are saved automatically

#### Step 4: Setup Branch Protection (Optional)
1. **Visit**: `https://github.com/[USERNAME]/[USERNAME]/settings/branch_protection_rules/new`
2. **Branch pattern**: `main`
3. **Click**: "Create" (minimal settings work fine)

### 🚀 Testing Your Automation

```bash
# Manually trigger the workflow to test
gh workflow run "🤖 Daily Repository Analysis Update" --ref main

# Check if it worked
gh run list --workflow=update-repos.yml --limit 1

# View any created PRs
gh pr list
```

**Success indicators:**
- ✅ Workflow shows ✅ (green checkmark)
- ✅ PR gets created automatically
- ✅ PR merges automatically
- ✅ Repository data stays current

### 📅 What Happens Daily

Every morning at 6 AM UTC:
1. 🔍 **Scans** all your repositories
2. 📊 **Updates** statistics and timestamps
3. 🌿 **Creates** branch with changes (if any)
4. 📋 **Generates** detailed PR with Alex Finch integration
5. ✅ **Auto-merges** PR when validation passes
6. 🗑️ **Cleans up** temporary branches

### 🛠️ Troubleshooting Automation

**Workflow fails with permission errors:**
- Check PAT_TOKEN secret exists and has correct permissions

**PR created but doesn't auto-merge:**
- Verify "Allow auto-merge" is enabled in repository settings
- Check branch protection rules are configured

**No changes detected:**
- Normal behavior - automation only creates PRs when data changes

**Need help?**
- Check the troubleshooting guides: `PAT-VERIFICATION.md` and `TROUBLESHOOTING.md`

> 💡 **Pro tip**: Automation is completely optional. Your portfolio works perfectly with manual updates using `check-forks.ps1`!

## 💡 Pro Tips

🎯 **Repository naming**: Use descriptive names like `ai-chatbot` not `project1`
📸 **Banner image**: Keep under 1MB, use 1200x400px for best results
🔍 **SEO friendly**: Include tech keywords in descriptions
📊 **GitHub stats**: Set repositories to Public to show in your stats
🤖 **AI assistant**: Use "meditate" command to consolidate insights and verify consistency
📝 **Memory management**: Update `.github/MEMORY.md` with key decisions and `.github/TODO.md` with priorities
⚙️ **AI customization**: Modify `.github/copilot-instructions.md` to match your working style
🔄 **Automation**: Run `check-forks.ps1` weekly to keep portfolio data fresh

## 🆘 Need Help?

**Script not working?**
```bash
gh auth status  # Check if you're logged in
```

**PowerShell blocked?**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Still stuck?**
- 📋 Check the [Issues](../../issues) section
- 📚 Review `REPO-MANAGEMENT.md` for detailed guidance
- 🔍 Search existing solutions before creating new issues

---

💫 **Ready to build something amazing?** Your portfolio is just three steps away!
