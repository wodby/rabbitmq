# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := rabbitmq
BASE_IMAGE_VERSION_SUFFIX := -alpine

BASE_IMAGE_DIGEST_4.2.9-alpine := sha256:2430a17fa578447eaaabdabc64b805052e4f8f3736a5ebbe4cc55cf4de5690e0
BASE_IMAGE_DIGEST_4.3.6-alpine := sha256:60f9d5575c0a96f0df221fa55a9bd82118c0098f006ff08f7c8b797ef7fd0f50

# Fail before building when a version or variant has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
