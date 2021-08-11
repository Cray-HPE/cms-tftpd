# Trivial File Transfer Protocol Service

The Trivial File Transfer Protocol (TFTP) service transfers files.  Typically,
it is used to transfer an iPXE binary to a node that is booting.  

## Build and run the Docker image
```bash
>> cd $REPO
>> docker build -t cray_tftpd .
>> docker run -d -v $(pwd):/var/lib/tftpboot --name cray_tftpd cray_tftpd
```
To snoop around in the running container:
```bash
>> docker exec -it cray_tftpd /bin/sh
/app # ls -l
total 4
-rwxr--r--    1 root     root            99 May 11 09:52 entrypoint.sh
/app # ps -a
PID   USER     TIME   COMMAND
    1 root       0:00 sh /app/entrypoint.sh -v /home/crayadm/jasons/cms-tftpd:/var/lib/tftpboot
    7 root       0:00 /usr/sbin/in.tftpd --foreground --verbose --user root --secure /var/lib/tftpboot
   10 root       0:00 /bin/sh
   22 root       0:00 ps -a
```
TFTP is a UDP protocol.  To access the tftp server, the tftp client must use
the IP address of the container providing the service.

Obtain the address.
```bash
>> docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cray_tftpd
172.17.0.3
```
Open a TFTP client and transfer a file from the directory where you started up 
the TFTP service.  This example arbitrarily uses the Dockerfile.
```bash
>> cd /tmp
>> atftp
tftp> connect 172.17.0.3 69
tftp> get Dockerfile foobar
tftp> quit
>> cat foobar
```

## Testing

See cms-tools repo for details on running CT tests for this service.

## Dependency: cray-bss-ipxe
cms-tftpd uses the cray-bss-ipxe image built by the cms-ipxe repo. 
We specify which major and minor version of the image we want with the 
[update_external_versions.conf](update_external_versions.conf) file.
At build time the [runBuildPrep.sh](runBuildPrep.sh) script finds the
latest version with that major and minor number.

When creating a new release branch, be sure to update this file to specify the
desired major and minor number of the image for the new release.

## Build Helpers
This repo uses some build helper scripts from the 
[cms-meta-tools](https://github.com/Cray-HPE/cms-meta-tools) repo. See that repo for more details.

## Local Builds
If you wish to perform a local build, you will first need to clone or copy the contents of the
cms-meta-tools repo to `./cms_meta_tools` in the same directory as the `Makefile`.

## Versioning
Use [SemVer](http://semver.org/). The version is located in the [.version](.version) file. Other files either
read the version string from this file or have this version string written to them at build time 
based on the information in the [update_versions.conf](update_versions.conf) file (using the 
update_versions.sh script in the cms-meta-tools repo).

## Copyright and License
This project is copyrighted by Hewlett Packard Enterprise Development LP and is under the MIT
license. See the [LICENSE](LICENSE) file for details.

When making any modifications to a file that has a Cray/HPE copyright header, that header
must be updated to include the current year.

When creating any new files in this repo, if they contain source code, they must have
the HPE copyright and license text in their header, unless the file is covered under
someone else's copyright/license (in which case that should be in the header). For this
purpose, source code files include Dockerfiles, Ansible files, RPM spec files, and shell
scripts. It does **not** include Jenkinsfiles, OpenAPI/Swagger specs, or READMEs.

When in doubt, provided the file is not covered under someone else's copyright or license, then
it does not hurt to add ours to the header.
