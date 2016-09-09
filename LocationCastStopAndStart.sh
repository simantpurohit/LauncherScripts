#!/bin/bash

LCHOME="/home/simant/Locationcast"
PUBHOME="$LCHOME/location-cast/lc-publisher"
SERVERHOME="$LCHOME/location-cast/lc-server"

echo Stopping server
sudo pkill -f lc.yml
sleep 5s

echo Stopping billing
sudo pkill -f billing
sleep 5s

echo Stopping publisher
sudo pkill -f publisher
sleep 5s

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
