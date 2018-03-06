#!/bin/bash

# TODO debug
set -x

[ ! -d /configmap ] && echo "Sysctl configuration directory /configmap not found" && exit 1

apply_configmap() {
    for option in $(ls -1 /configmap); do
        value=$(cat /configmap/${option})
        sysctl -w "$option=$value"
    done
}

apply_configmap

if [ -z "${ONESHOT:+x}" ]; then
    while true; do
        # TODO dump current sysctl state? (sysctl -a)
        inotifywait -qq -e modify -e create -e delete /configmap/
        apply_configmap
    done
fi