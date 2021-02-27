FROM alpine as builder

RUN apk add --no-cache unzip

RUN wget https://github.com/keeweb/keeweb/releases/download/v1.16.7/KeeWeb-1.16.7.html.zip

RUN unzip KeeWeb-1.16.7.html.zip -d /html

COPY config.json /html/

RUN sed -i'' 's#(no-config)#/config.json#g' /html/index.html && \
  grep -q '/config.json' /html/index.html

FROM nginx:alpine

COPY --from=builder /html /usr/share/nginx/html
