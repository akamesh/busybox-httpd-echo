#!/bin/bash

# run as sudo

container_name="httpd-echo"
echo "Stopping container..."
docker stop $container_name

echo "Removing container..."
docker rm $container_name

cd docker
image_id=""

# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html
pattern="Successfully built (.*)"

while read -r line ; do 
  echo $line
  if [[ $line =~ $pattern ]] ; then
    image_id=${BASH_REMATCH[1]}
  fi

done < <(docker build --no-cache .)

#https://unix.stackexchange.com/questions/14270/get-exit-status-of-process-thats-piped-to-another

if [ -z "$image_id" ] ; then
  exit 1
fi

echo ""

echo "Using image id $image_id"

cmd="docker run -p 127.0.0.1:8080:8080 -d --label system_code=akamesh --name $container_name $image_id"
echo $cmd
container_id=$($cmd)
echo "container_id is $container_id"

sleep 10

cmd="docker ps --filter name=$container_name"
echo $cmd
$cmd

cmd="ps -wf -u 1000"
echo $cmd
$cmd

echo "###########################################"
cmd="docker logs --since 1m $container_name"
echo $cmd
$cmd
echo "###########################################"

echo "###########################################"
cmd="curl --silent --show-error --connect-timeout 1 http://127.0.0.1:8080/"
echo $cmd
$cmd
echo "###########################################"

echo "###########################################"
cmd="docker logs --since 1m $container_name"
echo $cmd
$cmd
echo "###########################################"


#docker exec -it $container_name /bin/bash -l

