FROM alpine

RUN apk add --no-cache \
        bash \
        curl \
        httpie \
        jq && \
        which bash && \
        which curl && \
        which http && \
        which jq


ADD entrypoint.sh /usr/local/bin/entrypoint.sh
ADD sample_push_event.json /sample_push_event.json

ENTRYPOINT ["entrypoint.sh"]
