# Start from golang v1.11 base image
FROM golang:1.12

# Add Maintainer Info
LABEL maintainer="João Oliveirinha <joao@oliveirinha.me>"

# Install flarectl
RUN go get -u github.com/cloudflare/cloudflare-go/...  

COPY docker-entrypoint.sh .
ENTRYPOINT ["./docker-entrypoint.sh"]


