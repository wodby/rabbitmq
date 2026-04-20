#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

cid="$(docker run -d -e DEBUG --name "${NAME}" "${IMAGE}")"
trap "docker rm -vf $cid > /dev/null" EXIT

rabbitmq() {
    docker run --rm -i -e DEBUG --link "${NAME}" "${IMAGE}" "${@}"
}

rabbitmq make check-ready max_try=90 host="${NAME}"

echo -n "Checking RabbitMQ version... "
docker exec "${NAME}" rabbitmq-diagnostics server_version | grep -q "${RABBITMQ_VER}"
echo "OK"

echo -n "Checking rendered config... "
docker exec "${NAME}" cat /etc/rabbitmq/conf.d/90-wodby.conf | grep -q 'listeners.tcp.default = 5672'
echo "OK"

echo -n "Checking enabled plugins... "
docker exec "${NAME}" cat /etc/rabbitmq/enabled_plugins | grep -q 'rabbitmq_prometheus'
echo "OK"

echo -n "Checking default credentials... "
docker exec "${NAME}" rabbitmqctl authenticate_user wodby wodby | grep -q 'Success'
echo "OK"
