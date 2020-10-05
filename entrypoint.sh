#!/usr/bin/env sh
# Copyright 2019, Cray Inc. All Rights Reserved.
# Dockerfile for CMS tftpd service

# syslog-ng is installed in this container. Syslog-ng will log writes to the 
# Unix domain socket '/dev/log' to the stdout of process 1. The TFTP binary is
# process 1 in this container. Docker uses process 1's stdout as the container's
# log. The TFTP binary only logs to syslog and does not send output to stdout.
# Therefore, it was necessary to install a logging program, in this case,
# syslog-ng to handle TFTP's output.

set -e
/usr/sbin/syslog-ng -f /etc/syslog-ng/syslog-ng.conf

exec "$@"
