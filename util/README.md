# misc/
This folder contains additional tooling for the ARG that aren't files from the ARG itself. 

### radio_capture.bat
This script requires [FFMPEG](https://www.ffmpeg.org/download.html) to function. This script is used to pull the constant Icecast radio streams from cor3. This script purposefully discards corrupt mp3 frames, as it causes the capture to fail. It purposefully reconnects on EOF, as many of the radio segments were returing false EOFs. On line 14, update the name of the station to what was found on the Radio tool in game, eg. 0a7e. On line 22, update the frequency to be the in game frequency of the radio, eg. 155. You'll need to manually create the output folder of "155mhz_segments" at that time. The script, under perfect circumstances, will run indefinitely until ended, splitting streams at EOF or every 5 minutes.

### radio_concat.bat
This script requires [FFMPEG](https://www.ffmpeg.org/download.html) to function. This script is used to combine all the segmented audio from pieces from the radio_capture script. Drop this script into the folder of segments, run it, and you will have a fully combined mp3 of the recording.
