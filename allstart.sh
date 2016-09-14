#!/bin/bash

LCHOME="/home/simant/Locationcast"
LAUNCHERHOME="$LCHOME/LauncherScripts"

sh $LAUNCHERHOME/rmlogs.sh
sh $LAUNCHERHOME/rzkStart.sh
sh $LAUNCHERHOME/lcstart.sh
