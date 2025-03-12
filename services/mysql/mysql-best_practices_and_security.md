# MariaDB and MySQL

## MySQL Config File
When installed, the mysql service will automatically start and run upon system startup on port 3306. The config file is stored in /etc/mysql/mysql.conf.d/mysqld.cnf.

## MariaDB Config File
When installed, the mysql service will automatically start and run upon system startup on port 3306. The config files are stored in /etc/mysql/my.cnf and /etc/mysql/mariadb.conf.d/50-server.cnf (this file contains Maria-DB server specific settings).

## Securing the Services and Databases
### The config file:
- Ensure that these fields are set properly
	- User (should be mysql)
	- Ensure that the user mysql does not have sudo privileges, i.e., not in any sudoers group
	- Do not set the user to root!
- Port (3306 by default if no value is present)
- Bind-address (typically localhost or 127.0.0.1 if the database is hosted on the same machine with the config file)
- Disable local-infile
	- Include the line local-infile = 0 anywhere underneath \[mysqld\] in the config file
	- Local-infile introduces a security risk as enabling it allows users to import data from files on disk into a database table
- After making changes to the config file, restart mysql with **sudo systemctl restart mysql**

### The service files:
- MariaDB and MySQL’s service files are stored in /lib/systemd/system/ and/or /etc/systemd/system/
- Things to look out for:
	- User and Group should be set to mysql, as shown below
	- If they are set to anything else (such as root), red team can leverage exploits for privilege escalation
	- To check which user mysql is running as, use the command ps aux | grep mysql
- Good idea to backup the service files as well in case of deletion/alteration

### Passwords:
- By default, the root user in MySQL has no password. To change root’s password, open a mysql session with **sudo mysql -u root**
- Run **Use mysql;**
- If you’re on MySQL, run **ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '(new_password)';**
- If you’re on MariaDB, run **ALTER USER 'root'@'localhost' IDENTIFIED BY '(new_password)'**;
- Run **FLUSH PRIVILEGES;**

### Auditing Users:
- In an open MYSQL session, run **SELECT User, Host FROM mysql.user;** to view all users and their host values
- Host values are either localhost or an IP address. They restrict a user’s connection to that host only, i.e., a host value of localhost restricts connections to the local machine.
- A host value of % allows the user to connect from any host. Ensure that the root user and other system users have a host value of localhost. Ideally, no user should have a host value of %.
- To change a user’s host value, run the command **RENAME USER '(username)'@'(old_host)' TO '(username)'@'(new_host)';** Then run **FLUSH PRIVILEGES;** to apply the changes.

### Removing unwanted users: 
- run **DROP USER (username);**

### Backing up the databases:
- While the MySQL service is running, run **sudo mysqldump --all-databases --routines -u root -p > (path to a backup .sql file)**
- Create a copy of the config file: **sudo cp (path to config file) (path to backup config file)**
- Also a good idea to backup the files for the mysql service for systemctl should those files be altered or deleted

### Restoring the databases:
- sudo cp (path to backup config file) (path to config file)
- sudo systemctl stop mysql  
- sudo rm -rf /var/lib/mysql/*
- sudo mysqld --initialize
- sudo chown -R mysql: /var/lib/mysql
- sudo systemctl start mysql
- cat (path to backup .sql file) | sudo mysql -u root -p
