# Resetting Passwords on the Cisco Firepower Firewall

## Note: The web interface and command line interface may be split on two different machines.
## Make sure that passwords are reset on both the web and command line interface.

## Reset Passwords on the Web Interface
1. Log in to the web interface as a user with administrator access.
2. Navigate to System > Users, and click the edit icon (a pencil) for each user.
3. Enter the new password in the **Password** and **Confirm Password** fields.
4. Click Save. If prompted to restart the device, then restart.
5. Verify that the passwords were changed for all users.

## Reset Passwords on the Command Line Interface
1. Log in to the administrator account over SSH or with the console.
2. If you do not immediately boot into a Linux shell, enter the command **expert** to access the Linux shell.
3. At the shell prompt enter the command **sudo passwd (the name of the user)** to change passwords for all users.
4. Enter the command **exit** to exit the shell/interface.
5. Verify that the passwords were changed for all users.