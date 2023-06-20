
#!/bin/bash

# Script Name:                  System Information
# Author:                       Raphael Chookagian
# Date of latest revision:      04/25/2023
# Purpose:                      Create a script that uses lshw to display system information to the screen about the following components:.<README>

# Declaration of variables


# Declaration of functions
Name() {
echo "Name:"
sudo hostname
}

CPU() {
echo "CPU:"
sudo lshw -class cpu | grep -wv capabilities | grep -wv version | grep -wv *-cpu
}

RAM() {
echo "RAM:"
sudo lshw -class Memory | grep memory -A 3
# sudo lshw -class Memory | grep -wv memory
}

Display() {
echo "Display Adapter:"
sudo lshw -class display | grep -wv display | grep -wv version | grep -wv logical
}

Network() {
echo "Network Adapter:"
sudo lshw -class network | grep -wv network
}

# Create
Create() {
Name
CPU
RAM
Display
Network
}

# Main
Create

# End
