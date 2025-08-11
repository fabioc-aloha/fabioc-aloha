# 🤖 Claude Sonnet 4 Integration Setup Guide (Alternative AI Option)

## Overview

This guide will help you integrate Claude Sonnet 4 as an **alternative AI option** for your GitHub portfolio automation.

> 💡 **Note**: By default, the workflow uses **GPT-4o** which works out-of-the-box. This guide is for users who want to use Claude Sonnet 4 instead.

## 🎯 What You'll Get with Claude

✅ **AI-Enhanced Descriptions**: Professional, technical repository descriptions
✅ **Consistent Tone**: Unified voice across your entire portfolio
✅ **Technical Insights**: Automatic technology stack identification
✅ **Smart Fallback**: Continues with original data if Claude fails
✅ **Cost Efficient**: Only calls API when repository data changes (~$0.001-0.003 per repo)

## 📋 Prerequisites

- ✅ Working GitHub portfolio automation (see `TEMPLATE-SETUP.md`)
- ✅ Anthropic account with API access
- ✅ Repository secrets access

## 🚀 Step-by-Step Setup

### Step 1: Create Anthropic Account & API Key

1. **Visit Anthropic Console**
   - Go to: https://console.anthropic.com/
   - Sign up or sign in to your account

2. **Generate API Key**
   - Navigate to **"API Keys"** in the dashboard
   - Click **"Create Key"**
   - Name: `github-automation-claude`
   - Copy the key (starts with `sk-ant-`)
   - ⚠️ **Important**: Save this key securely - you won't see it again!

### Step 2: Add Repository Secret

1. **Navigate to Repository Secrets**
   ```
   https://github.com/[your-username]/[your-repo]/settings/secrets/actions
   ```

2. **Create New Secret**
   - Click **"New repository secret"**
   - **Name**: `CLAUDE_API_KEY`
   - **Secret**: Paste your Claude API key
   - Click **"Add secret"**

### Step 3: Test Integration

#### Option A: Manual Trigger with Claude
```powershell
gh workflow run "🤖 Daily Repository Analysis Update" --ref main -f llm_model=claude-sonnet-4
```

#### Option B: Manual Trigger without AI
```powershell
gh workflow run "🤖 Daily Repository Analysis Update" --ref main -f llm_model=skip-llm
```

#### Option C: Test Claude Script Locally
```powershell
# Set API key temporarily
$env:CLAUDE_API_KEY = "your-api-key-here"

# Run enhancement script
.\enhance-with-claude.ps1
```

### Step 4: Verify Setup

1. **Check Workflow Run**
   - Go to: `https://github.com/[your-username]/[your-repo]/actions`
   - Look for the latest "🤖 Daily Repository Analysis Update" run
   - Check for: `🤖 Enhance with Claude Sonnet 4` step

2. **Success Indicators**
   ```
   🔑 Claude API key found, proceeding with enhancement...
   🌐 Calling Claude API...
   ✅ Repository descriptions enhanced with Claude Sonnet 4!
   📈 Enhanced X repository descriptions
   ```

3. **Review Enhanced Content**
   - Check the generated PR for improved repository descriptions
   - Look for professional, technical language in repo descriptions

## ⚙️ Configuration Options

### Daily Automation (Default)
- **Schedule**: Runs daily at 6 AM UTC with Claude enhancement
- **Model**: Claude Sonnet 4 by default when scheduled
- **Enhancement**: Automatic when repository data changes

### Manual Control
- **LLM Selection**: Choose `claude-sonnet-4`, `gpt-4o`, or `skip-llm`
- **On-Demand**: Trigger workflows manually with specific LLM models
- **Fallback**: Continues with original data if Claude fails

## 💰 Cost Management

### Typical Usage
- **Per Analysis**: ~1,000-3,000 tokens
- **Daily Cost**: ~$0.01-0.05 USD
- **Monthly Cost**: ~$0.30-1.50 USD

