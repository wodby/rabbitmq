# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := rabbitmq
BASE_IMAGE_VERSION_SUFFIX := -alpine

BASE_IMAGE_DIGEST_4.2.9-alpine := sha256:920aeef84def9973d06c8334f71914d8a71dba1e8b38a7b0ff126a3da8e3d3ef
BASE_IMAGE_DIGEST_4.3.6-alpine := sha256:9a5494b32def2c288a755c933ea2ffd7f4a28647f7648776ad8b15507493f702

# Fail before building when a version or variant has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
