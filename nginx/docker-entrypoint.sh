#!/bin/bash
set -e

# WordPress の設定が完了しているか確認
if [ ! -f /etc/nginx/ssl/localhost.crt ]; then
  
  echo "SSL 証明書が見つかりません。自己署名証明書を作成します。"

  cd /etc/nginx/ssl
  # 秘密鍵の作成
  openssl genrsa -out localhost.key 2048

  # 証明書署名要求 (CSR) の作成
  openssl req -new -key localhost.key -out localhost.csr \
      -subj "/C=JP/ST=Tokyo/L=Chiyoda/O=LocalDev/CN=localhost"

  # 自己署名証明書の作成 (有効期限 365 日)
  openssl x509 -req -days 365 -in localhost.csr -signkey localhost.key -out localhost.crt
fi

exec nginx -g 'daemon off;'
