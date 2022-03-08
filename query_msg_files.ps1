$outlook = New-Object -comobject outlook.application

Get-ChildItem "C:\data\mail\kidum" -Filter  *.msg |
ForEach-Object{
  $msg = $outlook.CreateItemFromTemplate($_.FullName)
  $msg | Select to,subject| Export-csv -Append "C:\data\mail\kidum\output.csv" -Encoding UTF8
  $null = [System.Runtime.Interopservices.Marshal]::ReleaseComObject($msg);
}
$null = [System.Runtime.Interopservices.Marshal]::ReleaseComObject($outlook);
[System.GC]::Collect(); [System.GC]::WaitForPendingFinalizers();