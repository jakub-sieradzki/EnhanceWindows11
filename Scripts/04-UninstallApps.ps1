$appxApps = @(
    #"Microsoft.MicrosoftEdgeDevToolsClient"
    #"Microsoft.Windows.ParentalControls"
    #"Microsoft.XboxGameCallableUI"
    #"Microsoft.WindowsAlarms"
    "MicrosoftCorporationII.MicrosoftFamily"
    #"Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.Windows.DevHome"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.BingSearch"
    "Microsoft.Copilot"
    "MSTeams"
    "Microsoft.OutlookForWindows"
    #"Microsoft.Paint"
    #"Microsoft.ScreenSketch"
    "Microsoft.BingNews"
    "Microsoft.BingWeather"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.WidgetsPlatformRuntime"
    "Microsoft.GetHelp"
    #"Microsoft.Windows.Photos"
    "Microsoft.YourPhone"
    #"Microsoft.XboxGamingOverlay"
    #"Microsoft.Xbox.TCUI"
    "MicrosoftWindows.CrossDevice"
    #"Microsoft.XboxIdentityProvider"
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.Todos"
    #"Microsoft.WindowsSoundRecorder"
    #"Microsoft.GamingApp"
    "Microsoft.StartExperiencesApp"
    #"Microsoft.WindowsCamera"
    #"Microsoft.ZuneMusic"
    "Microsoft.WindowsFeedbackHub"
    "Clipchamp.Clipchamp"
    "MicrosoftWindows.Client.WebExperience"
    #"Microsoft.MicrosoftEdge.Stable"
)

Write-Host "Uninstalling apps..." -BackgroundColor Gray -ForegroundColor Black

foreach ($app in $appxApps) {
    Get-AppxPackage -Name "*$app*" | Remove-AppxPackage
}

#Uninstall OneDrive
Write-Host "Uninstalling OneDrive..."
Start-Process "$env:SystemRoot\System32\OneDriveSetup.exe" -ArgumentList "/uninstall" -Wait

#Uninstall Copilot
Write-Host "Uninstalling Copilot..."
winget uninstall --id "ARP\Machine\X86\Microsoft Copilot" --exact --silent --accept-source-agreements --disable-interactivity

Write-Host "Uninstalling apps done" -BackgroundColor Green -ForegroundColor White