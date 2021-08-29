#!/bin/bash

CONTAINER="httpd-echo"
echo "Stopping container..."
sudo docker stop $CONTAINER

echo "Removing container..."
sudo docker rm $CONTAINER

cd docker

sudo docker build --no-cache .

if [ $? -ne 0 ] ; then
  exit $?
fi

echo ""

read -p "Please enter IMAGE_ID: " IMAGE_ID

cmd="docker run -p 8080:8080 -d --label system_code=akamesh --name $CONTAINER $IMAGE_ID"
echo $cmd
CONTAINER_ID=$(sudo $cmd)
echo "CONTAINER_ID is $CONTAINER_ID"

sleep 1
curl http://localhost:8080/cgi-bin/echo.sh

sudo docker logs -f $CONTAINER_ID

#sudo docker exec -it $CONTAINER /bin/bash -l

