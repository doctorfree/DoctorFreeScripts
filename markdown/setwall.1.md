---
title: SETWALL
section: 1
header: User Manual
footer: setwall 4.0
date: December 06, 2021
---
# NAME
**setwall** - Set the desktop wallpaper

# SYNOPSIS
**setwall** [ **-arsu** ] [ **-d** /path/to/imagedir ] [ **-p** picture ] [ **-n** num ]

# DESCRIPTION
Sets the desktop wallpaper. Can be used to change wallpapers at a specified interval, set different wallpapers on selected desktops or all desktops, rotate through multiple desktop wallpapers, and specify desktop by number. On Mac OS X systems AppleScript is used to provide a graphical user interface.

# COMMAND LINE OPTIONS
**-a**
: specifies set wallpaper on all desktops/displays

**-d directory**
: specifies the image directory to use

**-i interval**
: seconds between desktop wallpaper changes

**-p picture**
: specifies the image file to use

**-n num**
: specifies the desktop number to use

**-r**
: rotate through multiple desktop wallpapers

**-s**
: single desktop wallpaper (stop rotation)

**-u**
: prints usage message and exits

# EXAMPLES
**setwall -a -p example.png**
: Sets the desktop wallpaper to example.png on all desktops

**setwall -r -d /u/pics/backgrounds -i 30 -n 2**
: Rotates through desktop wallpapers in /u/pics/backgrounds/ every 30 seconds setting the wallpaper on desktop 2

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
SETWALL is distributed under an Open Source license.
See the file LICENSE in the SETWALL source distribution
for information on terms &amp; conditions for accessing and
otherwise using SETWALL and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

