FROM alpine

LABEL "com.github.actions.name"="Keyword Releaser"
LABEL "com.github.actions.description"="Creates a release if the keyword is found in commit messages."
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="green"

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
