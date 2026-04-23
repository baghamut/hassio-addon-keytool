ARG BUILD_FROM
FROM $BUILD_FROM

# Update packages first to avoid conflicts
RUN apk update && apk upgrade --no-cache

RUN apk add --no-cache \
    openssl \
    openjdk17-jre-headless \
    bash \
    docker-cli \
    inotify-tools

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
