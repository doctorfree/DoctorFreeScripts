---
title: SDUMOUNT
section: 1
header: User Manual
footer: sdumount 4.0
date: January 23, 2022
---
# NAME
**sdumount** - Unmount an SD card

# SYNOPSIS
**sdumount** [ **-u** ] [ **-n** ] [ **-d** disk# ]"

# DESCRIPTION
Unmount an SD card. Tries to detect the SD card device. If device is not detected
or configured properly *sdumount* will inform the user and the appropriate *-d disk#*
option can be supplied. 

# COMMAND LINE OPTIONS
**-u**
: display usage message

**-n**
: tell what you would do without doing anything

**-d disk#**
: specify disk device name to unmount

# EXAMPLES
**sdumount -d disk4**
: Unmount the SD card on /dev/disk4 or /dev/rdisk4 on Mac OS X

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
SDUMOUNT is distributed under an Open Source license.
See the file LICENSE in the SDUMOUNT source distribution
for information on terms &amp; conditions for accessing and
otherwise using SDUMOUNT and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
**sdbackup**(1), **sdlist**(1), **sdrestore**(1), **sdmount**(1), **sdwrite**(1)

Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

