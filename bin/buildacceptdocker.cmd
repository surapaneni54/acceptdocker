
call setenv.cmd

if %1 == "" goto noacceptloc
if %2 == "" goto noimgname

set acceptZip=%1

copy %acceptZip% %DOCKER_DEV_HOME%\acceptinstaller

For %%A in ("%acceptZip%") do (
    Set acceptzipname=%%~nxA
)

set acceptImgName=%2

call replace.cmd "@@ACCEPT_ZIP@@" %acceptzipname% %DOCKER_DEV_HOME%\dockerfiles\accept_build_dockerfile.template  > %DOCKER_DEV_HOME%\dockerfiles\accept_build_dockerfile
call replace.cmd "@@ACCEPT_IMG_NAME@@" %acceptImgName% %DOCKER_DEV_HOME%\dockerfiles\accept_build_docker_compose.yml.template  > %DOCKER_DEV_HOME%\dockerfiles\accept_build_docker_compose.yml

echo "Building Oracle Database images"
docker build -f %DOCKER_DEV_HOME%/dockerfiles/acceptdb_dockerfile -t accept-oracle11g-data %DOCKER_DEV_HOME%

echo "Building Accept images"
docker build -f %DOCKER_DEV_HOME%/dockerfiles/accept_build_dockerfile -t %acceptImgName% %DOCKER_DEV_HOME%

echo "Removing any existing default database and accept containers and other configurations"
docker-compose -f %DOCKER_DEV_HOME%/dockerfiles/accept_build_docker_compose.yml down

echo "Creating Database and Accept containers and default network"
docker-compose -f %DOCKER_DEV_HOME%/dockerfiles/accept_build_docker_compose.yml up

goto :EOF

:noacceptloc
    echo ERROR: Accept Installer location not provided.
    goto :EOF

:noimgname
    echo ERROR: Accept Image name not provided.
    goto :EOF