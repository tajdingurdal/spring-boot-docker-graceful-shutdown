#!/bin/sh
set -x
pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    echo "Process with PID $pid is closing..."
    kill -SIGTERM "$pid"
    wait "$pid"
    echo "Process with PID $pid has been terminated"
  else
    echo "No valid PID found. Exiting..."
  fi
  exit 143
}

# Register signal handlers
trap 'kill ${!}; term_handler' SIGTERM

# Start Spring Boot application
java -jar /app/app.jar &
pid="$!"

# Keep the container alive
while true
do
  tail -f /dev/null & wait ${!}
done