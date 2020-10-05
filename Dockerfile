# Dockerfile for CMS tftpd service
# Copyright 2018-2020 Hewlett Packard Enterprise Development LP

FROM dtr.dev.cray.com/baseos/alpine:3.11.5
WORKDIR /app
EXPOSE 69/udp
VOLUME /var/lib/tftpboot
RUN apk add --no-cache \
    syslog-ng \
    tftp-hpa && \
    mkdir -p /var/lib/tftpboot
COPY syslog-ng.conf /etc/syslog-ng/
COPY tftp_liveness.sh tftp_readiness.sh entrypoint.sh /app/

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/usr/sbin/in.tftpd", "--foreground", "--verbose", "--user", "root", "--secure", "/var/lib/tftpboot"]
