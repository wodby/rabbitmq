# check=skip=InvalidDefaultArgInFrom

# The Makefile supplies the required digest-pinned BASE_IMAGE argument.
ARG RABBITMQ_VER=4.3.2

ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG TARGETPLATFORM
ARG RABBITMQ_VER

ENV RABBITMQ_VER="${RABBITMQ_VER}"

# Upgrade inherited packages even when their existing versions satisfy dependencies.
RUN set -ex; \
    apk upgrade --no-cache; \
    apk add --update --no-cache -t .wodby-rabbitmq-run-deps \
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
