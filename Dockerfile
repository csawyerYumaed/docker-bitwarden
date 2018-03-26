FROM ruby:2.4-alpine3.7

RUN apk add --update-cache \
    nginx \
    openssl \
    sqlite-dev \
    runit
RUN adduser -s -u 500 nginx
RUN adduser -s -u 501 bitwarden

ADD vault /bitwarden/vault
ADD bitwarden /bitwarden/api
ADD service /etc/runit/service

RUN chmod a+rx /etc/runit/service/*/run

VOLUME /bitwarden/api/db

ENTRYPOINT ["/sbin/runsvdir"]

CMD ["/etc/runit/service"]
