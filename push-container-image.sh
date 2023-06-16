#!/usr/bin/env bash

IMAGE_NAME="fake-logger"
IMAGE_TAG="0.0.1"
REGISTRY_REPO="docker.io/willsenabr/$IMAGE_NAME"

set -e

build_container() {
    docker  build --no-cache --tag pandoc --file Containerfile .
}

push_container() {
    docker image tag $IMAGE_NAME:latest $REGISTRY_REPO:latest
    docker image tag $IMAGE_NAME:latest $REGISTRY_REPO:$IMAGE_TAG
    
    docker image push $REGISTRY_REPO
    docker image push $REGISTRY_REPO:$IMAGE_TAG
}

build_container
push_container