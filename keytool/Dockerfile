FROM alpine:latest

# Install bash and openssl
RUN apk add --no-cache bash openssl

# Copy run.sh
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Set ENTRYPOINT to run.sh (bypasses s6)
ENTRYPOINT ["/run.sh"]
