# Script Name:                  Automated Endpoint Configuration
# Author:                       Raphael Chookagian
# Date of latest revision:      05/8/2023
# Purpose:                      Create a Powershell script /Test and validate that your script achieves the desired outcome for each listed objective

# Declare Functions
# Create
# Main

# Enable File and Printer Sharing
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True


# Allow ICMP traffic
netsh advfirewall firewall add rule name="Allow incoming ping requests IPv4" dir=in action=allow protocol=icmpv4 

# --------------------------------------------------------------------------------
# Enable Remote management
  reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

  # NLA
  Set-ItemProperty ‘HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\‘ -Name “UserAuthentication” -Value 1

  # Firewall Rule
  Enable-NetFirewallRule -DisplayGroup “Remote Desktop”
# --------------------------------------------------------------------------------

# Remove bloatware
iex ((New-Object System.Net.WebClient).DownloadString('https://git.io/debloat'))


# Enable Hyper-V
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All


# Disable SMBv1, an insecure protocol
Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
