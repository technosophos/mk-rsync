#!/bin/sh

: "${VCS_LOCAL_PATH:=/src}"
: "${VCS_REPO:?}"
: "${VCS_REVISION:?}"


echo "Copying ${VCS_REPO} to ${VCS_LOCAL_PATH} (HOST: ${RSYNC_RSYNC_SERVICE_HOST})"

# -a = -rlptgoD
# Don't want o or g b/c users aren't moved
# Don't want D because we can't transfer devices
# Might not want p because users are not preserved
rsync -Ctrlp rsync://${RSYNC_RSYNC_SERVICE_HOST}/share/${VCS_REPO} ${VCS_LOCAL_PATH}

echo "Done copying"
