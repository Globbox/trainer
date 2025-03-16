#!/bin/bash

sleep $(awk 'BEGIN { srand(); print rand() * 3600 }')
certbot renew --webroot --webroot-path /var/lib/certbot/ --post-hook "/usr/sbin/nginx -s reload"