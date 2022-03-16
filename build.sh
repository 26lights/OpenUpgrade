#!/bin/bash
CONTAINER_ENGINE=${CONTAINER_ENGINE:-docker}

$CONTAINER_ENGINE build -t openupgrade:$(git describe --all --long| cut -d / -f 2) .