#!/bin/bash

if [ -z $VERSION ]; then
    echo "VERSION is not set"
    exit 1
fi

function extract_arm() {
    tar -xvf /tmp/Geekbench-${VERSION}-LinuxARMPreview.tar.gz -C /tmp
    rm -rf /tmp/Geekbench-${VERSION}-LinuxARMPreview.tar.gz
    mv /tmp/Geekbench-${VERSION}-LinuxARMPreview /opt/geekbench
    rm /opt/geekbench/geekbench${MAJOR_VERSION}
}

function extract_x86() {
    tar -xvf /tmp/Geekbench-${VERSION}-Linux.tar.gz -C /tmp
    rm -rf /tmp/Geekbench-${VERSION}-Linux.tar.gz
    mv /tmp/Geekbench-${VERSION}-Linux /opt/geekbench
    rm /opt/geekbench/geekbench${MAJOR_VERSION}
}

MAJOR_VERSION=${VERSION%.*.*}
if [ $(uname -m) == "armv7l" ]; then
    extract_arm
    EXECUTABLE=geekbench_armv7
elif [ $(uname -m) == "aarch64" ]; then
    extract_arm
    EXECUTABLE=geekbench_aarch64
elif [ $(uname -m) == "x86_64" ]; then
    extract_x86
    EXECUTABLE=geekbench_x86_64
else
    echo "Unsupported architecture"
    exit 1
fi

echo "#!/bin/bash
/opt/geekbench/${EXECUTABLE} \$*" >/opt/geekbench/geekbench
chmod +x /opt/geekbench/geekbench
