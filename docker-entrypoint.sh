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

# The upstream entrypoint rejects RABBITMQ_VM_MEMORY_HIGH_WATERMARK as deprecated.
# Preserve backwards compatibility in this wrapper by mapping it to a template-only name
# before chaining to the official entrypoint.
if [[ -n "${RABBITMQ_VM_MEMORY_HIGH_WATERMARK:-}" ]] && [[ -z "${RABBITMQ_VM_MEMORY_HIGH_WATERMARK_RELATIVE:-}" ]]; then
    export RABBITMQ_VM_MEMORY_HIGH_WATERMARK_RELATIVE="${RABBITMQ_VM_MEMORY_HIGH_WATERMARK}"
fi
unset RABBITMQ_VM_MEMORY_HIGH_WATERMARK

mkdir -p /etc/rabbitmq/conf.d
gotpl /etc/gotpl/rabbitmq.conf.tmpl > /etc/rabbitmq/conf.d/90-wodby.conf
gotpl /etc/gotpl/enabled_plugins.tmpl > /etc/rabbitmq/enabled_plugins

if [[ "${1}" == "make" ]]; then
    exec "${@}" -f /usr/local/bin/actions.mk
else
    exec /usr/local/bin/docker-entrypoint.sh "${@}"
fi
