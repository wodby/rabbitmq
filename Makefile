-include env_make

RABBITMQ_VER ?= 4.2.6
RABBITMQ_VER_MINOR = $(shell echo "${RABBITMQ_VER}" | grep -oE '^[0-9]+\.[0-9]+')

TAG ?= $(RABBITMQ_VER_MINOR)

REPO = wodby/rabbitmq
NAME = rabbitmq-$(RABBITMQ_VER)

PLATFORM ?= linux/arm64

IMAGETOOLS_TAG ?= $(TAG)

ifneq ($(ARCH),)
	override TAG := $(TAG)-$(ARCH)
endif

.PHONY: build buildx-build buildx-push test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) \
		--build-arg RABBITMQ_VER=$(RABBITMQ_VER) \
		./

buildx-build:
	docker buildx build --platform $(PLATFORM) -t $(REPO):$(TAG) \
		--build-arg RABBITMQ_VER=$(RABBITMQ_VER) \
		--load \
		./

buildx-push:
	docker buildx build --platform $(PLATFORM) --push -t $(REPO):$(TAG) \
		--build-arg RABBITMQ_VER=$(RABBITMQ_VER) \
		./

buildx-imagetools-create:
	docker buildx imagetools create -t $(REPO):$(IMAGETOOLS_TAG) \
				$(REPO):$(TAG)-amd64 \
				$(REPO):$(TAG)-arm64
.PHONY: buildx-imagetools-create

test:
	cd ./tests && IMAGE=$(REPO):$(TAG) NAME=$(NAME) RABBITMQ_VER=$(RABBITMQ_VER) ./run.sh

push:
	docker push $(REPO):$(TAG)

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash

run:
	docker run --rm --name $(NAME) -e DEBUG=1 $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) $(CMD)

start:
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build push
