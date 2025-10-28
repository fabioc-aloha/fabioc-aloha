# Repository Update Workflow

## 🧠 **Simple Automated Process**

Your repository documentation updates automatically via **GitHub Actions** and can also be triggered manually for instant updates.

### **Automatic Updates (GitHub Actions):**

- **Runs daily** at 6 AM UTC automatically
- **Creates Pull Requests** with documentation updates
- **Auto-merges changes** immediately without manual review
- **Zero manual intervention** required
- **Completely hands-free** operation

### **Manual Updates (Local Command):**

1. **You run**: `.\refresh-repos.ps1`

2. **The automation**:
   - Runs repository analysis to collect current GitHub data
   - Automatically categorizes all repositories using dynamic logic
   - Generates complete updated `REPOS.md` with current statistics
   - Shows you a summary of what was updated

3. **You review and commit** the changes when ready

---

## 🤖 **GitHub Actions Automation**

Your portfolio includes a fully configured GitHub Actions workflow:

- **Daily Schedule**: Automatic updates at 6 AM UTC
- **Auto-Merge Enabled**: PRs are automatically merged after creation
- **Manual Trigger**: Run on-demand from GitHub Actions tab
- **Completely Hands-Free**: Zero manual intervention required
- **Complete Documentation**: See [AUTOMATION-GUIDE.md](AUTOMATION-GUIDE.md) for details

**The workflow is enabled by default** and requires no manual PR merging - everything happens automatically!

---

## 🛠️ **What the Automation Does**

The automated system:
- ✅ Fetches all repositories from GitHub API (no hardcoded lists)
- ✅ Identifies original work vs community forks
- ✅ Automatically categorizes repositories using priority-based logic
- ✅ Calculates language distribution and statistics
- ✅ Generates complete REPOS.md with current data and timestamps
- ✅ Always reflects your current portfolio state
- ✅ Zero manual intervention required

---

## 📁 **Current Portfolio Structure**

Your repositories are organized into these categories:
- **🧠 Core Cognitive Architecture Suite** - Catalyst frameworks and Alex systems
- **📝 Academic & Research Tools** - Research utilities and academic tools
- **🤖 AI & Machine Learning Projects** - AI work and community contributions
- **💼 Business Intelligence & Analytics** - Financial and analytics tools
- **🎵 Entertainment & Creative Projects** - Creative coding and integrations
- **🛠️ Development Tools & Utilities** - Utility scripts and tools
- **🏢 Enterprise & Microsoft Projects** - Internal and enterprise tools
- **📚 Learning & Education** - Educational materials
- **🌟 Profile & Portfolio** - GitHub profile repository

---

## ⚙️ **Requirements**

- GitHub CLI (`gh`) installed and authenticated
- PowerShell 5.1+
- Internet connection for GitHub API access

---

## 🎯 **That's It!**

Just ask me to update your repos and I'll take care of the rest. No complex procedures, no manual steps—just simple collaboration.

*Keep it KISS (Keep It Simple, Stupid)!* 🚀
