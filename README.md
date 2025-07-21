# Client Endpoint Updater

This is a simple utility script for updating the `Endpoint` IP address in a WireGuard `client.conf` file.

It is especially useful for users running a WireGuard server (for example, on AWS EC2) without a domain name or Elastic IP, whether for initial testing or personal use.

In such cases, the server’s public IPv4 address changes after each reboot, and the new address must be manually updated in the `client.conf` file.  
This script simplifies the process by prompting you to enter the new IP address and automatically applying the change.

## What this script does

- Prompts you to enter the new public IPv4 address (e.g., from your EC2 dashboard)
- Searches for the `[Peer]` block in your `client.conf`
- Replaces only the IP portion of the `Endpoint = x.x.x.x:port` line
- Leaves the port and all other configuration untouched

## Usage

### 1. Prepare your `client.conf`

The script expects `client.conf` to be in the **same directory** as the script itself.  
Example `client.conf` format:

```ini
[Interface]
PrivateKey = <your-private-key>
Address = 10.0.0.2/32
DNS = 1.1.1.1

[Peer]
PublicKey = <server-public-key>
Endpoint = 198.51.100.23:51820   <----- this is the line that gets updated
AllowedIPs = 0.0.0.0/0, ::/0
PersistentKeepalive = 25
```

### 2. Run the script

Make sure you have a Bash environment available (this is standard on Linux and macOS, and available via Git Bash or WSL on Windows).

```bash
chmod +x update-ip.sh
./update-ip.sh
```

You will be prompted to enter the new public IP address. The script will automatically update the relevant line in your `client.conf` file.


## Easy launchers

To simplify execution on each platform, there are launcher files stored in separate branches:

| Platform | Branch | File | Notes |
|----------|--------|------|-------|
| Windows  | [`windows-launcher`](https://github.com/hwahyeon/client-conf-endpoint-updater/tree/windows-launcher) | `update-ip.bat` | Requires [Git Bash](https://git-scm.com) |
| Linux    | [`linux-launcher`](https://github.com/hwahyeon/client-conf-endpoint-updater/tree/linux-launcher)   | `update-ip.desktop` | Double-clickable `.desktop` file |

> Place the launcher file and `client.conf` in the same directory as `update-ip.sh`.
