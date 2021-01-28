$filePath = "C:\users\[username]\Desktop\User Groups.csv"
$usersOU = 'OU=Users,DC=example,DC=local'
$users = Get-ADUser -Filter * -SearchBase $usersOU | sort -Property Name


#Removes the previous Group Membership CSV

if(Test-Path -path $filePath){
    Remove-Item -path $filePath
}


#Loops through users, gets group assignments, formats into easily readable format and outputs to file.

foreach($user in $users){
    $user.Name | Out-File $filePath  -Append
    $groups = (Get-ADUser $user –Properties MemberOf | Select-Object MemberOf).MemberOf
    foreach($group in $groups){
        ($group -split ',*..=')[1] | Out-File $filePath -Append
    }

    " " | Out-File $filePath -Append
   }
