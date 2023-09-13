@echo OFF




:: VARIABLES START

set deviceName=Microphone (High Definition Audio Device)
set password=hackme
set port=8000

:: VARIABLES END




echo Leave this window open to keep FFMPEG running and, if necessary, minimize it.
echo .

ffmpeg.exe -ac 1 -f dshow -i audio="%deviceName%" -tune zerolatency -acodec libmp3lame -ab 32k -ac 1 -content_type audio/mpeg -f mp3 icecast://source:%password%@localhost:%port%/domlive

echo .
echo .
echo .

echo --------------------------------------------				
echo    Press any key to close this window ...    										 	
echo --------------------------------------------


pause>nul