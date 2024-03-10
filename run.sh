#!/bin/sh
# Maybe use supervisord instead to start the two background tasks.
Xvfb :1 -screen 0 1920x1080x24 &
firefox --kiosk https://lichess.org/tv --display=:1 &

# Resize firefox to take the full view.
DISPLAY=:1 xdotool search --name ".*Mozilla Firefox" windowsize 1920 1080

sh stream.sh
