# RabbitMQ Docker Container Image

[![Build Status](https://github.com/wodby/rabbitmq/workflows/Build%20docker%20image/badge.svg)](https://github.com/wodby/rabbitmq/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/rabbitmq.svg)](https://hub.docker.com/r/wodby/rabbitmq)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/rabbitmq.svg)](https://hub.docker.com/r/wodby/rabbitmq)

## Docker Images

❗For better reliability we release images with stability tags (
`wodby/rabbitmq:4.2-X.X.X`) which correspond to [git tags](https://github.com/wodby/rabbitmq/releases). We strongly recommend using images only with stability tags.

Overview:

- All images are based on Alpine Linux
- Base image: [rabbitmq](https://hub.docker.com/_/rabbitmq)
- [GitHub actions builds](https://github.com/wodby/rabbitmq/actions)
- [Docker Hub](https://hub.docker.com/r/wodby/rabbitmq)

[_(Dockerfile)_]: https://github.com/wodby/rabbitmq/tree/master/Dockerfile

Supported tags and respective `Dockerfile` links:

- `4.2` [_(Dockerfile)_]
- stability tags in the form `4.2-X.X.X` [_(Dockerfile)_]

All images built for `linux/amd64` and `linux/arm64`

## Environment Variables

| Variable                                     | Default Value         | Description                                              |
|----------------------------------------------|-----------------------|----------------------------------------------------------|
| `RABBITMQ_CHANNEL_MAX`                       | `2047`                |                                                          |
| `RABBITMQ_COLLECT_STATISTICS_INTERVAL`       | `5000`                |                                                          |
| `RABBITMQ_DEFAULT_PASS`                      | `wodby`               | Default RabbitMQ broker password, applied on first boot  |
| `RABBITMQ_DEFAULT_USER`                      | `wodby`               | Default RabbitMQ broker user, applied on first boot      |
| `RABBITMQ_DEFAULT_VHOST`                     | `/`                   | Applied on first boot                                    |
| `RABBITMQ_DISK_FREE_LIMIT`                   | `50MB`                |                                                          |
| `RABBITMQ_ENABLED_PLUGINS`                   | `rabbitmq_prometheus` | Comma-separated list for `/etc/rabbitmq/enabled_plugins` |
| `RABBITMQ_ERLANG_COOKIE`                     |                       | Passed through to the official image                     |
| `RABBITMQ_HEARTBEAT`                         | `60`                  |                                                          |
| `RABBITMQ_NODENAME`                          |                       | Passed through to the official image                     |
| `RABBITMQ_PORT`                              | `5672`                |                                                          |
| `RABBITMQ_USE_LONGNAME`                      |                       | Passed through to the official image                     |
| `RABBITMQ_VM_MEMORY_HIGH_WATERMARK_RELATIVE` | `0.4`                 | Relative memory watermark used in rendered config        |

## Orchestration Actions

Usage:

```
make COMMAND [params ...]

commands:
    check-ready host port max_try wait_seconds delay_seconds

default params values:
    host localhost
    port 5672
    max_try 1
    wait_seconds 1
    delay_seconds 0
```

## Notes

- The image wraps the official Alpine RabbitMQ image and keeps the upstream entrypoint.
- A Wodby config snippet is rendered to `/etc/rabbitmq/conf.d/90-wodby.conf` at startup.
- Plugin enablement is rendered to `/etc/rabbitmq/enabled_plugins` at startup.
- The wrapper maps deprecated `RABBITMQ_VM_MEMORY_HIGH_WATERMARK` to `RABBITMQ_VM_MEMORY_HIGH_WATERMARK_RELATIVE`.

## Deployment

Deploy RabbitMQ to your server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com/).
