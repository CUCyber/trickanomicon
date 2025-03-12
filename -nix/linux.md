Linux CCDC Basic Checklist
==========================

1\. Network Scanning & Enumeration
----------------------------------

### Nmap Scanning

*   Scan all ports:

        nmap -p- <IP ADDRESS>


*   Ping sweep for active hosts:

        nmap 10.10.10.0-10
        nmap 10.10.10.0/24


*   Scan specific ports for service versions and OS detection, saving output to a file:

        nmap -sS -sV -O <IP ADDRESS> > nmap.txt



2\. User & Password Management
------------------------------

### Reset Passwords

(expects /etc/passwd copy with only accounts you want to reset the password for to be in the file)

#### Without saving passwords:

    for user in $(cat ./users | awk -F: '{print $1}'); do echo "$user:m0Nk3y!m0Nk3y!" | sudo chpasswd; done


#### With saving passwords to a file:

    for user in $(cat ./users | awk -F: '{print $1}'); do echo "$user:m0Nk3y!m0Nk3y!" | tee -a ./new_passwords | sudo chpasswd; done


### Create a New User

    useradd user -m -s /bin/bash -g sudo


*   Alternatively, add group separately:

    usermod -aG sudo|wheel user


*   Add public key to `.ssh/authorized_keys`

### Disable Accounts

    usermod -L <user>


### Enable Accounts

    usermod -U <user>


3\. SSH Security & Key Management
---------------------------------

### Rotate SSH Keys

*   Find `authorized_keys` files:

        find / -name "authorized_keys" 2>/dev/null


*   Replace contents with the new public key
*   Securely copy the new key:

        scp whatever.pub name@10.10.10.10:/home/name/.ssh/



### Secure `/etc/ssh/sshd_config`

*   Verify default SSH port
*   Disable root login
*   Disallow empty passwords
*   (Optional) Disable password authentication entirely

4\. System & Service Management
-------------------------------

### System Logs

*   Check authentication logs:

        cat /var/log/auth.log


*   Installed package logs:

        cat /var/log/dpkg.log


*   Terminal command logs:

        cat /var/log/term.log


*   Review logs in reverse order:

        journalctl -r



### Systemctl Commands

*   Check service status:

        systemctl status <service>


*   View service configuration:

        systemctl cat <service>


*   Restart a service:

        systemctl restart <service>


*   Enable and start a service:

        systemctl enable --now <service>


*   Disable a service:

        systemctl disable <service>


*   Stop a service:

        systemctl stop <service>



5\. Process & Cron Job Monitoring
---------------------------------

### Active Processes & Connections

*   View active processes:

        top


*   List active network connections:

        ss -tupa


*   List running processes:

        ps aux



### Crontab & Scheduled Tasks

*   View user crontabs:

        crontab -l


*   Edit crontab:

        crontab -e


*   Check system cron jobs:

        ls -la /etc/cron.*

*   Find crontabs of all users

		for user in $(cut -f1 -d: /etc/passwd); do echo "user: $user"; crontab -u "$user" -l 2>/dev/null && echo ""; done




6\. Security Hardening & Permissions
------------------------------------

### Remove SUID Binaries

*   Find all SUID binaries:

        find / -perm -u=s


*   Find files with read-only permissions:

        find / -type f -perm -0400 -ls 2>/dev/null


*   Remove SUID permissions:

        chmod a-s <file path>


*   Add SUID permissions:

        chmod u+s <file path>



### Secure `/etc/sudoers`

*   Ensure it is only writable by root:

        chmod 0440 /etc/sudoers



7\. Incident Response & Documentation
-------------------------------------

### Kill Active Sessions

*   Kill by TTY:

        pkill -9 -t <TTY>


*   Find your own TTY:

        tty


*   Kill by username:

        pkill -9 -u <username>


*   Kill by PID:

        kill -9 <PID>

*   Kill by process name:

        pkill <process name>



### Backups

*   Take a backup of `/etc/` directory or any other mission critial services:

        tar -czvf etc-backup.tar.gz /etc/



### Documentation

*   Record findings for incident response
*   Save nmap scans & security incidents
*   Maintain logs for injects & investigations
