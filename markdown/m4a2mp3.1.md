---
title: M4A2MP3
section: 1
header: User Manual
footer: m4a2mp3 4.0
date: December 05, 2021
---
# NAME
m4a2mp3 - Convert M4A format media file to MP3 format media file

# SYNOPSIS
**m4a2mp3** [ **-a** audio codec ] [ **-v** video codec ] [ **-c** codec ] [ **-p** preset ] [ **-i** input format (lower case) ] [ **-o** output format (lower case) ] [ **-q** scale ] [ **-r** rate ] [ **-b** audio bitrate ] [ **-z** video bitrate ] [ **-s** size ] [ **-t** threads ] [ **-I** ] [ **-d** ] [ **-y** ] [ **-u** ] file1 [file2 ...]

# DESCRIPTION
Converts audio and video media files from M4A format to MP3 format. **m4a2mp3** is a convenience link to **any2any** that behaves exactly as if **any2any** were invoked with the *-i m4a* and *-o mp3* options.

# COMMAND LINE OPTIONS

**-d**
: indicates tell me what you would do

**-a audio-codec**
: specifies the output audio codec

**-v video-codec**
: specifies the output video codec

**-s size**
: specifies the output video size (widthxheight)

**-c codec**
: specifies the output codec

**-I**
: indicates add the converted file to Apple Music

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

`ffmpeg -i INPUT -loglevel warning -strict -2 -vcodec libx264 -preset slow  -crf 23 -ab 128k  -threads 0 OUTPUT`

# EXAMPLES

**m4a2mp3 example.m4a**
: The most common use is conversion using the default parameters

**m4a2mp3 -c copy example.m4a**
: Copy audio and video codecs, convert the container

**m4a2mp3 -s 640x480 example.m4a**
: Specify output video size of 640 width by 480 height

**m4a2mp3 -v libx264 -p ipod640 example.m4a**
: Specify libx264 output video codec and use ipod640 preset

**m4a2mp3 -b 512k -I example.m4a**
: Specify 512k bitrate and add converted file to Apple Music

**m4a2mp3 -v libx264 -r 0 -q 3 example.m4a**
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
M4A2MP3 is distributed under an Open Source license.
See the file LICENSE in the M4A2MP3 source distribution
for information on terms &amp; conditions for accessing and
otherwise using M4A2MP3 and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
**any2any**(1), **ape2mp4**(1), **avi2mp4**(1), **f4v2mp4**(1), **flv2mp4**(1), **m4a2mp3**(1), **m4v2mp4**(1), **mkv2mp4**(1), **mov2mp4**(1), **mp42m4v**(1), **mpg2mp4**(1), **png2jpg**(1), **wma2m4a**(1), **wmv2m4v**(1), **wmv2mp4**(1)

Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

