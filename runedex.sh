#!/bin/bash

# limit max number of open files to force pqact to close open file descriptors.
ulimit -n 1024

set -e
set -x
. /etc/profile.d/awips2.sh
edex setup
edex start

# never exit
while true; do sleep 10000; done
