ARG IMAGE_NAME=ubuntu
ARG UBUNTU_VERSION
FROM ${IMAGE_NAME}:${UBUNTU_VERSION}

ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
ARG BASE_DIR
ADD ${BASE_DIR}/install_deps.sh /opt/env/install_deps.sh
RUN . /opt/env/install_deps.sh
