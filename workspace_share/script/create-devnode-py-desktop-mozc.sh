#!/bin/sh
BASE_DIR=$(cd $(dirname $0)/..;pwd)
DEV_DIR=${BASE_DIR}/dev
DIST_DIR=${BASE_DIR}/devnode-py-desktop-mozc

if [ ! -e ${DEV_DIR}/devnode-py-desktop ]; then
  cd ${DEV_DIR}/
  wget https://github.com/hiro345g/devnode-desktop/archive/refs/heads/main.zip
  unzip ${DEV_DIR}/main.zip
  mv ${DEV_DIR}/devnode-desktop-main ${DEV_DIR}/devnode-py-desktop
  rm ${DEV_DIR}/main.zip
fi
if [ ! -e ${DIST_DIR}/.devcontainer ]; then mkdir -p ${DIST_DIR}/.devcontainer; fi
if [ ! -e ${DIST_DIR}/workspace_share ]; then mkdir -p ${DIST_DIR}/workspace_share; fi
cp -r ${DEV_DIR}/devnode-py-desktop/.devcontainer/* ${DIST_DIR}/.devcontainer/
cp -r ${DEV_DIR}/devnode-py-desktop/docker-compose.yml ${DIST_DIR}/
sed -i 's/devnode-desktop/devnode-py-desktop-mozc/' ${DIST_DIR}/.devcontainer/devcontainer.json
sed -i 's/devnode-desktop/devnode-py-desktop-mozc/' ${DIST_DIR}/docker-compose.yml

rm -fr ${DEV_DIR}/devnode-py-desktop
