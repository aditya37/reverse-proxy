#!/bin/bash

# set fail jenkins
set -e
set -o pipefail

if [[ $API_CONF_PATH != "" ]] 
then
    # parse api config file with prefix _squad.conf
    for f in ./api_conf.d/*_squad.conf; do 
        cp $f $API_CONF_PATH${f##*/}
    done
else
    echo "Api Conf Path Is Empty"
    exit 1
fi