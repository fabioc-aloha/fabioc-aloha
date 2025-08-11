# Repository Update Workflow

## 🧠 **Simple Collaborative Process**

When you want to update your repository documentation, just ask me to **"update repos"** and I'll handle everything automatically.

### **The Workflow:**

1. **You say**: *"Update my repos"* or *"Refresh repository documentation"*

2. **I will**:
   - Run `.\check-forks.ps1` to analyze your current GitHub portfolio
   - Use the JSON output to update `REPOS.md` with current data
   - Update `README.md` statistics if repository counts changed
   - Show you what was updated

3. **You review and commit** the changes when ready

---

## 🛠️ **What the Script Does**

`check-forks.ps1` automatically:
- ✅ Fetches all repositories from GitHub API (no hardcoded lists)
- ✅ Identifies original work vs community forks
- ✅ Categorizes repositories into appropriate sections
- ✅ Calculates language distribution and statistics
- ✅ Exports clean JSON data for documentation updates
- ✅ Always reflects your current portfolio state

---

## � **Current Portfolio Structure**

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
