#!/bin/bash

prog="gedit"
class="gedit"

# Define workspaces (1-based index)
dis1=1  # Workspace 2
dis2=2  # Workspace 3
dis3=3  # Workspace 4

echo "Starting $prog instances..."

# Function to launch gedit and move to workspace
launch_and_move() {
    $prog &
    pid=$!
    sleep 2  # Allow time for the window to appear

    # Wait until the window is detected
    while true; do
        wid=$(xdotool search --onlyvisible --pid $pid 2>/dev/null | tail -1)
        if [ -n "$wid" ]; then
            break
        fi
        sleep 0.5
    done

    echo "Moving Gedit to workspace $(( $1 + 1 ))"
    xdotool set_desktop_for_window "$wid" "$1"
}

# Launch Gedit instances
launch_and_move $dis1
launch_and_move $dis2
launch_and_move $dis3

echo "All Gedit instances are placed in their respective workspaces."
