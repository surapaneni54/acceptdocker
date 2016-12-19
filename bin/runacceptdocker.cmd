
call setenv.cmd

set acceptImgName=%1

echo "Using default image accept-latest-img when no arguments are provided"
if [%acceptImgName%] == [] (
	set acceptImgName=accept-latest-img
) 

call replace.cmd "@@ACCEPT_IMG_NAME@@" %acceptImgName% %DOCKER_DEV_HOME%\dockerfiles\accept_run_dockerfile.template > %DOCKER_DEV_HOME%\dockerfiles\accept_run_dockerfile
call replace.cmd "@@ACCEPT_IMG_NAME@@" %acceptImgName% %DOCKER_DEV_HOME%\dockerfiles\accept_run_docker_compose.yml.template > %DOCKER_DEV_HOME%\dockerfiles\accept_run_docker_compose.yml

echo "Building Oracle Database images"
docker build -f %DOCKER_DEV_HOME%/dockerfiles/acceptdb_dockerfile -t accept-oracle11g-data %DOCKER_DEV_HOME%

echo "Building Accept images"
docker build -f %DOCKER_DEV_HOME%/dockerfiles/accept_run_dockerfile -t %acceptImgName%-local %DOCKER_DEV_HOME%

echo "Removing any existing default database and accept containers and other configurations"
docker-compose -f %DOCKER_DEV_HOME%/dockerfiles/accept_run_docker_compose.yml down

echo "Creating Database and Accept containers and default network"
docker-compose -f %DOCKER_DEV_HOME%/dockerfiles/accept_run_docker_compose.yml up
