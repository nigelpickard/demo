#############################################
# This is for local development on Windows
# RUN USING THE FOLLOWING COMMAND
# powershell -executionpolicy remotesigned -File %MYDEMO_PATH%\runMyDemo.ps1
#
#
#
#############################################

$myDemoName = 'myDemo'

$portNumberArray = (3306, 3307, 3308)
ForEach ($portNumber in $portNumberArray ) {
    $cmd = $Env:MYDEMO_PATH + '\myDemo\docker-runMySQL.ps1 ' + $myDemoName + ' ' + $portNumber
    Write-Host $cmd
    Invoke-Expression $cmd
}
