#!/bin/bash

echo ""
echo "Your MAC Address (WiFi) will be randomly changed."
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
#generate random numbers from 0 to 90
#and save them into variables.
r=$[( $RANDOM % 90 )+1]
a=$[( $RANDOM % 90 )+1]
q=$[( $RANDOM % 90 )+1]
y=$[( $RANDOM % 90 )+1]
h=$[( $RANDOM % 90 )+1]
k=$[( $RANDOM % 90 )+1]
#change my mac address
sudo ifconfig en0 ether $r:$a:$q:$y:$h:$k
echo "MAC-Address has been changed."
echo "Your new MAC-Address is:"
ifconfig en0 | grep ether
n=$(($n+1))

else echo "Try again pressing y (for yes) or n (for no)."
fi

echo ""
done

/bin/bash