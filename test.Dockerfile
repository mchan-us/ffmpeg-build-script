FROM ubuntu:20.04 AS build

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get -y --no-install-recommends install build-essential curl ca-certificates libva-dev libvdpau-dev libxext-dev python python3 \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && update-ca-certificates

WORKDIR /app
COPY ./test-build /app/test-build

RUN SKIPINSTALL=yes /app/test-build --build

CMD         ["-c","exit"]
ENTRYPOINT  ["/bin/bash"]