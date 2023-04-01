#!/bin/sh

pid=0

term_handler() {
  if [ "$pid" -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 0;
}

trap 'kill ${!}; term_handler' TERM

./playit -s -c "config/playit.toml" &
pid="$!"

while true; do :; done