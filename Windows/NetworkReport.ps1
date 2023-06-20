# Script Name:                  Powershell IP Analysis
# Author:                       Raphael Chookagian
# Date of latest revision:      05/9/2023
# Purpose:                      Write a Powershell script that returns the IPv4 address of the computer.

# Create a Powershell script that performs the following operations:

# Declare Variables

# Create a local file called network_report.txt that holds the contents of an ipconfig /all command.
$FileIt =  ipconfig /all | Out-File -FilePath .\Desktop\network_report.txt

# Use Select-String to search network_report.txt and return only the IP version 4 address.
$GetIPV4Only = Select-String -Path .\Desktop\network_report.txt -Pattern 'IPV4'


# Remove the network_report.txt when you are finished searching it.
$TossIt = Remove-Item -Path .\Desktop\network_report.txt -Force


# Declare Functions
function NetReport {
  # ipconfig /all | Out-File -FilePath .\Desktop\network_report.txt
  $FileIt
}

function IPV4Report {
  $GetIPV4Only
}

function TrashIt {
  
  $validAns = $false
  While(-not $validAns)
  {
    # Read-Host 'Finish and delete file?'
    $yn = Read-Host "Finish and delete file? Enter yes or no"
    Switch($yn.ToLower())
    {
        "yes" {$validAns = $true
            $TossIt
        }
        "no" {$validAns = $true
            TrashIt
        }
        Default {Write-Host "Enter 'yes' or 'no'."}
    }
  }
}
# Create

# Main

NetReport

IPV4Report

TrashIt









