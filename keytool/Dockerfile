ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache openjdk17-jre

COPY run.sh /
RUN chmod +x /run.sh
