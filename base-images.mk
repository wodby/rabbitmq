# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := rabbitmq
BASE_IMAGE_VERSION_SUFFIX := -alpine

BASE_IMAGE_DIGEST_4.2.9-alpine := sha256:63bf2b61c7ddd5ab746d1d964f33beb1b4a2c06df79505d55251aae5f8077884
BASE_IMAGE_DIGEST_4.3.7-alpine := sha256:f843f29765b9bf9303ac8af0f33de3bc650ee00bf5a9c0056dfd479f75bce588

# Fail before building when a version or variant has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
