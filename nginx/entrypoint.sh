#!/bin/sh

certbot certonly -n -d english-portal.ru,www.english-portal.ru \
  --standalone --preferred-challenges http --email rudeboyzzz666@gmail.com --agree-tos --expand

crond -f -d 8 &
nginx -g "daemon off;"