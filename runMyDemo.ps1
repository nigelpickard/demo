#############################################
# This is for local development on Windows
# RUN USING THE FOLLOWING COMMAND
# powershell -executionpolicy remotesigned -File %MYDEMO_PATH%\runMyDemo.ps1
#
#
#
#############################################

$NumArray = (3306, 3307, 3308)
ForEach ($number in $NumArray ) {
    $cmd = $Env:MYDEMO_PATH + '\myDemo\docker-runMySQL.ps1 myDemo ' + $number
    Write-Host $cmd
    Invoke-Expression $cmd
}
