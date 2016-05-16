FROM nginx:1.10-alpine

COPY env/nginx/nginx.conf /etc/nginx/nginx.conf
COPY env/nginx/conf.d /etc/nginx/conf.d
COPY webapp/public/ /var/www/html/public/