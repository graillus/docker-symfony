FROM nginx:latest

COPY site.conf /etc/nginx/conf.d/default.conf

COPY index.html /var/www/web/index.html

RUN usermod -u 1000 www-data
