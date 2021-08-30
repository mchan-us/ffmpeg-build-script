FROM ubuntu:20.04 AS build

ENV DEBIAN_FRONTEND noninteractive
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility,video

RUN apt-get update \
    && apt-get -y --no-install-recommends install build-essential curl ca-certificates python python3 \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && update-ca-certificates

WORKDIR /app
COPY ./test-build /app/test-build

RUN AUTOINSTALL=yes /app/test-build --build --full-static

CMD         ["-c","exit"]
ENTRYPOINT  ["/bin/bash]