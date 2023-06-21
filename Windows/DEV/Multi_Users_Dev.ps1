# Define an array of user details
$users = @(
    @{
        FirstName = "Franz"
        LastName = "Ferdinand"
        JobTitle = "TPS Reporting Lead"
        Department = "TPS Department"
        Company = "GlobeX USA"
        Office = "Springfield, OR"
        Email = "ferdi@GlobeXpower.com"
    },
    @{
        FirstName = "John"
        LastName = "Doe"
        JobTitle = "Sales Manager"
        Department = "Sales Department"
        Company = "GlobeX USA"
        Office = "Springfield, OR"
        Email = "johndoe@GlobeXpower.com"
    }
)

# Set the Active Directory domain information
$domain = "yourdomain.com"
$ou = "OU=Users,DC=yourdomain,DC=com"

# Loop through the users array and create/update each user
foreach ($userDetails in $users) {
    # Extract user details
    $firstName = $userDetails.FirstName
    $lastName = $userDetails.LastName
    $displayName = "$firstName $lastName"
    $jobTitle = $userDetails.JobTitle
    $department = $userDetails.Department
    $company = $userDetails.Company
    $office = $userDetails.Office
    $email = $userDetails.Email

    # Generate a password for the user
    $password = ConvertTo-SecureString -String "Passw0rd123" -AsPlainText -Force

    # Import the Active Directory module
    Import-Module ActiveDirectory

    # Check if the user already exists
    $existingUser = Get-ADUser -Filter {SamAccountName -eq ($firstName.Substring(0, 1) + $lastName)} -SearchBase $ou

    if ($existingUser) {
        # Update the existing user
        Set-ADUser -Identity $existingUser.SamAccountName `
                   -GivenName $firstName `
                   -Surname $lastName `
                   -DisplayName $displayName `
                   -Description $jobTitle `
                   -EmailAddress $email `
                   -Title $jobTitle `
                   -Company $company `
                   -Department $department `
                   -PhysicalDeliveryOfficeName $office
    } else {
        # Create a new user object
        $newUserParams = @{
            SamAccountName = $firstName.Substring(0, 1) + $lastName
            GivenName = $firstName
            Surname = $lastName
            DisplayName = $displayName
            Description = $jobTitle
            EmailAddress = $email
            UserPrincipalName = ($firstName.Substring(0, 1) + $lastName) + "@" + $domain
            AccountPassword = $password
            Enabled = $true
            Path = $ou
            ChangePasswordAtLogon = $true
        }

        New-ADUser @newUserParams
    }

    # Output the user's details
    Write-Host "User created/updated successfully:"
    Write-Host "--------------------------"
    Write-Host "Full Name: $displayName"
    Write-Host "Username: $($firstName.Substring(0, 1) + $lastName)"
    Write-Host "Email: $email"
    Write-Host "Job Title: $jobTitle"
    Write-Host "Department: $department"
    Write-Host "Company: $company"
    Write-Host "Office: $office"
    Write-Host "Password: Passw0rd123"
    Write-Host "--------------------------"
    Write-Host
}
