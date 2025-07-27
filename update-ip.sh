#!/bin/bash
shopt -s nullglob

# Collect all .conf files in the current directory
CONF_FILES=(*.conf)

# Exit if no .conf files are found
if [ ${#CONF_FILES[@]} -eq 0 ]; then
  echo "No .conf files found in the current directory."
  exit 1
fi

echo ""
echo "=== WireGuard Tunnel Updater ==="
echo ""

# Customize the select prompt
PS3="Enter the number of the tunnel to update: "
select CONF_FILE in "${CONF_FILES[@]}"; do
  if [ -n "$CONF_FILE" ]; then
    NAME="${CONF_FILE%.conf}"  # Remove .conf extension to get interface name
    break
  else
    echo "Invalid selection."
  fi
done

read -p "Enter the new EC2 Public IPv4 address (e.g., 12.123.12.12): " NEW_IP

# Exit if no input is provided
if [ -z "$NEW_IP" ]; then
  echo "No input provided. Exiting."
  exit 0
fi

# Replace only the IP (not the port) in the 'Endpoint' line within the [Peer] block
sed -i -E "/\[Peer\]/,/^\[/ s/(Endpoint = )[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+(:[0-9]+)/\1$NEW_IP\2/" "$CONF_FILE"

echo "Endpoint IP successfully updated to $NEW_IP."
