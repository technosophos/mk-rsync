#!/bin/sh

: "${VCS_LOCAL_PATH:=/src}"
: "${VCS_REPO:?}"
: "${VCS_REVISION:?}"


echo "Copying ${VCS_REPO} to ${VCS_LOCAL_PATH} (HOST: ${RSYNC_RSYNC_SERVICE_HOST})"

rsync -Cat rsync://${RSYNC_RSYNC_SERVICE_HOST}/share/${VCS_REPO} ${VCS_LOCAL_PATH}

echo "Done copying"
