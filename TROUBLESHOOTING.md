# 🔧 PAT Token Troubleshooting - Complete Guide

## 🎯 Current Situation
- ✅ Workflow runs successfully
- ✅ Auto-merge functionality is coded correctly
- ❌ Still using `github-actions[bot]` account (should be your username)
- ❌ PR creation fails with permission errors

**This means: PAT token is either missing, expired, or not configured correctly**

## 🚨 Common PAT Generation Issues

### Issue 1: Token Expiration
**Symptom:** Automation worked before, now fails
**Solution:** PAT tokens expire every 90 days
- Check token age in GitHub Settings
- Create new token with same permissions
- Update `PAT_TOKEN` secret

### Issue 2: Insufficient Permissions
**Symptom:** Token exists but workflow fails with "GraphQL: not permitted"
**Required permissions (must have ALL 4):**
- ✅ **Contents**: `Write` (not Read!)
- ✅ **Pull requests**: `Write` (not Read!)
- ✅ **Metadata**: `Read`
- ✅ **Actions**: `Read`

### Issue 3: Wrong Repository Scope
**Symptom:** Token created but workflow can't access repository
**Solution:** Token must have access to your `[username]/[username]` repository specifically
- Don't use "All repositories" (security risk)
- Select "Selected repositories" → Choose your profile repo

### Issue 4: Case-Sensitive Secret Name
**Symptom:** Token created correctly but workflow says "PAT_TOKEN secret not found"
**Solution:** Secret name must be exactly `PAT_TOKEN` (all caps, no spaces)

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
   - **Token name:** `portfolio-automation` (descriptive name)
   - **Expiration:** `90 days` (⚠️ set calendar reminder for renewal)
   - **Repository access:** Click "Selected repositories" → Choose your `[username]/[username]` repo
   - **Description:** (optional) "Automation for GitHub profile portfolio"

3. **Set Permissions (CRITICAL - must have ALL 4):**
   - ✅ **Contents:** `Write` (allows file modifications)
   - ✅ **Pull requests:** `Write` (allows PR creation)
   - ✅ **Metadata:** `Read` (allows repository info access)
   - ✅ **Actions:** `Read` (allows workflow interaction)

4. **Click:** "Generate token"
5. **⚠️ IMPORTANT:** Copy the token immediately (starts with `github_pat_`)
   - You can't see it again after leaving the page
   - Store temporarily in notepad while adding to secrets

#### 3b. Add Repository Secret
1. **Visit:** https://github.com/[your-username]/[your-username]/settings/secrets/actions
2. **Click:** "New repository secret"
3. **Enter EXACTLY:**
   - **Name:** `PAT_TOKEN` (case-sensitive, no spaces)
   - **Secret:** Paste your `github_pat_` token from step 3a
4. **Click:** "Add secret"
5. **Verify:** You should see `PAT_TOKEN` in the secrets list

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

## 🆘 Advanced Diagnostics

### Check Token Validity
```powershell
# Test if GitHub CLI can use your auth
gh auth status

# Check if you can access your repository with current auth
gh repo view [your-username]/[your-username] --json name,owner

# Verify workflow permissions
gh api /repos/[your-username]/[your-username]/actions/permissions
```

### Common Permission Errors and Solutions

**Error:** `GraphQL: GitHub Actions is not permitted to create pull requests`
- **Cause:** Token missing or has insufficient permissions
- **Fix:** Recreate token with `Pull requests: Write` permission

**Error:** `Resource not accessible by integration`
- **Cause:** Token doesn't have access to the repository
- **Fix:** Check repository selection when creating token

**Error:** `Bad credentials`
- **Cause:** Token expired or was revoked
- **Fix:** Generate new token and update secret

**Error:** `PAT_TOKEN secret not found`
- **Cause:** Secret name doesn't match exactly
- **Fix:** Ensure secret is named `PAT_TOKEN` (case-sensitive)

**Error:** `fine-grained personal access token does not have permission`
- **Cause:** Using fine-grained token instead of classic token
- **Fix:** Use the classic personal access token option

**Error:** `Token has expired`
- **Cause:** 90-day expiration reached
- **Fix:** Generate new token and update secret immediately

### PAT Generation Troubleshooting

**Can't find Personal Access Token settings?**
- Direct link: https://github.com/settings/personal-access-tokens/new
- Or: GitHub Settings → Developer settings → Personal access tokens → Fine-grained tokens

**"Selected repositories" option grayed out?**
- You might be in the wrong token type
- Use "Fine-grained personal access tokens" (recommended)
- Or use "Tokens (classic)" with full repo scope

**Permission options don't match documentation?**
- GitHub UI changes frequently
- Look for these equivalent permissions:
  - "Contents" = Repository contents
  - "Pull requests" = Pull request management
  - "Metadata" = Repository metadata
  - "Actions" = GitHub Actions

**Token not working immediately?**
- GitHub can take 1-2 minutes to propagate permissions
- Wait 2 minutes after creating token before testing
- Try triggering workflow again if first attempt fails

### Token Expiration Management
Set a 90-day calendar reminder:
```
Title: "Renew GitHub PAT Token"
Description: "Generate new PAT token and update PAT_TOKEN secret"
URL: https://github.com/settings/personal-access-tokens/new
```

## 🔍 Step-by-Step Verification Checklist

Before creating a new token, verify each step:

- [ ] Token has `Write` access to `Contents` (not just Read)
- [ ] Token has `Write` access to `Pull requests` (not just Read)
- [ ] Token has `Read` access to `Metadata`
- [ ] Token has `Read` access to `Actions`
- [ ] Token is scoped to your `[username]/[username]` repository
- [ ] Secret is named exactly `PAT_TOKEN` (case-sensitive)
- [ ] Token was copied correctly (starts with `github_pat_`)
- [ ] Auto-merge is enabled in repository settings
- [ ] Branch protection rule exists for `main` branch

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
