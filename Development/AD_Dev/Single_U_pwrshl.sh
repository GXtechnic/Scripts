
# Set user details
$firstName = "Franz"
$lastName = "Ferdinand"
$displayName = "$firstName $lastName"
$jobTitle = "TPS Reporting Lead"
$department = "TPS Department"
$company = "GlobeX USA"
$office = "Springfield, OR"
$email = "ferdi@GlobeXpower.com"

# Set the Active Directory domain information
$domain = "corp.globex.com"
$ou = "OU=Users,DC=corp.globex,DC=com"

# Generate a password for the user
$password = "Password123" | ConvertTo-SecureString -AsPlainText -Force

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
