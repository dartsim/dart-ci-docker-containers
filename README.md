# dart-ci-docker-containers

![Publish Docker image](https://github.com/dartsim/dart-ci-docker-containers/workflows/Publish%20Docker%20image/badge.svg)

This repository contains the `Dockerfile`s for the Docker images to build DART. The docker images are hosted on [Docker Hub](https://hub.docker.com/repository/docker/jslee02/dart-dev).

To pull the images,

```shell
docker pull jslee02/dart-dev:<tagname>
```

The available tags can be found [here](https://hub.docker.com/repository/registry-1.docker.io/jslee02/dart-dev/tags).

To launch the containers,

```shell
docker run -i --tty jslee02/dart-dev:<tagname>
```

To build DART in the container,

```shell
# In a shell
docker run -i --tty \
  -v <path_to_dart_source>:<dart_source_in_container> \
  jslee02/dart-dev:<tagname>

# In the container
cd <dart_source_in_container>
mkdir build && cd build
cmake ..
make -j
```
