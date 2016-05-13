#!/bin/bash

groupmod --gid $RUNUSER_GID galaxy
usermod --uid $RUNUSER_UID --gid $RUNUSER_GID galaxy
chown -R $RUNUSER_UID:$RUNUSER_GID /home/galaxy

su - galaxy -c "cd /home/galaxy/galaxy-15.07;./run.sh --daemon"
tail -f /home/galaxy/galaxy-15.07/paster.log

