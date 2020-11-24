#!/bin/bash

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMG_DIR=/opt/squash-images
MOUNT_DIR=/opt/compiler-explorer

shopt -s globstar
for img_file in "${IMG_DIR}"/**/*.img; do
    dst_path=${img_file/${IMG_DIR}/${MOUNT_DIR}}
    dst_path=${dst_path%.img}
    if mountpoint -q "$dst_path"; then
        echo "$dst_path is mounted already, skipping"
    else
        echo "$img_file -> $dst_path"
        mount -t squashfs "${img_file}" "${dst_path}" -o ro,nodev,relatime
    fi
done
