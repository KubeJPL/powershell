<#
  This script is designed to copy files from multiple work stations to the main one
  Syntax: .\copy_test.ps1 stage1 2020-06-05
#>

<#$source_path = "\e$\SnapshotLogs\webportal\$($file_name)"#>


<#$destination_path = "C:\Users\aiacob006a\Desktop\logs\"#>


$destination_path = "C:\Users\Administrator\Desktop\logs\"


$prod = @('10.0.2.4')

$stage1 = @('10.0.2.5')

$file_name_date = $args[1]

$file_name = "webportal.log"
if ($file_name_date) {
    $file_name = "$($file_name).$($file_name_date)"
}
$source_path = "\c$\Users\Administrator\Desktop\share_fold\$($file_name)"
echo "source path is: $($source_path)"
echo "file_name_date is :  $($file_name_date)"
echo "file_name is :  $($file_name)"
echo "source_path is : $($source_path)"


if ($args[0] -eq "prod") {
    $source_ip = $prod
    echo "prod ip is $($source_ip)"
}

elseif ($args[0] -eq "stage1") {
    $source_ip = $stage1
    echo "stage1 ip is $($source_ip)"
}



foreach ($i in $source_ip) {
    if (Test-Path \\"$($i)$($source_path)") {
        $f_name = $i
        Copy-Item -Path \\"$($i)$($source_path)" -Destination "$($destination_path)$($i)_$($file_name)"
        Write-Output "File $($file_name) from $($i) was copied to $($destination_path)$($i)_$($file_name)"

      }
  }