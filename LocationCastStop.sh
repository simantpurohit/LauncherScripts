#!/bin/bash

LCHOME="/home/simant/Locationcast"
PUBHOME="$LCHOME/location-cast/lc-publisher"
SERVERHOME="$LCHOME/location-cast/lc-server"

PID=$(pgrep -f lc.yml)
if [ ! -z $PID ]; then
    echo Stopping server
    sudo kill -9 $PID
    sleep 5s
else
    echo Server Not Running
fi
PID=""

PID=$(pgrep -f billing)
if [ ! -z "$PID" ]; then
    echo Stopping billing
    sudo kill -9 $PID
    sleep 5s
else
    echo Billing not running
fi
PID=""


PID=$(pgrep -f publisher)
if [ ! -z "$PID" ]; then
    echo Stopping Publisher
    sudo kill -9 $PID
    sleep 5s
else
    echo Publisher not running
fi
PID=""

echo DONE!
