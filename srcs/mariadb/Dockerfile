FROM debian:bullseye

RUN apt update && apt install -y mariadb-server mariadb-client

COPY my.cnf /etc/mysql/my.cnf
COPY docker-entrypoint.sh /docker-entrypoint-initdb.d/docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint-initdb.d/docker-entrypoint.sh"]

