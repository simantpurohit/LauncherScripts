#!/bin/bash
echo Stopping LC services

PID=$(pgrep -f lc.yml)
if [ ! -z $PID ]; then
    echo Stopping server
    kill -9 $PID
    sleep 5s
else
    echo Server Not Running
fi
PID=""

PID=$(pgrep -f billing)
if [ ! -z "$PID" ]; then
    echo Stopping billing
    kill -9 $PID
    sleep 5s
else
    echo Billing not running
fi
PID=""

PID=$(pgrep -f publisher)
if [ ! -z "$PID" ]; then
    echo Stopping Publisher
    kill -9 $PID
    sleep 5s
else
    echo Publisher not running
fi
PID=""

echo Stopped any running lc-server, publisher and billing
