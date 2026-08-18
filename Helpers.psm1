function Start-SimpleTimer {
    
    param(
        [Parameter(Mandatory = $true)]
        [int]$Seconds
    )

    for ($i = $Seconds; $i -ge 0; $i--) {
        Write-Host ("`rPlease wait: $i ") -NoNewline -ForegroundColor DarkCyan
        Start-Sleep -Seconds 1
    }
    Write-Host
    Write-Host
}

function Add-MissingKeys {
    param (
        [Parameter(Mandatory = $true)]
        [string[]]$Paths
    )

    Write-Host "Checking and completing missing registry keys..."

    foreach ($Path in $Paths) {
        if (-not (Test-Path -Path $Path)) {
            $null = New-Item -Path $Path -Force
            Write-Host "Created missing registry key: $Path" -ForegroundColor Green
        }
    }
}

Export-ModuleMember -Function Start-SimpleTimer, Add-MissingKeys