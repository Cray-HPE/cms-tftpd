# Copyright 2019-2021 Hewlett Packard Enterprise Development LP
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

DOCKER_NAME ?= cray-tftpd
CHART_PATH ?= kubernetes
VERSION ?= $(shell cat .version)-local
CHART_VERSION ?= $(VERSION)

HELM_UNITTEST_IMAGE ?= quintush/helm-unittest:3.3.0-0.2.5

all : build_prep lint image chart

chart: chart_setup chart_tftp chart_tftp_pvc chart_tftpd_ipxe

chart_tftp: chart_tftp_package chart_tftp_test
chart_tftp_pvc: chart_tftp_pvc_package chart_tftp_pvc_test
chart_tftpd_ipxe: chart_tftpd_ipxe_package chart_tftpd_ipxe_test

build_prep:
		./runBuildPrep.sh

lint:
		./runLint.sh

image:
		docker build --pull ${DOCKER_ARGS} --tag '${DOCKER_NAME}:${VERSION}' .


chart_setup:
		mkdir -p ${CHART_PATH}/.packaged
		printf "\nglobal:\n  appVersion: ${VERSION}" >> ${CHART_PATH}/cray-tftp/values.yaml
		printf "\nglobal:\n  appVersion: ${VERSION}" >> ${CHART_PATH}/cray-tftp-pvc/values.yaml
		printf "\nglobal:\n  appVersion: ${VERSION}" >> ${CHART_PATH}/cray-tftpd-ipxe/values.yaml

chart_tftp_package:
		helm dep up ${CHART_PATH}/cray-tftp
		helm package ${CHART_PATH}/cray-tftp -d ${CHART_PATH}/.packaged --app-version ${VERSION} --version ${CHART_VERSION}

chart_tftp_test:
		helm lint "${CHART_PATH}/cray-tftp"
		docker run --rm -v ${PWD}/${CHART_PATH}:/apps ${HELM_UNITTEST_IMAGE} -3 cray-tftp

chart_tftp_pvc_package:
		helm dep up ${CHART_PATH}/cray-tftp-pvc
		helm package ${CHART_PATH}/cray-tftp-pvc -d ${CHART_PATH}/.packaged --app-version ${VERSION} --version ${CHART_VERSION}

chart_tftp_pvc_test:
		helm lint "${CHART_PATH}/cray-tftp-pvc"
		docker run --rm -v ${PWD}/${CHART_PATH}:/apps ${HELM_UNITTEST_IMAGE} -3 cray-tftp-pvc
chart_tftpd_ipxe_package:
		helm dep up ${CHART_PATH}/cray-tftpd-ipxe
		helm package ${CHART_PATH}/cray-tftpd-ipxe -d ${CHART_PATH}/.packaged --app-version ${VERSION} --version ${CHART_VERSION}

chart_tftpd_ipxe_test:
		helm lint "${CHART_PATH}/cray-tftpd-ipxe"
		docker run --rm -v ${PWD}/${CHART_PATH}:/apps ${HELM_UNITTEST_IMAGE} -3 cray-tftpd-ipxe
