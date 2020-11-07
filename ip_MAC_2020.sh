#!/bin/bash
echo ""
echo "Developed from Dimitrios Pigkas. v2.0 2020."

sleep 1

echo ""
echo "Please, select what you want to do, 
pressing one of the below numbers."
echo ""
echo "1.  Show (public) IP Address"
echo "2. Show my local IP Adress"
echo "3a. Show my MAC Address (WiFi)"
echo "3b. Show my MAC Address (Ethernet)"
echo "4a. Edit my MAC address (WiFi)"
echo "4b. Edit my MAC address (Ethernet)"
echo "5.  Show devices connected on this Network"
echo "q - Type and press 'q' if you want to exit."
echo ""

n=1 
while [ "$n" = "1" ]
do

read result

if echo "$result" | grep -iq "^1"; then
	echo "Your public IP Address is:"
	curl ifconfig.me

elif echo "$result" | grep -iq "^2"; then
	echo "Your local IP Address is:"
	hostname -I

elif echo "$result" | grep -iq "^3a"; then
	echo "Your MAC Address is:"
	 ip -a link show dev wlan0 | grep link/ether | awk '{print $2;}'
elif echo "$result" | grep -iq "^3b"; then
	echo "Your MAC Address is:"
	 ip -a link show dev eth0 | grep link/ether | awk '{print $2;}'

elif echo "$result" | grep -iq "^4a"; then
	echo "Edit your MAC Address like this
	'xx:xx:xx:xx:xx:xx' 
with x=0-9 or x=a-f, and hit enter."
	read number
	echo "Setting network interface down..."
	ip link set dev wlan0 down
	echo "...changing the MAC Address..."
	ip link set dev wlan0 address
	echo "...setting network interface up again."
	ip link set dev interface up
	echo "Your new MAC Address is:"
	ip -a link show dev wlan0 | grep link/ether | awk '{print $2;}'
elif echo "$result" | grep -iq "^4b"; then
	echo "Edit your MAC Address like this
   'xx:xx:xx:xx:xx:xx' 
with x=0-9 or x=a-f, and hit enter."
	read number
	echo "Setting network interface down..."
	ip link set dev eth0 down
	echo "...changing the MAC Address..."
	ip link set dev eth0 address
	echo "...setting network interface up again."
	ip link set dev eth0 up
	echo "Your new MAC Address is:"
	ip -a link show dev eth0 | grep link/ether | awk '{print $2;}'
	
elif echo "$result" | grep -iq "^5"; then
	echo "--- local IP ----- MAC Adress ----- Connection type ----"
	echo ""
	arp -a
elif echo "$result" | grep -iq "^q"; then
	n=$(($n+1))
	#increase the value of n, to make the condition FALSE and exit the loop.
else echo "Press a combination from
1 to 5, or q to exit. 
Please try again."
fi
echo""

done

echo "Bye bye"

/bin/bash