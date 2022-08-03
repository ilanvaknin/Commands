Write-Output ((Get-Date -format yyyy-MM-dd-HH:mm:ss) + ": Started ...");

$Filepath       = 'C:\backup\scripts' # local directory to save build-scripts to
$DataSource     = '' # server name and instance
$reportserver   = "";        # SQL Server Instance.
$reportserverdb = "";        # ReportServer Database.

###########################################################################
#                          Script FlexMirror DB                           #
###########################################################################
$Database='FlexMirror'# the database to copy from
# set "Option Explicit" to catch subtle errors
set-psdebug -strict
$ErrorActionPreference = "stop" # you can opt to stagger on, bleeding, if an error occurs
# Load SMO assembly, and if we're running SQL 2008 DLLs load the SMOExtended and SQLWMIManagement libraries
$ms='Microsoft.SqlServer'
$v = [System.Reflection.Assembly]::LoadWithPartialName( "$ms.SMO")
if ((($v.FullName.Split(','))[1].Split('='))[1].Split('.')[0] -ne '9') {
[System.Reflection.Assembly]::LoadWithPartialName("$ms.SMOExtended") | out-null
   }
$My="$ms.Management.Smo" #
$s = new-object ("$My.Server") $DataSource
if ($s.Version -eq  $null ){Throw "Can't find the instance $Datasource"}
$db= $s.Databases[$Database] 
if ($db.name -ne $Database){Throw "Can't find the database '$Database' in $Datasource"};
$transfer = new-object ("$My.Transfer") $db
$transfer.Options.ScriptBatchTerminator = $true # this only goes to the file
$transfer.Options.ToFileOnly = $true # this only goes to the file
$transfer.Options.Filename = "$($FilePath)\$($Database).sql"; 
$transfer.ScriptTransfer()

###########################################################################
#                          Script FlexStage DB                            #
###########################################################################
$Database='FlexStage'# the database to copy from
# set "Option Explicit" to catch subtle errors
set-psdebug -strict
$ErrorActionPreference = "stop" # you can opt to stagger on, bleeding, if an error occurs
# Load SMO assembly, and if we're running SQL 2008 DLLs load the SMOExtended and SQLWMIManagement libraries
$ms='Microsoft.SqlServer'
$v = [System.Reflection.Assembly]::LoadWithPartialName( "$ms.SMO")
if ((($v.FullName.Split(','))[1].Split('='))[1].Split('.')[0] -ne '9') {
[System.Reflection.Assembly]::LoadWithPartialName("$ms.SMOExtended") | out-null
   }
$My="$ms.Management.Smo" #
$s = new-object ("$My.Server") $DataSource
if ($s.Version -eq  $null ){Throw "Can't find the instance $Datasource"}
$db= $s.Databases[$Database] 
if ($db.name -ne $Database){Throw "Can't find the database '$Database' in $Datasource"};
$transfer = new-object ("$My.Transfer") $db
$transfer.Options.ScriptBatchTerminator = $true # this only goes to the file
$transfer.Options.ToFileOnly = $true # this only goes to the file
$transfer.Options.Filename = "$($FilePath)\$($Database).sql"; 
$transfer.ScriptTransfer() 

###########################################################################
#                          Export Mapping data                            #
###########################################################################
$database = "FlexStage"
$outputFile = $Filepath+"\"+$database+"_Mapping.sql"
$connectionString = "Data Source="+$DataSource+";Initial Catalog="+$database+";Integrated Security=True;"

$sqlConnection = new-object System.Data.SqlClient.SqlConnection($connectionString)
$conn = new-object Microsoft.SqlServer.Management.Common.ServerConnection($sqlConnection)
$srv = new-object Microsoft.SqlServer.Management.Smo.Server($conn)
$db = $srv.Databases[$srv.ConnectionContext.DatabaseName]
$scr = New-Object Microsoft.SqlServer.Management.Smo.Scripter $srv
$scr.Options.FileName = $outputFile
$scr.Options.AppendToFile = $false
$scr.Options.ScriptSchema = $false
$scr.Options.ScriptData = $true
$scr.Options.NoCommandTerminator = $true

$tables = New-Object Microsoft.SqlServer.Management.Smo.UrnCollection

foreach($table in $db.Tables){
    if ($table.name -like "MAP*" ){
        $tables.Add($table.Urn)
    }
}

[void]$scr.EnumScript($tables)
$sqlConnection.Close()

###########################################################################
#                          Script FlexWarehouse DB                        #
###########################################################################
$Database='FlexWarehouse'# the database to copy from
# set "Option Explicit" to catch subtle errors
set-psdebug -strict
$ErrorActionPreference = "stop" # you can opt to stagger on, bleeding, if an error occurs
# Load SMO assembly, and if we're running SQL 2008 DLLs load the SMOExtended and SQLWMIManagement libraries
$ms='Microsoft.SqlServer'
$v = [System.Reflection.Assembly]::LoadWithPartialName( "$ms.SMO")
if ((($v.FullName.Split(','))[1].Split('='))[1].Split('.')[0] -ne '9') {
[System.Reflection.Assembly]::LoadWithPartialName("$ms.SMOExtended") | out-null
   }
$My="$ms.Management.Smo" #
$s = new-object ("$My.Server") $DataSource
if ($s.Version -eq  $null ){Throw "Can't find the instance $Datasource"}
$db= $s.Databases[$Database] 
if ($db.name -ne $Database){Throw "Can't find the database '$Database' in $Datasource"};
$transfer = new-object ("$My.Transfer") $db
$transfer.Options.ScriptBatchTerminator = $true # this only goes to the file
$transfer.Options.ToFileOnly = $true # this only goes to the file
$transfer.Options.Filename = "$($FilePath)\$($Database).sql"; 
$transfer.ScriptTransfer() 

