lichess_streamer
================

Builds a container for streaming Lichess TV to Twitch.

Usage
-----
* Save your Twitch API key in a file called twitch.env outside the repo, in the
  form:
  ```
  STREAM_KEY=live_keygoes here
  ```
* Build the container image
  ```
  podman build -t lichess_streamer:latest .
  ```
* Run the container image
  ```
  podman run --env-file ../twitch.env lichess_streamer:latest
  ```

Contents
--------

- Base image is Alpine Linux
- Mozilla Firefox - This is essentially the video source for our stream.
- ffmpeg - This is video capture, transcoding and transmitting of the source to
  Twitch.
- Xvfb - A X virtual framebuffer which is a display server implementing the X11
  display server protocol. This is what Firefox is drawn too and what ffmpeg
  will capture from.
- xdotool - Resize Firefox to be full screen, it seems while kiosk mode is meant
  to make it full screen, the lack of a window manager seems to be stopping it.

Notes
-----

There were a few things I still need to look at.

* Make the 'browser's address configurable to make it a more general.
* Possibly in my example I could avoid adding the repositories to the container
  and instead use the `--repository` command line argument of `apk add`.
* Allow the ENDPOINT to be configured via envfile as well.
  See [Recommended Ingest Endpoints For You][3] page in the Twitch help for
  list of endpoints.
* The libx264 usage seems to prevent Mozilla Firefox from being able to view
  the stream, I have to use Microsoft Edge to view it instead.
* If the Xvfb set-up could be baked into the image so it always loads on
  start-up that would be nice.
* Remove the menu bar and Previously on Lichess TV text. I originally attempted
  this with a Python script using Selenium and then again with a TamperMonkey
  script which worked well except at the end of the match where the page
  essentially reloads, they come back.

### Features

* Update the stream description to mention who is playing. This involves
  detecting when the game finishes and hit an API call on Twitch.
* Post in chat the link for the completed match so viewers can use the analysis
  tools from Lichess' website.

### Fixes
- Enable the game sounds - Firefox has blocked them by default and I am not
  sure how to re-enable them without a mouse and interactive session.