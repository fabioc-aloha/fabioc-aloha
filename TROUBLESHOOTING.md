# 🔧 PAT Token Troubleshooting - Step by Step

## 🎯 Current Situation
- ✅ Workflow runs successfully
- ✅ Auto-merge functionality is coded correctly
- ❌ Still using `github-actions[bot]` account (should be your username)
- ❌ PR creation fails with permission errors

**This means: PAT token is either missing or not configured correctly**

## 📋 Simple 5-Step Fix

### Step 1: Check if PAT Secret Exists
**Click this link:** https://github.com/fabioc-aloha/fabioc-aloha/settings/secrets/actions

**What to look for:**
- Do you see `PAT_TOKEN` in the list?
  - ✅ **YES** → Go to Step 2
  - ❌ **NO** → Go to Step 3

### Step 2: Test Current Setup (If PAT_TOKEN exists)
```powershell
# Run a test workflow
gh workflow run "🤖 Daily Repository Analysis Update" --ref main

# Wait 30 seconds, then check logs for this message:
gh run view --log $(gh run list --workflow=update-repos.yml --limit 1 --json databaseId --jq '.[0].databaseId') | Select-String "PAT_TOKEN found"
```

**Results:**
- ✅ **See "PAT_TOKEN found"** → PAT is working, problem elsewhere
- ❌ **See "PAT_TOKEN secret not found"** → Secret exists but token is invalid
- ❌ **No message at all** → Go to Step 4 (workflow issue)

### Step 3: Create PAT Token and Secret (If PAT_TOKEN missing)

#### 3a. Create Personal Access Token
1. **Visit:** https://github.com/settings/personal-access-tokens/new
2. **Fill out:**
   - **Token name:** `fabioc-aloha-automation`
   - **Expiration:** `90 days`
   - **Repository access:** Click "Selected repositories" → Choose `fabioc-aloha`

3. **Set Permissions:**
   - **Contents:** `Write` ✅
   - **Pull requests:** `Write` ✅
   - **Metadata:** `Read` ✅
   - **Actions:** `Read` ✅

4. **Click:** "Generate token"
5. **Copy** the token (starts with `github_pat_`)

#### 3b. Add Repository Secret
1. **Visit:** https://github.com/fabioc-aloha/fabioc-aloha/settings/secrets/actions
2. **Click:** "New repository secret"
3. **Name:** `PAT_TOKEN` (exactly this, case-sensitive)
4. **Secret:** Paste your token
5. **Click:** "Add secret"

### Step 4: Quick Verification Test
```powershell
# Test the automation
gh workflow run "🤖 Daily Repository Analysis Update" --ref main

# Check if it worked (wait 30 seconds first)
gh run list --workflow=update-repos.yml --limit 1
```

**Success indicators:**
- Status shows ✅ (green checkmark), not ❌ (red X)
- PR gets created automatically
- Auth shows your username, not `github-actions[bot]`

### Step 5: If Still Not Working

Run this diagnostic command and share the output:

```powershell
# Get detailed workflow logs
$runId = (gh run list --workflow=update-repos.yml --limit 1 --json databaseId --jq '.[0].databaseId')
gh run view --log $runId | Select-String -Pattern "PAT_TOKEN|github-actions|permissions|GraphQL" -Context 1
```

## 🎯 What Success Looks Like

**Before PAT (current state):**
```
✓ Logged in to github.com account github-actions[bot] (GH_TOKEN)
pull request create failed: GraphQL: GitHub Actions is not permitted...
```

**After PAT (success state):**
```
✓ Logged in to github.com account YOUR_USERNAME (GH_TOKEN)
✓ Created pull request #X
✓ Auto-merge enabled for PR #X
```

## 🆘 Still Confused?

If you're still stuck, run this and share the output:

```powershell
# Show current auth status
gh auth status

# Show latest workflow result
gh run list --workflow=update-repos.yml --limit 1

# Show repository secrets (this won't show values, just names)
Start-Process "https://github.com/fabioc-aloha/fabioc-aloha/settings/secrets/actions"
```

Tell me:
1. What you see at the secrets URL
2. The output from `gh auth status`
3. The output from `gh run list`

I'll help you figure out exactly what's wrong!
