---
title: CAP2MP4
section: 1
header: User Manual
footer: cap2mp4 4.0
date: December 05, 2021
---
# NAME
cap2mp4 - Capture from media device and save audio/video in MP4 video file format

# SYNOPSIS

**cap2mp4** [ **-a** audio codec ] [ **-v** video codec ] [ **-c** codec ] [ **-p** preset ] [ **-V** screen device index ] [ **-A** audio device index ] [ **-o** output format (lower case) ] [ **-O** output filename no suffix ] [ **-q** scale ] [ **-r** rate ] [ **-b** audio bitrate ] [ **-z** video bitrate ] [ **-s** size ] [ **-t** threads ] [ **-I** ] [ **-C** ] [ **-d** ] [ **-D** ] [ **-y** ] [ **-u** ]

# DESCRIPTION
Captures, converts, and saves audio and video from a media device to MP4 video file format. Input device can be specified on the command line. **cap2mp4** is a convenience link to **cap2any** and behaves exactly as if it were invoked as **cap2any** with the *-o mp4* option.

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

**-I **
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

# EXAMPLES

**cap2mp4**
: The most common use is capture using the default parameters

**cap2mp4 -s 640x480**
: Specify output video size of 640 width by 480 height

**cap2mp4 -v libx264 -p ipod640**
: Specify libx264 output video codec and use ipod640 preset

**cap2mp4 -b 512k -I**
: Specify 512k bitrate and add capture file to Apple Music

**cap2mp4 -v libx264 -r 0 -q 3**
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
CAP2MP4 is distributed under an Open Source license.
See the file LICENSE in the CAP2MP4 source distribution
for information on terms &amp; conditions for accessing and
otherwise using CAP2MP4 and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
**cap2any**(1), **cap2mp4**(1)

Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

