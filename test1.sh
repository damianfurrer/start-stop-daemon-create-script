#!/bin/sh
interval=1
action() {
  xsetroot -name "$(date)"
  echo "updated @ $(date)"
  >&2 echo "test error @ $(date)"
}

Main(){
  while true
  do
    action
    sleep $interval
  done
}

Main
exit 0
