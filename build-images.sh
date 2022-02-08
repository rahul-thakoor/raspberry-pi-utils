#!/bin/bash
set -e

function build_and_push_image () {
  local BALENA_ARCH=$1
  local PLATFORM=$2

  TAG=$DOCKER_REPO/$PROJECT:$BALENA_ARCH-$VERSION

  echo "Building for $BALENA_ARCH, platform $PLATFORM, pushing to $TAG"
  
  docker buildx build . --pull \
      --build-arg BALENA_ARCH=$BALENA_ARCH \
      --platform $PLATFORM \
      --file Dockerfile \
      --tag $TAG --load

  echo "Publishing..."
  docker push $TAG
}

function create_and_push_manifest() {
  docker manifest create $DOCKER_REPO/$PROJECT:latest \
  --amend $DOCKER_REPO/$PROJECT:aarch64-$VERSION \
  --amend $DOCKER_REPO/$PROJECT:armv7hf-$VERSION \
  --amend $DOCKER_REPO/$PROJECT:rpi-$VERSION 

  docker manifest push $DOCKER_REPO/$PROJECT:latest
}


DOCKER_REPO=${1:-rahulthakoor}
VERSION=${2:-$(<VERSION)}
PROJECT=${3:-raspberry-pi-utils}

build_and_push_image "aarch64" "linux/arm64" 
build_and_push_image "armv7hf" "linux/arm/v7" 
build_and_push_image "rpi" "linux/arm/v6" 

create_and_push_manifest