#!/bin/sh

ARG=$1
PIDFILE=monitor.pid
OUTPUT_FILE=output.csv

start() {
    if [ ! -f $PIDFILE ]; then
        (
        while true; do
            TIMESTAMP=$(date +%s)
            CPU_USAGE=$(top -b -n1 | awk 'NR>7{s+=$9} END {print s}')
            printf "${TIMESTAMP};${CPU_USAGE}\n" >> $OUTPUT_FILE
            sleep 600
        done
        ) &

        echo $! > $PIDFILE
    fi
}

status() {
    if [ -f $PIDFILE ]; then
        cat $PIDFILE
    fi
}

stop() {
    if [ -f $PIDFILE ]; then
        kill $(cat $PIDFILE)
        rm $PIDFILE
    fi
}

case $ARG in
    START)
        start
        ;;
    STATUS)
        status
        ;;
    STOP)
        stop
        ;;
    *)
        echo "Usage: $0 {START|STATUS|STOP}"
        exit 1
        ;;
esac