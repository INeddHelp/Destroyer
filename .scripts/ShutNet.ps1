$ipAddresses = @()
for ($i = 1; $i -le 254; $i++) {
    $ip = "192.168.1.$i"
    Write-Host "Scanning $ip"
    $pingResult = Test-Connection -ComputerName $ip -Count 1 -ErrorAction SilentlyContinue
    if ($pingResult) {
        $ipAddresses += $ip
    }
}

Set-Content -Path "Ips.txt" -Value $ipAddresses

foreach ($ip in $ipAddresses) {
    Write-Host "Shutting down $ip"
    $pingResult = Test-Connection -ComputerName $ip -Count 1 -ErrorAction SilentlyContinue
    if ($pingResult) {
        $computerName = $(nslookup $ip | Select-String "name =" | Out-String).Trim() -replace ".*name = ([^\.]*)\..*", '$1'
        if ($computerName) {
            $deviceType = ""
            $osName = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computerName | Select-Object -ExpandProperty Caption
            if ($osName -match "Windows") {
                $deviceType = "Windows"
            } elseif ($osName -match "Linux") {
                $deviceType = "Linux"
            } elseif ($osName -match "macOS") {
                $deviceType = "Mac"
            } else {
                Write-Warning "Unknown operating system for $ip"
            }

            switch ($deviceType) {
                "Windows" {
                    Invoke-Command -ComputerName $computerName -ScriptBlock {shutdown.exe /s /t 0}
                    break
                }
                "Linux" {
                    Invoke-Command -ComputerName $computerName -ScriptBlock {shutdown -h now}
                    break
                }
                "Mac" {
                    Invoke-Command -ComputerName $computerName -ScriptBlock {sudo shutdown -h now}
                    break
                }
                default {
                    Write-Warning "No action taken for $ip"
                }
            }
        } else {
            Write-Warning "Could not resolve computer name for IP address $ip"
        }
    } else {
        Write-Warning "Could not connect to IP address $ip"
    }
}

Clear-Content "Ips.txt"
