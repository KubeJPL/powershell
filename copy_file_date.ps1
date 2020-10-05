<#
  This script is designed to copy files from multiple work stations to the main one
  Syntax: .\copy_test.ps1 stage1 2020-06-05
#>

$prod = @('server1', 'server2', 'server3', 'server4')

$stage1 = @('server1', 'server2', 'server3', 'server4')

$file_name_date = $args[1]

$file_name = "webportal.log"

if ($file_name_date) {
    $file_name = "$($file_name).$($file_name_date)"
}

if ($args[0] -eq "prod") {
    $source_ip = $prod
}

elseif ($args[0] -eq "stage1") {
    $source_ip = $stage1
}
$source_path = "\e$\SnapshotLogs\webportal\$($file_name)"
$destination_path = "C:\Users\aiacob006a\Desktop\logs\"


foreach ($i in $source_ip) {
    $f_name = $i
    Copy-Item -Path \\"$($i)$($source_path)" -Destination "$($destination_path)$($i)_$($file_name)"
    echo "File $($file_name) from $($i) was copied to $($destination_path)$($i)_$($file_name)"

}
