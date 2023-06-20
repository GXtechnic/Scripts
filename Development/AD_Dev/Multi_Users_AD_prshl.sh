## Muliple users update array accordinly:

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

# Loop through the users array and create each user
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
    $password = "Passw0rd123" | ConvertTo-SecureString -AsPlainText -Force

    # Create a new user object
    $user = New-Object -TypeName "System.DirectoryServices.AccountManagement.UserPrincipal" -ArgumentList $([System.DirectoryServices.AccountManagement.PrincipalContext]::Current)
    $user.SamAccountName = $firstName.Substring(0, 1) + $lastName
    $user.GivenName = $firstName
    $user.Surname = $lastName
    $user.DisplayName = $displayName
    $user.Description = $jobTitle
    $user.EmailAddress = $email
    $user.UserPrincipalName = $user.SamAccountName + "@" + $domain
    $user.SetPassword($password)
    $user.Enabled = $true

    # Save the user to Active Directory
    $context = New-Object -TypeName "System.DirectoryServices.AccountManagement.PrincipalContext" -ArgumentList "Domain", $domain, $ou
    $user.Save($context)

    # Set additional properties
    $userExtension = $user.GetUnderlyingObject()
    $userExtension.Title = $jobTitle
    $userExtension.Company = $company
    $userExtension.Department = $department
    $userExtension.PhysicalDeliveryOfficeName = $office
    $userExtension.Save()

    # Output the user's details
    Write-Host "User created successfully:"
    Write-Host "--------------------------"
    Write-Host "Full Name: $displayName"
    Write-Host "Username: $($user.SamAccountName)"
    Write-Host "Email: $email"
    Write-Host "Job Title: $jobTitle"
    Write-Host "Department: $department"
    Write-Host "Company: $company"
    Write-Host "Office: $office"
    Write-Host "Password: Passw0rd123"
    Write-Host "--------------------------"
    Write-Host
}
