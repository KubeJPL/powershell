<#
  This script is designed to copy files from multiple work stations to the main one
  Syntax:  .\copy_logs.ps1 prod 2020-06-05  --> For choosing a specific date log
			.\copy_logs.ps1 prod webportal  --> For choosing the generic webportal log
			.\copy_logs.ps1 prod systemout  --> For choosing the systemout log
#>


$destination_path = "C:\Users\aiacob006a\Desktop\logs\"

$webportallog = "webportal.log"



$prod = @('10.243.25.22')

$stage1 = @('10.243.29.22')



$file_name_date = $args[1]


# Environments

if ($args[0] -eq "prod") {
    $source_ip = $prod
    echo "prod ip is $($source_ip)"
}

elseif ($args[0] -eq "stage1") {
    $source_ip = $stage1
    echo "stage1 ip is $($source_ip)"
}


 #webportal.log 
 
 
if($args[1] -eq "webportal")
{
	$file_name = "webportal.log"
	$source_path = "\e$\SnapshotLogs\webportal\$($file_name)"
	
	echo "source path is: $($source_path)"
	echo "file_name is :  $($file_name)"

	foreach ($i in $source_ip) {



    if (Test-Path \\"$($i)$($source_path)") {
        $f_name = $i
        Copy-Item -Path \\"$($i)$($source_path)" -Destination "$($destination_path)$($i)_$($file_name)"
        Write-Output "File $($file_name) from $($i) was copied to $($destination_path)$($i)_$($file_name)"

      }
  }
}


#webportal.date


if($args[1] -eq $file_name_date)
{
	$file_name = $webportallog
	$source_path = "\e$\SnapshotLogs\webportal\$($file_name).$($file_name_date)"
	
	echo "source path is: $($source_path)"
	echo "file_name is :  $($file_name).$($file_name_date)"

	foreach ($i in $source_ip) {



    if (Test-Path \\"$($i)$($source_path)") {
        $f_name = $i
        Copy-Item -Path \\"$($i)$($source_path)" -Destination "$($destination_path)$($i)_$($file_name).$($file_name_date)"
        Write-Output "File $($file_name).$($file_name_date) from $($i) was copied to $($destination_path)$($i)_$($file_name).$($file_name_date)"

      }
  }
}


#SystemOut.log

 
if($args[1] -eq "systemout"){
	

	foreach ($i in $source_ip) {
		
		$systemoutlog = @(Get-ChildItem -Path \\$source_ip\e$\IBM\WASv85\profiles\AppSrv01\logs\ -recurse -filter SystemOut.log | % {Write-Output $_.FullName})

		echo "========================================="
		
		$array = $systemoutlog.Split()
		
		echo "========================================="
		echo $array
		foreach ($k in $array)
		{
		echo "########"
		echo $k

		echo "########"
		}
		foreach ($j in $array)
		{
			$source_path= $j
            $file_name="SystemOut.log"
			#echo "source path is: $($j)"
			$parent= Split-Path (Split-Path "$j" -Parent) -Leaf
			echo $parent
					
			Copy-Item -Path "$j" -Destination "$($destination_path)$($i)_$($parent)_$($file_name)"
			Write-Output "File $($file_name) from $($i) was copied to $($destination_path)$($i)_$($parent)_$($file_name)"

	  }
  }
}

 echo "Done"
