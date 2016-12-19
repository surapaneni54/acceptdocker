#!bin/bash

. setenv.sh

if ["$1" == ""]; then 
    echo ERROR: Accept Installer location not provided.
    exit 1;
fi

if ["$2" == ""]; then 
    echo ERROR: Accept Image name not provided.
    exit 1;
fi

cp "$1" $DOCKER_DEV_HOME\acceptinstaller

acceptImgName="$2"

sed 's/@@ACCEPT_IMG_NAME@@/$acceptImgName/g' $DOCKER_DEV_HOME/dockerfiles/accept_build_docker_compose.yml.template > $DOCKER_DEV_HOME/dockerfiles/accept_build_docker_compose.yml

echo "Building Oracle Database images"
docker build -f $DOCKER_DEV_HOME/dockerfiles/acceptdb_dockerfile -t accept-oracle11g-data $DOCKER_DEV_HOME

echo "Building Accept images"
docker build -f $DOCKER_DEV_HOME/dockerfiles/accept_build_dockerfile -t $acceptImgName $DOCKER_DEV_HOME

echo "Removing any existing default database and accept containers and other configurations"
docker-compose -f $DOCKER_DEV_HOME/dockerfiles/accept_build_docker_compose.yml down

echo "Creating Database and Accept containers and default network"
docker-compose -f $DOCKER_DEV_HOME/dockerfiles/accept_build_docker_compose.yml up
