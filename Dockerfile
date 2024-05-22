FROM alpine:latest

RUN apk --no-cache add bash git wget nginx

RUN wget https://github.com/adnanh/webhook/releases/download/2.8.0/webhook-linux-amd64.tar.gz \
    && tar -xvzf webhook-linux-amd64.tar.gz \
    && mv webhook-linux-amd64/webhook /usr/local/bin/webhook \
    && rm -rf webhook-linux-amd64.tar.gz webhook-linux-amd64

RUN mkdir -p /webhooks /app /usr/share/nginx/html 

COPY update.sh /app/update.sh
COPY index.html /app/index.html
COPY hooks.json /webhooks/hooks.json


RUN chmod +x /app/update.sh


RUN cp /app/index.html /usr/share/nginx/html/


WORKDIR /app


CMD ["sh", "-c", "nginx && webhook -hooks /webhooks/hooks.json -port 8080 -verbose"]
