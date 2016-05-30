#!/bin/sh
i=0
while [ "$i" -lt $1 ]; do
  /tmp/hellogalaxy
  i=$(( i + 1 ))
done
