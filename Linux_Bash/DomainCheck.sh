#!/bin/bash

# Script Name:                  Domain Analyzer
# Author:                       Raphael Chookagian
# Date of latest revision:      05/10/2023
# Purpose:                      Create a script that asks a user to type a domain, then displays information about the typed domain. Operations that must be used include:
  # whois
  # dig
  # host
  # nslookup

  # Install whois on your Ubuntu VM.

  # Add to your bash script a sixth option that calls a function to:
  
  # Take a user input string. Presumably the string is a domain name such as Google.com.
  # Run whois against a user input string.
  # Run dig against the user input string.
  # Run host against the user input string.
  # Run nslookup against the user input string.
  # Output the results to a single .txt file and open it with your favorite text editor.

# Declare Variables
# AddToFile=">> fetchDom.txt"

# Declare Functions
removeDom(){
  rm -rf fetchDom.txt
}

WhoDis(){
  whois "$userInput"
  whois "$userInput" >> fetchDom.txt
}

DigDis(){
  dig "$userInput"
  dig "$userInput" >> fetchDom.txt
}

HostDis(){
  host "$userInput"
  host "$userInput" >> fetchDom.txt
}

NslDis(){
  nslookup "$userInput"
  nslookup "$userInput" >> fetchDom.txt
}

# Create
removeDom

fetchDom(){
  # echo "Please enter a domain name"
  # read -r userInput 
  WhoDis
  DigDis
  HostDis
  NslDis
}

# Main
# echo "Please enter a domain name"
# read -r userInput 
read -p "Please enter a domain name: " userInput

fetchDom

# linux
xdg-open fetchDom.txt

# mac
open fetchDom.txt

# End
