# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.10.2] - 2024-09-05

### Dependencies
- Move to `cray-bss-ipxe` 1.14.x for CSM 1.6

## [1.10.1] - 2024-09-05

### Dependencies
- Bump `tj-actions/changed-files` from 44 to 45 ([#65](https://github.com/Cray-HPE/cms-tftpd/pull/65))
- Bump `cray-services` base chart version to 11.0

## [1.10.0] - 2024-04-29
### Changed
- Update cray-tftp-ipxe chart to work with CSM 1.6 manifests

### Dependencies
- Bump `tj-actions/changed-files` from 42 to 44 ([#60](https://github.com/Cray-HPE/cms-tftpd/pull/60), [#61](https://github.com/Cray-HPE/cms-tftpd/pull/61))

## [1.9.0] - 2024-02-23
### Changed
- Disabled concurrent Jenkins builds on same branch/commit
- Added build timeout to avoid hung builds

### Dependencies
- Bump `tj-actions/changed-files` from 37 to 42 ([#50](https://github.com/Cray-HPE/cms-tftpd/pull/50), [#52](https://github.com/Cray-HPE/cms-tftpd/pull/52), [#54](https://github.com/Cray-HPE/cms-tftpd/pull/54), [#55](https://github.com/Cray-HPE/cms-tftpd/pull/55), [#57](https://github.com/Cray-HPE/cms-tftpd/pull/57))
- Bump `actions/checkout` from 3 to 4 ([#51](https://github.com/Cray-HPE/cms-tftpd/pull/51))
- Bump `stefanzweifel/git-auto-commit-action` from 4 to 5 ([#53](https://github.com/Cray-HPE/cms-tftpd/pull/53))

## [1.8.4] - 2023-03-14
### Changed
- Use cray-bss-ipxe version 1.11 (CASMCMS-8460)

### Removed
- Removed file remnants of previous dynamic versioning system (CASMCMS-8460)

## [1.8.3] - 2023-03-14
### Changed
- Do not run cray-tftp-modprobe pods on master NCNs (CASMCMS-8450)

## [1.8.2] - 2023-01-26
### Changed
- Upgraded kmod pkg within the built image to handle kernels requiring compressed kmods
- Add root override to cray-tftp-ipxe helm chart
- Enabled building of unstable artifacts
- Updated header of update_versions.conf to reflect new tool options

### Fixed
- Spelling corrections.
- Update Charts with correct image and chart version strings during builds.

## [1.8.1] - 2022-12-20
### Added
- Add Artifactory authentication to Jenkinsfile

## [1.8.0] - 2022-08-10
### Changed
- Convert to gitflow/gitversion.
