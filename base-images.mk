# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := rabbitmq
BASE_IMAGE_VERSION_SUFFIX := -alpine

BASE_IMAGE_DIGEST_4.2.9-alpine := sha256:2ec385e7399a5e0d6fc267304fb711ac78ec0b05dc0a64c4d7501f70b15d66a2
BASE_IMAGE_DIGEST_4.3.6-alpine := sha256:6931816af1a943f471c038b278835d36692d55dec769232739296bb91b7de0f5

# Fail before building when a version or variant has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
