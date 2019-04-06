FROM alpine

LABEL "com.github.actions.name"="Keyword Releaser"
LABEL "com.github.actions.description"="Creates a release if the keyword is found in commit messages."
LABEL "com.github.actions.icon"="gift"
LABEL "com.github.actions.color"="purple"

RUN apk add --no-cache \
        bash \
        httpie \
        jq && \
        which bash && \
        which http && \
        which jq

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY sample_push_event.json /sample_push_event.json

ENTRYPOINT ["entrypoint.sh"]
