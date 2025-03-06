# Windows Splunk Changes

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