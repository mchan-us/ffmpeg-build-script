FROM ubuntu:20.04 AS build

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get -y --no-install-recommends install build-essential curl ca-certificates pkg-config libva-dev libvdpau-dev libxext-dev python python3 \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && update-ca-certificates

WORKDIR /app
COPY ./build-ffmpeg /app/build-ffmpeg

RUN SKIPINSTALL=yes /app/build-ffmpeg --build

CMD         ["-c","exit"]
ENTRYPOINT  ["/bin/bash"]