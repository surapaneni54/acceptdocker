#!/bin/sh

java -cp "$DOCKER_HOME/lib/ojdbc6.jar:$DOCKER_HOME/lib/DBUtil.jar" com.versata.common.util.DBUtil "accept_service1" "accept" 2 180