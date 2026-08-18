Write-Host "Disabling BitLocker..." -BackgroundColor Gray -ForegroundColor Black

Disable-BitLocker -MountPoint $env:SystemDrive
Write-Host

while ($true) {
    $volume = Get-BitLockerVolume -MountPoint $env:SystemDrive
    if ($volume.VolumeStatus -eq "FullyDecrypted") {
        Write-Host "Drive has been decrypted. BitLocker is now turned off for system drive" -BackgroundColor Green -ForegroundColor White
        break
    }
    
    Write-Host "System drive status: $($volume.VolumeStatus) | Encryption percentage $($volume.EncryptionPercentage)%." -ForegroundColor DarkYellow
    
    Start-Sleep -Seconds 5
}