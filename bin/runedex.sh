#!/bin/bash
. /etc/profile.d/awips2.sh
ulimit -n 1024
set -e
set -x
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

# Cleanup
echo "export SERVICES=('ingestRadar')" > /etc/init.d/edexServiceList
#rm -rf /awips2/edex/lib/plugins/com.raytheon.uf.edex.plugin.goesr.jar

# EDEX
edex setup
/awips2/qpid/bin/qpid-wrapper &
/awips2/edex/bin/start.sh -noConsole ingestRadar &
#/awips2/edex/bin/start.sh -noConsole request &
#/awips2/edex/bin/start.sh -noConsole ingestGrib &

# LDM
export PATH=$PATH:/awips2/ldm/bin/
rand=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1`
regutil -s 'unidata-awips-edex-ingest-'${rand}'.docker.com' /hostname
#ldmadmin mkqueue
#ldmadmin start

# never exit
while true; do sleep 10000; done
