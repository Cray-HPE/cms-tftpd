#!/bin/sh
# Copyright 2020 Hewlett Packard Enterprise Development LP
# Kubernetes liveness check for the tftpd service.
# If the expected tftpd process is not found then exit
# with a non-zero value to signal Kubernetes to restart
# this pod.
#
proc_name=in.tftpd
pgrep $proc_name > /dev/null
if [ $? -ne 0 ]
then
  echo "liveness: Did not find the expected $proc_name process."
  return 1
fi

