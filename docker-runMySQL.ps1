#############################################
# This is for local development on Windows
# RUN USING THE FOLLOWING COMMAND
# powershell -executionpolicy remotesigned -File %MYDEMO_PATH%\myDemo\docker-runMySQL.ps1 [container name part] [mapped port number]
#
# e.g.
# powershell -executionpolicy remotesigned -File %MYDEMO_PATH%\myDemo\docker-runMySQL.ps1 myDemo 1 3306
#
#
#############################################

$demoName = $args[0]
$mappedPort = $args[1]
Write-Host 'Arguments are demoName: '$demoName' instance Id: '$instanceId' mapped port: '$mappedPort


Write-Host 'MYDEMO_PATH='$Env:MYDEMO_PATH


#--------------------------------------------------------------------------------------
# MYSQL
#

# Obtain the ip address
$ip=get-WmiObject Win32_NetworkAdapterConfiguration|Where {$_.Ipaddress.length -gt 1}

#get the name used for the container
$myDemoSQLName = $demoName + '-' + 'MySQL' + '-' + $mappedPort

#get the host name used
$myDemoHostName = 'local.' + $demoName + '.com'


#first stop and remove any existing SQL containers
Write-Host 'Stopping and removing any App container with name of '$myDemoName
docker stop $myDemoSQLName
docker rm $myDemoSQLName


#now create directory if it doesn't exist
$databaseDir = $Env:MYDEMO_PATH + '/mySQLData/' + $mappedPort + '/myDemoDb'


if(!(Test-Path -Path $databaseDir )){
    New-Item -ItemType directory -Path $databaseDir
}

#we now have the mysql running, now run the demo app
$cmd = 'docker run --name=' + $myDemoSQLName + ' --add-host ' + $myDemoHostName + ':' + $ip.ipaddress[0] + ' -v ' + $databaseDir + ':/var/lib/mysql -p ' + $mappedPort + ':3306 -e MYSQL_ROOT_PASSWORD=password -d mysql:5.6.32'
Write-Host $cmd
Invoke-Expression $cmd


#now create the database
#make sure container is started
$cmd = 'Start-Sleep -s 30'
Write-Host $cmd
Invoke-Expression $cmd

# create schema
$cmd = 'cmd /c ''docker exec -i ' + $myDemoSQLName + ' mysql --port 3306 --password=password < createSchema.sql'''
Write-Host $cmd
Invoke-Expression $cmd
