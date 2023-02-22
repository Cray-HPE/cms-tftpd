# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
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

## [1.8.2] - 2023-02-22
### Changed
- Added root security context for cray-tftp container



