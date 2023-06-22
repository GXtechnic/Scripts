# Set the Active Directory domain information
$domain = "corp.globex.com"
$ou = "OU=Users,DC=corp,DC=globex,DC=com"

# Import the Active Directory module
Import-Module ActiveDirectory

# Prompt for the number of users to create
$userCount = Read-Host "Enter the number of users to create"

# Loop to create multiple users
for ($i = 1; $i -le $userCount; $i++) {
    Write-Host "Creating User $i"

    # Prompt for user details
    $firstName = Read-Host "Enter First Name"
    $lastName = Read-Host "Enter Last Name"
    $displayName = "$firstName $lastName"
    $jobTitle = Read-Host "Enter Job Title"
    $department = Read-Host "Enter Department"
    $company = Read-Host "Enter Company"
    $office = Read-Host "Enter Office"
    $email = Read-Host "Enter Email"

    # Prompt for additional user details
    $samAccountName = Read-Host "Enter SamAccountName"
    $userPrincipalName = Read-Host "Enter UserPrincipalName"

    # Generate a secure password for the user
    $password = Read-Host "Enter Password" -AsSecureString

    # Create a new user object
    New-ADUser -Name $displayName -SamAccountName $samAccountName -UserPrincipalName $userPrincipalName -GivenName $firstName -Surname $lastName -DisplayName $displayName -Description $jobTitle -EmailAddress $email -Enabled $true -ChangePasswordAtLogon $true -PasswordNeverExpires $false -AccountPassword $password -Path $ou | Set-ADUser -Company $company -Department $department -Title $jobTitle -Office $office -PassThru

    # Output the user's details
    Write-Host "User created successfully:"
    Write-Host "--------------------------"
    Write-Host "Full Name: $displayName"
    Write-Host "Username: $samAccountName"
    Write-Host "Email: $email"
    Write-Host "Job Title: $jobTitle"
    Write-Host "Department: $department"
    Write-Host "Company: $company"
    Write-Host "Office: $office"
    Write-Host "--------------------------"
}
