# Script Name:                  M
# Author:                       Raphael Chookagian
# Date of latest revision:      05/5/2023
# Purpose:                      Create a Powershell script that performs these operations on separate lines. See README for more information.

# Declare Functions
# Create
# Main

#  Print to the terminal screen all active processes ordered by highest CPU time consumption at the top.

Get-Process | Sort-Object -Property CPU -Descending

# Print to the terminal screen all active processes ordered by highest Process Identification Number at the top.

Get-Process | Sort-Object -Property ID -Descending

# Print to the terminal screen the top five active processes ordered by highest Working Set (WS(K)) at the top.

Get-Process | Sort-Object -Property WS(K) -Descending | Select-Object -First 5

# Start a browser process (such as Google Chrome or MS Edge) and have it open <https://owasp.org/www-project-top-ten/>.

Start-Process -FilePath "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -ArgumentList '--start-fullscreen "https://owasp.org/www-project-top-ten"'

# Start the process Notepad ten times using a for loop.
for ($i = 1 ; $i -le 10 ; $i++)
{
  Start-Process notepad
}

# Close all instances of the Notepad.

Stop-Process -Name "notepad" -PassThru

# Kill a process by its Process Identification Number. Choose a process whose termination won’t destabilize the system, such as Google Chrome or MS Edge.

# Stop-Process -Id [****] -Confirm -PassThru
Stop-Process -Id 992 -Confirm -PassThru

# End
