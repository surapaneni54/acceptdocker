
call setenv.cmd

if %1 == "" goto noacceptloc

set acceptZip=%1

copy %acceptZip% %DOCKER_DEV_HOME%\acceptinstaller

For %%A in ("%acceptZip%") do (
    Set acceptzipname=%%~nxA
)

call replace.cmd "@@ACCEPT_ZIP@@" %acceptzipname% %DOCKER_DEV_HOME%\dockerfiles\accept_build_dockerfile.template  > %DOCKER_DEV_HOME%\dockerfiles\accept_build_dockerfile