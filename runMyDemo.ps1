#############################################
# This is for local development on Windows
# RUN USING THE FOLLOWING COMMAND
# powershell -executionpolicy remotesigned -File %MYDEMO_PATH%\runMyDemo.ps1
#
#
#
#############################################

$cmd = $Env:MYDEMO_PATH + '\myDemo\docker-runMySQL.ps1 myDemo 3310'
Write-Host $cmd
Invoke-Expression $cmd