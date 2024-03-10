# Building: podman build -t lichess_streamer:latest .
# Running: podman run --env-file twitch_key.sh lichess_streamer:latest
FROM alpine:3.19.1
# Use a mirror close by, the default CDN keeps timing out for me.
ADD repositories /etc/apk/repositories
RUN apk add --no-cache firefox ffmpeg xvfb xdotool
ADD stream.sh run.sh /root
WORKDIR /root
ENTRYPOINT [ "sh", "run.sh" ]
