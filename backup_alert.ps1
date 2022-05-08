$Output = "C:\Folder\To\Check\*"

$Number_of_items = (Get-ChildItem -Path $Output -Recurse | Measure-Object).Count

$hostname = hostname

If ($Number_of_items -gt 4)
{
    $MailArgs = @{
            'To'          = "ylanou@gmail.com"
            'From'        = "adminuser@domain.co.il"
            'Subject'     = "$hostname Failure - Too much mahout backup files"
            'Body'        = "$hostname Failure - Number of items on G:\App_Backups\Flex\backup\ IS $Number_of_items "
            'SmtpServer' = ""
            }
}

else {
$MailArgs = @{
        'To'          = "ylanou@gmail.com"
        'From'        = "adminuser@domain.co.il"
        'Subject'     = "$hostname Success - The amount of transaction logs reasonable"
        'Body'        = "$hostname Success - Number of items on D:\ExchangeData IS $Number_of_items "
        'SmtpServer' = ""
          
            }      
}

Send-MailMessage @MailArgs