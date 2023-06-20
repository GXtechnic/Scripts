#!/bin/bash
# Script Name:                  Loops
# Author:                       Raphael Chookagian
# Date of latest revision:      04/28/2023
# Purpose:                      Write a script that displays running processes, asks the user for a PID, then kills the process with that PID. See README file for more in depth information.

# Declaration of variables
count=0
# PID=[ ps -p $userInput > /dev/null  ]
# Declaration of functions
runIt(){
  count=0
while (( $count < 3 ))
  do
    killProcs
  done
}

doIt(){
  if [  $( pgrep "$userInput" | grep -v grep | awk "{print $2}") = $PID ]
  # if [ ps -p $userInput > /dev/null  ]
    then
      kill $( pgrep "$userInput" | grep -v grep | awk "{print $2}")
  else
    echo "Please enter a valid PID number"
    killProcs
  fi
}

killProcs(){
  ps aux
  echo "Choose target to eliminate"
  echo "Enter PID"
  read -r userInput
  doIt
  # kill $( pgrep "$userInput" | grep -v grep | awk "{print $2}")
  count=$(( $count + 1 ))
}

killAgainQ(){
  echo "Would you like to kill again? Yes/No"
read -r userInput
if [ "$userInput" = "yes" ]
  then
    echo "Maybe it's time for a break"
elif [ "$userInput" = "no" ]
  then
    echo "Have a great day!"
    exit
else
  runIt
  killAgainQ
fi
}

# Create
# Main

runIt
killAgainQ

# End

#--------------------------------v1 below
# i=1

# while [ $i -le 3 ]
#   do
#     ps aux
#     echo "Choose target to eliminate"
#     echo "Enter PID"
#     read -r userInput
#     # kill "$userInput"
#     kill $( pgrep "$userInput" | grep -v grep | awk "{print $2}")
#     # ((i=i+1))
#     i=$(( $i + 1 ))
#   done
