
echo "Committing Accept Image as " $acceptImgName "and updating to the docker hub"
docker commit accept-cnt acceptdockerrep/$acceptImgName
docker push accept-cnt acceptdockerrep/$acceptImgName

echo "Committing Accept Image as accept_latest_img and updating to the docker hub"
docker commit accept-cnt acceptdockerrep/accept_latest_img
docker push accept-cnt acceptdockerrep/accept_latest_img