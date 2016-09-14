#!/bin/bash

if [ -z $1 ]; then
    echo Build version to run not passed. Exiting
    exit
else
    Test suite version $1 will be build and started
fi


LCHOME="/home/simant/Locationcast"

echo Stopping any running test-suite
sudo pkill -f lc-test-suite
sleep 5s

echo Building test-suite
cd $LCHOME/lc-test-suite
mvn clean install

echo Starting lc-test-suite
java -jar $LCHOME/lc-test-suite/target/lc-test-suite-$1-SNAPSHOT.jar -a bQfsay683budVOmk0uMV -c 64u0MwqRMwGSJ4ZudR53lA -l "http://localhost:9080" -r "localhost" -o "locationcast" -v localhost:9092 -s 20000 -p "layer" -b TueI5kod3RaQ9uFPfC7TTjqKgOSjIJUX2bYZH1S6arTgQ3k7ofl7FO8TKlHDmj7Q05ful86e8iSBDaEBIdA9aA -d https://stg.account.api.here.com $2 > $LCHOME/Logs/test-suite.log 2> $LCHOME/Logs/test-suite.err < /dev/null &
