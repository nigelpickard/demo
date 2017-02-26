#############################################
# This is for local development on Windows
# RUN USING THE FOLLOWING COMMAND
# powershell -executionpolicy remotesigned -File %MYDEMO_PATH%\myDemo\docker-runMySQL.ps1 [container name part] [database name] [mapped database port number] [stop]
#
# e.g.
# powershell -executionpolicy remotesigned -File %MYDEMO_PATH%\myDemo\docker-runMySQL.ps1 myDemo myDemoDb 3306 stop
#
#
#############################################

$demoName = $args[0]
$dbName = $args[1]
$dbMappedPort = $args[2]
$stop = $args[3]
Write-Host 'MySQL arguments are demoName: '$demoName' database name: '$dbName' mapped database port: '$dbMappedPort


#--------------------------------------------------------------------------------------
# MYSQL
#

# Obtain the ip address
$ip=get-WmiObject Win32_NetworkAdapterConfiguration|Where {$_.Ipaddress.length -gt 1}

#get the name used for the container
$myDemoSQLName = $demoName + '-' + 'MySQL' + '-' + $dbMappedPort

#get the host name used
$myDemoHostName = 'local.' + $demoName + '.com'


#first stop and remove any existing SQL containers
Write-Host 'Stopping and removing any MySQL container with name of '$myDemoSQLName
docker stop $myDemoSQLName
docker rm $myDemoSQLName


#now create directory if it doesn't exist
$databaseDir = $Env:MYDEMO_PATH + '/mySQLData/' + $dbMappedPort + '/' + $dbName

if(!(Test-Path -Path $databaseDir )){
    New-Item -ItemType directory -Path $databaseDir
}

#we now have the mysql running, now run the demo app
if("stop" -ne $stop){
    $cmd = 'docker run --name=' + $myDemoSQLName + ' --add-host ' + $myDemoHostName + ':' + $ip.ipaddress[0] + ' -v ' + $databaseDir + ':/var/lib/mysql -p ' + $dbMappedPort + ':3306 -e MYSQL_ROOT_PASSWORD=password -d mysql:5.6.32'
    Write-Host $cmd
    Invoke-Expression $cmd

    #now create the database if it does not exist
    $databaseDirDb = $databaseDir + '/' + $dbName
    if(!(Test-Path -Path $databaseDirDb )){
        #make sure container is started
        $cmd = 'Start-Sleep -s 30'
        Write-Host $cmd
        Invoke-Expression $cmd

        # create schema
        $cmd = 'cmd /c ''docker exec -i ' + $myDemoSQLName + ' mysql --port 3306 --password=password < createSchema.sql'''
        Write-Host $cmd
        Invoke-Expression $cmd
    }
}




