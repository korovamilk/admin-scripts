#!/bin/bash
## "deb_convert_i386_to_amd64.sh"
## Simple DEB packages arch conversion
## (changes $arch in control.tar.gz from i386 to amd64)
# author: marco . agate @ gmail . com
# v.20130612
FULL_PACKAGE_NAME_VERSION="$1"
echo "\n * deb_convert_i386_to_amd64.sh\n"
echo " Usage: $0 PACKAGENAME_VERSION  (without \$arch and '.deb', please)"
echo " Eg. for python-setproctitle_1.1.6-1_i386.deb you would launch:"
echo " $0 python-setproctitle_1.1.6-1\n"

if [ -e ${FULL_PACKAGE_NAME_VERSION}_i386.deb ]; then
    # deb exists, I can do my job..
    mkdir ${FULL_PACKAGE_NAME_VERSION}
    cp ${FULL_PACKAGE_NAME_VERSION}_i386.deb ${FULL_PACKAGE_NAME_VERSION}/
    cd ${FULL_PACKAGE_NAME_VERSION}/
    mkdir -p tempo/DEBIAN
    ar x ${FULL_PACKAGE_NAME_VERSION}_i386.deb
    tar zxvf data.tar.gz -C tempo/
    tar zxvf control.tar.gz -C tempo/DEBIAN/
    cp debian-binary tempo/DEBIAN/
    sed -i -e 's/Architecture: i386/Architecture: amd64/' tempo/DEBIAN/control
    dpkg-deb -b tempo/ ../${FULL_PACKAGE_NAME_VERSION}_amd64.deb
    cd ../
    rm -rf ${FULL_PACKAGE_NAME_VERSION}/
    chmod 0744 ${FULL_PACKAGE_NAME_VERSION}_amd64.deb
    exit 0
else    echo "The expected package [ ${FULL_PACKAGE_NAME_VERSION}_i386.deb ] is NOT FOUND."
    echo "Nothing to do.\n"
    exit 1
fi
