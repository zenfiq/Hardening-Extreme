#!/bin/bash

echo "=== Update Server ==="
apt update && apt upgrade -y

echo "=== Install Fail2Ban ==="
apt install fail2ban -y

echo "=== Enable Fail2Ban SSH Protection ==="
cat > /etc/fail2ban/jail.d/ssh.conf <<EOF
[sshd]
enabled = true
port = ssh
logpath = %(sshd_log)s
maxretry = 3
findtime = 600
bantime = 3600
EOF

systemctl restart fail2ban
systemctl enable fail2ban

echo "=== Limit Connections per IP (iptables) ==="
iptables -A INPUT -p tcp --syn -m connlimit --connlimit-above 30 -j DROP

echo "=== Enable SYN cookies ==="
sysctl -w net.ipv4.tcp_syncookies=1

echo "=== Hardening sysctl.conf ==="
cat >> /etc/sysctl.conf <<EOF

# Extra Anti-DDoS Hardening
net.ipv4.conf.all.rp_filter = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.ipv4.tcp_rfc1337 = 1
net.ipv4.tcp_syncookies = 1
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF

sysctl -p

echo "=== Anti Port Scanning via iptables ==="
iptables -N PORT-SCANNING
iptables -A PORT-SCANNING -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j RETURN
iptables -A PORT-SCANNING -j DROP
iptables -A INPUT -p tcp --tcp-flags SYN,ACK,FIN,RST RST -j PORT-SCANNING

echo "=== Save iptables rules ==="
netfilter-persistent save
netfilter-persistent reload

echo "=== DONE! Server kamu sekarang Hardening Extreme aktif! ==="
echo "✅ Fail2Ban aktif"
echo "✅ TCP protection aktif"
echo "✅ Port scan block aktif"
echo "✅ Syn cookies aktif"
echo "✅ IPv6 disabled"
