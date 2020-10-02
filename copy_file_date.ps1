
<#
  This script is designed to copy files from multiple work stations to the main one
#>

$file_name_date = $args[0]

$source_ip = @('10.0.2.4', '10.0.2.5')

$file_name = "webportal.log"

if ($file_name_date){

  $file_name = "$($file_name).$($file_name_date)"

}


$source_path = "\c$\Users\Administrator\Desktop\share_fold\$($file_name)"

$destination_path = "C:\Users\Administrator\Desktop\"


foreach ($i in $source_ip) {
$f_name = $i
    Copy-Item -Path \\"$($i)$($source_path)" -Destination "$($destination_path)$($i)_$($file_name)"
    echo "File $($file_name) from $($i) was copied to $($destination_path)$($i)_$($file_name)"
    }
