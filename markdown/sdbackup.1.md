---
title: SDBACKUP
section: 1
header: User Manual
footer: sdbackup 4.0
date: December 06, 2021
---
# NAME
**sdbackup** - Backup an SD card to an image file

# SYNOPSIS
**sdbackup** [ **-u** ] [ **-n** ] [ **-o** filename ] [ **-z** ] [ **-d** disk# ]"

# DESCRIPTION
Tries to detect the SD card device. If device is not detected or configured properly *sdbackup* will inform the user and the appropriate *-d disk#* option can be supplied. Options to the **dd** command are provided by *sdbackup* to optimize backup speed.

# COMMAND LINE OPTIONS
**-u**
: display usage message

**-n**
: tell what you would do without doing anything

**-z**
: compress the output with zip

**-o filename**
: specify output file name

**-d disk#**
: specify disk device number to read

# EXAMPLES
**sdbackup -o sdback_20211204.iso -d disk4**
: Backup the SD card on /dev/rdisk4 to the file sdback_20211204.iso

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
SDBACKUP is distributed under an Open Source license.
See the file LICENSE in the SDBACKUP source distribution
for information on terms &amp; conditions for accessing and
otherwise using SDBACKUP and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
**sderase**(1), **sdlist**(1), **sdrestore**(1), **sdwrite**(1)

Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

