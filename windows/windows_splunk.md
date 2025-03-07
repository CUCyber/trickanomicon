# Windows Splunk Changes

```powershell
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
```

## splunk.ps1

- Set Indexer IP
- Set username and password (username in script, env $password or replace in script)
- Set `index=windows` for all log sources

## once installed

```powershell
C:\Program Files\SplunkUniversalForwarder\etc\system\local\ inputs.conf outputs.conf
```

```powershell
C:\Program Files\SplunkUniversalForwarder\var\log\splunk\ splunkd.log
```

## inputs.conf

```
 [default]
host = ${HOSTNAME}

[WinEventLog] 
index = windows
checkpointInterval = 5

[WinEventLog://Security]
disabled = 0
index = windows

[WinEventLog://Application]
dsiabled = 0
index = windows

[WinEventLog://System]
disabled = 0
index = windows

[WinEventLog://DNS Server]
disabled = 0
index = windows

[WinEventLog://Directory Service]
disabled = 0
index = windows

[WinEventLog://Windows Powershell]
disabled = 0
index = windows

[WinEventLog://Microsoft-Windows-Sysmon/Operational]
current_only = 0
disabled = 0
start_from = oldest
index=windows
renderXml = false

[WinEventLog://Microsoft-Windows-Sysmon/Operational]
current_only = 0
disabled = 0
start_from = oldest
index=windows
renderXml = false 
```