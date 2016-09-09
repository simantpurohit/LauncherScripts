#!/bin/bash
echo Starting LC services

KAFKADIR="/home/simant/Locationcast/kafka_2.11-0.9.0.1"
LCHOME="/home/simant/Locationcast"
PUBHOME="$LCHOME/location-cast/lc-publisher"
SERVERHOME="$LCHOME/location-cast/lc-server"

echo removing log files
sudo truncate $LCHOME/Logs/*.* --size 0
sudo truncate $LCHOME/LauncherScripts/*.log --size 0

echo Stopping server
sudo pkill -f lc.yml
sleep 5s

echo Stopping billing
sudo pkill -f billing
sleep 5s

echo Stopping publisher
sudo pkill -f publisher
sleep 5s

echo Stopping Redis...
killall redis-server
sleep 5s

echo Starting Redis...
redis-server /etc/redis/redis.conf
sleep 5s

echo Stopping kafka and zookeeper
sudo pkill -f kafka
sudo pkill -f zookeeper
sleep 30s

echo Starting Zookeeper
nohup ${KAFKADIR}/bin/zookeeper-server-start.sh ${KAFKADIR}/config/zookeeper.properties > $LCHOME/Logs/zookeeper.out 2> $LCHOME/Logs/zookeeper.err < /dev/null &
sleep 10s

echo Starting kafka
nohup ${KAFKADIR}/bin/kafka-server-start.sh ${KAFKADIR}/config/server.properties > $LCHOME/Logs/kafka.out 2> $LCHOME/Logs/kafka.err < /dev/null &
sleep 10s

echo Starting lc-publisher
nohup java -jar $PUBHOME/target/lc-publisher-$1-SNAPSHOT.jar publisher $PUBHOME/src/main/resources/ > $LCHOME/Logs/publisher.out 2> $LCHOME/Logs/publisher.err < /dev/null &
sleep 5s

echo Starting lc-billing
nohup java -jar $PUBHOME/target/lc-publisher-$1-SNAPSHOT.jar billing $PUBHOME/src/main/resources/ > $LCHOME/Logs/billing.out 2> $LCHOME/Logs/billing.err < /dev/null &
sleep 5s

echo Starting lc-server
nohup java -jar $SERVERHOME/target/lc-server-$1-SNAPSHOT.jar server $SERVERHOME/lc.yml > $LCHOME/Logs/server.out 2> $LCHOME/Logs/server.err < /dev/null &
sleep 5s
