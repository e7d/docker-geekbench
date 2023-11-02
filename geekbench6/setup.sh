#!/bin/bash

function extract_arm() {
    tar -xvf /tmp/Geekbench-${VERSION}-LinuxARMPreview.tar.gz -C /tmp
    rm -rf /tmp/Geekbench-${VERSION}-LinuxARMPreview.tar.gz
    mv /tmp/Geekbench-${VERSION}-LinuxARMPreview /tmp/geekbench
    rm /tmp/geekbench/geekbench6
}

function extract_x86() {
    tar -xvf /tmp/Geekbench-${VERSION}-Linux.tar.gz -C /tmp
    rm -rf /tmp/Geekbench-${VERSION}-Linux.tar.gz
    mv /tmp/Geekbench-${VERSION}-Linux /tmp/geekbench
    rm /tmp/geekbench/geekbench6
}

if [ $(uname -m) == "aarch64" ]; then
    extract_arm
    mv /tmp/geekbench/geekbench_aarch64 /tmp/geekbench/geekbench
elif [ $(uname -m) == "x86_64" ]; then
    extract_x86
    mv /tmp/geekbench/geekbench_x86_64 /tmp/geekbench/geekbench
else
    echo "Unsupported architecture $(uname -m)"
    exit 1
fi

mv /tmp/geekbench /opt/geekbench/
