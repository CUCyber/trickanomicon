# PostgreSQL

## Config Files
- When installed, the postgresql service will automatically start and run upon system startup on port 5432. The config files are stored in /etc/postgresql/(version number)/main.

- Important config files are
	- pg_hba.conf
		- Client Authentication Config File
		- Controls which hosts can connect to the PostgreSQL server, how clients are authenticated, which users they can log in as, and which databases they can access
		- Remove all suspicious entries from the file
		- Check for out-of-place users and hosts
	- postgresql.conf
		- Main Config File for PostgreSQL
		- Important fields
			- listen_addresses: which IPs to listen on
			- port: should always be set to 5432
			- password_encryption

- Check if any malicious files are in /etc/postgresql/(version number)/main/conf.d
- After updating config files, restart the service using **sudo systemctl restart postgresql**

### The service files:
- PostgreSQL’s service files are stored in /lib/systemd/system/ and/or /etc/systemd/system/
- Good idea to backup the service files as well in case of deletion/alteration

### Passwords:
- By default, the root user in PostgreSQL has no password. To change root’s password, run **ALTER USER root WITH PASSWORD '(new password)';**

### Auditing Users:
- In an open PostgreSQL session, run **\\duS+** to view all users and their permissions
- Add new users with the command **CREATE USER (username);**

### Removing unwanted users: 
- run **DROP USER (username);**

### Backing up the databases:
- While the PostgreSQL service is running, run **sudo pg_dumpall > postgresql_dump**
- Create a copy of the config files: **sudo cp -r /etc/postgresql/(version number)/main /path/to/backup/directory**
- Also a good idea to backup the files for the postgreSQL service for systemctl should those files be altered or deleted

### Restoring the databases:
- **psql -X -f postgresql_dump postgres**
- Restore config files
- Restore systemctl service files

