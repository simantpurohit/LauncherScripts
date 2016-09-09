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

echo Stopped any running lc-server, publisher and billing

echo Building locationcast
cd $LCHOME/location-cast
mvn clean install $2

echo Starting lc-publisher
nohup java -jar $PUBHOME/target/lc-publisher-$1-SNAPSHOT.jar publisher $PUBHOME/src/main/resources/ > $LCHOME/Logs/publisher.log 2> $LCHOME/Logs/publisher.err < /dev/null &
sleep 2s

echo Starting lc-billing
nohup java -jar $PUBHOME/target/lc-publisher-$1-SNAPSHOT.jar billing $PUBHOME/src/main/resources/ > $LCHOME/Logs/billing.log 2> $LCHOME/Logs/billing.err < /dev/null &
sleep 2s

echo starting lc-server
nohup java -jar $SERVERHOME/target/lc-server-$1-SNAPSHOT.jar server $SERVERHOME/lc.yml > $LCHOME/Logs/server.log 2> $LCHOME/Logs/server.err < /dev/null &
sleep 2s
