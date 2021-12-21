---
title: SDWRITE
section: 1
header: User Manual
footer: sdwrite 4.0
date: December 21, 2021
---
# NAME
**sdwrite** - Write an SD card

# SYNOPSIS
**sdwrite** [ **-u** ] [ **-n** ] [ **-i** filename ] [ **-d** disk# ]"

# DESCRIPTION
Write an SD card. An input image to be written to the SD card, specified
by the *-i filename* option, is required.

Tries to detect the SD card device. If device is not detected or configured
properly *sdwrite* will inform the user and the appropriate *-d disk#*
option can be supplied. 

Options to the **dd** command are provided by *sdwrite* to optimize write speed.

# COMMAND LINE OPTIONS
**-u**
: display usage message

**-n**
: tell what you would do without doing anything

**-d disk#**
: specify disk device number to erase

**-i filename**
: specify input file name

# EXAMPLES
**sdwrite -d disk4 -i image.iso**
: Write image file *image.iso* to the SD card on /dev/rdisk4

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
SDWRITE is distributed under an Open Source license.
See the file LICENSE in the SDWRITE source distribution
for information on terms &amp; conditions for accessing and
otherwise using SDWRITE and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
**sdbackup**(1), **sderase**(1), **sdrestore**(1)

Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

