#!/bin/bash

LCHOME="/home/simant/Locationcast"

echo Building locationcast
cd $LCHOME/location-cast
mvn clean install $1
sleep 2s
echo Done. Check logs if not successful!

