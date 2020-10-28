$date = Get-Date -Format 'yyyy/MM/dd'

$server_source_name = "ADRIAN\SQLEXPRESS"

$destinationdatabase = "AdventureWorks2012"

$backup_dest = "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\$date_$destinationdatabase"

$backup_source = "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\$date_$destinationdatabase"




# Script for backup

$scriptForBackup="BACKUP DATABASE $destinationdatabase TO  DISK = N'$backup_dest' WITH NOFORMAT, NOINIT,  NAME = N'$backup_dest);', SKIP, NOREWIND, NOUNLOAD, NO_COMPRESSION,  STATS = 10
GO"

# Script for restore

$scriptForRestore="USE [master]
ALTER DATABASE $destinationdatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE $destinationdatabase FROM  DISK = N'$backup_source' WITH  FILE = 2,  NOUNLOAD,  REPLACE,  STATS = 5
ALTER DATABASE $destinationdatabase SET MULTI_USER

GO"



# Execution


if($args[0] -eq "Backup"){

Write-Host "We are backing-up $destinationdatabase"

$Backup = Invoke-Sqlcmd -ServerInstance "$server_source_name" -Query $scriptForBackup -Database master -Verbose -ErrorAction stop

}

elseif($args[0] -eq "Restore"){

Write-Host "We are restoring $destinationdatabase"

$Restore = Invoke-Sqlcmd -ServerInstance "$server_source_name" -Query $scriptForRestore -Database master -Verbose -ErrorAction stop

}

