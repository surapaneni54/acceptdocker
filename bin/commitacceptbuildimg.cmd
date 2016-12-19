
if %1 == "" goto noimgname

set acceptImgName=%1

docker login --username=acceptdockerrep --password=accept

echo "Committing Accept Image as " %acceptImgName% "and updating to the docker hub"
docker commit accept-cnt acceptdockerrep/%acceptImgName%
docker push acceptdockerrep/%acceptImgName%

echo "Tagging Accept Image as accept-latest-img and updating to the docker hub"
docker tag acceptdockerrep/%acceptImgName% acceptdockerrep/accept-latest-img
docker push acceptdockerrep/accept-latest-img
goto :EOF

:noimgname
    echo ERROR: Accept Image name not provided.
    goto :EOF