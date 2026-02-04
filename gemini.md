# QZ Server Knowledge Base

## 🖥️ System Info
- **OS**: CachyOS (Arch-based)
- **Shell**: Fish
- **Terminal**: WezTerm
- **Prompt**: Starship

## 🛠️ Global Config Links (in ~/kb/qzserver)
- [Fish Config](./qzserver/fish)
- [WezTerm Config](./qzserver/wezterm)
- [Starship Config](./qzserver/starship.toml)
- [SSH Config](./qzserver/ssh)

## 🌐 Headless Server Tweaks
- **OS Base**: Arch/CachyOS optimized for performance.
- **Access**: Managed via SSH keys.
- **Environment**: Fish shell as default for interactive sessions.

---
*Last Updated: 2026年 02月 05日 星期四 00:06:57 CST*

## 🔒 Headless & Server Hardening
### Laptop Lid Behavior (Lid Close)
- Configured in `/etc/systemd/logind.conf`:
  - `HandleLidSwitch=ignore`
  - `HandleLidSwitchExternalPower=ignore`
  - `HandleLidSwitchDocked=ignore`

### System Boot & Performance
- **Default Target**: `multi-user.target` (No GUI/X11 by default)
- **Power Profile**: `performance`
- **Kernel**: Optimized CachyOS Kernel ($(uname -r))

### SSH Configuration
- Config file: `/etc/ssh/sshd_config`
- Key-based authentication recommended.
