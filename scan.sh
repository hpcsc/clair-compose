#!/bin/sh

IMAGE_TO_SCAN=$1

if [ -z ${IMAGE_TO_SCAN} ]; then
  echo "=== image is required"
  echo "Usage: $0 image-to-scan:tag"
  exit 1
fi

CLAIR_SCANNER_VERSION=v12

if [ ! -f ./clair-scanner ]; then
  OS_TYPE=$(uname -s | tr '[:upper:]' '[:lower:]')
  echo "=== Downloading clair-scanner for ${OS_TYPE}"
  curl -L https://github.com/arminc/clair-scanner/releases/download/${CLAIR_SCANNER_VERSION}/clair-scanner_${OS_TYPE}_amd64 -o clair-scanner && \
    chmod +x ./clair-scanner
fi;

./wait-for localhost:6060 -- ./clair-scanner --ip 192.168.0.11 -c http://localhost:6060 ${IMAGE_TO_SCAN}
