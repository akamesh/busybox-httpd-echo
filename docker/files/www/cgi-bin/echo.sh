#!/bin/bash
# Remember bash was added to busybox so use #!/bin/bash and not #!/bin/sh

# useful examples
# http://www.yolinux.com/TUTORIALS/BashShellCgi.html
# http://libcgi.sourceforge.net/

# https://tldp.org/LDP/abs/html/randomvar.html
response="/tmp/$RANDOM.html"

echo "<html>" > $response
echo "<body>" >> $response
echo "<p>POST data</p>" >> $response
echo "<pre>" >> $response

cat >> $response

echo "</pre>" >> $response
# display the environment
echo "<p>env vars</p>" >> $response
env|sort >> $response

echo "</pre>" >> $response
echo "</body>" >> $response
echo "</html>" >> $response

contentlength=$(stat -c %s "$response")

# respond
echo -e "HTTP/1.1 200 OK"
echo -e "Content-Length: $contentlength"
echo -e "Connection: close"
echo -e ""

while read output ; do 
  echo $output 
done < $response

rm -f $response

