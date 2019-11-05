#!/bin/sh

IMAGE_TO_SCAN=$1

if [ -z ${IMAGE_TO_SCAN} ]; then
  echo "=== image is required"
  echo "Usage: $0 image-to-scan:tag"
  exit 1
fi


if [ ! -f ./scanner ]; then
  CLAIR_SCANNER_VERSION=v12
  OS_TYPE=$(uname -s | tr '[:upper:]' '[:lower:]')
  echo "=== Downloading clair-scanner for ${OS_TYPE}"
  curl -L https://github.com/arminc/clair-scanner/releases/download/${CLAIR_SCANNER_VERSION}/clair-scanner_${OS_TYPE}_amd64 -o scanner && \
    chmod +x ./scanner
fi;

HOST_IP=$(ifconfig en0 | grep -e 'inet\s' | awk '{print $2}')
./clair-scanner/wait-for localhost:6060 -- ./scanner --ip ${HOST_IP} -c http://localhost:6060 ${IMAGE_TO_SCAN}
