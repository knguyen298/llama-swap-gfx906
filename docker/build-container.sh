#!/bin/bash

cd $(dirname "$0")

sudo mkdir -p /mnt/docker-data
sudo chmod 777 /mnt/docker-data

dockerd --data-root /mnt/docker-data

# Check if GITHUB_TOKEN is set and not empty
if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "Error: GITHUB_TOKEN is not set or is empty."
  exit 1
fi

LS_VER=$(curl -s https://api.github.com/repos/mostlygeek/llama-swap/releases/latest | jq -r .tag_name | sed 's/v//')
CONTAINER_LATEST="ghcr.io/knguyen298/llama-swap-gfx906:rocm-6.3.3"
docker build -f llama-swap.Containerfile --build-arg BASE_TAG=full-rocm-6.3.3 --build-arg LS_VER=${LS_VER} -t ${CONTAINER_LATEST} .
docker push ${CONTAINER_LATEST}
