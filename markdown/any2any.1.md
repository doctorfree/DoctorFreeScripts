---
title: ANY2ANY
section: 1
header: User Manual
footer: any2any 4.0
date: December 05, 2021
---
# NAME
any2any - Convert any format media file to any other format media file

# SYNOPSIS
**any2any** [ **-a** audio codec ] [ **-v** video codec ] [ **-c** codec ] [ **-p** preset ] [ **-i** input format (lower case) ] [ **-o** output format (lower case) ] [ **-q** scale ] [ **-r** rate ] [ **-b** audio bitrate ] [ **-z** video bitrate ] [ **-s** size ] [ **-t** threads ] [ **-I** ] [ **-d** ] [ **-y** ] [ **-u** ] file1 [file2 ...]

# DESCRIPTION
Converts audio and video media files from one format to another format. Input and output formats can be specified on the command line. Convenience links can be created to simplify conversion between formats. When invoked as the link *xxx2yyy*, **any2any** converts from media format *XXX* to media format *YYY*.

The convenience links to *any2any* that are installed by default are:

- ape2m4a - convert from APE format to M4A
- ape2mp4 - convert from APE format to MP4
- avi2mp4 - convert from AVI format to MP4
- f4v2mp4 - convert from F4V format to MP4
- flv2mp4 - convert from FLV format to MP4
- m4a2mp3 - convert from M4A format to MP3
- m4v2mp4 - convert from M4V format to MP4
- mkv2mp4 - convert from MKV format to MP4
- mov2mp4 - convert from MOV format to MP4
- mp42m4v - convert from MP4 format to M4V
- mpg2mp4 - convert from MPG format to MP4
- png2jpg - convert from PNG format to JPG
- wma2m4a - convert from WMA format to M4A
- wmv2m4v - convert from WMV format to M4V
- wmv2mp4 - convert from WMV format to MP4

Additional convenience links can be created by creating a new symbolic link
to *any2any*. For example, to create a convenience link that converts WMA format
audio files to MP3 audio files, issue the following commands:

```bash
cd /usr/local/bin
sudo ln -s /usr/local/DoctorFreeScript/bin/any2any wma2mp3
```

# COMMAND LINE OPTIONS

**-d**
: indicates tell me what you would do

**-i**
: input format specifies the 3 letter lower case input format

**-o**
: output format specifies the 3 letter lower case output format

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

**any2any WMV/example.mp4**
: The most common use is conversion using the default parameters

**any2any -c copy WMV/example.mp4**
: Copy audio and video codecs, convert the container

**any2any -s 640x480 WMV/example.mp4**
: Specify output video size of 640 width by 480 height

**any2any -v libx264 -p ipod640 WMV/example.mp4**
: Specify libx264 output video codec and use ipod640 preset

**any2any -b 512k -I WMV/example.mp4**
: Specify 512k bitrate and add converted file to Apple Music

**any2any -v libx264 -r 0 -q 3 WMV/example.mp4**
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
ANY2ANY is distributed under an Open Source license.
See the file LICENSE in the ANY2ANY source distribution
for information on terms &amp; conditions for accessing and
otherwise using ANY2ANY and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
**ape2m4a**(1), **ape2mp4**(1), **avi2mp4**(1), **f4v2mp4**(1), **flv2mp4**(1), **m4a2mp3**(1), **m4v2mp4**(1), **mkv2mp4**(1), **mov2mp4**(1), **mp42m4v**(1), **mpg2mp4**(1), **png2jpg**(1), **wma2m4a**(1), **wmv2m4v**(1), **wmv2mp4**(1)

Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

