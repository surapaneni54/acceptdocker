#!/bin/bash

echo "Testing Database Container/Connection availability..."

. $DOCKER_HOME/bin/testdbconnection.sh
dbstatus=$?

echo "Accept Docker Log" >> $DOCKER_HOME/logs/accept-docker.log

if [ "$dbstatus" -ne 0 ]; then
    echo "Accept Server cannot be started because database container/connection not available" >> $DOCKER_HOME/logs/accept-docker.log
	tail -f $DOCKER_HOME/logs/accept-docker.log
else
    echo "Starting Dockerized Accept Server" >> $DOCKER_HOME/logs/accept-docker.log

    echo "Starting Dockerized Accept Server"
    $ACCEPT_HOME/startaccept.sh start

    tail -f $DOCKER_HOME/logs/accept-docker.log
fi 