#!/bin/bash


docker stop httpd-echo
docker rm httpd-echo

docker run -p 127.0.0.1:8080:8080 -d --name httpd-echo akamesh/busybox-httpd-echo:latest

curl --silent --show-error http://127.0.0.1:8080/cgi-bin/echo.sh?hello=goodbye

docker stop httpd-echo


