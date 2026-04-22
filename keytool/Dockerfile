# HA Add-on base (universal arch)
FROM ghcr.io/hassio-addons/base:16.2.1

RUN apk add --no-cache \
    openssl \
    openjdk17-jre-headless \
    bash \
    docker \
    inotify-tools

COPY rootfs/ /
EXPOSE 8080
CMD ["/init"]
