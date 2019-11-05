# docker compose for local clair scanner

This repository contains docker-compose setup for clair-local-scan from [https://github.com/arminc/clair-local-scan](https://github.com/arminc/clair-local-scan)

It also uses `wait-for` script from [https://github.com/Eficode/wait-for](https://github.com/Eficode/wait-for) to wait for dependency to startup

There are 2 ways to use this repository:

## Run everything inside containers

```
IMAGE_TO_SCAN=some-image docker-compose up --exit-code-from clair-scanner
```

This command will start up clair postgres database container, clair local server container and a containerized clair-scanner, run scanner against `some-image` and exit

Note:

- this setup mounts `/var/run/docker.sock` from your host machine to `clair-scanner` so that it has access to images from host machine. 
- `clair-scanner` uses a prebuilt image `hpcsc/clair-scanner`. This image is built from `./clair-scanner/Dockerfile` and pushed to docker hub to avoid rebuilding image each time

## Run clair-scanner from host machine

```
docker-compose up -d postgres clair
./scan.sh some-image
```

In this approach, docker-compose is only used to start up postgres database and clair local server containers. 
`scan.sh` script will download `clair-scanner` from github to current folder (and rename the executable to `scanner`) and run scanning agaist clair local server container
