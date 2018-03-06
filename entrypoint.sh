#!/bin/bash

# TODO debug
set -x

[ ! -d /configmap ] && echo "Sysctl configuration directory /configmap not found" && exit 1

while true; do
    for option in $(ls -1 /configmap); do
        value="$(cat /configmap/${option})"
        sysctl -w "$option=$value"
    done
    # TODO dump current sysctl state? (sysctl -a)
    inotifywait -qq -e modify -e create -e delete /configmap/
done
