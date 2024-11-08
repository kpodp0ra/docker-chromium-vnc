FROM alpine:3.19

RUN apk upgrade --no-cache --available \
 && apk add --no-cache chromium-swiftshader font-noto-all font-liberation font-noto-emoji tigervnc supervisor i3wm \
 && apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community font-wqy-zenhei \
 && adduser -D chrome --uid 1000

COPY ./i3wm.conf /etc/i3/config
COPY ./policies.json /etc/chromium/policies/managed/custom-chrome.json
COPY ./supervisord.ini /etc/supervisord.conf

USER chrome
ENV DISPLAY=:0 TERMINAL=/bin/false
WORKDIR /home/chrome
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
