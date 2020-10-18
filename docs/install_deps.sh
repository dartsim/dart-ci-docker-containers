#!/usr/bin/env bash
set -ex

apt-get update

# Build tools
apt-get install -y --no-install-recommends \
  build-essential \
  clang \
  cmake \
  curl \
  doxygen \
  git \
  lcov \
  lsb-release \
  pkg-config \
  software-properties-common

# DART required dependencies
apt-get install -y --no-install-recommends \
  libassimp-dev \
  libboost-filesystem-dev \
  libboost-system-dev \
  libccd-dev \
  libeigen3-dev \
  libfcl-dev

# DART required dependencies for building API documentation of DART < 6.10
apt-get install -y --no-install-recommends \
  libboost-regex-dev

# DART optional dependencies
apt-get install -y --no-install-recommends \
  freeglut3-dev \
  libxi-dev \
  libxmu-dev \
  libbullet-dev \
  liblz4-dev \
  libflann-dev \
  coinor-libipopt-dev \
  libtinyxml2-dev \
  liburdfdom-dev \
  liburdfdom-headers-dev \
  libopenscenegraph-dev
if [ $(lsb_release -sc) = "xenial" ] || [ $(lsb_release -sc) = "bionic" ]; then
  apt-get install -y --no-install-recommends \
    libnlopt-dev \
    liboctomap-dev \
    libode-dev \
    clang-format-6.0
elif [ $(lsb_release -sc) = "focal" ]; then
  apt-get install -y --no-install-recommends \
    libnlopt-cxx-dev \
    liboctomap-dev \
    libode-dev \
    clang-format-6.0
elif [ $(lsb_release -sc) = "groovy" ]; then
  apt-get install -y --no-install-recommends \
    libnlopt-cxx-dev \
    liboctomap-dev \
    libode-dev
else
  echo -e "$(lsb_release -sc) is not supported."
  exit 1
fi

# pagmo2
apt-get install -y --no-install-recommends \
  libboost-serialization-dev \
  libtbb-dev
git clone https://github.com/esa/pagmo2.git -b 'v2.15.0' --single-branch --depth 1 &&
  cd pagmo2 && mkdir build && cd build &&
  cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DPAGMO_WITH_EIGEN3=ON &&
  # NLopt and IPopt supports are disabled until https://github.com/esa/pagmo2/issues/445 is resolved
  # -DPAGMO_WITH_NLOPT=ON \
  # -DPAGMO_WITH_IPOPT=ON \
  make -j$(nproc) &&
  make install

# dartpy dependencies
apt-get install -y --no-install-recommends \
  python3-dev \
  python3-numpy \
  python3-pip \
  python3-setuptools

if [ $(lsb_release -sc) = "xenial" ] || [ $(lsb_release -sc) = "bionic" ]; then
  git clone https://github.com/pybind/pybind11 -b 'v2.3.0' --single-branch --depth 1 &&
    cd pybind11 && mkdir build && cd build &&
    cmake .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DPYBIND11_TEST=OFF &&
    make -j$(nproc) &&
    make install
elif [ $(lsb_release -sc) = "focal" ] || [ $(lsb_release -sc) = "groovy" ]; then
  apt-get install -y --no-install-recommends \
    pybind11-dev \
    python3 \
    libpython3-dev \
    python3-distutils
else
  echo -e "$(lsb_release -sc) is not supported."
  exit 1
fi

pip3 install pytest -U

rm -rf /var/lib/apt/lists/*
