# start-stop-daemon-script

New create daemon script:
- used command: ./createdaemon.sh \<your script\> "xdaemon"

privately edited afterwards:
- xdaemon.rc:  added command argument to pass to script
- xdaemon.src: changed user:group

Script example:
```
#!/bin/sh

_term() { 
  echo "term pid $pid"
  echo "Caught SIGTERM signal!" 
  kill $pid
  wait $pid
}

_int() {
  echo "interupt"
  sleep 5
  _term
}

_kill() {
  echo "kill"
  _term
}

trap _kill SIGKILL
trap _int SIGINT
trap _term SIGTERM

/root/start-command &
pid=$!

wait $pid
```
