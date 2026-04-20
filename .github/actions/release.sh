#!/usr/bin/env bash

set -exo pipefail

if [[ "${GITHUB_REF}" == refs/heads/main || "${GITHUB_REF}" == refs/heads/master || "${GITHUB_REF}" == refs/tags/* ]]; then
  minor_ver="${RABBITMQ_VER%.*}"
  tags=("${minor_ver}")

  if [[ "${GITHUB_REF}" == refs/tags/* ]]; then
    stability_tag="${GITHUB_REF##*/}"
    tags=("${minor_ver}-${stability_tag}")
  fi

  for tag in "${tags[@]}"; do
    make buildx-imagetools-create IMAGETOOLS_TAG=${tag}
  done
fi
