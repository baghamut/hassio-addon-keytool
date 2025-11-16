ARG BUILD_FROM
FROM $BUILD_FROM

# Install openssl for pkcs12 export
RUN apk add --no-cache openssl

# Copy cont-init script
COPY rootfs/ /
