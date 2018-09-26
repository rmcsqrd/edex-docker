#!/bin/bash
set -e
set -x
su - awips -c 'regutil -s '$HOSTNAME' /hostname'
edex setup
edex start
# never exit
while true; do sleep 10000; done
