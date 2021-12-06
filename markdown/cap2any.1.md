---
title: CAP2ANY
section: 1
header: User Manual
footer: cap2any 4.0
date: December 05, 2021
---
# NAME
cap2any - Capture from media device and save audio/video in any format

# SYNOPSIS

**cap2any** [ **-a** audio codec ] [ **-v** video codec ] [ **-c** codec ] [ **-p** preset ] [ **-V** screen device index ] [ **-A** audio device index ] [ **-o** output format (lower case) ] [ **-O** output filename no suffix ] [ **-q** scale ] [ **-r** rate ] [ **-b** audio bitrate ] [ **-z** video bitrate ] [ **-s** size ] [ **-t** threads ] [ **-I** ] [ **-C** ] [ **-d** ] [ **-D** ] [ **-y** ] [ **-u** ]

# DESCRIPTION
Captures, converts, and saves audio and video from a media device. Input device and output format can be specified on the command line. Convenience links can be created to simplify capture to various formats. When invoked as the link *cap2yyy*, **cap2any** converts and saves the capture in media format *YYY*.

The convenience links to *cap2any* that are installed by default are:

- cap2m4v - Capture and convert to M4V
- cap2mp4 - Capture and convert to MP4

Additional convenience links can be created by creating a new symbolic link
to *cap2any*. For example, to create a convenience link that captures and
converts to AVI video format, issue the following commands:

```bash
cd /usr/local/bin
sudo ln -s /usr/local/DoctorFreeScript/bin/cap2any cap2avi
```

# COMMAND LINE OPTIONS

**-d**
: indicates tell me what you would do

**-C**
: indicates use the character interface, ignore AppleScript

**-D**
: indicates use default audio and video devices, don't prompt

**-o output format**
: specifies the 3 letter lower case output format

**-O output filename**
: specifies the output filename without suffix

**-a audio codec**
: specifies the output audio codec

**-v video codec**
: specifies the output video codec

**-s size**
: specifies the output video size (widthxheight)

**-c codec**
: specifies the output codec

**-I**
: indicates add the captured file to Apple Music

**-p preset**
: specifies the ffmpeg preset to use
	 Useful presets:
	 ultrafast superfast veryfast faster fast medium slow
	 slower veryslow. Default preset is 'slow'

**-q scale**
: specifies the qscale variable bit rate quality

**-r rate**
: specifies the rate for Constant Rate Factor (CRF)
	encoding. Use "-r 0" to disable for formats other than x264

**-b bitrate**
: specifies the bitrate (default 128k)

**-t threads**
: specifies the number of threads to use

**-y**
: indicates overwrite output files without asking

**-u**
: displays this usage message

Current invocation defaults to:

`/usr/local/bin/ffmpeg -f avfoundation -i :   -loglevel warning -strict -2 -vsync 2  /Users/doctorwhen/Movies/ScreenCaps/MP4/capture_40163.mp4`

# EXAMPLES

**cap2any**
: The most common use is capture using the default parameters

**cap2any -s 640x480**
: Specify output video size of 640 width by 480 height

**cap2any -v libx264 -p ipod640**
: Specify libx264 output video codec and use ipod640 preset

**cap2any -b 512k -I**
: Specify 512k bitrate and add capture file to Apple Music

**cap2any -v libx264 -r 0 -q 3**
: Specify libx264 output video codec and variable bit rate

# REQUIREMENTS
This command is basically a wrapper script for **ffmpeg**. To install 
**ffmpeg**, issue the following command:

**Debian Linux**
: sudo apt install ffmpeg

**Fedora/CentOS/SuSE Linux**
: sudo yum install ffmpeg

**Mac OS X**
: brew install ffmpeg

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
CAP2ANY is distributed under an Open Source license.
See the file LICENSE in the CAP2ANY source distribution
for information on terms &amp; conditions for accessing and
otherwise using CAP2ANY and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
**cap2m4v**(1), **cap2mp4**(1)

Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

