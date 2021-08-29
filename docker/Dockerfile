FROM docker pull akamesh/busybox-bash
LABEL Maintainers="support@akamesh.com"
COPY --chown=1000:1000 ./files/ /
CMD /bin/sh /httpd.sh
