# Windows notes

## set TLS settings for downloading (add this to splunk)

```powershell
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
```

## gpupdate on all domain machines

```powershell
Get-ADComputer -Filter * | ForEach-Object {
     Invoke-Command -ComputerName $_.Name -ScriptBlock {
         gpupdate /force 
    } 
}
```

## require kerb preauth on all accounts

```powershell
Get-ADUSer -Filter 'DoesNotRequirePreAuth -eq $true ' | Set-ADAccountControl -doesnotrequirepreauth $false
```

## download sysinternals

```powershell
Invoke-WebRequest -Uri "https://download.sysinternals.com/files/SysinternalsSuite.zip" -OutFile "C:\Users\sysinternals.zip"
```