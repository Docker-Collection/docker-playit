#!/bin/bash

pid=0
playit=./playit

term_handler() {
  if [ "$pid" -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 0;
}

trap 'kill ${!}; term_handler' TERM

if [[ -f "config/playit.toml" ]]; then
  echo "Start playit! ..."
  $playit --secret_path config/playit.toml &
  pid="$!"
else
  echo "Config not found, sleeping..."
  sleep infinity &
  pid="$!"
fi

while :; do
    tail -f /dev/null & wait ${!}
done
