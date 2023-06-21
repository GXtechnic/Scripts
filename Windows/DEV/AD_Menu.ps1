# Function to add a user to Active Directory
function Add-UserToAD {
  param (
      [Parameter(Mandatory = $true)]
      [string]$FirstName,

      [Parameter(Mandatory = $true)]
      [string]$LastName,

      [Parameter(Mandatory = $true)]
      [string]$JobTitle,

      [Parameter(Mandatory = $true)]
      [string]$Department,

      [Parameter(Mandatory = $true)]
      [string]$Company,

      [Parameter(Mandatory = $true)]
      [string]$Office,

      [Parameter(Mandatory = $true)]
      [string]$Email,

      [Parameter(Mandatory = $true)]
      [string]$Domain,

      [Parameter(Mandatory = $true)]
      [string]$OU
  )

  # Generate a password for the user
  $password = ConvertTo-SecureString -String "Passw0rd123" -AsPlainText -Force

  # Import the Active Directory module
  Import-Module ActiveDirectory

  # Create a new user object
  $userParams = @{
      SamAccountName = $FirstName.Substring(0, 1) + $LastName
      GivenName = $FirstName
      Surname = $LastName
      DisplayName = "$FirstName $LastName"
      Description = $JobTitle
      EmailAddress = $Email
      UserPrincipalName = ($FirstName.Substring(0, 1) + $LastName) + "@" + $Domain
      AccountPassword = $password
      Enabled = $true
      Path = $OU
      ChangePasswordAtLogon = $true
  }

  $user = New-ADUser @userParams

  # Set additional properties
  Set-ADUser -Identity $user.SamAccountName `
             -Title $JobTitle `
             -Company $Company `
             -Department $Department `
             -PhysicalDeliveryOfficeName $Office

  # Output the user's details
  Write-Host "User created successfully:"
  Write-Host "--------------------------"
  Write-Host "Full Name: $($user.DisplayName)"
  Write-Host "Username: $($user.SamAccountName)"
  Write-Host "Email: $Email"
  Write-Host "Job Title: $JobTitle"
  Write-Host "Department: $Department"
  Write-Host "Company: $Company"
  Write-Host "Office: $Office"
  Write-Host "Password: Passw0rd123"
  Write-Host "--------------------------"
  Write-Host
}

# Main menu
function Show-MainMenu {
  Write-Host "Main Menu"
  Write-Host "---------"
  Write-Host "1. Add a user"
  Write-Host "2. Exit"
  Write-Host

  $choice = Read-Host "Enter your choice"

  switch ($choice) {
      "1" {
          $firstName = Read-Host "Enter First Name"
          $lastName = Read-Host "Enter Last Name"
          $jobTitle = Read-Host "Enter Job Title"
          $department = Read-Host "Enter Department"
          $company = Read-Host "Enter Company"
          $office = Read-Host "Enter Office"
          $email = Read-Host "Enter Email"
          $domain = Read-Host "Enter Domain"
          $ou = Read-Host "Enter OU"

          Add-UserToAD -FirstName $firstName -LastName $lastName -JobTitle $jobTitle -Department $department -Company $company -Office $office -Email $email -Domain $domain -OU $ou

          Show-MainMenu
      }
      "2" {
          # Exit the script
          return
      }
      default {
          Write-Host "Invalid choice. Please try again."
          Show-MainMenu
      }
  }
}

# Start the main menu
Show-MainMenu
