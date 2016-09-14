#!/bin/bash
echo Stopping Redis, Kafka and Zookeeper

PID=$(pgrep -f redis-server)
if [ ! -z "$PID" ]; then
    echo Stopping Redis Server
    kill -9 $PID
    sleep 5s
else
    echo Redis not running
fi
PID=""

PID=$(pgrep -f kafka)
if [ ! -z "$PID" ]; then
    echo Stopping Kafka
    kill -9 $PID
    sleep 10s
else
    echo Kafka not running
fi
PID=""

PID=$(pgrep -f zookeeper)
if [ ! -z "$PID" ]; then
    echo Stopping Zookeeper
    kill -9 $PID
    sleep 10s
else
    echo Zookeeper not running
fi
PID=""

echo Done!
