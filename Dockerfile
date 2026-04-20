ARG RABBITMQ_VER=4.2.5

FROM rabbitmq:${RABBITMQ_VER}-alpine

ARG TARGETPLATFORM
ARG RABBITMQ_VER

ENV RABBITMQ_VER="${RABBITMQ_VER}"

RUN apk add --update --no-cache -t .wodby-rabbitmq-run-deps \
        make; \
    \
    apk add --update --no-cache -t .wodby-rabbitmq-build-deps \
        ca-certificates \
        tar \
        wget; \
    \
    dockerplatform=${TARGETPLATFORM:-linux/amd64}; \
    gotpl_url="https://github.com/wodby/gotpl/releases/latest/download/gotpl-${dockerplatform/\//-}.tar.gz"; \
    wget -qO- "${gotpl_url}" | tar xz --no-same-owner -C /usr/local/bin; \
    \
    apk del .wodby-rabbitmq-build-deps; \
    rm -rf /var/cache/apk/*

COPY templates /etc/gotpl/
COPY docker-entrypoint.sh /
COPY bin /usr/local/bin/

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["rabbitmq-server"]
