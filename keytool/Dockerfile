ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache openssl

COPY run.sh /
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
