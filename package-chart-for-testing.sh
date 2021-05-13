#!/bin/sh
# Copyright 2021 Hewlett Packard Enterprise Development LP
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
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# (MIT License)

set -x
# You can use this helper script to package a chart for testing in craystack or a test system

this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
path_to_chart="$1"
if [ -z "$path_to_chart" ]; then
  echo "Provide a single argument that is the local path to the chart you want to package"
  exit 1
fi
path_to_chart=$( cd $path_to_chart >/dev/null 2>&1 && pwd )
chart_name=$(basename $path_to_chart)

docker run --rm -it -v $path_to_chart:/charts/$chart_name -v $this_dir:/packaged-dest arti.dev.cray.com/csm-internal-docker-stable-local/craypc/chartsutil:latest \
  /bin/sh -c "cd /charts/$chart_name && helm dep up && helm package . -d /packaged-dest"
