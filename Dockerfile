FROM ghcr.io/linuxserver/baseimage-alpine:3.13

LABEL maintainer="Adam Beardwood"

ENV \
  HOME=/app \
  GO111MODULE=on \
  GOOS=linux

RUN \
  mkdir -p /app && \
  apk --update --no-cache add go git upx && \
  echo "*** Installing AdGuardHome Sync ***" && \
  go get -u github.com/bakito/adguardhome-sync && \
  cd /app/go/bin && \
  upx -qqq adguardhome-sync && \
  cp adguardhome-sync /app && \
  echo "*** Cleaning Up ***" && \
  go clean -cache -modcache && \
  apk del git go upx && \
  rm -rf /app/go && \
  rm -rf /app/.cache
COPY /root /

EXPOSE 8080

VOLUME /config

ENV \
  HOME=/config