# MariaDB and MySQL Service Hardening Steps
1. Log in to the mysql/mariadb console with sudo mysql -u root -p
2. Root’s password may be blank if it is not provided during the competition
3. If you can not log in, ensure the mysql service has properly started without logging errors (broken config file, networking error, etc.)
4. In MySQL, run **USE mysql;**
5. Change root user's password
	- If you’re on MySQL, run **ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '<new_password>';**
	- If you’re on MariaDB, run **ALTER USER 'root'@'localhost' IDENTIFIED BY '<new_password>';**
6. Run **FLUSH PRIVILEGES;**
7. Verify/edit the appropriate config file
	- MySQL: /etc/mysql/mysql.conf.d/mysqld.cnf
	- MariaDB: /etc/mysql/my.cnf and /etc/mysql/mariadb.conf.d/50-server.cnf
	- Verify that user is set to mysql
	- Verify that the port is set correctly (3306 by default)
	- Verify that the bind-address is set correctly
	- Add the line local-infile = 0 somewhere underneath the \[mysqld\] section
	- Save changes and restart mysql with sudo systemctl restart mysql
8. Audit users
	- Log in to the mysql/mariadb console
	- run **SELECT User, Host FROM mysql.user;** to view all users and their host values
	- Make sure host values are either a valid IP address or localhost. No user should have a host value of %.
	- To change a user’s host value, run the command **RENAME USER '(username)'@'(current_host)' TO '(username)'@'(new_host)';** Then run **FLUSH PRIVILEGES;** to apply the changes.
	- Remove unneeded users with **DROP USER (username)**;
9. Create backups
	- While the MySQL service is running, run **sudo mysqldump --all-databases --routines -u root -p > (path to backup .sql file)**
	- Create a copy of the config file: **sudo cp (path to config file) (path to backup config file)**
	- Create backups of the mysql service files used by systemctl
		- /lib/systemd/system/ and/or /etc/systemd/system/
