---
title: SDMOUNT
section: 1
header: User Manual
footer: sdmount 4.0
date: January 23, 2022
---
# NAME
**sdmount** - Mount an SD card

# SYNOPSIS
**sdmount** [ **-u** ] [ **-n** ] [ **-d** disk# ]"

# DESCRIPTION
Mount an SD card. Tries to detect the SD card device. If device is not detected
or configured properly *sdmount* will inform the user and the appropriate *-d disk#*
option can be supplied. 

# COMMAND LINE OPTIONS
**-u**
: display usage message

**-n**
: tell what you would do without doing anything

**-d disk#**
: specify disk device name to mount

# EXAMPLES
**sdmount -d disk4**
: Mount the SD card on /dev/disk4 or /dev/rdisk4 on Mac OS X

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
SDMOUNT is distributed under an Open Source license.
See the file LICENSE in the SDMOUNT source distribution
for information on terms &amp; conditions for accessing and
otherwise using SDMOUNT and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
**sdbackup**(1), **sdlist**(1), **sdrestore**(1), **sdumount**(1), **sdwrite**(1)

Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

