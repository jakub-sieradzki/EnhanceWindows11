Import-Module "$PSScriptRoot\..\Helpers.psm1" -Force

$PoliciesPath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"

$ExtensionsIDs = @{
    "uBlockOriginLite" = "cimighlppcgcoapaliogpjjdehbnofhn"
    "GoogleSearch"     = "dakcooigljlhlgibgdfadgphfnoooacj"
}

$ExtensionsPolicies = @"
{
  "$($ExtensionsIDs['uBlockOriginLite'])": {
    "toolbar_state": "force_shown"
  }
}
"@

$Policies = @{
    "UserFeedbackAllowed"                                 = 0
    "VisualSearchEnabled"                                 = 0
    "TrackingPrevention"                                  = 3
    "TextPredictionEnabled"                               = 0
    "TabServicesEnabled"                                  = 0
    "SyncDisabled"                                        = 1
    "StandaloneHubsSidebarEnabled"                        = 0
    "ShowRecommendationsEnabled"                          = 0
    "ShowMicrosoftRewards"                                = 0
    "SearchbarIsEnabledOnStartup"                         = 0
    "SearchbarAllowed"                                    = 0
    "SearchSuggestEnabled"                                = 0
    "ResolveNavigationErrorsUseWebService"                = 0
    #"PinningWizardAllowed"                                = 0
    "PaymentMethodQueryEnabled"                           = 0
    "MicrosoftEdgeInsiderPromotionEnabled"                = 0
    "MediaRouterCastAllowAllIPs"                          = 0
    #"DefaultSearchProviderEnabled"                        = 0
    #"DefaultSearchProviderSearchURL"                      = "https://google.com/search?q={searchTerms}&udm=14"
    "M365LinksAutoOpenCopilotEnabled"                     = 0
    "LocalProvidersEnabled"                               = 0
    "LocalBrowserDataShareEnabled"                        = 0
    "LiveVideoTranslationEnabled"                         = 0
    "LaunchEdgeOnWindowsStartupEnabled"                   = 0
    "InAppSupportEnabled"                                 = 0
    "HubsSidebarEnabled"                                  = 0
    "HttpsOnlyMode"                                       = "force_enabled"
    "HideFirstRunExperience"                              = 1
    #"NewTabPageLocation"                                  = "https://google.com"
    "ForceSync"                                           = 0
    "BrowserSignin"                                       = 0
    "NonRemovableProfileEnabled"                          = 0
    "EdgeWalletCheckoutEnabled"                           = 0
    "EdgeShoppingAssistantEnabled"                        = 0
    "EdgeReadingModeServiceBasedExtractionEnabled"        = 0
    "EdgeHistoryAISearchEnabled"                          = 0
    "EdgeEDropEnabled"                                    = 0
    "EdgeAutofillMlEnabled"                               = 0
    "EdgeAssetDeliveryServiceEnabled"                     = 0
    "DefaultBrowserSettingsCampaignEnabled"               = 0
    "DefaultBrowserSettingEnabled"                        = 0
    "CopilotNewTabPageEnabled"                            = 0
    "CopilotAddressBarSuggestionsEnabled"                 = 0
    "ConfigureDoNotTrack"                                 = 1
    "BlockThirdPartyCookies"                              = 1
    "BingAdsSuppression"                                  = 1
    "AutofillCreditCardEnabled"                           = 0
    "AutofillAddressEnabled"                              = 0
    "AlternateErrorPagesEnabled"                          = 0
    "AllowBrowsingWithCopilot"                            = 0
    "AdsTransparencyEnabled"                              = 0
    "AdsSettingForIntrusiveAdsSites"                      = 2
    "AddressBarClipboardSuggestEnabled"                   = 0
    "WebRtcLocalhostIpHandling"                           = "disable_non_proxied_udp"
    "ConfigureNTPFeedTabVisibility"                       = 1
    #"RestoreOnStartup"                                    = 5
    #"HomepageLocation"                                    = "https://google.com"
    "NewTabPageAllowedBackgroundTypes"                    = 3
    "NewTabPageAppLauncherEnabled"                        = 0
    "NewTabPageBingChatEnabled"                           = 0
    "NewTabPageContentEnabled"                            = 0
    "NewTabPagePrerenderEnabled"                          = 0
    #"SmartScreenPuaEnabled"                               = 1
    "PersonalizationReportingEnabled"                     = 0
    "PersonalizeTopSitesInCustomizeSidebarEnabled"        = 0
    "StartupBoostEnabled"                                 = 0
    "ShowAcrobatSubscriptionButton"                       = 0
    "NetworkPredictionOptions"                            = 2
    "EdgeManagementUserPolicyOverridesCloudMachinePolicy" = 0
    "EdgeManagementPolicyOverridesPlatformPolicy"         = 0
    "GenAILocalFoundationalModelSettings"                 = 1
    "Microsoft365CopilotChatIconEnabled"                  = 0
    "DiagnosticData"                                      = 0
    "UrlDiagnosticDataEnabled"                            = 0
    "NewTabPageSearchBox"                                 = "redirect"
    "EnableMediaRouter"                                   = 0
    "AddressBarTrendingSuggestEnabled"                    = 0
    "QuickSearchShowMiniMenu"                             = 0
    "TranslateEnabled"                                    = 0
    "NewTabPageHideDefaultTopSites"                       = 1
    "Edge3PSerpTelemetryEnabled"                          = 0
    "ComposeInlineEnabled"                                = 0
    "ExtensionSettings"                                   = $ExtensionsPolicies
}

$PoliciesPathExtensionForceList = "$PoliciesPath\ExtensionInstallForcelist"
$PoliciesPathExtensionsInPrivate = "$PoliciesPath\MandatoryExtensionsForInPrivateNavigation"
$UBlockPoliciesPath = "$PoliciesPath\3rdparty\extensions\$($ExtensionsIDs['uBlockOriginLite'])\policy"

Write-Host "Configuring Edge..." -BackgroundColor Gray -ForegroundColor Black

Add-MissingKeys -Paths @($PoliciesPath, $PoliciesPathExtensionForceList, $PoliciesPathExtensionsInPrivate, $UBlockPoliciesPath)

foreach ($Policy in $Policies.GetEnumerator()) {
    Set-ItemProperty -Path $PoliciesPath -Name $($Policy.Key) -Value $($Policy.Value)
}

Set-ItemProperty -Path $PoliciesPathExtensionForceList -Name "1" -Value $ExtensionsIDs["uBlockOriginLite"]
Set-ItemProperty -Path $PoliciesPathExtensionForceList -Name "2" -Value $ExtensionsIDs["GoogleSearch"]
#Set-ItemProperty -Path $PoliciesPathExtensionsInPrivate -Name "1" -Value $ExtensionsIDs["uBlockOriginLite"]

#uBlock Origin Lite Policies
$UBlockPolicies = @{
    "defaultFiltering"    = "complete"
    "disableFirstRunPage" = 1
    "rulesets"            = '["+default", "+block-lan", "+adguard-spyware-url", "+annoyances-ai", "+annoyances-cookies", "+annoyances-overlays", "+annoyances-social", "+annoyances-widgets", "+annoyances-others", "+annoyances-notifications"]'
    "strictBlockMode"     = 1
}

foreach ($Policy in $UBlockPolicies.GetEnumerator()) {
    Set-ItemProperty -Path $UBlockPoliciesPath -Name $($Policy.Key) -Value $($Policy.Value)
}

Write-Host "Edge configuration done" -BackgroundColor Green -ForegroundColor White