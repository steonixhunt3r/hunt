#!/bin/bash

# Function to expand a CIDR address
prips() {
    local cidr="$1"
    local lo hi a b c d e f g h

    # Extract the network and prefix length
    IFS=/ read -r lo hi <<< "$cidr"
    IFS=. read -r a b c d <<< "$lo"
    e=$(( (1 << (32 - hi)) - 1 ))

    # Loop through the IP addresses
    for i in $(seq 0 "$e"); do
        printf "%d.%d.%d.%d\n" "$((a + (i >> 24 & 255)))" "$((b + (i >> 16 & 255)))" "$((c + (i >> 8 & 255)))" "$((d + (i & 255)))"
    done
}

# Usage: ./cidr-to-ip.sh 192.168.0.1/24
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <CIDR>"
    exit 1
fi

# Call the function with the provided CIDR
prips "$1"
