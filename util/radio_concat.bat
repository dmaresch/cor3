dir /b /on *.mp3 > list.tmp
(for /f "usebackq delims=" %%i in ("list.tmp") do @echo file '%%i') > concat.txt
ffmpeg -f concat -safe 0 -i concat.txt -c copy full_recording.mp3