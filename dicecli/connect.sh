#!/bin/bash

# Get the arguments
host=$1
port=${2:-7379} # Default to 7379 if not provided
timeout=5       # Set a timeout in seconds

# Get the host type from the environment variable
host_type=${HOST_TYPE:-linux}

# Validate host type
if [[ "$host_type" != "linux" && "$host_type" != "windows" && "$host_type" != "macos" ]]; then
    echo "Invalid HOST_TYPE: $host_type. Valid values are 'linux', 'windows', or 'macos'."
    exit 1
fi

# Determine the host IP address if not provided
if [ -z "$host" ]; then
    if [ "$host_type" = "linux" ]; then
        # Try to get the host IP address using `ip route show` (works on Linux)
        host=$(ip route show | awk '/default/ {print $3}')
    else
        # Fallback to host.docker.internal (works on macOS and Windows)
        host="host.docker.internal"
    fi
fi

# log host_type and host and port used
echo "Using Host: $host"
echo "Using Port: $port"
echo "Host Type: $host_type"

# Check if the port is open on the host
if nc -zv "$host" "$port" -w "$timeout"; then
    echo "Port $port on $host is open."
else
    echo "Port $port on $host is not open."
    exit 1
fi

# Activate the virtual environment
source /venv/bin/activate

# Print the path of the Python interpreter
which python

# Run the dice command with the provided or determined host and port
dice -h "$host" -p "$port"

