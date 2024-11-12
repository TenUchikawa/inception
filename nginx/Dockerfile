FROM debian:bullseye

RUN apt update && apt install -y nginx

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
