FROM ghcr.io/linuxserver/baseimage-alpine:3.13

LABEL maintainer="Adam Beardwood"

ENV \
  HOME=/app \
  GO111MODULE=on

RUN \
  mkdir -p /app && \
  apk --update --no-cache add go git && \
  go version && \
  echo "*** Installing AdGuardHome Sync ***" && \
  go get -u github.com/bakito/adguardhome-sync && \
  apk del --no-network git
COPY /root /

EXPOSE 8080

VOLUME /config

ENV \
  HOME=/config