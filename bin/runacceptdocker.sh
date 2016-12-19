#!bin/bash

. setenv.sh

acceptImgName="$1"

echo "Using default image accept_latest_img when no arguments are provided"
if [$acceptImgName == ""]; then
    acceptImgName=accept-latest-img
fi

sed 's/@@ACCEPT_IMG_NAME@@/$acceptImgName/g' $DOCKER_DEV_HOME/dockerfiles/accept_run_dockerfile.template > $DOCKER_DEV_HOME/dockerfiles/accept_run_dockerfile
sed 's/@@ACCEPT_IMG_NAME@@/$acceptImgName/g' $DOCKER_DEV_HOME/dockerfiles/accept_run_docker_compose.yml.template > $DOCKER_DEV_HOME/dockerfiles/accept_run_docker_compose.yml

echo "Building Oracle Database images"
docker build -f $DOCKER_DEV_HOME/dockerfiles/acceptdb_dockerfile -t accept-oracle11g-data $DOCKER_DEV_HOME

echo "Building Accept images"
docker build -f $DOCKER_DEV_HOME/dockerfiles/accept_run_dockerfile -t $acceptImgName-local $DOCKER_DEV_HOME

echo "Removing any existing default database and accept containers and other configurations"
docker-compose -f $DOCKER_DEV_HOME/dockerfiles/accept_run_docker_compose.yml down

echo "Creating Database and Accept containers and default network"
docker-compose -f $DOCKER_DEV_HOME/dockerfiles/accept_run_docker_compose.yml up