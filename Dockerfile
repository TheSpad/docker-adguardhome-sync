FROM golang:alpine

ENV HOME=/config

RUN go get -u github.com/bakito/adguardhome-sync

EXPOSE 8080

VOLUME /config

CMD ["/go/bin/adguardhome-sync","run"]