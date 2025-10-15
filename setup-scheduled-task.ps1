# Setup Scheduled Task for Portfolio Workflow
# This script creates a Windows scheduled task to run the portfolio workflow every 4 hours

param(
    [switch]$Remove,  # Remove existing task
    [switch]$Status   # Show task status
)

$TaskName = "Portfolio-Update-4Hours"
$ScriptPath = "C:\Development\fabioc-aloha\auto-update-repos.ps1"
$WorkingDirectory = "C:\Development\fabioc-aloha"

if ($Remove) {
    Write-Information "🗑️  Removing scheduled task..." -InformationAction Continue
    if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
    Write-Information "✅ Task removed successfully!" -InformationAction Continue
    } else {
    Write-Information "❌ Task not found!" -InformationAction Continue
    }
    exit 0
}

if ($Status) {
    Write-Information "📊 Task Status:" -InformationAction Continue
    $Task = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
    if ($Task) {
        $Task | Format-Table TaskName, State, LastRunTime, NextRunTime -AutoSize
    Write-Information "📋 Task Details:" -InformationAction Continue
    $TaskInfo = Get-ScheduledTaskInfo -TaskName $TaskName
    Write-Information "  Last Result: $($TaskInfo.LastTaskResult)" -InformationAction Continue
    Write-Information "  Last Run Time: $($TaskInfo.LastRunTime)" -InformationAction Continue
    Write-Information "  Next Run Time: $($TaskInfo.NextRunTime)" -InformationAction Continue
    } else {
        Write-Information "❌ Task not found!" -InformationAction Continue
    }
    exit 0
}

Write-Information "🕐 Setting up Portfolio Workflow - Every 4 Hours" -InformationAction Continue
Write-Information ("=" * 55) -InformationAction Continue

# Check if task already exists and remove it
if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
    Write-Information "🔄 Removing existing task: $TaskName" -InformationAction Continue
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
}

# Verify script exists
if (-not (Test-Path $ScriptPath)) {
    Write-Error "Script not found: $ScriptPath"
    exit 1
}

# Create the action
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$ScriptPath`" -UpdateDescriptions" -WorkingDirectory $WorkingDirectory

# Create triggers for every 4 hours
Write-Information "⏰ Creating triggers for every 4 hours..." -InformationAction Continue
$Triggers = @()
$RunTimes = @("00:00", "04:00", "08:00", "12:00", "16:00", "20:00")

foreach ($Time in $RunTimes) {
    $Triggers += New-ScheduledTaskTrigger -Daily -At $Time
}

# Create settings
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RunOnlyIfNetworkAvailable -MultipleInstances IgnoreNew

# Create principal (run as current user)
$Principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -LogonType Interactive

try {
    # Register the task
    Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Triggers -Settings $Settings -Principal $Principal -Description "Automatically updates GitHub portfolio every 4 hours with repository descriptions"

    Write-Information "✅ Scheduled task created successfully!" -InformationAction Continue
    Write-Information "📋 Task Details:" -InformationAction Continue
    Write-Information "  Task Name: $TaskName" -InformationAction Continue
    Write-Information "  Schedule: Every 4 hours at 12:00 AM, 4:00 AM, 8:00 AM, 12:00 PM, 4:00 PM, 8:00 PM" -InformationAction Continue
    Write-Information "  Command: powershell.exe -ExecutionPolicy Bypass -File `"$ScriptPath`" -UpdateDescriptions" -InformationAction Continue
    Write-Information "  Working Directory: $WorkingDirectory" -InformationAction Continue

    # Show next run times
    Write-Information "`n📅 Next Run Times:" -InformationAction Continue
    $Task = Get-ScheduledTask -TaskName $TaskName
    $TaskInfo = Get-ScheduledTaskInfo -TaskName $TaskName
    Write-Information "  Next Run: $($TaskInfo.NextRunTime)" -InformationAction Continue

} catch {
    Write-Error "Failed to create scheduled task: $($_.Exception.Message)"
    exit 1
}
Write-Information "`n🎯 Management Commands:" -InformationAction Continue
Write-Information "  View Status: .\setup-scheduled-task.ps1 -Status" -InformationAction Continue
Write-Information "  Remove Task: .\setup-scheduled-task.ps1 -Remove" -InformationAction Continue
Write-Information "  Manual Run: Start-ScheduledTask -TaskName '$TaskName'" -InformationAction Continue

Write-Information "`n🎉 Setup complete! Your portfolio will now update automatically every 4 hours." -InformationAction Continue

