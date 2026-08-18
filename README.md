# EnhanceWindows11

EnhanceWindows11 is an automated PowerShell-based debloating, optimization, and system-hardening toolkit designed for Windows 11. It streamlines system cleanup, removes telemetry and preinstalled bloatware, enforces security best practices (including DNS-over-HTTPS and browser hardening), and customizes UI settings for a cleaner, privacy-focused desktop experience.

---

## Overview and Key Features

The toolkit automates Windows 11 debloating across a structured, multi-phase execution process handling automatic reboots, state persistence via Windows RunOnce registry entries, and execution logging.

### 1. Phased Execution and Safety
- **Multi-Phase Architecture:** Handles system states seamlessly before and after restarts.
- **UCPD Management:** Temporarily disables the Universal Consent Profile Driver (UCPD) service and scheduled tasks during modification to prevent Windows from resetting default associations and settings, re-enabling it upon completion.
- **Transcript Logging:** Logs execution details to a timestamped file (`debloat_yyyyMMdd_HHmmss.log`) in the script directory.

### 2. Core Modules and Tweaks

| Script | Purpose / Features |
| :--- | :--- |
| `01-DisableBitLocker.ps1` | Decrypts and disables BitLocker on the system drive (`C:`) with real-time status monitoring. |
| `02-MainSettings.ps1` | Applies comprehensive system, privacy, explorer, and taskbar optimizations via registry tweaks: <br> - Disables telemetry, diagnostic data collection, feedback prompts, and advertising ID.<br> - Disables Windows Spotlight, lock screen widgets, tips, and search highlights.<br> - Cleans up the Start Menu (disables recommendations, account promotions, frequent apps).<br> - Cleans up the Taskbar (hides Search bar, Task View, Widgets, and Resume buttons; enables "End Task" on right-click).<br> - Configures File Explorer to open to "This PC", shows file extensions, and reveals hidden files.<br> - Enables Clipboard History and shows seconds in the system clock.<br> - Disables WPAD (Web Proxy Auto-Discovery) security vulnerability.<br> - Disables Sticky Keys shortcut trigger and Microsoft Edge background startup. |
| `03-ChangeTheme.ps1` | Automatically switches the Windows interface to the official Dark Theme. |
| `04-UninstallApps.ps1` | Removes built-in bloatware, telemetry-heavy UWP/AppX packages, Microsoft Copilot, and OneDrive: <br> - Uninstalls Microsoft Copilot via Winget and AppX.<br> - Uninstalls OneDrive via setup parameters.<br> - Removes Teams, Outlook for Windows, Dev Home, Bing Weather/News, Solitaire, Clipchamp, Feedback Hub, Web Experience / Widgets runtime, and more. |
| `05-NetworkConfig.ps1` | Configures system-wide DNS-over-HTTPS (DoH) using Cloudflare Security DNS (`1.1.1.2`, `1.0.0.2`, and IPv6 equivalents) with automatic encryption enforcement across all active network adapters. |
| `06-InstallApps.ps1` | Automates unattended installation of software packages via `winget` (Brave Browser, Discord, Steam, Prism Launcher). |
| `07-EdgeConfig.ps1` | Hardens Microsoft Edge enterprise policies: disables telemetry, promotional features, shopping assistants, and AI sidebar integrations; enforces HTTPS-only mode; and force-installs uBlock Origin Lite with strict blocking rulesets. |
| `08-BraveConfig.ps1` | Hardens Brave Browser via registry policies: disables Brave Rewards, Brave Wallet, Brave VPN, Brave Leo AI Chat, Brave News, Brave Talk, P3A telemetry, and stats pinging. |
| `Helpers.psm1` | Shared module providing reusable utilities such as interactive countdown timers (`Start-SimpleTimer`) and registry validation (`Add-MissingKeys`). |

---

## Repository Structure

```text
EnhanceWindows11/
├── Enhance.ps1                  # Master orchestration script (Phase 0 -> Phase 1 -> Phase 2)
├── Helpers.psm1                 # Helper PowerShell module
├── README.md                    # Project documentation
└── Scripts/                     # Modular enhancement scripts executed during Phase 1
    ├── 01-DisableBitLocker.ps1  # BitLocker decryption
    ├── 02-MainSettings.ps1      # System settings, privacy, and explorer tweaks
    ├── 03-ChangeTheme.ps1       # Dark theme activation
    ├── 04-UninstallApps.ps1     # AppX bloatware, OneDrive, and Copilot removal
    ├── 05-NetworkConfig.ps1     # Cloudflare DNS-over-HTTPS configuration
    ├── 06-InstallApps.ps1       # Winget application installer
    ├── 07-EdgeConfig.ps1        # Microsoft Edge enterprise policy hardening
    └── 08-BraveConfig.ps1       # Brave browser policy hardening
```

---

## Prerequisites

- **Operating System:** Windows 11 (fully updated).
- **Privileges:** Administrator privileges are required.
- **PowerShell Execution Policy:** Must allow script execution.
- **Disk Storage:** The script folder must be extracted and saved locally on disk before running (do not run directly from inside a compressed ZIP archive).

---

## How to Start / Usage Guide

### Step 1: Download and Extract
1. Download or clone this repository to a local folder on your computer (for example: `C:\EnhanceWindows11`).
2. Make sure all files are fully extracted.

### Step 2: Open PowerShell as Administrator
Press `Win + X` and select **Terminal (Admin)** or search for **PowerShell**, right-click it, and select **Run as administrator**. 

You can also open Terminal directly from the EnhanceWindows11 folder. Inside the folder, right-click an empty space in File Explorer, then hold **Ctrl+Shift** and click **Open in Terminal** to launch it as Administrator.

### Step 3: Run the Script
Navigate to the directory where the repository is saved and execute `Enhance.ps1`:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
.\Enhance.ps1
```

---

## What Happens During Execution

1. **Phase 0 (Preparation):**
   - The script initializes logging.
   - It disables the `UCPD` service and scheduled tasks to ensure system tweaks apply cleanly.
   - It sets up a `RunOnce` registry key to automatically launch Phase 1 upon the next reboot.
   - The system reboots automatically after a 5-second countdown.

2. **Phase 1 (Execution):**
   - Upon logging in after restart, PowerShell automatically opens and executes all scripts in the `Scripts/` directory in numerical order.
   - Decrypts BitLocker, applies system/privacy settings, switches to dark mode, removes bloatware, configures secure DNS, installs chosen apps, and configures browser policies.
   - Re-enables the `UCPD` service and registers Phase 2 for the final startup.
   - The system restarts automatically.

3. **Phase 2 (Completion):**
   - After the second reboot, a confirmation banner informs you that the debloating process has completed successfully.
   - Press Enter to close the window.

---

## Customization

You can tailor the configuration prior to running `Enhance.ps1`:
- **Applications to Install:** Open `Scripts/06-InstallApps.ps1` and uncomment or add desired Winget package identifiers (e.g., Google Chrome, Firefox, VS Code, Git).
- **Applications to Uninstall:** Edit `Scripts/04-UninstallApps.ps1` to comment out any preinstalled apps you wish to keep.
- **BitLocker:** If you prefer to keep BitLocker enabled, remove `Scripts/01-DisableBitLocker.ps1`.
- **DNS Configuration:** Modify `Scripts/05-NetworkConfig.ps1` if you use a custom DNS provider.
