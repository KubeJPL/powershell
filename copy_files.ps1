
$source_ip = @('10.0.2.4', '10.0.2.5')

$file_name = "webportal.log"

$source_path = "\c$\Users\Administrator\Desktop\share_fold\$($file_name)"

$destination_path = "C:\Users\Administrator\Desktop\"


foreach ($i in $source_ip) {
$f_name = $i
    Copy-Item -Path \\"$($i)$($source_path)" -Destination "$($destination_path)$($i)_$($file_name)"
    }