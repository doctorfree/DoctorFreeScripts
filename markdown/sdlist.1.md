---
title: SDLIST
section: 1
header: User Manual
footer: sdlist 4.0
date: January 23, 2022
---
# NAME
**sdlist** - List SD card device info

# SYNOPSIS
**sdlist** [ **-u** ]

# DESCRIPTION
List SD card device info. Attempts to detect the SD card device. If device is
not detected or configured properly *sdlist* will list all disk devices and
inform the user no device was detected. If a FAT32 device is located then
*sdlist* will display info for that device.

# COMMAND LINE OPTIONS
**-u**
: display usage message

# EXAMPLES
**sdlist**
: List SD card device info if any are found

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
SDLIST is distributed under an Open Source license.
See the file LICENSE in the SDLIST source distribution
for information on terms &amp; conditions for accessing and
otherwise using SDLIST and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
**sdbackup**(1), **sderase**(1), **sdrestore**(1), **sdwrite**(1)

Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

