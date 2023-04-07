#!/bin/bash

# set fail jenkins
set -e
set -o pipefail

if [[ $API_CONF_UPSTREAM_PATH != "" ]] 
then
    for f in ./api_upstream.d/*.conf; do 
        echo "copying file to"
        echo $API_CONF_UPSTREAM_PATH${f##*/}
        cp $f $API_CONF_UPSTREAM_PATH${f##*/}
    done
else
    echo "Api upstream Path Is Empty"
    exit 1
fi