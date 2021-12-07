---
title: SDRESTORE
section: 1
header: User Manual
footer: sdrestore 4.0
date: December 06, 2021
---
# NAME
**sdrestore** - Restore an SD card from an image file

# SYNOPSIS
**sdrestore** [ **-u** ] [ **-n** ] [ **-i** filename ] [ **-D date** ] [ **-d** disk# ]"

# DESCRIPTION
Attempts to locate the image file to use by combining the provided *filename*
and *date*. If backup file names were saved in the format *filename-date.iso*
where *date* was generated using the **date** command **date "+%Y%m%d"** then
*sdrestore* can automatically locate the file to use for the SD card restore.

Tries to detect the SD card device to use. If device is not detected or configured properly *sdrestore* will inform the user and the appropriate *-d disk#* option can be supplied. Options to the **dd** command are provided by *sdrestore* to optimize restore speed.

Compressed backups, either with gzip or zip, are automatically detected and
uncompressed prior to restoring.

# COMMAND LINE OPTIONS
**-u**
: display usage message

**-n**
: tell what you would do without doing anything

**-D date**
: specify the *date* string to use when looking for backup filename *filename-date.iso*

**-i filename**
: specify input file name

**-d disk#**
: specify disk device number to read

# EXAMPLES
**sdrestore -i sdback_20211204.iso -d disk4**
: Restore the SD card on /dev/rdisk4 from the file sdback_20211204.iso

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
SDRESTORE is distributed under an Open Source license.
See the file LICENSE in the SDRESTORE source distribution
for information on terms &amp; conditions for accessing and
otherwise using SDRESTORE and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

