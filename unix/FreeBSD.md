# FreeBSD

## Package Manager
- FreeBSD uses the package manager pkg, similar to the package manager apt
- Example usage commands
	- **sudo pkg update**
	- **sudo pkg install (package name)**
	- **sudo pkg delete (package name)**

## Monitoring Services
- Services and other scripts run at system startup are located in the directories
	- /etc/rc.d/ 
	- /usr/local/etc/rc.d/
	- Scripts are ran at the kernel level (higher privileges than the root user)
	- Each script is a POSIX-compliant /bin/sh script with no file extension

```
#!/bin/sh

my_example_service code

```

- Use the service command to view services and their status
	- List all enable services
		- **service -e**
	- List all loaded services (enabled or not enabled)
		- **service -l**
		- Check for any malicious/unneeded services and remove the file from /etc/rc.d or /usr/local/etc/rc.d as needed
	- Start, stop, and restart services
		- **service (service name) start**
		- **service (serivce name) stop**
		- **service (service name) restart**
	- Enable and disable services
		- **service (service name) enable**
		- **service (service name) disable**
	- Reload a service (this applies configuration file changes to services without a full restart)
		- **service (service name) reload**
		- Note that all services may not support this feature. If a service does not support reload, restart it instead to apply configuration file changes.
	- View the status of a service
		- **service -v (service name) status**
			- When running, the process ID is shown
			- The directory the service file is located in is shown
			- This command's output is not very descriptive. We recommend using the ps command to view more information about the service. Additionally, navigate to the service's directory and view its shell script.

## Checking Network Connections
- The sockstat command displays network and system opened sockets in FreeBSD
- List all opened ports
	- **sockstat**
- List all listening ports
	- **sockstat -l**
- List all TCP or UDP sockets
	- **sockstat -P udp**
	- **sockstat -P tcp**
	- **sockstat -P tcp,udp**
	- **sockstat -P tcp -p 80, 443** 
		- **-p** allows for filtering by port numbers
- List all Unix sockets and named pipes
	- **sockstat -u**

## Changing File Flags
- Alongside the **chattr** command, FreeBSD includes the **chflags** command to set file flags
- Examples
	- Set the system immutable flag
		- **sudo chflags schg (filepath)**
		- Remove the flag: **sudo chflags noschg (filepath)**
	- Set the system append-only flag
		- **sudo chflags sappnd (filepath)**
		- Remove the flag: **sudo chflags noappnd (filepath)**
	- Set the system undeletable flag
		- **sudo chflags sunlnk (filepath)**
		- Remove the flag: **sudo chflags nounlnk (filepath)**
- To view which flags are set on a file, run **ls -lo (filepath)**

## System Configuration Files
- FreeBSD's main system configuration file is /etc/rc.conf
	- System variables can be changed by either editing this file or using the **sysrc** command
	- To check the value of a variable in rc.conf, run **sudo sysrc (variable name)**
	- To set a variable's value, run **sudo sysrc (variable name)=(new value)**
	- To append a value to a variable run **sudo sysrc (variable name)+=(value to append)
	- To remove a value from a variable run **sudo sysrc (variable name)-=(value to remove)**
- Note that rc.conf should not be made immutable, as sysrc commands won't be able to update variable names
- Limit rc.conf visibility and read/write permissions to only the root user:
	- **sudo chown root:(sudoers group) /etc/rc.conf**
	- **sudo chmod 640 /etc/rc.conf**

## The Kernel Securelevel
- The FreeBSD kernel has five different levels of security
- If the rc.conf variable **kern_securelevel_enable** is set to "YES", then the kernel level is enforced
	- Otherwise, if **kern_securelevel_enable** is set to "NO", then the kernel level is disabled and always set to Level -1
- The current level is stored in the rc.conf variable **kern.securelevel**
	- Level -1: permanently insecure mode
		- Always run the system in level 0 mode
		- Default initial value upon installation
	- Level 0: insecure mode
		- Immutable and append-only flags may be turned off
	- Level 1: secure mode
		- The system immutable and system append-only flags may not be turned off
		- Note that not even the root user can remove the system immutable and system append-only flags
	- Level 2 is basically identical to level 1
	- Level 3: nearly identical to level 1, except IP packet filter rules cannot be changed
- Any super-user process can raise the security level, but no process can lower the level
	- To lower or raise **kern.securelevel**, use the command **sudo sysrc kern.securelevel=(new level)**
	- If /etc/rc.conf is made immutable, this command along with other sysrc commands to alter variables will not work

