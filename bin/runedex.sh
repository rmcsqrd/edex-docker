#!/bin/bash
. /etc/profile.d/awips2.sh
ulimit -n 1024
set -e
set -x
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

# EDEX
edex setup
/awips2/qpid/bin/qpid-wrapper &
/awips2/edex/bin/start.sh -noConsole ingest &
#/awips2/edex/bin/start.sh -noConsole ingestGrib &

# LDM
export PATH=$PATH:/awips2/ldm/bin/
rand=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1`
regutil -s 'unidata-awips-edex-ingest-'${rand}'.docker.com' /hostname
ldmadmin mkqueue
ldmadmin start

# never exit
while true; do sleep 10000; done
