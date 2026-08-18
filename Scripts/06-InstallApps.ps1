$apps = @(
    "Brave.Brave"
    # "Google.Chrome"
    # "Mozilla.Firefox"
    "Discord.Discord"
    # "OpenWhisperSystems.Signal"
    "Valve.Steam"
    # "EpicGames.EpicGamesLauncher"
    "PrismLauncher.PrismLauncher"
    # "Microsoft.VisualStudioCode"
    # "Git.Git"
)

Write-Host "Installing apps..." -BackgroundColor Gray -ForegroundColor Black

foreach ($app in $apps) {
    Write-Host "Installing: $app"
    Write-Host
    winget install --id $app --exact --silent --accept-package-agreements --accept-source-agreements --disable-interactivity
    Write-Host
}

Write-Host "Installing apps completed" -BackgroundColor Green -ForegroundColor White