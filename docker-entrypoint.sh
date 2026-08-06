#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

# These are RabbitMQ application-level defaults for the initial broker user/vhost,
# not Unix accounts. The official base image already provides the `rabbitmq` OS user.
export RABBITMQ_DEFAULT_USER="${RABBITMQ_DEFAULT_USER:-wodby}"
export RABBITMQ_DEFAULT_PASS="${RABBITMQ_DEFAULT_PASS:-wodby}"
export RABBITMQ_DEFAULT_VHOST="${RABBITMQ_DEFAULT_VHOST:-/}"

# RabbitMQ owns the enabled_plugins file. Preserve the Wodby image default while
# allowing orchestrators to provide the complete plugin list through the native
# RabbitMQ environment variable.
export RABBITMQ_ENABLED_PLUGINS="${RABBITMQ_ENABLED_PLUGINS:-rabbitmq_prometheus}"

# The upstream entrypoint rejects RABBITMQ_VM_MEMORY_HIGH_WATERMARK as deprecated.
# Preserve backwards compatibility in this wrapper by mapping it to a template-only name
# before chaining to the official entrypoint.
if [[ -n "${RABBITMQ_VM_MEMORY_HIGH_WATERMARK:-}" ]] && [[ -z "${RABBITMQ_VM_MEMORY_HIGH_WATERMARK_RELATIVE:-}" ]]; then
    export RABBITMQ_VM_MEMORY_HIGH_WATERMARK_RELATIVE="${RABBITMQ_VM_MEMORY_HIGH_WATERMARK}"
fi
unset RABBITMQ_VM_MEMORY_HIGH_WATERMARK

mkdir -p /etc/rabbitmq/conf.d
gotpl /etc/gotpl/rabbitmq.conf.tmpl > /etc/rabbitmq/conf.d/90-wodby.conf

# Kubernetes charts can mount an emptyDir over the image's /etc/rabbitmq
# directory. Make the mount point writable before the official entrypoint drops
# privileges so RabbitMQ can materialize RABBITMQ_ENABLED_PLUGINS itself.
if [[ "$(id -u)" == "0" ]]; then
    chown rabbitmq:rabbitmq /etc/rabbitmq
fi

if [[ "${1}" == "make" ]]; then
    exec "${@}" -f /usr/local/bin/actions.mk
else
    exec /usr/local/bin/docker-entrypoint.sh "${@}"
fi
