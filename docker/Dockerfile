FROM akamesh/busybox-bash:0.4
LABEL Maintainers="support@akamesh.com"
COPY --chown=1000:1000 ./files/ /
EXPOSE 8080/tcp
CMD /bin/sh /httpd.sh
