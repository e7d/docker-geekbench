#!/bin/bash

DIR=$(realpath $(dirname "$0"))

function to_docker_tags_param() {
    local VERSION=$1
    local ADDITIONAL_TAG=$2
    local TAGS="--tag e7db/geekbench:${VERSION} --tag e7db/geekbench:${VERSION%.*} --tag e7db/geekbench:${VERSION%.*.*}"
    if [ ! -z "${ADDITIONAL_TAG}" ]; then
        TAGS="${TAGS} --tag e7db/geekbench:${ADDITIONAL_TAG}"
    fi
    echo ${TAGS}
}

function build_image() {
    local VERSION=$1
    local MAJOR_VERSION=${VERSION%.*.*}
    local FOLDER=geekbench${MAJOR_VERSION}
    local PLATFORMS=$2
    local ADDITIONAL_TAG=$3
    local TAGS=$(to_docker_tags_param ${VERSION} ${ADDITIONAL_TAG})
    mkdir -p ${DIR}/${FOLDER}/build ${DIR}/${FOLDER}/cache
    docker buildx create \
        --name e7db-geekbench${MAJOR_VERSION} \
        --platform ${PLATFORMS} \
        --use
    docker buildx build \
        --cache-from type=local,src=${DIR}/${FOLDER}/cache \
        --cache-to type=local,dest=${DIR}/${FOLDER}/cache \
        --file ${DIR}/Dockerfile \
        --metadata-file ${DIR}/${FOLDER}/build/metadata.json \
        --output type=registry \
        --platform ${PLATFORMS} \
        --build-arg FOLDER=${FOLDER} \
        --build-arg VERSION=${VERSION} \
        ${TAGS} \
        ${DIR}
    docker buildx rm e7db-geekbench${MAJOR_VERSION}
}

VERSIONS=($(echo "$(curl -s https://www.geekbench.com/preview/)" | grep -oE 'Geekbench-[0-9]+\.[0-9]+\.[0-9]+' | awk -F'-' '{print $2}' | sort -u))
SORTED_VERSIONS=($(printf "%s\n" "${VERSIONS[@]}" | tr ' ' '\n' | sort -t. -k1,1n -k2,2n -k3,3n))
for VERSION in "${SORTED_VERSIONS[@]}"; do
    MAJOR_VERSION=${VERSION%.*.*}
    if [ $MAJOR_VERSION -lt 6 ]; then
        PLATFORMS="linux/amd64,linux/arm64/v8,linux/arm/v7"
    else
        PLATFORMS="linux/amd64,linux/arm64/v8"
    fi
    unset ADDITIONAL_TAG
    if [ $VERSION == "${SORTED_VERSIONS[-1]}" ]; then
        ADDITIONAL_TAG="latest"
    fi
    build_image ${VERSION} ${PLATFORMS} ${ADDITIONAL_TAG}
done
