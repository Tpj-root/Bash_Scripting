#!/bin/bash

sleep 5
word="HELLO"

for i in {1..100}; do
    xdotool type "$word"
    xdotool key Return
    sleep 0.5  # Adjust the delay if needed
done
