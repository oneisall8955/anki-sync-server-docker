#!/bin/bash -e

DIR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

cd "${DIR_PATH}"

docker-compose down && docker-compose up -d

echo "anki restart success !"
