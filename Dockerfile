FROM alpine:3.5

MAINTAINER David Coelho <davidrcoelho@gmail.com>

ENV SRC_DIR=/tmp
ENV CV2_VER=2.4.13.3

RUN apk update \
&& apk add \
  cmake \
  unzip \
  make \
  build-base \
  linux-headers \
  openssl \
  && mkdir -p ${SRC_DIR} \
  && cd ${SRC_DIR} \
  && wget https://github.com/opencv/opencv/archive/${CV2_VER}.zip \
  && unzip ${CV2_VER}.zip \
  && mv opencv-${CV2_VER} opencv \
  && rm ${CV2_VER}.zip \
  && cd opencv \
  && mkdir build \
  && cd build \
  && cmake \
      -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_PYTHON_EXAMPLES=ON .. \
  && make -j4 VERBOSE=1 \
  && make install \
  && rm -rf ${SRC_DIR} \
  && rm -rf /var/cache/apk/*
