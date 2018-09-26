#!/bin/bash
set -e
if [ "$1" = 'runedex.sh' ]; then
    for i in /awips2/ldm/etc/ /awips2/edex/bin/
    do
        if [ -d "$i" ]; then
            chown awips:fxalpha "$i"
        fi
    done
    exec gosu edex "$@"
fi
exec "$@"
