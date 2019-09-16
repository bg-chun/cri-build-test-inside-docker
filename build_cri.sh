#!/bin/bash

BUILD_OPT=--no-cache
IMAGE_NAME=cri-build-image
CONTAINER_NAME=cri-builder
BINARY_SRC=/go/src/github.com/containerd/cri/_output/containerd
BINARY_DST=./

sudo docker build $BUILD_OPT -t $IMAGE_NAME .
sudo docker create -ti --name $CONTAINER_NAME $IMAGE_NAME bash
sudo docker cp $CONTAINER_NAME:$BINARY_SRC $BINARY_DST
sudo docker rm -f $CONTAINER_NAME
sudo docker image rm $IMAGE_NAME
