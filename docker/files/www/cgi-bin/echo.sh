#!/bin/bash
# Remember bash was added to busybox so use #!/bin/bash and not #!/bin/sh

# https://tldp.org/LDP/abs/html/randomvar.html
response="/tmp/$RANDOM.html"

echo "<html>" > $response
echo "<body>" >> $response
echo "<pre>" >> $response

# receive request
while read -r line ; do 

  echo $line >> $response

  # optional: echo to stderr for logging
  #>&2 echo ${line}

  if [ ${#line} -eq 1 ] ; then
    break ;
  fi
done

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

