#!/bin/sh
#
# MIT License
#
# (C) Copyright 2020-2022 Hewlett Packard Enterprise Development LP
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
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
