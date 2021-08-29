#!/bin/sh

echo "About to start httpd"

# -f to run in foreground and not exit, thus keeping container alive
httpd -f -vv -c /etc/httpd.conf -p 8080 -u 1000:1000 -h /www

echo "Return code is $?"

