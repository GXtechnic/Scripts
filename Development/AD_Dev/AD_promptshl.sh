# Prompts user to input fields: 

# Please note that the domain and OU should be provided in the format "yourdomain.com" and "OU=Users,DC=yourdomain,DC=com" respectively.


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
    $password = "Passw0rd123" | ConvertTo-SecureString -AsPlainText -Force

    # Create a new user object
    $user = New-Object -TypeName "System.DirectoryServices.AccountManagement.UserPrincipal" -ArgumentList $([System.DirectoryServices.AccountManagement.PrincipalContext]::Current)
    $user.SamAccountName = $FirstName.Substring(0, 1) + $LastName
    $user.GivenName = $FirstName
    $user.Surname = $LastName
    $user.DisplayName = "$FirstName $LastName"
    $user.Description = $JobTitle
    $user.EmailAddress = $Email
    $user.UserPrincipalName = $user.SamAccountName + "@" + $Domain
    $user.SetPassword($password)
    $user.Enabled = $true

    # Save the user to Active Directory
    $context = New-Object -TypeName "System.DirectoryServices.AccountManagement.PrincipalContext" -ArgumentList "Domain", $Domain, $OU
    $user.Save($context)

    # Set additional properties
    $userExtension = $user.GetUnderlyingObject()
    $userExtension.Title = $JobTitle
    $userExtension.Company = $Company
    $userExtension.Department = $Department
    $userExtension.PhysicalDeliveryOfficeName = $Office
    $userExtension.Save()

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
