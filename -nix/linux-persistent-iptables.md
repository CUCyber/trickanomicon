# Linux Persistent Iptables Service

**NOTE:** Using systemd

1\. Creating the Backup Script
------------------------------

*   Make a directory to store the restore script

        sudo mkdir /etc/iptables-persistent/

*   Put your iptables rules file in the created directory

        sudo cp /path/to/rules /etc/iptables-persistent/iptables-rules

*   Use one of the following to create the restore script (based on existence of iptables-restore):

        sudo vi /etc/iptables-persistent/restore.sh

    1\. Paste the following if ***iptables-restore*** exists:

        #!/bin/bash

        bin=`which iptables-restore`
        $bin < /etc/iptables-persistent/iptables-rules

    2\. Paste the following if ***iptables-restore*** does **NOT** exist

    **NOTE:** the iptables-rules file must be lines that finish the command ***sudo iptables*** and without any whitelines or comments):

        #!/bin/bash

        while read rule;
        do
            iptables $rule
        done < etc/iptables-persistent/iptables-rules

*   Make the script executable

        sudo chmod +x /etc/iptables-persistent/restore.sh

2\. Creating the Service
------------------------

*   Create the service file

        sudo vi /etc/systemd/system/iptables-persistent.service

*   Paste the following into the file

        [Unit]
        Description=iptables persistent service
        ConditionFileIsExecutable=/etc/iptables-persistent/restore.sh
        After=network.target

        [Service]
        Type=forking
        ExecStart=/etc/iptables-persistent/restore.sh
        start TimeoutSec=0
        RemainAfterExit=yes
        GuessMainPID=no

        [Install]
        WantedBy=multi-user.target

*   Enable the service

        sudo systemctl enable --now iptables-persistent.service
