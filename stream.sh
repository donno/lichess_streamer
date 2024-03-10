#!/bin/sh
# Load the stream key from a file if present.
#
# If running as a container instead use --env-file and use your twitch_key.sh
# as the env file instead.
[ -e twitch_key.sh ] && . twitch_key.sh

ENDPOINT=rtmp://syd02.contribute.live-video.net/app/$STREAM_KEY
INPUT="-f x11grab -framerate 25 -video_size hd1080 -i :1.0"
OUTPUT="-vcodec libx264 -b:v 5M -acodec aac -b:a 256k -f flv $ENDPOINT"
ffmpeg $INPUT $OUTPUT
