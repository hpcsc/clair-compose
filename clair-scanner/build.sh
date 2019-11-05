#!/bin/sh

set -e

SCRIPT_DIR=$(cd $(dirname $0); pwd)

IMAGE=$(cat ${SCRIPT_DIR}/Dockerfile | grep image= | sed 's/LABEL image=//g')
VERSION=$(cat ${SCRIPT_DIR}/Dockerfile | grep version= | sed 's/LABEL version=//g')

pushd ${SCRIPT_DIR} > /dev/null

docker build -t ${IMAGE}:${VERSION} .

popd > /dev/null
