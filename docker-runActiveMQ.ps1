#############################################
# This is for local development on Windows
# RUN USING THE FOLLOWING COMMAND
# powershell -executionpolicy remotesigned -File %MYDEMO_PATH%\myDemo\docker-runActiveMQ.ps1 [container name]
#
# e.g.
# powershell -executionpolicy remotesigned -File %MYDEMO_PATH%\myDemo\docker-runActiveMQ.ps1 myDemo
#
#
#############################################

$demoName = $args[0]
Write-Host 'ActiveMQ arguments are demoName: '$demoName

#--------------------------------------------------------------------------------------
# ACTIVE MQ
#

# Obtain the ip address
$ip=get-WmiObject Win32_NetworkAdapterConfiguration|Where {$_.Ipaddress.length -gt 1}

#get the name used for the container
$myDemoActiveMQName = $demoName + '-' + 'ActiveMQ' + '-' + '61616'

#first stop and remove any existing SQL containers
Write-Host 'Stopping and removing any MySQL container with name of '$myDemoSQLName
docker stop $myDemoActiveMQName
docker rm $myDemoActiveMQName

#get the host name used
$myDemoHostName = 'local.' + $demoName + '.com'

$cmd = 'docker run --name=' + $myDemoActiveMQName + ' --add-host ' + $myDemoHostName + ':' + $ip.ipaddress[0] + ' -p 8161:8161 -p 61616:61616 -p 61613:61613 -p 61617:61617 -d granthbr/docker-activemq-oraclejava-7'
Write-Host $cmd
Invoke-Expression $cmd