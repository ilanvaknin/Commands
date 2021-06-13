$rootfolder = 'E:\backup\Flex\'
$Filepath       = $rootfolder+'Mahout_Backup_'+$date # local directory to save build-scripts to

$ssas_deployment = 'Microsoft.AnalysisServices.Deployment.exe'
$asdatabase = 'E:\sources\Ilan\BI Developers\FlexTabular\Master\FlexTabular\bin\Model.asdatabase'
$pathxmla = $Filepath+'\FlexTabular.xmla'
$arglist = @(
	$asdatabase,	
	"/d",
	"/o:$pathxmla"
)
Start-Process -FilePath $ssas_deployment -ArgumentList $arglist