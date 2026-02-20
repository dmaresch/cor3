@echo off
setlocal enabledelayedexpansion

:loop
echo [%date% %time%] Starting ffmpeg...

ffmpeg ^
  -reconnect 1 ^
  -reconnect_streamed 1 ^
  -reconnect_delay_max 30 ^
  -reconnect_at_eof 1 ^
  -fflags +discardcorrupt ^
  -err_detect ignore_err ^
  -i "https://radio-corie.cor3.gg/0a7e" ^
  -map a ^
  -vn -sn -dn ^
  -c copy ^
  -f segment ^
  -segment_time 300 ^
  -reset_timestamps 1 ^
  -strftime 1 ^
  -reset_timestamps 1 "155mhz_segments/stream_%%Y-%%m-%%d_%%H-%%M-%%S.mp3"

echo [%date% %time%] ffmpeg exited with code %ERRORLEVEL%
echo Restarting in 2 seconds...
timeout /t 2 /nobreak >nul
goto loop
