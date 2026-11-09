#!/usr/bin/env bash

set -e

# Setup variables:
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
APP_FOLDER_NAME="hackrf-apps"
IMAGE_NAME="hackrf-dev-env"
CONTAINER_NAME="hackrf-dev"

mkdir -p "$APP_FOLDER_NAME"

docker run --rm -it \
    --name "$CONTAINER_NAME" \
    --mount "type=bind,src=$SCRIPT_DIR,dst=/workspace" \
    "$IMAGE_NAME"