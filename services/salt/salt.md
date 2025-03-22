# Salt
<https://docs.saltproject.io/en/latest/topics/tutorials/walkthrough.html>

## Commands (Execution Modules)
### Basics
```sh
# ping minions
sudo salt '*' test.ping

# list version
sudo salt -v '*' test.version

# install command
sudo salt -v '*linux*' pkg.install vim

# apply /srv/salt/test.sls
sudo salt -v '*linux*' state.apply test

# run commands (can use pipes, command substitution, etc.)
sudo salt '*linux*' cmd.run 'uptime'

# execute other code
sudo salt '*' cmd.exec_code perl 'print("hello")'
sudo salt '*' cmd.exec_code ruby 'puts "cheese"' args='["arg1", "arg2"]' env='{"FOO": "bar"}'
```

### Copying Files
```sh
# put files into /srv/salt to use salt://
sudo salt '*linux*' cp.get_file salt://files/reset_passwords.pl /tmp/reset_passwords.pl

sudo salt '*linux*' cp.get_dir salt://files /tmp/files
sudo salt '*win*' cp.get_dir salt://files C:/ # no \

sudo salt-cp '*linux*' src dest # slower

# push files from minion; /var/cache/salt/master/minions/minion-id/files
sudo salt '*linux*' cp.push_dir /var/www/html/index.html
sudo salt '*linux*' cp.push_dir /var/www/html
```

### User Administration
```sh
# user management
sudo salt 't*' user.add jp2

# get users
sudo salt '*' ps.get_users

# add/remove user to group
sudo salt '*' group.adduser group user 
sudo salt '*' group.deluser group user

# delete group
sudo salt '*' group.delete group

# get all group info
sudo salt '*' group.getent

# set group members (replaces users)
sudo salt '*' group.members group 'user1,user2,user3'

# set password
sudo salt '*' shadow.gen_password 'password'
sudo salt '*' shadow.set_password someuser 'hash'
```

### System Info
```sh
# get disk partitons
sudo salt '*' ps.disk_partitions

# get running processes
sudo salt '*' ps.status running
sudo salt '*' ps.top
sudo salt 'linux*' ps.aux '.*'
sudo salt '*' ps.get_pid_list
```

### Services & More
```sh
# crontabs!!! (list/add/remove)
sudo salt '*' cron.ls user
sudo salt '*' cron.set_job root '*' '*' '*' '*' '*' cmd
sudo salt '*' cron.set_special root @hourly 'echo foobar'

# install wordpress
sudo salt '*' wordpress.install /var/www/html apache dwallace password123 dwallace@example.com "Daniel's Awesome Blog" https://blog.dwallace.com

# mysql
sudo salt '*' mysql.db_create 'dbname'
sudo salt '*' mysql.db_remove 'dbname'
sudo salt '*' mysql.query 'dbname' 'DELETE from users where id = 4 limit 1'

# services
sudo salt '*' service.get_all
sudo salt '*' service.restart service
sudo salt '*' service.start service
sudo salt '*' service.stop service
```

## Sample `.sls` File
```yaml
network_utilities:
  pkg.installed:
    - pkgs:
      - rsync
      - curl

nginx_pkg:
  pkg.installed:
    - name: nginx

nginx_service:
  service.running:
    - name: nginx
    - enable: True
    - require:
      - pkg: nginx_pkg
```

## Firewall Rules
### Minion Rules
```sh
sudo salt '*' iptables.build_rule match=conntrack connstate=RELATED,ESTABLISHED jump=ACCEPT

sudo salt 't*' cmd.run 'iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT'
sudo salt 't*' cmd.run 'iptables -A OUTPUT -d 10.3.12.150 -p tcp --dport 4505 -j ACCEPT'
sudo salt 't*' cmd.run 'iptables -A OUTPUT -d 10.3.12.150 -p tcp --dport 4506 -j ACCEPT'
```

### Master Rules
```sh
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

sudo iptables -A INPUT -i lo -p tcp -m multiport --dports 4505:4506 -j ACCEPT # allow salt localhost comm
sudo iptables -A INPUT -p tcp -m multiport --dports 4505:4506 -j ACCEPT # minion comm

sudo iptables -A OUTPUT -p tcp -m iprange --dst-range 10.3.12.1-10.3.12.4 -j ACCEPT

sudo iptables -A INPUT -i lo -p tcp -m multiport --dports 4505:4506 -j ACCEPT
sudo iptables -A INPUT -p tcp -m multiport --dports 4505:4506 -j ACCEPT

sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT # inbound
sudo iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT # outbound
```
