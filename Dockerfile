FROM ghcr.io/linuxserver/baseimage-alpine:3.13

LABEL maintainer="Adam Beardwood"

ENV \
  HOME=/app \
  GO111MODULE=on

RUN \
  mkdir -p /app && \
  apk --update --no-cache add go git && \
  echo "*** Installing AdGuardHome Sync ***" && \
  go get -u github.com/bakito/adguardhome-sync && \
  echo "*** Cleaning Up ***" && \
  apk del --no-network git && \
  go clean -cache -modcache
COPY /root /

EXPOSE 8080

VOLUME /config

ENV \
  HOME=/config