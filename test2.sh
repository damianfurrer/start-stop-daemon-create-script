#!/bin/sh
daemon="$(pwd)/test1.sh"
pidfile="$(pwd)/test.pid"
logfile="$(pwd)/test.log"
errfile="$(pwd)/test.err"
useuserfile="$(pwd)/user.txt"
user="$(cat $useuserfile)"
dumask="022" #u,g,o 1-7 (rwx)
args="-p ${pidfile} -u ${user} -P -k ${dumask} ${daemon}"
argsstart="-m -b -2 ${errfile} -1 ${logfile} ${args}"
echo "${args}"
start-stop-daemon -S $argsstart
echo "waiting 30s to stop"
sleep 30
echo "stopping"
start-stop-daemon -K $args
exit 0
