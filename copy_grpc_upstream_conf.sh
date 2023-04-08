#!/bin/bash

# set fail jenkins
set -e
set -o pipefail

if [[ $GRPC_CONF_UPSTREAM_PATH != "" ]] 
then
    for f in ./grpc_upstream.d/*.conf; do 
        echo "copying file to"
        echo $GRPC_CONF_UPSTREAM_PATH${f##*/}
        cp $f $GRPC_CONF_UPSTREAM_PATH${f##*/}
    done
else
    echo "gRPC Api upstream Path Is Empty"
    exit 1
fi