#!/bin/bash

# RUNUSER_USERNAME
if [ ! -n "${RUNUSER_USERNAME-}" ] ; then
  echo "RUNUSER_USERNAME is not set or empty"
  exit 1
fi

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


chown -R $RUNUSER_UID:$RUNUSER_GID /home/galaxy
groupmod --gid $RUNUSER_GID galaxy
usermod --uid $RUNUSER_UID --gid $RUNUSER_GID --login $RUNUSER_USERNAME galaxy

su - $RUNUSER_USERNAME -c "echo 'hostname; date' | qsub; cd /home/galaxy/galaxy-15.07;SGE_ROOT=/var/lib/gridengine ./run.sh --daemon"
tail -f /home/galaxy/galaxy-15.07/paster.log
