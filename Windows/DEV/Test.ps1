# Set the Active Directory domain information
# $domain = "globex.com"
# $ou = "OU=Users,DC=globex,DC=com"



# Prompt for user details
$firstName = Read-Host "Enter First Name"
$lastName = Read-Host "Enter Last Name"
$displayName = "$firstName $lastName"
$jobTitle = Read-Host "Enter Job Title"
$department = Read-Host "Enter Department"
$company = Read-Host "Enter Company"
$office = Read-Host "Enter Office"
$email = Read-Host "Enter Email"

# Set the Active Directory domain information
$domain = "globex.com"
$ou = "OU=Users,DC=globex,DC=com"

# Generate a password for the user
$password = ConvertTo-SecureString -String "Password123" -AsPlainText -Force

# Import the Active Directory module
Import-Module ActiveDirectory

# Create a new user object
$userPrincipalName = $firstName.Substring(0, 1) + $lastName + "@" + $domain
$samAccountName = $firstName.Substring(0, 1) + $lastName
New-ADUser -Name $displayName -SamAccountName $samAccountName -UserPrincipalName $userPrincipalName -GivenName $firstName -Surname $lastName -DisplayName $displayName -Description $jobTitle -EmailAddress $email -Enabled $true -ChangePasswordAtLogon $true -PasswordNeverExpires $true -AccountPassword $password -Path $ou | Set-ADUser -Company $company -Department $department -Title $jobTitle -Office $office -Description $jobTitle -PassThru

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
Write-Host "Password: Password123"
Write-Host "--------------------------"





