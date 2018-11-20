#!/bin/sh
set -e

DIR="$(dirname "$(readlink -f "$0")")"

chmod 777 "${DIR}/workdir"
docker build --tag ubuntu:test "${DIR}"
docker run -it --rm \
    --mount "type=bind,source=${DIR}/workdir,target=/home/builduser/workdir" \
    ubuntu:test