###########################################################################
#                          Script FlexExport DB                           #
###########################################################################
$Database='FlexExport'# the database to copy from
# set "Option Explicit" to catch subtle errors
set-psdebug -strict
$ErrorActionPreference = "stop" # you can opt to stagger on, bleeding, if an error occurs
# Load SMO assembly, and if we're running SQL 2008 DLLs load the SMOExtended and SQLWMIManagement libraries
$ms='Microsoft.SqlServer'
$v = [System.Reflection.Assembly]::LoadWithPartialName( "$ms.SMO")
if ((($v.FullName.Split(','))[1].Split('='))[1].Split('.')[0] -ne '9') {
[System.Reflection.Assembly]::LoadWithPartialName("$ms.SMOExtended") | out-null
   }
$My="$ms.Management.Smo" #
$s = new-object ("$My.Server") $DataSource
if ($s.Version -eq  $null ){Throw "Can't find the instance $Datasource"}
$db= $s.Databases[$Database] 
if ($db.name -ne $Database){Throw "Can't find the database '$Database' in $Datasource"};
$transfer = new-object ("$My.Transfer") $db
$transfer.Options.ScriptBatchTerminator = $true # this only goes to the file
$transfer.Options.ToFileOnly = $true # this only goes to the file
$transfer.Options.Filename = "$($FilePath)\$($Database).sql"; 
$transfer.ScriptTransfer() 


###########################################################################
#                          Script FlexTabular Model                       #
###########################################################################
$ssas_deployment = 'Microsoft.AnalysisServices.Deployment.exe'
$asdatabase = 'C:\appl\FlexTabular\FlexTabular\bin\Model.asdatabase'
$pathxmla = $Filepath+'\FlexTabular.xmla'
$arglist = @(
	$asdatabase,	
	"/d",
	"/o:$pathxmla"
)
Start-Process -FilePath $ssas_deployment -ArgumentList $arglist

###########################################################################
#                          Retrieve ETL ispac file                        #
###########################################################################
Copy-Item "C:\appl\DWH16\DWH16\bin\Development\DWH16.ispac" -Destination $Filepath

###########################################################################
#                          Retrieve PBIX files                            #
###########################################################################
# replacing with a single known PBI report that has all 3 parts in the 	CatalogItemExtendedContent	
$sql = "SELECT	CT.[Path]
        ,CT.[Type]
		,ISNULL(cc.ContentType,'SSRS') as ContentType
        ,CONVERT(varbinary(max), cc.[Content]) AS PBI_BinaryContent
        ,CONVERT(varbinary(max), ct.[Content]) AS RDL_BinaryContent
FROM dbo.[Catalog] AS CT
		LEFT OUTER JOIN dbo.CatalogItemExtendedContent cc
			ON ct.ItemID = cc.ItemId
WHERE CT.[Type] = 13
	and ISNULL(cc.ContentType,'CatalogItem') = 'CatalogItem'
	and ct.[Path] in ('/Teken/teken_20190918','/Teken/employee_details','/No_employee_data/teken','/Time/employee_details_time','/Time/Time_20191107')";		

# Open ADO.NET Connection with Windows authentification.
$con = New-Object Data.SqlClient.SqlConnection;
$con.ConnectionString = "Data Source=$reportserver;Initial Catalog=$reportserverdb;Integrated Security=True;";
$con.Open();

# New command and reader.
$cmd = New-Object Data.SqlClient.SqlCommand $sql, $con;
$rd = $cmd.ExecuteReader();

$invalids = [System.IO.Path]::GetInvalidFileNameChars();
# Looping through all selected datasets.
While ($rd.Read())
{
    Try
    {
        # Get the name and make it valid.
        $name = $rd.GetString(0);
		Write-Output "fetching $name"
        foreach ($invalid in $invalids)
           {    $name = $name.Replace($invalid, "-");    }
        If ($rd.GetInt32(1) -eq 2)
            {    $name = $name + ".rdl";    }
        ElseIf ($rd.GetInt32(1) -eq 5)
            {    $name = $name + ".rds";    }
        ElseIf ($rd.GetInt32(1) -eq 8)
            {    $name = $name + ".rsd";    }
        ElseIf ($rd.GetInt32(1) -eq 11)
            {    $name = $name + ".kpi";    }
        ElseIf ($rd.GetInt32(1) -eq 13)
			{   $name = $name + ".pbix";    }
			
        Write-Output ((Get-Date -format yyyy-MM-dd-HH:mm:ss) + ": Exporting {0}" -f $name);

        $name = [System.IO.Path]::Combine($Filepath, $name);

        # New BinaryWriter; existing file will be overwritten.
        $fs = New-Object System.IO.FileStream ($name), Create, Write;
        $bw = New-Object System.IO.BinaryWriter($fs);

        # Read of complete Blob with GetSqlBinary
        if ($rd.GetString(2) -eq "SSRS") {
			$bt = $rd.GetSqlBinary(4).Value;
		} else{
			$bt = $rd.GetSqlBinary(3).Value;
		}
				
        $bw.Write($bt, 0, $bt.Length);
        $bw.Flush();
        $bw.Close();
        $fs.Close();
    }
    Catch
    {
        Write-Output ($_.Exception.Message)
    }
    Finally
    {
        $fs.Dispose();
    }
}

# Closing & Disposing all objects
$rd.Close();
$cmd.Dispose();
$con.Close();
$con.Dispose();

Write-Output ((Get-Date -format yyyy-MM-dd-HH:mm:ss) + ": Finished");
"All done"
