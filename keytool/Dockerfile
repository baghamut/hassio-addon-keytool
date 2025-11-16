FROM ghcr.io/home-assistant/amd64-base:latest
RUN mkdir -p /ssl
COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]
