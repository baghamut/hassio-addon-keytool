ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest
FROM ${BUILD_FROM}

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/init"]
# Fix single CMD
