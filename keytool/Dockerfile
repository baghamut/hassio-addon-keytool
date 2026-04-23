ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache \
    openssl \
    openjdk17-jre-headless \
    bash \
    docker-cli \
    inotify-tools

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
