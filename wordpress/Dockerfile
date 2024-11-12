# ベースイメージとして Debian Bullseye を使用
FROM debian:bullseye

# パッケージリストを更新
RUN apt-get update

# 必要なパッケージをインストール
RUN apt install -y mariadb-client php-fpm php-mysql curl wget unzip

# WordPress 用のディレクトリを作成
RUN mkdir -p /var/www/html

# WP-CLI（WordPress コマンドラインツール）をダウンロード
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# ダウンロードしたファイルを実行可能にし、システム全体で使えるように配置
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# /var/www/html の所有者を www-data ユーザーに変更
RUN chown -R www-data:www-data /var/www/html

# PHP-FPM のログディレクトリを作成し、適切な権限を設定
#(無いと初期起動時にエラーが出る)
RUN mkdir /var/log/php-fpm/ && \
    chown -R www-data:www-data /var/log/php-fpm/

# 必要ファイルを生成する為PHP-FPM サービスを一度起動して停止
RUN service php7.4-fpm start && service php7.4-fpm stop

# カスタム PHP-FPM 設定ファイルをコピー
COPY php-fpm/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# カスタムエントリーポイントスクリプトをコピー
COPY docker-entrypoint.sh /docker-entrypoint-initdb.d/docker-entrypoint.sh

# エントリーポイントスクリプトを実行（コンテナ起動時に実行される）
ENTRYPOINT ["/docker-entrypoint-initdb.d/docker-entrypoint.sh"]