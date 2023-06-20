#!/bin/bash

# Script Name:                  GitHub
# Author:                       Raphael Chookagian
# Date of latest revision:      05/18/2023
# Purpose:                      Script that runs scripts in order 1, 2, 3 for basic Ubuntu Lab System Set up with SSH, RDP, Virtualbox and preferences.

# Main

# SSH, XRDP install and prefs
 bash 1stUbSetup.sh 

# Installs Virtualbox
 bash 2ndVBoxIns.sh

# Basic prefs colors, sleep, lock, etc.
 bash 3rdPrefsSetup.sh

# End
