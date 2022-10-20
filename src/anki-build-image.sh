#!/bin/bash -e

ANKI_HOME="/opt/software/anki"
ANKI_TMP_WORKSPACE="${ANKI_HOME}/tmp"
ANKI_GIT_URL="https://github.com/ankicommunity/anki-sync-server.git"
ANKI_BRANCH="main"
ANKI_IMG_NAME="myanki:v1.0"

SHELL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"

# delete tmp folder for build image (such:git project,old version file ...)
rm ${ANKI_TMP_WORKSPACE:=/tmp/anki.d}/ -rf

# create folder
mkdir -p ${ANKI_HOME}
mkdir -p ${ANKI_TMP_WORKSPACE}

# download anki sync server code & cd to folder & switch to target branch
cd ${ANKI_TMP_WORKSPACE}/
git clone ${ANKI_GIT_URL}
cd anki-sync-server
git branch ${ANKI_BRANCH}

# the files needed to build the image
cp "${SHELL_DIR}/.dockerignore" "${SHELL_DIR}/Dockerfile" ./

# build
docker build --network=host -t ${ANKI_IMG_NAME} .

# copy docker restart
[ ! -f "${ANKI_HOME}/anki-docker-restart.sh" ] && cp "${SHELL_DIR}/anki-docker-restart.sh" "${ANKI_HOME}/"
[ ! -f "${ANKI_HOME}/docker-compose.yml" ] && cp "${SHELL_DIR}/docker-compose.yml" "${ANKI_HOME}/"

chmod +x "${ANKI_HOME}/anki-docker-restart.sh"

# clean tmp folder
rm ${ANKI_TMP_WORKSPACE:=/tmp/anki.d}/ -rf

echo "##############################################################"
echo " build docker image successful !                              "
echo " please edit ${ANKI_HOME}/docker-compose.yml                  "
echo " then execute ${ANKI_HOME}/anki-docker-restart.sh              "
echo "##############################################################"
