$Source = "\\folder\from\*.zip"
$Dest   = "\\folder\to"
$Username = "user"
$Password = ConvertTo-SecureString "xxxxxxxxxxxxx" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential($Username, $Password)

New-PSDrive -Name J -PSProvider FileSystem -Root $Dest -Credential $mycreds -Persist

Move-Item -Path $Source -Destination "J:\"

Remove-PSDrive -Name J