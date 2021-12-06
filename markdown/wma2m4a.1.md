---
title: WMA2M4A
section: 1
header: User Manual
footer: wma2m4a 4.0
date: December 05, 2021
---
# NAME
wma2m4a - Convert WMA format media file to M4A format media file

# SYNOPSIS
**wma2m4a** [ **-a** audio codec ] [ **-v** video codec ] [ **-c** codec ] [ **-p** preset ] [ **-i** input format (lower case) ] [ **-o** output format (lower case) ] [ **-q** scale ] [ **-r** rate ] [ **-b** audio bitrate ] [ **-z** video bitrate ] [ **-s** size ] [ **-t** threads ] [ **-I** ] [ **-d** ] [ **-y** ] [ **-u** ] file1 [file2 ...]

# DESCRIPTION
Converts audio and video media files from WMA format to M4A format. **wma2m4a** is a convenience link to **any2any** that behaves exactly as if **any2any** were invoked with the *-i wma* and *-o m4a* options.

# COMMAND LINE OPTIONS

**-d**
: indicates tell me what you would do

**-a**
: audio codec specifies the output audio codec

**-v**
: video codec specifies the output video codec

**-s**
: size specifies the output video size (widthxheight)

**-c**
: codec specifies the output codec

**-I**
: indicates add the converted file to Apple Music

**-p**
: preset specifies the ffmpeg preset to use
	 Useful presets:
	 ultrafast superfast veryfast faster fast medium slow
	 slower veryslow. Default preset is 'slow'

**-q**
: scale specifies the qscale variable bit rate quality

**-r**
: rate specifies the rate for Constant Rate Factor (CRF)
	encoding. Use "-r 0" to disable for formats other than x264

**-b**
: bitrate specifies the bitrate (default 128k)

**-t**
: threads specifies the number of threads to use

**-y**
: indicates overwrite output files without asking

**-u**
: displays this usage message

Current invocation defaults to:

`ffmpeg -i INPUT -loglevel warning -strict -2 -vcodec libx264 -preset slow  -crf 23 -ab 128k  -threads 0 OUTPUT`

# EXAMPLES

**wma2m4a example.wma**
: The most common use is conversion using the default parameters

**wma2m4a -c copy example.wma**
: Copy audio and video codecs, convert the container

**wma2m4a -s 640x480 example.wma**
: Specify output video size of 640 width by 480 height

**wma2m4a -v libx264 -p ipod640 example.wma**
: Specify libx264 output video codec and use ipod640 preset

**wma2m4a -b 512k -I example.wma**
: Specify 512k bitrate and add converted file to Apple Music

**wma2m4a -v libx264 -r 0 -q 3 example.wma**
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
WMA2M4A is distributed under an Open Source license.
See the file LICENSE in the WMA2M4A source distribution
for information on terms &amp; conditions for accessing and
otherwise using WMA2M4A and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
**any2any**(1), **ape2mp4**(1), **avi2mp4**(1), **f4v2mp4**(1), **flv2mp4**(1), **m4a2mp3**(1), **m4v2mp4**(1), **mkv2mp4**(1), **mov2mp4**(1), **mp42m4v**(1), **mpg2mp4**(1), **png2jpg**(1), **ape2m4a**(1), **wmv2m4v**(1), **wmv2mp4**(1)

Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

