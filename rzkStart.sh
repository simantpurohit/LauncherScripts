#!/bin/bash
echo Starting LC services

KAFKADIR="/home/simant/Locationcast/kafka_2.11-0.9.0.1"
LCHOME="/home/simant/Locationcast"
PUBHOME="$LCHOME/location-cast/lc-publisher"
SERVERHOME="$LCHOME/location-cast/lc-server"

echo removing log files
truncate $LCHOME/Logs/*.log --size 0
truncate $LCHOME/Logs/*.out --size 0
truncate $LCHOME/Logs/*.err --size 0
truncate $LCHOME/LauncherScripts/*.log --size 0


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


echo Starting Redis...
redis-server /etc/redis/redis.conf
sleep 5s

echo Starting Zookeeper
nohup ${KAFKADIR}/bin/zookeeper-server-start.sh ${KAFKADIR}/config/zookeeper.properties > $LCHOME/Logs/zookeeper.out 2> $LCHOME/Logs/zookeeper.err < /dev/null &
sleep 10s

echo Starting kafka
nohup ${KAFKADIR}/bin/kafka-server-start.sh ${KAFKADIR}/config/server.properties > $LCHOME/Logs/kafka.out 2> $LCHOME/Logs/kafka.err < /dev/null &
sleep 10s
