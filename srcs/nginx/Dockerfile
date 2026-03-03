FROM alpine:3.19

RUN apk update && apk add nginx openssl

RUN mkdir -p /run/nginx

COPY tools/nginx.conf /etc/nginx/http.d/default.conf
COPY tools/init.sh /init.sh

RUN chmod +x /init.sh

EXPOSE 443

ENTRYPOINT ["/init.sh"]
