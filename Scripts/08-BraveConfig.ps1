Import-Module "$PSScriptRoot\..\Helpers.psm1" -Force

$PoliciesPath = "HKLM:\SOFTWARE\Policies\BraveSoftware\Brave"

$Policies = @{
    "TorDisabled"              = 1
    "BraveRewardsDisabled"     = 1
    "BraveWalletDisabled"      = 1
    "BraveVPNDisabled"         = 1
    "BraveAIChatEnabled"       = 0
    "BraveNewsDisabled"        = 1
    "BraveTalkDisabled"        = 1
    "BraveP3AEnabled"          = 0
    "BraveStatsPingEnabled"    = 0
    "BraveWebDiscoveryEnabled" = 0
}

Write-Host "Configuring Brave..." -BackgroundColor Gray -ForegroundColor Black

Add-MissingKeys -Paths @($PoliciesPath)

foreach ($Policy in $Policies.GetEnumerator()) {
    Set-ItemProperty -Path $PoliciesPath -Name $($Policy.Key) -Value $($Policy.Value)
}

Write-Host "Brave configuration done" -BackgroundColor Green -ForegroundColor White