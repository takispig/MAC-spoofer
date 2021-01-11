#!/bin/bash
echo ""
echo "This script will just change your MAC Address with a random one"
echo ""

sleep 1

# this returns the current network device, useful for ip link [] commands
network_dev=`ip address | grep -v lo | cut -d ' ' -f2 | tr ':' '\n' | awk NF`

echo "Setting network interface down..."
sudo ip link set dev $network_dev down
echo "...changing the MAC Address..."
rand_mac=`openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`
sudo ip link set $network_dev address $rand_mac
echo "...setting network interface up again."
sudo ip link set $network_dev up
echo "Your new MAC Address is:"
ip -a link show $network_dev | grep link/ether | awk '{print $2;}'

echo "Check github's repository: https://github.com/takispig/MAC-spoofer"

/bin/bash