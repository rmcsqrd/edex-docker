#!/bin/bash
set -e
set -x
regutil -s '$HOSTNAME' /hostname
edex setup
/bin/bash /awips2/qpid/bin/qpid-wrapper
/bin/bash /awips2/edex/bin/start.sh -noConsole ingest
/bin/bash /awips2/edex/bin/start.sh -noConsole ingestGrib
# never exit
while true; do sleep 10000; done
