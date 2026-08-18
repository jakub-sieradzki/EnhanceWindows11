Import-Module "$PSScriptRoot\..\Helpers.psm1" -Force

Write-Host "Changing theme..." -BackgroundColor Gray -ForegroundColor Black

Start-Process -FilePath "C:\Windows\Resources\Themes\dark.theme"

Write-Host "Settings app will automatically be closed after 5 seconds"
Start-SimpleTimer -Seconds 5

Stop-Process -Name "SystemSettings" -Force

Write-Host "Changed theme" -BackgroundColor Green -ForegroundColor White