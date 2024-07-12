FROM ubuntu:22.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata
RUN apt-get update && apt-get install -y less gzip wget nginx zip unzip git nano mysql-client
RUN apt-get update && apt-get install --no-install-recommends -y php8.1
RUN apt-get install -y php8.1-fpm php8.1-cli php8.1-common php8.1-mysql php8.1-mbstring php8.1-curl php8.1-xml

RUN mkdir -p /var/www/app
RUN chown -R www-data:www-data /var/www/app

COPY nginx.app.config /etc/nginx/sites-available/app
RUN rm /etc/nginx/sites-enabled/*
RUN ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled/app
RUN mkdir -p /var/www/.env

WORKDIR /var/www

COPY heartbeat.sh /var/www/heartbeat.sh
RUN chmod +x heartbeat.sh

CMD ./heartbeat.sh
