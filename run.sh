#!/bin/sh
set -e

DIR="$(dirname "$(readlink -f "$0")")"
chmod 777 "${DIR}/workdir"

export DISTRO="${DISTRO:-ubuntu}"
export RELEASE="${RELEASE:-xenial}"

docker build \
    --build-arg "DISTRO=$DISTRO" \
    --build-arg "RELEASE=$RELEASE" \
    --tag "debuild:${DISTRO}-${RELEASE}" "${DIR}"

docker run -it --rm \
    --mount "type=bind,source=${DIR}/workdir,target=/home/builduser/workdir" \
    "$@" \
    "debuild:${DISTRO}-${RELEASE}"
