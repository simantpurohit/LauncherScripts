#!/bin/bash
echo Starting LC services

if [ -z $1 ]; then
    echo Build version to start not passed. Exiting
    exit
else
    Locationcast version $1 will be build and started
fi


LCHOME="/home/simant/Locationcast"
PUBHOME="$LCHOME/location-cast/lc-publisher"
SERVERHOME="$LCHOME/location-cast/lc-server"
LAUNCHERHOME="$LCHOME/LauncherScripts"

echo Stopping services if any running
sh $LAUNCHERHOME/lcstop.sh
if [ "$2" = "build" ]; then
    echo Building locationcast
    cd $LCHOME/location-cast
    mvn clean install $3
else
    echo Not bulding LC before starting as build command not passed.
fi

echo Starting lc-publisher
nohup java -jar $PUBHOME/target/lc-publisher-$1-SNAPSHOT.jar publisher $PUBHOME/src/main/resources/ > $LCHOME/Logs/publisher.out 2> $LCHOME/Logs/publisher.err < /dev/null &
sleep 5s

echo Starting lc-billing
nohup java -jar $PUBHOME/target/lc-publisher-$1-SNAPSHOT.jar billing $PUBHOME/src/main/resources/ > $LCHOME/Logs/billing.out 2> $LCHOME/Logs/billing.err < /dev/null &
sleep 5s

echo Starting lc-server
nohup java -jar $SERVERHOME/target/lc-server-$1-SNAPSHOT.jar server $SERVERHOME/lc.yml > $LCHOME/Logs/server.out 2> $LCHOME/Logs/server.err < /dev/null &
sleep 5s
