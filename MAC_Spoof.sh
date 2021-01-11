#!/bin/bash
echo ""
echo "Developed from Dimitrios Pigkas. v2.0 2021"
echo "Check github's repository: https://github.com/takispig/MAC-spoofer"

sleep 1

echo ""
echo "Select what you want to do by pressing one of the numbers below:"
echo ""
echo "1.  Show my public IP Address"
echo "2.  Show my local IP Adress"
echo "3.  Show devices connected on this Network"
echo "4.  --------------- MAC-Spoof ---------------"
echo "4a. Show my MAC Address"
echo "4b. Change my MAC Address manually"
echo "4c. Change my MAC Address randomly"
echo ""
echo "q - Type and press 'q' if you want to exit."
echo ""

n=1 
while [ "$n" = "1" ]
do

read result			# wait for user's input and save it

# this returns the current network device, useful for ip link [] commands
network_dev=`ip address | grep -v lo | cut -d ' ' -f2 | tr ':' '\n' | awk NF`

if echo "$result" | grep -iq "^1"; then
	echo "Your public IP Address is:"
	curl ifconfig.me

elif echo "$result" | grep -iq "^2"; then
	echo "Your local IP Address is:"
	hostname -I | awk '{ print $1 }'

elif echo "$result" | grep -iq "^3"; then
	arp -e

elif echo "$result" | grep -iq "^4a"; then
	echo "Your MAC Address is:"
	# ifconfig | grep ether | awk '{ print $2 }'
	ip link show $network_dev | grep link/ether | awk '{print $2;}'

elif echo "$result" | grep -iq "^4b"; then
	echo "Edit your MAC Address like this
	'xx:xx:xx:xx:xx:xx' 
	with x=0-9 or x=a-f, and hit enter."
	read number
	echo "Setting network interface down..."
	sudo ip link set dev $network_dev down
	echo "...changing the MAC Address..."
	sudo ip link set $network_dev address $number
	echo "...setting network interface up again."
	sudo ip link set dev $network_dev up
	echo "Your new MAC Address is:"
	ip -a link show $network_dev | grep link/ether | awk '{print $2;}'

elif echo "$result" | grep -iq "^4c"; then
	echo "Setting network interface down..."
	sudo ip link set dev $network_dev down
	echo "...changing the MAC Address..."
	rand_mac=`openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`
	sudo ip link set $network_dev address $rand_mac
	echo "...setting network interface up again."
	sudo ip link set $network_dev up
	echo "Your new MAC Address is:"
	ip -a link show $network_dev | grep link/ether | awk '{print $2;}'

elif echo "$result" | grep -iq "^q"; then
	#increase the value of n, to make the condition FALSE and exit the loop.
	n=$(($n+1))

else echo "Press a combination from 1 to 5, or q to exit. 
Please try again."
fi

echo ""
echo ""
echo "Press 'q' to exit, or any of the numbers listed above"
echo ""

done

echo "Bye bye"

/bin/bash