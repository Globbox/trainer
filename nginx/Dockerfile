FROM node:lts-alpine AS builder

WORKDIR /app
COPY ./frontend/package*.json ./
RUN npm install
COPY ./frontend ./
RUN npm run build

FROM nginx:stable-alpine

RUN apk add --no-cache certbot
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app/dist /www

COPY nginx/entrypoint.sh /entrypoint.sh
COPY nginx/renew.sh /etc/periodic/daily/renew.sh

RUN chmod +x /entrypoint.sh /etc/periodic/daily/renew.sh
RUN mkdir -p /var/lib/certbot

ENTRYPOINT ["/entrypoint.sh"]