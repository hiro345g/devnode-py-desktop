#! /bin/sh
IMAGE_NAME=devnode-py-desktop:1.0
BUILD_DEVCON_DIR=$(cd $(dirname $0);pwd)
PATH=${PATH}:${NPM_CONFIG_PREFIX}/bin

cd ${BUILD_DEVCON_DIR}
npm exec --package=@devcontainers/cli -- \
    devcontainer build --workspace-folder ./ --image-name ${IMAGE_NAME} --no-cache
