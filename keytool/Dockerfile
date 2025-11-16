FROM alpine:latest

# Install bash, openssl, jq, inotify-tools
RUN apk add --no-cache bash openssl jq inotify-tools

# Copy run.sh
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Set ENTRYPOINT to run.sh (persistent app)
ENTRYPOINT ["/run.sh"]
