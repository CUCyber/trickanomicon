# Miscellaneous Linux Information
## Application Hardening
- [PHP hardening](https://cheatsheetseries.owasp.org/cheatsheets/PHP_Configuration_Cheat_Sheet.html)

## Firewall
```sh
# ufw
ufw status numbered
ufw delete $rule_number

ufw default deny incoming
ufw default allow outgoing

ufw allow 5432 comment "Service"
ufw deny 80
ufw deny proto udp from any to any port 8412:8500
ufw allow proto tcp from 192.168.0.4 to any port 22

# firewalld
firewall-cmd --list-all-zones
firewall-cmd --reload

firewall-cmd --get-default-zone # use this zone...

firewall-cmd --permanent --zone public --add-port 22/tcp
firewall-cmd --permanent --zone public --add-service https
firewall-cmd --permanent --zone public --remove-service http
firewall-cmd --permanent --zone public --add-rich-rule 'rule family "ipv4|ipv6" forward-port port "443" protocol "udp|tcp" to-port "8443"'

firewall-cmd --permanent --zone drop --add-source 10.0.0.0/24 # OR --zone block

firewall-cmd --permanent --zone public --set-target DROP

firewall-cmd --permanent --add-rich-rule='rule family="ipv4" service name="http" limit value="20/second" accept'

firewall-cmd --runtime-to-permanent # to test, omit --permanent then save after checking
```

### nftables
- <https://wiki.nftables.org/wiki-nftables/index.php/Rate_limiting_matchings>

```
#!/usr/sbin/nft -f

flush ruleset

table inet filter {
    set flood_limit {
        type ipv4_addr
        size 65535
        flags dynamic, timeout
        timeout 1m
    }

    chain input {
        type filter hook input priority 0; policy drop;

        ct state invalid drop
        iif "lo" accept
        ct state established,related accept

        tcp dport { 80, 443 } ct state new \
            update @flood_limit { ip saddr limit rate over 20/minute burst 5 packets } \
            counter drop

        ip protocol icmp icmp type { destination-unreachable, time-exceeded, parameter-problem, echo-request, echo-reply } accept

        tcp dport { 80, 443 } ct state new accept  # web
    }

    chain forward {
        type filter hook forward priority 0; policy drop;
    }

    chain output {
        type filter hook output priority 0; policy drop;

        ct state new,established,related accept
    }
}
```

## Extension
- `Dashboard`, `Settings`, `Restore from file...`
```json
{"timeStamp":0,"version":"1.69.0","userSettings":{"advancedUserEnabled":true,"importedLists":[],"popupPanelSections":31},"selectedFilterLists":["user-filters","ublock-filters","ublock-badware","ublock-privacy","ublock-quick-fixes","ublock-unbreak","easylist","adguard-generic","easyprivacy","adguard-spyware-url","block-lan","urlhaus-1","curben-phishing","plowe-0","dpollock-0"],"hiddenSettings":{"filterAuthorMode":true},"whitelist":["chrome-extension-scheme","moz-extension-scheme"],"dynamicFilteringString":"behind-the-scene * * noop\nbehind-the-scene * inline-script noop\nbehind-the-scene * 1p-script noop\nbehind-the-scene * 3p-script noop\nbehind-the-scene * 3p-frame noop\nbehind-the-scene * image noop\nbehind-the-scene * 3p noop\n* * 3p block","urlFilteringString":"","hostnameSwitchesString":"no-large-media: behind-the-scene false\nno-csp-reports: * true","userFilters":""}
```

## sysctl
<https://github.com/k4yt3x/sysctl/raw/master/sysctl.conf>

```
net.ipv4.tcp_syncookies=1
net.ipv4.tcp_max_syn_backlog=2048
net.ipv4.tcp_fin_timeout=30
net.core.somaxconn=1024
```

## auditd
<https://github.com/Neo23x0/auditd/raw/master/audit.rules>

## Snoopy
<https://github.com/a2o/snoopy>

## Others
```
mount -o remount,nodev,nosuid,noexec /tmp
mount -o remount,nodev,nosuid,noexec /var/tmp
mount -o remount,nodev,nosuid,noexec /dev/shm
```
