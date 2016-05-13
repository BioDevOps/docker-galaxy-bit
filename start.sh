#!/bin/bash

cd /home/galaxy/galaxy-15.07
./run.sh --daemon
tail -f paster.log

