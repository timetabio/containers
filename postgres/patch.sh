#!/bin/bash

STORAGE_DIR=/data/applied

set -e

apply () {
  CHECKSUM=$(cat ${1} | shasum -a 256 | awk '{print $1}')

  TEXT='Applying'
  SKIP=0

  if [ -f ${STORAGE_DIR}/${CHECKSUM} ]; then
    SKIP=1
    TEXT='Skipping'
  fi

  tput setaf 2
  echo "--> ${TEXT} patch..."
  tput sgr0

  echo "$(tput bold)Filename$(tput sgr0): ${1}"
  echo "$(tput bold)Checksum$(tput sgr0): ${CHECKSUM}"

  if [ ${SKIP} -eq 1 ]; then
    return
  fi

  psql -U postgres -a -f ${1}
  touch ${STORAGE_DIR}/${CHECKSUM}
}

mkdir -p ${STORAGE_DIR}

for PATCH in /data/patches/*.sql; do
  apply ${PATCH}
done
