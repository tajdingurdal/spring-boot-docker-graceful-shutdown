#!/bin/bash

# This function defines what to do when a SIGTERM signal is caught. It checks if the process with the process ID (pid) is running, and if it is, it sends a SIGTERM signal to it and waits for it to terminate before exiting with a specific exit code (143).
term_handler() {
  if [ $pid -ne 0 ]; then
    echo "Process with PID $pid is closing..."
    kill -SIGTERM "$pid"
    wait "$pid"
    echo "Process with PID $pid has been terminated"
  else
    echo "No valid PID found. Exiting..."
  fi
  exit 143 # 128 + 15 -- SIGTERM
}

# This line sets up a trap for the SIGTERM signal. When a SIGTERM signal is received, it runs the term_handler function.
trap 'kill ${!}; term_handler' SIGTERM

cd /srv/"$APP" || exit

# This line starts the Spring Boot application with the specified JAVA_OPTS and binds it to the specified PORT. The process runs in the background, and its process ID is stored in the variable pid.
java -jar /app/app.jar &
pid="$!"

# The last part is an infinite loop that continuously checks if the Java application is still running every 5 seconds.
# If the process is not running, it prints a message and calls the term_handler function to terminate the script properly. It’s important because if the script were to end, the Docker container would stop.
while true; do
  # Check if process is still running
  kill -0 "$pid" 2>/dev/null
  if [ $? -ne 0 ]; then
    echo "Process $pid is not running, shutting down the container."
    term_handler
  fi

  sleep 5
done