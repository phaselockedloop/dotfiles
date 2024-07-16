#!/bin/zsh

# Function to retry a command until it succeeds
retry_until_success() {
  local command="$@"
  local exit_code=1

  while [[ $exit_code -ne 0 ]]; do
    eval $command
    exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
      echo "Command failed with exit code $exit_code. Retrying..."
      sleep 1  # Optional: wait for 1 second before retrying
    fi
  done

  echo "Command succeeded!"
}

# Check if a command is provided
if [[ $# -eq 0 ]]; then
  echo "Usage: $0 <command>"
  exit 1
fi

# Call the function with the provided command
retry_until_success "$@"
