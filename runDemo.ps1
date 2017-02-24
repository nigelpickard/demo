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
$hostPort = '3306'
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

#first stop and remove any existing SQL containers
Write-Host 'Stopping and removing any mysql container with name of '$mySQLName
docker stop $mySQLName
docker rm $mySQLName

# note: -p host port to the container port
$cmd = 'docker run --name=' + $mySQLName + ' -p ' + $portSetting + ' -e MYSQL_ROOT_PASSWORD=password -d mysql:5.6.32'
Write-Host $cmd
Invoke-Expression $cmd

#make sure container is started
$cmd = 'Start-Sleep -s 30'
Write-Host $cmd
Invoke-Expression $cmd

# create schema
$cmd = 'cmd /c ''docker exec -i ' + $mySQLName + ' mysql --port 3306 --password=password < createSchema.sql'''
Write-Host $cmd
Invoke-Expression $cmd


#--------------------------------------------------------------------------------------
# APP
#
$myDemoName = $demoName + '-' + 'App'

#first stop and remove any existing SQL containers
Write-Host 'Stopping and removing any App container with name of '$myDemoName
docker stop $myDemoName
docker rm $myDemoName

#we now have the mysql running, now run the demo app
#$cmd = 'docker run --name=' + $myDemoName + ' -p 8080:8080 -d -v $Env:DEMO_HOME\target\demo-0.0.1-SNAPSHOT.jar:/docker/demo-0.0.1-SNAPSHOT.jar java:8u40 java -jar /docker/demo-0.0.1-SNAPSHOT.jar'
#$cmd = 'docker run --name=' + $myDemoName + ' --add-host ' + $mappedHostInfo + ' -p 8080:8080 -d -v $Env:DEMO_HOME\target\demo-0.0.1-SNAPSHOT.jar:/docker/demo-0.0.1-SNAPSHOT.jar java:8u40 java -jar /docker/demo-0.0.1-SNAPSHOT.jar'
$cmd = 'docker run --name=' + $myDemoName + ' -p 8080:8080 -d -v $Env:DEMO_HOME\target\demo-0.0.1-SNAPSHOT.jar:/docker/demo-0.0.1-SNAPSHOT.jar java:8u40 java -jar /docker/demo-0.0.1-SNAPSHOT.jar' + ' --link ' + $mySQLName + ':' + $mySQLName
Write-Host $cmd
Invoke-Expression $cmd
