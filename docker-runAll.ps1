#############################################
# This is for local development on Windows
# RUN USING THE FOLLOWING COMMAND
# powershell -executionpolicy remotesigned -File %MYDEMO_PATH%\myDemo\docker-runAllMyDemo.ps1 [container name part] [database name]
#
# e.g.
# powershell -executionpolicy remotesigned -File %MYDEMO_PATH%\myDemo\docker-runAllMyDemo.ps1 myDemo myDemoDb
#
#
#############################################

$demoName = $args[0]
$dbName = $args[1]
Write-Host 'Running and create all services -arguments are demoName: '$demoName'  database name: '$dbName
Write-Host 'MYDEMO_PATH='$Env:MYDEMO_PATH


$dbPortNumbersArray = (3306, 3307)
$demoPortNumbersArray = (8080, 8081)


for($i = 0; $i -le $dbPortNumbersArray.count -1; $i++) {

    $cmd = $Env:MYDEMO_PATH + '\myDemo\docker-runMySQL.ps1 ' + $demoName + ' ' + $dbName + ' ' + $dbPortNumbersArray[$i]
    Write-Host $cmd
    Invoke-Expression $cmd

    #make sure container is started
    $cmd = 'Start-Sleep -s 10'
    Write-Host $cmd
    Invoke-Expression $cmd

    $cmd = $Env:MYDEMO_PATH + '\myDemo\docker-runMyDemo.ps1 ' + $demoName + ' ' + $demoPortNumbersArray[$i] + ' ' + $dbName + ' ' + $dbPortNumbersArray[$i]
    Write-Host $cmd
    Invoke-Expression $cmd

}


#ForEach ($dbPortNumber in $dbPortNumberArray ) {
#    $cmd = $Env:MYDEMO_PATH + '\myDemo\docker-runMySQL.ps1 ' + $demoName + ' ' + $dbPortNumber + ' ' + $dbName
#    Write-Host $cmd
#    Invoke-Expression $cmd
#}
