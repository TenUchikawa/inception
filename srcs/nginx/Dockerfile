FROM debian:bullseye

RUN apt update
RUN apt install -y nginx openssl nginx curl


COPY docker-entrypoint.sh /docker-entrypoint-initdb.d/docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint-initdb.d/docker-entrypoint.sh"]
