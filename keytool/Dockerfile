ARG BUILD_FROM
FROM $BUILD_FROM

# Install deps
RUN apk add --no-cache openssl keytool-openjdk8 bash docker-cli inotify-tools

# Copy rootfs
COPY rootfs/ /

WORKDIR /root
CMD ["/init"]
