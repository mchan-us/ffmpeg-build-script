ARG VER=20.04

FROM nvidia/cuda:11.1-devel-ubuntu${VER} AS build

ENV DEBIAN_FRONTEND noninteractive
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility,video

RUN apt-get update \
    && apt-get -y --no-install-recommends install build-essential curl ca-certificates libvdpau-dev libva-dev libxext-dev python python3 \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && update-ca-certificates

WORKDIR /app
COPY ./test-build /app/test-build

RUN SKIPINSTALL=yes /app/test-build --build

CMD         ["-c","exit"]
ENTRYPOINT  ["/bin/bash"]