### Monitor Usage
- Check your usage at: https://console.anthropic.com/usage
- Set up billing alerts in your Anthropic account
- API calls are only made when repository data changes

## 🔧 How It Works

### Enhancement Process
1. **Repository Analysis**: Standard scripts gather latest data
2. **Claude Processing**: AI analyzes and enhances descriptions
3. **Data Validation**: Ensures JSON structure integrity
4. **Fallback Safety**: Preserves original data if Claude fails
5. **Integration**: Enhanced data flows into normal PR process

### Claude Prompting
The script uses optimized prompts that instruct Claude to:
- Maintain professional, technical language
- Focus on purpose, technology stack, and use case
- Keep descriptions concise but informative
- Distinguish between original projects and forks
- Ensure consistency across all repositories

## 🛠️ Troubleshooting

### Common Issues

#### ❌ "CLAUDE_API_KEY not found"
**Solution**: Add the secret to repository settings
```
Repository → Settings → Secrets and variables → Actions → New repository secret
```

#### ❌ "Claude API call failed: 401 Unauthorized"
**Solutions**:
- Verify API key is correct (starts with `sk-ant-`)
- Check if API key has expired
- Ensure sufficient credits in Anthropic account

#### ❌ "Invalid JSON structure from Claude"
**Solutions**:
- This is usually temporary - Claude will retry on next run
- Original repository data is preserved
- Check Anthropic status page for service issues

#### ❌ "Empty response from Claude"
**Solutions**:
- May indicate rate limiting or service issues
- Workflow continues with original data
- Try running again in a few minutes

### Debug Commands

```powershell
# Check if secret exists (will show masked value)
gh secret list

# View workflow logs
gh run list --workflow="update-repos.yml"
gh run view [RUN_ID] --log

# Test Claude script locally
$env:CLAUDE_API_KEY = "your-key"
.\enhance-with-claude.ps1
```

## 🎯 Before & After Examples

### Repository Descriptions

#### Before (Original)
```
"A simple web app"
"Machine learning project"
"Fork of popular-repo"
```

#### After (Claude Enhanced)
```
"A responsive React.js web application with Node.js backend, featuring user authentication and real-time data visualization"
"A Python-based machine learning pipeline using TensorFlow for predictive analytics with automated model training and evaluation"
"Fork of popular-repo with custom authentication middleware and enhanced API endpoints for enterprise deployment"
```

### Technical Insights
- **Automatic Technology Detection**: Identifies frameworks, languages, and tools
- **Professional Language**: Uses appropriate technical terminology
- **Value Proposition**: Explains what the project does and why it matters
- **Consistency**: Maintains uniform tone across all repositories

## 🔄 Daily Workflow Process

1. **6 AM UTC**: Workflow runs automatically
2. **Repository Analysis**: Scripts gather latest data
3. **Claude Enhancement**: AI improves descriptions (if enabled)
4. **Data Validation**: Ensures quality and structure
5. **Timestamp Update**: Last updated time refreshed
6. **PR Creation**: Changes submitted for review
7. **Auto-merge**: PR merges automatically if validation passes

## 🎉 Success!

Your repository automation now includes AI-powered content enhancement! Claude Sonnet 4 will:

- ✅ **Analyze** your repositories for technical insights
- ✅ **Enhance** descriptions with professional language
- ✅ **Maintain** consistency across your portfolio
- ✅ **Provide** technical context and value propositions
- ✅ **Save** you hours of manual description writing

Your GitHub portfolio will now automatically maintain professional, AI-enhanced descriptions that accurately represent your technical work and expertise!

## 🔗 Related Documentation

- **[Template Setup](TEMPLATE-SETUP.md)**: Complete automation setup
- **[Troubleshooting](TROUBLESHOOTING.md)**: PAT token and workflow issues
- **[Contributing](CONTRIBUTING.md)**: How to improve this template

---

**Need help?** Check the troubleshooting section above or create an issue in the repository.
