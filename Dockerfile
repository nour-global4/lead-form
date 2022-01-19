FROM global4/php7.3:latest

RUN apt-get update && apt-get install nano

COPY  ./.docker/vhosts/vhost.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/lead-form
