#!/bin/bash

LCHOME="/home/simant/Locationcast"

echo removing log files
truncate $LCHOME/Logs/*.log --size 0
truncate $LCHOME/Logs/*.out --size 0
truncate $LCHOME/Logs/*.err --size 0
truncate $LCHOME/LauncherScripts/*.log --size 0
