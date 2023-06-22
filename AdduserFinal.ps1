# Import AD Module
Import-Module ActiveDirectory

#Grab variables from user
$firstname = Read-Host -Prompt "Please enter the first name"
$lastname = Read-Host -Prompt "Please enter the last name"
$Department = Read-Host -Prompt "Please enter department"
$JobTitle = Read-Host -Prompt "Please enter your job title"
$Office = Read-Host -Prompt "Please enter office location"
$Company = Read-Host -Prompt "Please ener company name"
$Email = Read-Host -Prompt "Please enter your email address"
# Create AD User
New-ADUser `
    -Name "$firstname $lastname" `
    -GivenName $firstname `
    -Surname $lastname `
    -Department $Department `
    -Title $JobTitle `
    -Office $Office `
    -Company $Company `
    -EmailAddress $Email `
    -UserPrincipalName "$firstname.$lastname" `
    -AccountPassword (ConvertTo-SecureString "P@$$w0rd123" -AsPlainText -Force) `
    -Path "CN=Users,DC=corp,DC=globex,DC=com" `
    -ChangePasswordAtLogon 1 `
    -Enabled 1