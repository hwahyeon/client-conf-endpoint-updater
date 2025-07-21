#!/bin/bash

CONF_FILE="./client.conf"

read -p "Enter the new EC2 Public IPv4 address (e.g., 12.123.12.12): " NEW_IP

# Exit if no input is provided
if [ -z "$NEW_IP" ]; then
  echo "No input provided. Exiting."
  exit 0
fi

# Replace only the IP (not the port) in the 'Endpoint' line within the [Peer] block
sed -i -E "/\[Peer\]/,/^\[/ s/(Endpoint = )[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+(:[0-9]+)/\1$NEW_IP\2/" "$CONF_FILE"

echo "Endpoint IP successfully updated to $NEW_IP."
