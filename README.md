# MAC-spoofer
These are some scripts I wrote to change my MAC Address. I tried to implement some more things in the process, part of self learning, like displaying the IP and some network informations.
Those scripts are using the iproute2 (even MAC_Spoof_OSX.sh that uses ifconfig inherits from iproute2), so they should be able to run in most Linux operating systems, without any configurations.

# Scripts explained:
In order to run the scripts, you have to make them executable. For example: `chmod +x /path/to/MAC_Spoof.sh`
1. *MAC_Spoof.sh* is the basic script for MAC-Spoofing, and further can return the (local and public) IPs.
2. *MAC_Spoof_silent.sh* is a script, that just changes the MAC Address to a random one. It could be used easily as a start-up MAC Spoof script by making some system configurations.
3. *MAC_Spoof_OSX.sh* is a script configured for OSX Systems to change the MAC Address randomly (unstable).

# Troubleshooting
In order to automate the scripts, and prevent any user interaction with the terminal, I stored the network device name from the returned value of this command:\
``` ip address | grep -v lo | cut -d ' ' -f2 | tr ':' '\n' | awk NF ```\
If this does not return your network device, then the scripts won't run, or will misbehave. Try to find your network device manually and replace the command after the network_dev with your network's device name. 

# Feedback
Since this is a free time experimentation from a non-expert on this field, I don't expect that these scripts are perfect.
So any feedback and / or corrections would be more than welcome.

# Licence
[MIT Licence](https://github.com/takispig/MAC-spoofer/blob/main/LICENSE)
