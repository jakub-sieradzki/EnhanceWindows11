Import-Module "$PSScriptRoot\..\Helpers.psm1" -Force

Write-Host "Changing DNS Settings..." -BackgroundColor Gray -ForegroundColor Black

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters"

Add-MissingKeys -Paths $regPath
New-ItemProperty -Path $regPath -Name "EnableAutoDoh" -Value 2 -PropertyType DWord -Force | Out-Null

$dohServers = @(
    @{ IP = "1.1.1.2"; Template = "https://security.cloudflare-dns.com/dns-query" },
    @{ IP = "1.0.0.2"; Template = "https://security.cloudflare-dns.com/dns-query" },
    @{ IP = "2606:4700:4700::1112"; Template = "https://security.cloudflare-dns.com/dns-query" },
    @{ IP = "2606:4700:4700::1002"; Template = "https://security.cloudflare-dns.com/dns-query" }
)

foreach ($server in $dohServers) {
    $existing = Get-DnsClientDohServerAddress -ServerAddress $server.IP -ErrorAction SilentlyContinue
    if ($existing) {
        Set-DnsClientDohServerAddress -ServerAddress $server.IP -DohTemplate $server.Template -AllowFallbackToUdp $False -AutoUpgrade $True | Out-Null
    }
    else {
        Add-DnsClientDohServerAddress -ServerAddress $server.IP -DohTemplate $server.Template -AllowFallbackToUdp $False -AutoUpgrade $True | Out-Null
    }
}

$ipAddresses = $dohServers.IP
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters"

Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | ForEach-Object {
    Set-DnsClientServerAddress -InterfaceIndex $_.ifIndex -ServerAddresses $ipAddresses | Out-Null

    foreach ($ip in $ipAddresses) {
        if ($ip -match ":") {
            $dohPath = "$regPath\$($_.InterfaceGuid)\DohInterfaceSettings\Doh6\$ip"
        }
        else {
            $dohPath = "$regPath\$($_.InterfaceGuid)\DohInterfaceSettings\Doh\$ip"
        }
        Add-MissingKeys -Paths $dohPath
        New-ItemProperty -Path $dohPath -Name "DohFlags" -Value 1 -PropertyType QWORD -Force | Out-Null
    }   
}

Clear-DnsClientCache

Write-Host "Changing DNS Settings completed" -BackgroundColor Green -ForegroundColor White