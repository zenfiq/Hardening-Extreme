# Ultra Secure VPS Setup - Cloudflare DoH + Firewall Hardening + Fail2Ban + TCP Optimization

📦 Script ini secara otomatis:
- Update & upgrade server
- Pasang Cloudflare DNS over HTTPS (DoH) via `cloudflared`
- Kunci Firewall hanya port 22, 80, 443 (UFW + iptables)
- Aktifkan Fail2Ban untuk proteksi SSH brute-force
- Optimasi koneksi TCP Stack (Enable BBRv2)
- Setting Anti-DDoS dasar (iptables limit SYN, UDP, ICMP)
- Anti Port Scanning via iptables
- Auto-restore semua setting setelah reboot
- Health monitor untuk cloudflared service

---

## 📜 Fitur Lengkap:

| Fitur | Status |
|:------|:-------|
| Cloudflare Private DNS (DoH 1.1.1.1) | ✅ |
| Firewall Lockdown (22, 80, 443 only) | ✅ |
| Outbound DNS Lock (No Leak) | ✅ |
| Fail2Ban aktif untuk SSH Protection | ✅ |
| Anti TCP Flood, SYN Flood, UDP Flood, ICMP Flood | ✅ |
| Limit Max Connections per IP | ✅ |
| Block Port Scanning | ✅ |
| Enable BBRv2 (Google TCP Congestion Control) | ✅ |
| Cloudflared Auto Health Monitor (via cron) | ✅ |
| Auto-save firewall (iptables-persistent) | ✅ |

---

## 🚀 Cara Pakai:

1. Copy seluruh isi script ke file, contoh:
   
   ```bash
   nano secure-vps.sh
