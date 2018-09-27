#!/bin/bash
ulimit -n 1024
set -e
set -x
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

# EDEX
edex setup
/awips2/qpid/bin/qpid-wrapper &
/awips2/edex/bin/start.sh -noConsole ingest &
/awips2/edex/bin/start.sh -noConsole ingestGrib &

. /etc/profile.d/awips2.sh
export PATH=$PATH:/awips2/ldm/bin/
# LDM
regutil -s '$HOSTNAME' /hostname
ldmadmin mkqueue
ldmadmin start

# never exit
while true; do sleep 10000; done
