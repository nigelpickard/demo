#############################################
# This is for local development on Windows
# RUN USING THE FOLLOWING COMMAND
# powershell -executionpolicy remotesigned -File %MYDEMO_DOCKER_PATH%\myDemoMySqlStartup.ps1
#
# TODO: Have ability to start single service
#
#############################################


## CLEANUP EXISTING CONTAINERS AND DIRECTORY FOR TEMP SETTINGS
#docker stop myDemoMySQL
#docker rm myDemoMySQL

## Start up all containers and an activeMQ container on localhost
#docker run --name=myDemoMySQL -v c:/Users/npickard/Documents/personal/MyDemo/myDemoMySqlData/myDemo_database:/var/lib/mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -d mysql:5.6.32