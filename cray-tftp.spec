# Copyright 2019 Cray Inc. All Rights Reserved.

Name: cray-tftpd-crayctldeploy
License: Cray Software License Agreement
Summary: Cray deployment CT tests for TFTPD
Group: System/Management
Version: %(cat .rpm_version)
Release: %(echo ${BUILD_METADATA})
Source: %{name}-%{version}.tar.bz2
Vendor: Cray Inc.
Requires: cray-crayctl
Requires: cray-cmstools-crayctldeploy
Requires: kubernetes-crayctldeploy
Requires: sms-crayctldeploy
Requires: python2-oauthlib
Requires: python3-oauthlib

%description
This is a collection of CT tests for TFTPD

%prep
%setup -q

%build

%install
# Install smoke tests under /opt/cray/tests/crayctl-stage4
mkdir -p ${RPM_BUILD_ROOT}/opt/cray/tests/crayctl-stage4/cms/
cp ct-tests/tftpd_stage4_ct_tests.sh ${RPM_BUILD_ROOT}/opt/cray/tests/crayctl-stage4/cms/tftpd_stage4_ct_tests.sh

%clean

%files
%defattr(755, root, root)

/opt/cray/tests/crayctl-stage4/cms/tftpd_stage4_ct_tests.sh

%changelog
