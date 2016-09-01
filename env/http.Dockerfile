FROM nginx:mainline-alpine

COPY env/http/nginx/nginx.conf /etc/nginx/nginx.conf
COPY env/http/nginx/conf.d /etc/nginx/conf.d
COPY webapp/public/ /var/www/html/public/
