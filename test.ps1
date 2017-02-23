#############################################
# This is for local development on Windows
# RUN USING THE FOLLOWING COMMAND
# powershell -executionpolicy remotesigned -File %MYDEMO_DOCKER_PATH%\myDemoMySqlStartup.ps1
#
# TODO: Have ability to start single service
#
#############################################

# usage will be:  runMyDemo [demoName] [port]

# Obtain the ip address
$ip=get-WmiObject Win32_NetworkAdapterConfiguration|Where {$_.Ipaddress.length -gt 1}

$demoName = 'myDemo'
$hostPort = '3308'
$containerPort = '3306'
$portSetting = $hostPort + ':' + $containerPort
$mappedHostName = 'local.' + $demoName + '.com'
$mappedHostInfo = $mappedHostName + ':' + $ip.ipaddress[0]


#--------------------------------------------------------------------------------------
# MYSQL
#

#set docker sql name
$mySQLName = $demoName + '-' + 'MySQL'
Write-Host 'The mysql container name is '$mySQLName

$cmd = 'cmd /c ''docker exec -i ' + $mySQLName + ' mysql --port 3306 --password=password < createSchema.sql'''
Write-Host $cmd
Invoke-Expression $cmd

