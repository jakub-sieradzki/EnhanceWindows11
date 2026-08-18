Import-Module "$PSScriptRoot\..\Helpers.psm1" -Force

$Paths = @{
    "UserProfileEngagement"      = "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement"
    "ContentDeliveryManager"     = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    "StoragePolicy"              = "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy"
    "Explorer"                   = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
    "ExplorerAdvanced"           = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    "ExplorerAdvancedTaskbarDev" = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings"
    "Clipboard"                  = "HKCU:\Software\Microsoft\Clipboard"
    "CDMSub338387"               = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\338387"
    "LockScreen"                 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lock Screen"
    "Start"                      = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start"
    "Search"                     = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
    "CDRConfig"                  = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration"
    "CDRNotifi"                  = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Notification"
    "TabletTip17"                = "HKCU:\Software\Microsoft\TabletTip\1.7"
    "InputSettings"              = "HKCU:\Software\Microsoft\input\Settings"
    "StickyKeys"                 = "HKCU:\Control Panel\Accessibility\StickyKeys"
    "Privacy"                    = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy"
    "UserProfile"                = "HKCU:\Control Panel\International\User Profile"
    "AccountNotifi"              = "HKCU:\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications"
    "CPSSStoreAd"                = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\AdvertisingInfo"
    "AdvertisingInfo"            = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
    "ImproveInking"              = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\ImproveInkingAndTyping"
    "TIPC"                       = "HKCU:\Software\Microsoft\input\TIPC"
    "SiufRules"                  = "HKCU:\Software\Microsoft\Siuf\Rules"
    "SearchSettings"             = "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings"
    "DataCollection"             = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    "StartupApproved"            = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run"
    "CPSSInkingAndTyping"        = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\InkingAndTypingPersonalization"
    "PersonalizationSettings"    = "HKCU:\Software\Microsoft\Personalization\Settings"
    "InputPersonalization"       = "HKCU:\Software\Microsoft\InputPersonalization"
    "TrainedDataStore"           = "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore"
    "ConsentStoreLocation"       = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location"
    "LocationSensor"             = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
    "DisableWpad"                = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp"
    #"SetDefaultConsole"          = "HKCU:\Console\%%Startup"
}

