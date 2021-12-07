---
title: SDERASE
section: 1
header: User Manual
footer: sderase 4.0
date: December 06, 2021
---
# NAME
**sderase** - Erase an SD card

# SYNOPSIS
**sderase** [ **-u** ] [ **-n** ] [ **-d** disk# ]"

# DESCRIPTION
Erase an SD card. Tries to detect the SD card device. If device is not detected
or configured properly *sderase* will inform the user and the appropriate *-d disk#*
option can be supplied. 

# COMMAND LINE OPTIONS
**-u**
: display usage message

**-n**
: tell what you would do without doing anything

**-d disk#**
: specify disk device number to erase

# EXAMPLES
**sderase -d disk4**
: Erase the SD card on /dev/rdisk4

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
SDERASE is distributed under an Open Source license.
See the file LICENSE in the SDERASE source distribution
for information on terms &amp; conditions for accessing and
otherwise using SDERASE and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

