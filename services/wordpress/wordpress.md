# Wordpress

Source: https://www.wpbeginner.com/wordpress-security/

## Checklist
1. Reset Password
	- Click on profile (top right)
	- Scroll down to "Set New Password"
	- Default user is admin
2. Check when wp-config.php was last edited
	- ls -lt /var/www/html/wp-config.php
3. Check for any file types of .php, .js, .exe
	- ls -la /var/www/html/wp-content/uploads
4. Verify Wordpress Database Information
	- First, begin a mysql session and select the wordpress database:
		- show databases;
		- use wordpress;
		- show tables;
	- Verify Default Wordpress Tables:
		- wp_commentmeta
		- wp_comments
		- wp_links
		- wp_options
		- wp_postmeta
		- wp_posts
		- wp_term_relationships
		- wp_term_taxonomy
		- wp_termmeta
		- wp_terms
		- wp_usermeta
		- wp_users
	- Things to look for:
		- select * from wp_options where option_name='active_plugins';
		- select * from wp_options where option_name='cron';
5. Plugins
	- Default plugins:
		- Akismet Anti-Spam
		- Hello Dolly
6. Updates
	- make sure you are on latest version of wordpress (can find this under the "Updates" section)
	- make sure plugins are up to date
7. Backups
	- take a backup of the entire /var/www/html directory
		- tar -czvf www-backup.tar.gz /var/www/html
8. Disable File editing
	- in wp-config.php add the following line
		- define( 'DISALLOW_FILE_EDIT', true );
9. Security Plugins
	- "Limit Login Attempts Reloaded"
		- Default settings:
			- 4 allowed retries
			- 20 minutes lockout
			- 4 lockouts increase lockout time to 24hrs
		- Can configure settings under "Settings" Tab by the plugins name
