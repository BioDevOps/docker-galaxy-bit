#!/bin/bash

# RUNUSER_UID
if [ ! -n "${RUNUSER_UID-}" ] ; then
  echo "RUNUSER_UID is not set or empty"
  exit 1
fi
# RUNUSER_GID
if [ ! -n "${RUNUSER_GID-}" ] ; then
  echo "RUNUSER_GID is not set or empty"
  exit 1
fi


groupmod --gid $RUNUSER_GID galaxy
usermod --uid $RUNUSER_UID --gid $RUNUSER_GID galaxy
chown -R $RUNUSER_UID:$RUNUSER_GID /home/galaxy

su - galaxy -c "cd /home/galaxy/galaxy-15.07;./run.sh --daemon"
tail -f /home/galaxy/galaxy-15.07/paster.log

