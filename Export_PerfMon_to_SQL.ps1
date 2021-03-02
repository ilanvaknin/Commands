$sourceblg = "D:\PerfLogs\ETL\HO-SQL16_20190830-000005\DataCollector01.blg"
$sqldsnconnection = "SQL:Perfmon_DSN!logfile"

$allarg = @($sourceblg, '-f', 'SQL', '-o', $sqldsnconnection)

& 'relog.exe' $allarg