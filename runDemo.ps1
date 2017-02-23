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

#first stop and remove any existing SQL containers
Write-Host 'Stopping and removing any mysql container with name of '$mySQLName
docker stop $mySQLName
docker rm $mySQLName

# note: -p host port to the container port
docker run --name=$mySQLName -p $portSetting -e MYSQL_ROOT_PASSWORD=password -d mysql:5.6.32


#--------------------------------------------------------------------------------------
# APP
#
$myDemoName = $demoName + '-' + 'App'

#first stop and remove any existing SQL containers
Write-Host 'Stopping and removing any App container with name of '$myDemoName
docker stop $myDemoName
docker rm $myDemoName

#we now have the mysql running, now run the demo app
#docker run --name=mainApp --add-host local.omedlive.com:$ip.ipaddress[0] -p 8080:8080 --env-file=$Env:ZAREX_DOCKER_PATH\docker\local.env -d -v $Env:ZAREX_DOCKER_PATH\main-app\target\main-app-1.0-SNAPSHOT.jar:/docker/main-app-1.0-SNAPSHOT.jar java:8u40 java -jar /docker/main-app-1.0-SNAPSHOT.jar
docker run --name=$myDemoName --add-host $mappedHostInfo -p 8080:8080 -d -v $Env:DEMO_HOME\target\demo-0.0.1-SNAPSHOT.jar:/docker/demo-0.0.1-SNAPSHOT.jar java:8u40 java -jar /docker/demo-0.0.1-SNAPSHOT.jar