$Settings = @(
    #Settings -> Notifications -> Additional Settings -> disable
    [PSCustomObject]@{ Path = $Paths["UserProfileEngagement"]; Name = "ScoobeSystemSettingEnabled"; Value = 0 }
    [PSCustomObject]@{ Path = $Paths["ContentDeliveryManager"]; Name = "SubscribedContent-338389Enabled"; Value = 0 }
    #Settings -> Storage -> Storage Sense -> run Storage sense every month
    [PSCustomObject]@{ Path = $Paths["StoragePolicy"]; Name = "StoragePoliciesChanged"; Value = 1 }
    [PSCustomObject]@{ Path = $Paths["StoragePolicy"]; Name = "2048"; Value = 30 }
    #Settings -> Multitasking -> Shaking -> enable
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvanced"]; Name = "DisallowShaking"; Value = 0 }
    #Settings -> Advanced -> End Task Enable
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvancedTaskbarDev"]; Name = "TaskbarEndTask"; Value = 1 }
    #Settings -> Advanced -> File Explorer -> Show file extentions
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvanced"]; Name = "HideFileExt"; Value = 0 }
    #Settings -> Advanced -> File Explorer -> Show hidden files
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvanced"]; Name = "Hidden"; Value = 1 }
    #Settings -> Clipboard -> Clipboard History -> enable
    [PSCustomObject]@{ Path = $Paths["Clipboard"]; Name = "EnableClipboardHistory"; Value = 1 }
    #Settings -> Personalization -> Lockscreen -> disable Windows Spotlight
    [PSCustomObject]@{ Path = $Paths["ContentDeliveryManager"]; Name = "RotatingLockScreenEnabled"; Value = 0 }
    #Settings -> Personalization -> Lockscreen -> Show tips etc. on lock screen -> disable
    [PSCustomObject]@{ Path = $Paths["ContentDeliveryManager"]; Name = "RotatingLockScreenOverlayEnabled"; Value = 0 }
    [PSCustomObject]@{ Path = $Paths["ContentDeliveryManager"]; Name = "SubscribedContent-338387Enabled"; Value = 0 }
    [PSCustomObject]@{ Path = $Paths["CDMSub338387"]; Name = "SubscriptionContext"; Value = "sc-mode=1" }
    #Settings -> Personalization -> Lock Screen -> Widgets -> disable
    [PSCustomObject]@{ Path = $Paths["LockScreen"]; Name = "LockScreenWidgetsEnabled"; Value = 0 }
    #Settings -> Personalization -> Lock Screen -> Suggest Widgets -> disable
    [PSCustomObject]@{ Path = $Paths["LockScreen"]; Name = "LockScreenWidgetsSystemCurationEnabled"; Value = 0 }
    #Settings -> Personalization -> Start -> Show Recent -> disable
    [PSCustomObject]@{ Path = $Paths["Start"]; Name = "ShowRecentList"; Value = 0 }
    #Settings -> Personalization -> Start -> Show recommended files -> disable
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvanced"]; Name = "Start_TrackDocs"; Value = 0 }
    #Settings -> Personalization -> Start -> show tips -> disable
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvanced"]; Name = "Start_IrisRecommendations"; Value = 0 }
    #Settings -> Personalization -> Start -> Show frequent apps -> disable
    [PSCustomObject]@{ Path = $Paths["Start"]; Name = "ShowFrequentList"; Value = 0 }
    #Settings -> Personalization -> Start -> show account notifications -> disable
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvanced"]; Name = "Start_AccountNotifications"; Value = 0 }
    #Settings -> Personalization -> Taskbar -> hide search button
    [PSCustomObject]@{ Path = $Paths["Search"]; Name = "SearchboxTaskbarMode"; Value = 0 }
    #Settings -> Personalization -> Taskbar -> hide task view button
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvanced"]; Name = "ShowTaskViewButton"; Value = 0 }
    #Settings -> Personalization -> Taskbar -> hide widgets button
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvanced"]; Name = "TaskbarDa"; Value = 0 }
    #Settings -> Personalization -> Taskbar -> hide resume button
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvanced"]; Name = "IsEnabled"; Value = 0 }
    #Settings -> Apps -> Resume -> turn off
    [PSCustomObject]@{ Path = $Paths["CDRConfig"]; Name = "IsResumeAllowed"; Value = 0 }
    [PSCustomObject]@{ Path = $Paths["CDRNotifi"]; Name = "Status"; Value = 5 }
    #Settings -> Time & Language -> Show seconds
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvanced"]; Name = "ShowSecondsInSystemClock"; Value = 1 }
    #Settings -> Time & Language -> Show time in notification center
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvanced"]; Name = "ShowClockInNotificationCenter"; Value = 1 }
    #Settings -> Writing -> Autocorrection -> disable
    [PSCustomObject]@{ Path = $Paths["TabletTip17"]; Name = "EnableAutocorrection"; Value = 0 }
    #Settings -> Writing -> Writing Insights -> disable
    [PSCustomObject]@{ Path = $Paths["InputSettings"]; Name = "InsightsEnabled"; Value = 0 }
    #Settings -> Ease of access -> Keyboard -> Sticky keys -> shortcut -> disable
    [PSCustomObject]@{ Path = $Paths["StickyKeys"]; Name = "Flags"; Value = 506 }
    #Settings -> Privacy & security -> Recommendations & offers -> Personalized offers -> disable
    [PSCustomObject]@{ Path = $Paths["Privacy"]; Name = "PersonalizedOffersEnabled"; Value = 0 }
    #Settings -> Privacy & security -> Recommendations & offers -> allow websites to access to my list of languages -> disable
    [PSCustomObject]@{ Path = $Paths["UserProfile"]; Name = "HttpAcceptLanguageOptOut"; Value = 1 }
    #Settings -> Privacy & security -> Recommendations & offers -> Improve speed of apps' start and search -> disable
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvanced"]; Name = "Start_TrackProgs"; Value = 0 }
    #Settings -> Privacy & security -> Recommendations & offers -> Show account notifications -> disable
    [PSCustomObject]@{ Path = $Paths["AccountNotifi"]; Name = "EnableAccountNotifications"; Value = 0 }
    #Settings -> Privacy & security -> Recommendations & offers -> Recommendations and offers in Settings -> disable
    [PSCustomObject]@{ Path = $Paths["ContentDeliveryManager"]; Name = "SubscribedContent-338393Enabled"; Value = 0 }
    [PSCustomObject]@{ Path = $Paths["ContentDeliveryManager"]; Name = "SubscribedContent-353694Enabled"; Value = 0 }
    [PSCustomObject]@{ Path = $Paths["ContentDeliveryManager"]; Name = "SubscribedContent-353696Enabled"; Value = 0 }
    #Settings -> Privacy & security -> Recommendations & offers -> Advertising ID -> disable
    [PSCustomObject]@{ Path = $Paths["CPSSStoreAd"]; Name = "Value"; Value = 0 }
    [PSCustomObject]@{ Path = $Paths["AdvertisingInfo"]; Name = "Enabled"; Value = 0 }
    [PSCustomObject]@{ Path = $Paths["AdvertisingInfo"]; Name = "Id"; Value = 0 }
    #Settings -> Privacy & security -> Diagnostics & feedback -> Do not send optional data
    [PSCustomObject]@{ Path = $Paths["DataCollection"]; Name = "AllowTelemetry"; Value = 0 }
    #Settings -> Privacy & security -> Diagnostics & feedback -> Improve handrwriting and typing -> disable
    [PSCustomObject]@{ Path = $Paths["ImproveInking"]; Name = "Value"; Value = 0 }
    [PSCustomObject]@{ Path = $Paths["TIPC"]; Name = "Enabled"; Value = 0 }
    #Settings -> Privacy & security -> Diagnostics & feedback -> Feedback frequency -> Never
    [PSCustomObject]@{ Path = $Paths["SiufRules"]; Name = "NumberOfSIUFInPeriod"; Value = 0 }
    #Settings -> Privacy & security -> Search -> Search history -> disable
    [PSCustomObject]@{ Path = $Paths["SearchSettings"]; Name = "IsDeviceSearchHistoryEnabled"; Value = 0 }
    #Settings -> Privacy & security -> Search -> Allow search apps to show answers -> disable
    [PSCustomObject]@{ Path = $Paths["SearchSettings"]; Name = "IsGlobalWebSearchProviderToggleEnabled"; Value = 0 }
    #Settings -> Privacy & security -> Search -> Search my accounts -> Microsoft Account -> disable
    [PSCustomObject]@{ Path = $Paths["SearchSettings"]; Name = "IsMSACloudSearchEnabled"; Value = 0 }
    #Settings -> Privacy & security -> Search -> Search my accounts -> School or work account -> disable
    [PSCustomObject]@{ Path = $Paths["SearchSettings"]; Name = "IsAADCloudSearchEnabled"; Value = 0 }
    #Windows Explorer Options -> General -> Launch To -> This computer
    [PSCustomObject]@{ Path = $Paths["ExplorerAdvanced"]; Name = "LaunchTo"; Value = 1 }
    #Windows Explorer Options -> General -> Show frequent folders -> disable
    [PSCustomObject]@{ Path = $Paths["Explorer"]; Name = "ShowFrequent"; Value = 0 }
    #Windows Explorer Options -> General -> Include detailed information based on... -> disable
    [PSCustomObject]@{ Path = $Paths["Explorer"]; Name = "ShowCloudFilesInQuickAccess"; Value = 0 }
    #Settings -> Privacy & security -> Inking and typing personalization -> disable
    [PSCustomObject]@{ Path = $Paths["CPSSInkingAndTyping"]; Name = "Value"; Value = 0 }
    [PSCustomObject]@{ Path = $Paths["PersonalizationSettings"]; Name = "AcceptedPrivacyPolicy"; Value = 0 }
    [PSCustomObject]@{ Path = $Paths["InputPersonalization"]; Name = "RestrictImplicitTextCollection"; Value = 1 }
    [PSCustomObject]@{ Path = $Paths["InputPersonalization"]; Name = "RestrictImplicitInkCollection"; Value = 1 }
    [PSCustomObject]@{ Path = $Paths["TrainedDataStore"]; Name = "HarvestContacts"; Value = 0 }
    #Settings -> Privacy & security -> Location -> disable *NOT WORKING*
    # [PSCustomObject]@{ Path = $Paths["ConsentStoreLocation"]; Name = "Value"; Value = "Deny" }
    # [PSCustomObject]@{ Path = $Paths["ConsentStoreLocation"]; Name = "LastSetTime"; Value = ([DateTime]::UtcNow.ToFileTime()) }
    # [PSCustomObject]@{ Path = $Paths["LocationSensor"]; Name = "SensorPermissionState"; Value = 0 }
    #Disable WPAD
    [PSCustomObject]@{ Path = $Paths["DisableWpad"]; Name = "DisableWpad"; Value = 1 }
    #Settings -> System -> Advanced -> Terminal -> Windows Terminal
    # [PSCustomObject]@{ Path = $Paths["SetDefaultConsole"]; Name = "DelegationConsole"; Value = "{2EACA947-7F5F-4CFA-BA87-8F7FBEEFBE69}" }
    # [PSCustomObject]@{ Path = $Paths["SetDefaultConsole"]; Name = "DelegationTerminal"; Value = "{E12CFF52-A866-4C77-9A90-F570A7AA2C6B}" }
)

Write-Host "Changing settings..." -BackgroundColor Gray -ForegroundColor Black

#completing missing registry keys
Add-MissingKeys -Paths $Paths.Values

#changing registry settings
Write-Host "Done. Starting changing settings..."

foreach ($Item in $Settings) {
    Set-ItemProperty -Path $($Item.Path) -Name $($Item.Name) -Value $($Item.Value)
}

#disable Microsoft Edge autorun
(Get-Item -Path $Paths["StartupApproved"]).Property | Where-Object { $_ -like "MicrosoftEdgeAutoLaunch*" } | ForEach-Object {
    Set-ItemProperty -Path $Paths["StartupApproved"] -Name $_ -Value ([byte[]](0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00))
}

Write-Host "Changing settings completed" -BackgroundColor Green -ForegroundColor White