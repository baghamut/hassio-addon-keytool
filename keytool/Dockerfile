ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache \
    openssl \
    openjdk17-jre-headless \
    bash \
    docker \
    inotify-tools

COPY rootfs/ /
