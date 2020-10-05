#!/bin/sh
# Copyright 2020 Hewlett Packard Enterprise Development LP
# Kubernetes readiness check for the tftpd service.
# If the expected file can not be obtained from the tftpd
# service then exit with a non-zero value to signal that
# Kubernetes should not route traffic to this pod.

# Exit on any error and ensure the cleanup trap is run.
set -e
tftp_dir=/var/lib/tftpboot
cleanup(){
   rm -f $tftp_dir/$HOSTNAME
   rm -f /tmp/$HOSTNAME
}
trap 'cleanup' EXIT

# Create a temporary file under the tftpd server
# directory for this test.
echo $HOSTNAME > $tftp_dir/$HOSTNAME

# Remove any previous file that may exist in /tmp.
rm -f /tmp/$HOSTNAME

# Try to obtain the file from the tftpd server and
# save it into /tmp.   Limit the time that tftp can
# run in the event the command hangs and results in numerous
# checks being spawned (CASMCMS-5848).
timeout 3s tftp localhost -c get $HOSTNAME /tmp/$HOSTNAME
if [ -s /tmp/$HOSTNAME ]; then
    # File has some data; TFTP succeeded.
    exit 0;
else
    # File is empty. TFTP failed.
    exit 1;
fi
