#############################################
# This is for local development on Windows
# RUN USING THE FOLLOWING COMMAND
# powershell -executionpolicy remotesigned -File %MYDEMO_DOCKER_PATH%\myDemoMySqlStartup.ps1
#
# TODO: Have ability to start single service
#
#############################################

# usage will be:  runMyDemo [demoName] [port]

$demoName = 'myDemo'

#--------------------------------------------------------------------------------------
# APP
#
$myDemoName = $demoName + '-' + 'App'
# Obtain the ip address
$ip=get-WmiObject Win32_NetworkAdapterConfiguration|Where {$_.Ipaddress.length -gt 1}

#first stop and remove any existing SQL containers
Write-Host 'Stopping and removing any App container with name of '$myDemoName
docker stop $myDemoName
docker rm $myDemoName

#we now have the mysql running, now run the demo app
#$cmd = 'docker run --name=' + $myDemoName + '  --add-host local.omedlive.com:' + $ip.ipaddress[0] + ' -p 8080:8080 -d -v $Env:DEMO_HOME\target\demo-0.0.1-SNAPSHOT.jar:/docker/demo-0.0.1-SNAPSHOT.jar java:8u40 java -jar /docker/demo-0.0.1-SNAPSHOT.jar'
#$cmd = 'docker run --name=' + $myDemoName + ' -p 8080:8080 -d -v $Env:DEMO_HOME\target\demo-0.0.1-SNAPSHOT.jar:/docker/demo-0.0.1-SNAPSHOT.jar java:8u40 java -jar /docker/demo-0.0.1-SNAPSHOT.jar'
#$cmd = 'docker run  --link myDemo-MySQL:myDemo-MySQL --name=' + $myDemoName + ' -p 8080:8080 -d -v $Env:DEMO_HOME\target\demo-0.0.1-SNAPSHOT.jar:/docker/demo-0.0.1-SNAPSHOT.jar java:8u40 java -jar /docker/demo-0.0.1-SNAPSHOT.jar'

#$cmd = 'docker run --name=mainApp --add-host ' + $hostNames + ':' + $ip.ipaddress[0] + ' -p 8080:8080 --env-file=$Env:ZAREX_DOCKER_PATH\docker\local.env -d -v $Env:ZAREX_DOCKER_PATH\main-app\target\main-app-1.0-SNAPSHOT.jar:/docker/main-app-1.0-SNAPSHOT.jar java:8u40 java -jar /docker/main-app-1.0-SNAPSHOT.jar'
$cmd = 'docker run --name=' + $myDemoName + ' --add-host local.omedlive.com:' + $ip.ipaddress[0] + ' -p 8080:8080 -d -v $Env:DEMO_HOME\target\demo-0.0.1-SNAPSHOT.jar:/docker/demo-0.0.1-SNAPSHOT.jar java:8u40 java -jar /docker/demo-0.0.1-SNAPSHOT.jar'
Write-Host $cmd
Invoke-Expression $cmd
