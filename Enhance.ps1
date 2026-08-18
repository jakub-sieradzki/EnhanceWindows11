param(
    [int]$Phase = 0
)

Import-Module "$PSScriptRoot\Helpers.psm1" -Force

$scriptDir = if ($PSScriptRoot) { 
    $PSScriptRoot 
}
elseif ($MyInvocation.MyCommand.Path) { 
    Split-Path -Parent $MyInvocation.MyCommand.Path 
}
else { 
    $PWD.Path 
}

$logPath = Join-Path -Path $scriptDir -ChildPath "debloat_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
Start-Transcript -Path $logPath -Append

$ScriptPath = $PSCommandPath

if ([string]::IsNullOrEmpty($ScriptPath)) {
    Write-Error "Error: This script should be saved on disk before starting"
    return
}

$scriptsFolder = Join-Path -Path $PSScriptRoot -ChildPath "Scripts"

function Set-UCPDStatus {
    param (
        [Parameter(Mandatory = $true)]
        [bool]$IsEnabled
    )

    if ($IsEnabled) {
        try {
            Write-Host "Enabling UCPD..."
            Set-Service -Name UCPD -StartupType Automatic
            Enable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "UCPD velocity" | Out-Null
            Write-Host "Sucessfully enabled UCPD" -ForegroundColor Green
        }
        catch {
            Write-Host "Error enabling UCPD" -ForegroundColor Red
        }
    }
    else {
        try {
            Write-Host "Disabling UCPD..."
            Set-Service -Name UCPD -StartupType Disabled
            Disable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "UCPD velocity" | Out-Null
            Write-Host "Sucessfully disabled UCPD" -ForegroundColor Green
        } 
        catch {
            Write-Host "Error disabling UCPD" -ForegroundColor Red
        }
    }
}

function Set-RunOnce {
    param(
        [Parameter(Mandatory = $true)]
        [int]$Phase
    )

    $RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
    $CommandLine = "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle normal -File `"$ScriptPath`" -Phase $Phase"
    
    New-ItemProperty -Path $RunOnceKey -Name "!W11DebloatPhase$Phase" -Value $CommandLine -PropertyType String -Force | Out-Null
}

switch ($Phase) {
    0 {
        Write-Host "--------------------------------------------------------------------------------------" -BackgroundColor Blue -ForegroundColor White
        Write-Host "    Welcome to Windows 11 Debloat developed by IT Biker. Scripts will run shortly.    " -BackgroundColor Blue -ForegroundColor White
        Write-Host "--------------------------------------------------------------------------------------" -BackgroundColor Blue -ForegroundColor White
        Write-Host
        Write-Host "Preparing..."

        #disable UCPD
        Set-UCPDStatus -IsEnabled $false
        #run script after restart
        Set-RunOnce -Phase 1

        Write-Host "Preparation completed. Restarting in 5 seconds..."
        Start-SimpleTimer -Seconds 5
        Restart-Computer -Force
        break
    }
    1 {
        Write-Host "Starting the second phase..."
        Start-SimpleTimer -Seconds 15
        Write-Host
        
        $scripts = Get-ChildItem -Path $scriptsFolder -Filter "*.ps1" | Sort-Object Name

        foreach ($script in $scripts) {
            & $script.FullName
            Write-Host
        }

        Start-SimpleTimer -Seconds 5

        #reenabling UCPD
        Set-UCPDStatus -IsEnabled $true

        #run script after restart
        Set-RunOnce -Phase 2

        Write-Host "Final restart in 5 seconds..."
        #Read-Host -Prompt "Click Enter to close this window"
        Start-SimpleTimer -Seconds 5
        Restart-Computer -Force
        break
    }
    2 {
        Write-Host "------------------------------------------------------------------------------------------" -BackgroundColor Blue -ForegroundColor White
        Write-Host " Process of debloating Windows 11 is now completed. Thank you for using this script. LwG! " -BackgroundColor Blue -ForegroundColor White
        Write-Host "------------------------------------------------------------------------------------------" -BackgroundColor Blue -ForegroundColor White
        Write-Host
        Read-Host -Prompt "Click Enter to close this window"
        break
    }
}

Stop-Transcript