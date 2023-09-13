# Stream Input Device Over Internet
Example for streaming audio from input device to http stream using **FFMPEG** and **Icecast**.  This example is for windows.


## Icecast

#### Installing Icecast
1. Go to [Icecast Downloads Page](https://icecast.org/download/) and download Icecast for windows.
2. Install Icecast using downloaded *.exe* file.

#### Configuring Icecast
In Icecast install folder (default: `C:\Program Files (x86)\Icecast`) is configuration file `icecast.xml`. 
Most settings have comments with explanations. Important settings are passwords under `<authentication>` category.
Number of listeners  and imput sources can be changed under `<limits>` category.


## FFMPEG

#### Installing FFMPEG
Install FFMPEG using this turorial: [Installing FFmpeg on Windows](https://phoenixnap.com/kb/ffmpeg-windows).

After installing FFMPEG we need to download `ffmpegStart.bat` from this repository.
- If FFMPEG was added to **PATH** environment variable, location of this file is not important.
- If FFMPEG was not added to **PATH** environment variable, save `ffmpegStart.bat` to `bin` folder in ffmpeg installation folder. 

> *If FFMPEG was added to **PATH**, best location for `ffmpegStart.bat` is in Icecast installation folder, because you can start everything from same location.*

#### Finding input device
To list all avaliable input devices we need to run command `ffmpeg -list_devices true -f dshow -i dummy`. Example command output:
```cmd
...
libswscale      5.  8.100 /  5.  8.100
libswresample   3.  8.100 /  3.  8.100
libpostproc    55.  8.100 / 55.  8.100
[dshow @ 0000025c1607dac0] DirectShow video devices (some may be both video and audio devices)
[dshow @ 0000025c1607dac0]  "OBS Virtual Camera"
[dshow @ 0000025c1607dac0]     Alternative name "@device_sw_{860BB310-5D01-11D0-BD3B    -00A0C911CE86}\{A3FCE0F5-3493-419F-958A-ABA1250EC20B}"
[dshow @ 0000025c1607dac0]  "Microphone (High Definition Audio Device)"
[dshow @ 0000025c1607dac0]     Alternative name "@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{FA843586-EDF3-43AE-AB9D-E8AA2429F0D7}"
dummy: Immediate exit requested
```
We need to copy name for device we want to stream from (for example: `Microphone (High Definition Audio Device)`). 

#### Editing `ffmpegStart.bat` file

In `ffmpegStart.bat` file there are 3 variables (*defined between VARIABLES START and VARIABLES END*):
- **deviceName**: device copied in previous step (without quotex)
- **password**: password defined in `icecast.xml` in attribute `<source-password>`
- **port**: port defined in `icecast.xml` in attribute `<port>`

> **Important**: spaces around equal sign will cause errors. Correct variable definition: `variable=My variable` 

## Starting Stream

> **Important**: Icecast must be started before FFMPEG.

#### Starting Icecast
Icecast can be started via `icecast.bat`, located in Icecast installation folder.

#### Starting FFMPEG
FFMPEG can be started via `ffmpegStart.bat`.

## Listening to stream

After starting both Icecast and FFMPEG, stream will be available at: `http://localhost:8000/`. Tihs port can be port forwarded and then accessed from everywhere at: `http://your-public-ip:8000/`