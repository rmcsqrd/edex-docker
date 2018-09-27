#!/bin/bash -v
rebuild=true

# current directory
dir="$( cd "$(dirname "$0")" ; pwd -P )"
pushd $dir

# source AWIPS build env vars
. ../buildEnvironment.sh

# remove existing image (optional)
if $rebuild; then
   rmflag=" --rm "
   img=$(sudo docker images | grep edex-ingest | awk '{ print $3 }')
   if [ ! -z "$img" ]; then
      echo "removing edex-ingest:latest"
      sudo docker rmi $img
   fi
fi

# build image
sudo docker build ${rmflag} -t unidata/edex-ingest -f Dockerfile.edex .

# push to dockerhub
sudo docker push unidata/edex-ingest
