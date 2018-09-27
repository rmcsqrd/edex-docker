#!/bin/bash
ulimit -n 1024
set -e
set -x
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

# EDEX
edex setup
/bin/bash /awips2/qpid/bin/qpid-wrapper
/bin/bash /awips2/edex/bin/start.sh -noConsole ingest
/bin/bash /awips2/edex/bin/start.sh -noConsole ingestGrib

# LDM
regutil -s '$HOSTNAME' /hostname
ldmadmin mkqueue
ldmadmin start

# never exit
while true; do sleep 10000; done
