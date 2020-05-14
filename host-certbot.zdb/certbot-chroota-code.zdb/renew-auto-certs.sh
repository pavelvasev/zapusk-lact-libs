#!/bin/bash -e

# обновляет сертификаты, и ежели обновилось - деплоит их в haproxy

certbot renew --deploy-hook $(dirname "$0")/deploy-auto-certs.sh