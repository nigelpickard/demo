#############################################
# This is for local development on Windows
# RUN USING THE FOLLOWING COMMAND
# powershell -executionpolicy remotesigned -File %MYDEMO_PATH%\myDemo\docker-runAll.ps1 [container name part] [database name] [stop]
#
# e.g.
# powershell -executionpolicy remotesigned -File %MYDEMO_PATH%\myDemo\docker-runAll.ps1 myDemo myDemoDb stop
#
#
#############################################

$demoName = $args[0]
$dbName = $args[1]
$stop = $args[2]
Write-Host 'Running and create all services -arguments are demoName: '$demoName'  database name: '$dbName
Write-Host 'MYDEMO_PATH='$Env:MYDEMO_PATH


#get active mq up and running
$cmd = $Env:MYDEMO_PATH + '\myDemo\docker-runActiveMQ.ps1 ' + $demoName + ' ' + $stop
Write-Host $cmd
Invoke-Expression $cmd

$dbPortNumbersArray = (3306, 3307)
$demoPortNumbersArray = (8080, 8081)

for($i = 0; $i -le $dbPortNumbersArray.count -1; $i++) {

    $cmd = $Env:MYDEMO_PATH + '\myDemo\docker-runMySQL.ps1 ' + $demoName + ' ' + $dbName + ' ' + $dbPortNumbersArray[$i]  + ' ' + $stop
    Write-Host $cmd
    Invoke-Expression $cmd

    if("stop" -ne $stop){
        #make sure container is started
        $cmd = 'Start-Sleep -s 10'
        Write-Host $cmd
        Invoke-Expression $cmd
    }

    $cmd = $Env:MYDEMO_PATH + '\myDemo\docker-runMyDemo.ps1 ' + $demoName + ' ' + $demoPortNumbersArray[$i] + ' ' + $dbName + ' ' + $dbPortNumbersArray[$i]  + ' ' + $stop
    Write-Host $cmd
    Invoke-Expression $cmd

}
