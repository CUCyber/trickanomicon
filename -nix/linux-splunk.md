# Linux Splunk Changes

## Pre-Execution Script Changes

All changes pertain to the `splunk.sh` script (competition-resources/Splunk/splunk.sh)
- Change INDEXER to the ip address of the splunk instance (receiver)
- Changed PASS to a different password
- Remove the else branch from the "if ! restart_splunk" (lines 126-128)

## Post script execution

Manually add source(s) to monitor:

1. Select a file (or entire directory) to monitor
1. Talk to a captain to obtain the index to use (most likely either "linux" or "windows")
1. Change directory into the **$SPLUNK_HOME/bin** directory (most likely **$SPLUNK_HOME** is `/opt/splunkforwarder`)
1. Run a command like `sudo ./splunk add monitor /path/to/thing/to/monitor -index <name of index>`

In the case where the chosen source is already being monitored (and you need to change something about how it is being monitored... e.g., changing the index):

1. Change directory into the $SPLUNK_HOME/bin directory
1. Run the command `sudo ./splunk remove monitor /path/to/thing/to/monitor`
1. Follow the previous set of steps to re-add the source as a monitor

These commands edit the file at the path `$SPLUNK_HOME/etc/apps/search/local/inputs.conf`. Do what you will with this information. It should be noted that making manual changes usually requires a restart of the splunk daemon to take effect. To do this: `sudo $SPLUNK_HOME/bin/splunk restart`
