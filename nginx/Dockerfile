FROM node:lts-alpine as builder

WORKDIR /app
COPY $FRONTEND_PATH/package*.json ./
RUN npm install
COPY $FRONTEND_PATH/ .
RUN npm run build

FROM nginx:stable-alpine

COPY --from=builder /app/dist /www

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]
