# LiveStreamRadio for AzuraCast
This is a modified version of [Noni's LiveStreamRadio](https://github.com/NoniDOTio/LiveStreamRadio). My main idea was to ditch mpg123 and use [AzuraCast](https://github.com/AzuraCast/AzuraCast) mainly because of some technical issues of mpg123 or aac codecs (still not sure) but the sound was terrible, so I gave it a try to AzuraCast and it was a lot better -> not only for the fixed sound problems but it's a well-designed radio station management service. So in general, I just removed Noni's player service and added a way to set the audio source from almost any MP3 radio stream (it can be a local AzuraCast, Icecast, or anything you can imagine - even also remote radio URL). And now it uses libmp3lame instead of aac.

The core design of Noni's LiveStreamRadio is very nice: 
+ Lightweight (uses very small resources)
+ You can add as many stream URLs as you want (Youtube, Twitch, etc)
+ Easy to start, restart or stop your streams
+ Great error-handling solutions (if there is a crash, it will restart itself)

Well, because of using vcodec copy inside the FFMPEG instance, the bitrate depends on the copied video resource: so pretty sure you will get errors from any streaming platforms that the connection is unstable. Other than some connection warnings, I had no problems with Twitch and Youtube.

## Dependencies
Install the following software on your machine: 
+ screen 
+ alsa
+ libmp3lame

## Installation
Clone this repository
```bash
git clone git@github.com:LeFizzy/LiveStreamRadio.git
```

## How To Use
-- you may need to "chmod +x" all the script files in order to use/run them.

```bash
./lsr.sh --start
```
