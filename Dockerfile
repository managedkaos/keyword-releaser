FROM alpine

RUN apk add --no-cache \
        bash \
        curl \
        git \
        jq

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
ADD sample_push_event.json /sample_push_event.json

ENTRYPOINT ["entrypoint.sh"]
