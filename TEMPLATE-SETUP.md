# 🚀 Template Setup Guide

Transform this into your professional GitHub portfolio in under 10 minutes!

## 🎯 What You'll Get

✅ **Automated portfolio**: Script generates your repository showcase
✅ **Professional README**: Ready-to-use profile with stats and badges
✅ **Repository management**: Organized, categorized project listings
✅ **Easy maintenance**: One command updates everything

## 🏃‍♂️ Quick Start

**First time here?** Choose your path:

### 🆕 Creating Your Portfolio
1. Click the green **"Use this template"** button above
2. Name your new repository: `[your-username]/[your-username]`
   > 💡 This special naming creates your GitHub profile README
3. Set to **Public** (required for profile)
4. Click **"Create repository"**

### 🤝 Contributing Improvements
1. Click **"Fork"** → **"Create fork"**
2. Clone locally and make improvements
3. Submit pull requests to help others

## ⚡ Setup (3 easy steps)

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

### Step 2: Make It Yours
**Required changes:**
- 🖼️ Replace `ALEX-CODING.png` with your banner image
- 📝 Edit `README.md` - update name, bio, skills, contact info
- 🏷️ Update repository descriptions to match your projects

**Optional (but recommended):**
- 📂 Customize categories in `check-forks.ps1` to match your work

### Step 3: Generate Your Portfolio
```powershell
.\check-forks.ps1
```
🎉 **That's it!** This creates `repo-analysis.json` with all your repository data.

## 🛠️ Customization Made Easy

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

## 💡 Pro Tips

🎯 **Repository naming**: Use descriptive names like `ai-chatbot` not `project1`
📸 **Banner image**: Keep under 1MB, use 1200x400px for best results
🔍 **SEO friendly**: Include tech keywords in descriptions
📊 **GitHub stats**: Set repositories to Public to show in your stats

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
