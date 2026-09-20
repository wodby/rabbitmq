# RabbitMQ Docker Container Image

[![Build Status](https://github.com/wodby/rabbitmq/workflows/Build%20docker%20image/badge.svg)](https://github.com/wodby/rabbitmq/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/rabbitmq.svg)](https://hub.docker.com/r/wodby/rabbitmq)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/rabbitmq.svg)](https://hub.docker.com/r/wodby/rabbitmq)

## Docker Images

Use image revision tags such as `wodby/rabbitmq:4.3-rN` to select a Wodby image revision.
Major and minor tags use the repository release number. Full-version tags such as
`wodby/rabbitmq:4.3.6-r0` start at `r0` for each exact upstream version.
Every published versioned revision tag has a matching annotated Git tag pointing to its release commit.
Existing tags remain available after support for their major or minor version ends.
See [release tags](https://github.com/wodby/rabbitmq/tags) for available revisions and the [image revision policy](https://github.com/wodby/images#image-revisions) for upgrade guidance.
Previously published image tags remain available.

Overview:

- All images are based on Alpine Linux
- Base image: [rabbitmq](https://hub.docker.com/_/rabbitmq)
- [GitHub actions builds](https://github.com/wodby/rabbitmq/actions)
- [Docker Hub](https://hub.docker.com/r/wodby/rabbitmq)

[_(Dockerfile)_]: https://github.com/wodby/rabbitmq/tree/master/Dockerfile

Supported tags and respective `Dockerfile` links:

- `4.3` [_(Dockerfile)_]
- `4.2` [_(Dockerfile)_]
- image revision tags in the form `4.3-rN` or `4.2-rN` [_(Dockerfile)_]

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
- Plugin enablement is passed to RabbitMQ through `RABBITMQ_ENABLED_PLUGINS`; RabbitMQ writes the enabled plugins file.
- The wrapper maps deprecated `RABBITMQ_VM_MEMORY_HIGH_WATERMARK` to `RABBITMQ_VM_MEMORY_HIGH_WATERMARK_RELATIVE`.

## Deployment

Deploy RabbitMQ to your server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com/).
