# Windows Notes
By: Aaron Sprouse and Dylan Harvey

## Set TLS Settings for Downloading (any download + splunk)
```powershell
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
```

## Require Kerberos Preauth on all Accounts
```powershell
Get-ADUSer -Filter 'DoesNotRequirePreAuth -eq $true ' | Set-ADAccountControl -doesnotrequirepreauth $false
```

## Download Sysinternals
```powershell
Invoke-WebRequest -Uri "https://download.sysinternals.com/files/SysinternalsSuite.zip" -OutFile "C:\sysinternals.zip";
Expand-Archive -Path "C:\sysinternals.zip" -DestinationPath "C:\sysinternals\"
```

## Remove WMI Event Subscribers
```powershell
Get-WmiObject -Namespace root/subscription -Class CommandLineEventConsumer

Get-WmiObject -Namespace root/subscription -Class __EventFilter

Get-WmiObject -Namespace root/subscription -Class __FilterToConsumerBinding

Get-WmiObject -Class __IntervalTimerInstruction

<command> | Remove-WmiObject
```

## Bins to Remove
- `C:\Windows\System32\sethc.exe`
- `C:\Windows\System32\Utilman.exe`
- `C:\Windows\System32\osk.exe` - May require TrustedInstaller
- `C:\Windows\System32\Narrator.exe`
- `C:\Windows\System32\Magnify.exe`
- `C:\Windows\System32\DisplaySwitch.exe`
