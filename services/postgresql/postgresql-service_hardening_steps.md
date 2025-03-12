# PostgreSQL Hardening
1. Log in to the PostgreSQL console with **sudo psql**
2. Root’s password may be blank if it is not provided during the competition
3. If you can not log in, ensure the PostgreSQL service has properly started without logging errors (broken config file, networking error, etc.)
4. Change root user's password
	- In PostgreSQL, run **ALTER USER root WITH PASSWORD '(new password)';**
	- Alternatively, use **\password**
5. Verify/edit the config files in /etc/postgresql/(version number)/main
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
6. Audit users
	- Log in to the PostgreSQL console
	- Run **\\duS+** to view all users and their permissions
	- Remove unneeded users with **DROP USER (username)**;
7. Create backups
	- While the PostgreSQL service is running, run **sudo pg_dumpall > postgresql_dump**
	- Create a copy of the config files: **sudo cp -r /etc/postgresql/(version number)/main /path/to/backup/directory**
	- Also a good idea to backup the files for the postgreSQL service for systemctl should those files be altered or deleted
		- Located in /lib/systemd/system/ and/or /etc/systemd/system/
