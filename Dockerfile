FROM nginx

RUN set -eu; \
    mkdir -p \
      /etc/nginx/conf.d/default/ \
      /etc/nginx/vhost.d/ \
      /etc/nginx/certs/ \
      /etc/nginx/dhparam/; \
    touch /etc/nginx/conf.d/default/server_name.conf; \
    touch /etc/nginx/vhost.d/server.conf; \
    touch /etc/nginx/vhost.d/location.conf

COPY *.template configs.conf /etc/nginx/templates/
COPY configs.conf /etc/nginx/conf.d/default/
COPY 99-prepare.sh /docker-entrypoint.d/
COPY dhparam.pem /etc/nginx/dhparam/dhparam.pem

CMD ["nginx", "-g", "daemon off;"]
