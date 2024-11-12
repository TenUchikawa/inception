FROM debian:bullseye

RUN apt-get update

RUN apt install -y php-fpm php-mysql curl wget unzip

RUN mkdir -p /var/www/html

RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    mv wordpress/* /var/www/html && \
    rm latest.zip

RUN chown -R www-data:www-data /var/www/html

RUN mkdir /run/php/ && chown -R www-data:www-data /run/php/


ENTRYPOINT ["php-fpm7.4", "-F"]

ENTRYPOINT ["sleep", "infinity"]