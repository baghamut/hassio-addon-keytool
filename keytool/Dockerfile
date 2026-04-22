# HA Add-on base (universal arch)
FROM ghcr.io/hassio-addons/base:15.3.0

# Install deps (docker-cli for exec/cp)
RUN apk add --no-cache \
    openssl \
    openjdk17-jre-headless=17.0.12_p11-r0 \
    bash \
    docker-cli \
    inotify-tools

# Copy scripts
COPY rootfs/ /

# Expose (optional)
EXPOSE 8080

WORKDIR /
CMD ["/init"]
