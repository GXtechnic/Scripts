# Import AD Module
Import-Module ActiveDirectory

#Grab variables from user
$firstname = Read-Host -Prompt "Please enter the first name"
$lastname = Read-Host -Prompt "Please enter the last name"

# Create AD User
New-ADUser `
    -Name "$firstname $lastname" `
    -GivenName $firstname `
    -Surname $lastname `
    -UserPrincipalName "$firstname.$lastname" `
    -AccountPassword (ConvertTo-SecureString "P@$$w0rd123" -AsPlainText -Force) 
    #change path name if different on your system`
    -Path "CN=Users,DC=corp,DC=globex,DC=com" `
    -ChangePasswordAtLogon 1 `
    -Enabled 1