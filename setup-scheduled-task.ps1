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
    Write-Host "🗑️  Removing scheduled task..." -ForegroundColor Yellow
    if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
        Write-Host "✅ Task removed successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Task not found!" -ForegroundColor Red
    }
    exit 0
}

if ($Status) {
    Write-Host "📊 Task Status:" -ForegroundColor Cyan
    $Task = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
    if ($Task) {
        $Task | Format-Table TaskName, State, LastRunTime, NextRunTime -AutoSize
        Write-Host "📋 Task Details:" -ForegroundColor Cyan
        $TaskInfo = Get-ScheduledTaskInfo -TaskName $TaskName
        Write-Host "  Last Result: $($TaskInfo.LastTaskResult)" -ForegroundColor Gray
        Write-Host "  Last Run Time: $($TaskInfo.LastRunTime)" -ForegroundColor Gray
        Write-Host "  Next Run Time: $($TaskInfo.NextRunTime)" -ForegroundColor Gray
    } else {
        Write-Host "❌ Task not found!" -ForegroundColor Red
    }
    exit 0
}

Write-Host "🕐 Setting up Portfolio Workflow - Every 4 Hours" -ForegroundColor Cyan
Write-Host ("=" * 55) -ForegroundColor Gray

# Check if task already exists and remove it
if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
    Write-Host "🔄 Removing existing task: $TaskName" -ForegroundColor Yellow
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
Write-Host "⏰ Creating triggers for every 4 hours..." -ForegroundColor Yellow
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

    Write-Host "✅ Scheduled task created successfully!" -ForegroundColor Green
    Write-Host "📋 Task Details:" -ForegroundColor Cyan
    Write-Host "  Task Name: $TaskName" -ForegroundColor White
    Write-Host "  Schedule: Every 4 hours at 12:00 AM, 4:00 AM, 8:00 AM, 12:00 PM, 4:00 PM, 8:00 PM" -ForegroundColor White
    Write-Host "  Command: powershell.exe -ExecutionPolicy Bypass -File `"$ScriptPath`" -UpdateDescriptions" -ForegroundColor White
    Write-Host "  Working Directory: $WorkingDirectory" -ForegroundColor White

    # Show next run times
    Write-Host "`n📅 Next Run Times:" -ForegroundColor Cyan
    $Task = Get-ScheduledTask -TaskName $TaskName
    $TaskInfo = Get-ScheduledTaskInfo -TaskName $TaskName
    Write-Host "  Next Run: $($TaskInfo.NextRunTime)" -ForegroundColor White

} catch {
    Write-Error "Failed to create scheduled task: $($_.Exception.Message)"
    exit 1
}

Write-Host "`n🎯 Management Commands:" -ForegroundColor Cyan
Write-Host "  View Status: .\setup-scheduled-task.ps1 -Status" -ForegroundColor Gray
Write-Host "  Remove Task: .\setup-scheduled-task.ps1 -Remove" -ForegroundColor Gray
Write-Host "  Manual Run: Start-ScheduledTask -TaskName '$TaskName'" -ForegroundColor Gray

Write-Host "`n🎉 Setup complete! Your portfolio will now update automatically every 4 hours." -ForegroundColor Green
