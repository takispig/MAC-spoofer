#!/bin/bash

echo ""
echo "Your MAC Address (WiFi) will be randomly changed."
# for ethernet use en1
echo "Are you sure you want to change it? (y/n)"
echo ""

n=1
while [ "$n"="1" ]
do

read answer

if echo "$answer" | grep -iq "^n"; then
	n=$(($n+1))
	echo "Ok, bye bye!"

elif echo "$answer" | grep -iq "^y"; then

echo "Your previous MAC-Address:"
ifconfig en0 | grep ether

# create a random mac-address
rand_mac=`openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`
sudo ifconfig en0 ether $rand_mac

echo "has been changed to:"
ifconfig en0 | grep ether

n=$(($n+1))

else echo "Try again pressing y (for yes) or n (for no)."
fi

echo ""
done

/bin/bash