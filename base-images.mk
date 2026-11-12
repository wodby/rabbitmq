# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := rabbitmq
BASE_IMAGE_VERSION_SUFFIX := -alpine

BASE_IMAGE_DIGEST_4.2.9-alpine := sha256:cd4f5c5bb4ffe530dba84770a8d139b8518470cdd385fec9cf014ebfff6bb009
BASE_IMAGE_DIGEST_4.3.7-alpine := sha256:d363f79df91b170122c5ab6043d39d1c2612e83d333b1fc2bc84c8125272af79

# Fail before building when a version or variant has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
