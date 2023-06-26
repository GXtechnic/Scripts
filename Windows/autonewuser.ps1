#Author: Marcelo Clark
#Date: 6/25/2023
#Purpose: Automate users being added from a csv file into Active directory
#Import Active Directory Module


Import-Module ActiveDirectory

# Open File Dialog
# Load Windows forms
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

#Create and Show open file Dialog
$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.InitialDirectory = "C:\"
$dialog.Filter = "CSV (*.csv) | *.csv"
$dialog.ShowDialog() | Out-Null

#Store file path in variable
$CSVFile = $dialog.FileName

# Import file into variable
# ensure file path is valid
# File path not valid? Script stops running
if([System.IO.File]::Exists($CSVFile )) {
Write-Host "Importing CSV"
$CSV = Import-CSV -LiteralPath "$CSVFile"
} else {
    Write-Host "File path specified was not valid"
    Exit
}

#Iterate over each line in CSV file
Foreach($user in $CSV) {
#variable setup

$UserName = "$($user.'namefirst').$($user.'namelast')"
$UserName = $UserName.Replace(" ", "")

#Password
#[ First Name Initial] + [Last Name]
$SecurePassword = ConvertTo-SecureString "$($user.'namefirst'[0])$($user.'namelast')!@#" -AsPlainText -Force

#create AD User
New-ADUSer -Name "$($user.'namefirst') $($user.'namelast')" `
            -GivenName $user.'namefirst' `
            -UserPrincipalName $UserName `
            -SamAccountName $UserName `
            -Surname $user.'namelast' `
            -Title $user.'title' `
            -Department $user.'department' `
            -Company $user.'company' `
            -Office $user.'state' `
            -Path "CN=Users,DC=corp,DC=globex,DC=com" `
            -ChangePasswordAtLogon $true `
            -AccountPassword $SecurePassword `
            -Enabled $([System.Convert]::ToBoolean($user.Enabled))

         #Write to host new user created
         Write-Host "Created $UserName"