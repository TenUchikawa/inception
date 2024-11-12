FROM debian:bullseye

RUN apt update && apt install -y mariadb-server mariadb-client

COPY my.cnf /etc/mysql/my.cnf

EXPOSE 3306
VOLUME ["/var/lib/mysql"]

# MariaDB サービスの起動
CMD ["mysqld_safe"]