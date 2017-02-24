#############################################
# This is for local development on Windows
# RUN USING THE FOLLOWING COMMAND
# powershell -executionpolicy remotesigned -File %MYDEMO_DOCKER_PATH%\myDemoMySqlStartup.ps1
#
# TODO: Have ability to start single service
#
#############################################

$demoName = 'myDemo'

#--------------------------------------------------------------------------------------
# APP
#
$myDemoSQLName = $demoName + '-' + 'MySQL'
# Obtain the ip address
$ip=get-WmiObject Win32_NetworkAdapterConfiguration|Where {$_.Ipaddress.length -gt 1}

#first stop and remove any existing SQL containers
Write-Host 'Stopping and removing any App container with name of '$myDemoName
docker stop $myDemoSQLName
docker rm $myDemoSQLName

#we now have the mysql running, now run the demo app
$cmd = 'docker run --name=' + $myDemoSQLName + ' --add-host local.mydemo.com:' + $ip.ipaddress[0] + ' -v c:/Users/npickard/Documents/personal/MyDemo/workspace/myDemoDb:/var/lib/mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -d mysql:5.6.32'
Write-Host $cmd
Invoke-Expression $cmd
