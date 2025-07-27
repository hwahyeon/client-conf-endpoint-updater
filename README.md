# Client Endpoint Updater

A simple CLI utility for WireGuard **clients** to update the `Endpoint` IP address in a `.conf` file and restart the tunnel.

This is especially useful for users running a WireGuard server (e.g., on AWS EC2) **without a domain name or Elastic IP**, where the public IPv4 address changes after each reboot.

Instead of manually editing your client configuration and restarting the interface, this script automates the entire process.

## What This Script Does

- Scans for available `.conf` files in the current directory
- Prompts you to select the tunnel to update
- Asks for the new public IPv4 address (e.g., from your EC2 dashboard)
- Updates the `Endpoint = x.x.x.x:port` line inside the `[Peer]` block
- Automatically restarts the selected WireGuard interface using `wg-quick`

## Usage

### 1. Prepare your configuration files

Place the script and your `.conf` file(s) in the **same directory**.

Example format:

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

Ensure you are using a **Bash-compatible CLI environment**  
(Linux, macOS Terminal, or WSL/Git Bash on Windows):

```bash
chmod +x update-ip.sh
./update-ip.sh
```

Follow the prompts to:

1. Select a `.conf` file
2. Enter the new public IP

The script will:

- Update the `Endpoint` line
- Restart the interface using `wg-quick`
