FROM docker:19.03.4
LABEL image=hpcsc/clair-scanner
LABEL version=0.1.0

WORKDIR /app

ENV CLAIR_SCANNER_VERSION=v12

COPY wait-for .

ADD https://github.com/arminc/clair-scanner/releases/download/${CLAIR_SCANNER_VERSION}/clair-scanner_linux_amd64 /usr/local/bin/clair-scanner

RUN chmod +x /usr/local/bin/clair-scanner

