FROM alpine:3.13

RUN apk update && apk upgrade && apk add inotify-tools bash && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

ADD entrypoint.sh /

CMD ["/entrypoint.sh"]
