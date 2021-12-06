---
title: SAVER
section: 1
header: User Manual
footer: saver 4.0
date: December 06, 2021
---
# NAME
**saver** - Convenience frontend for xscreensaver to manage slideshows, screen saver folders, and xscreensaver commands

# SYNOPSIS
**saver** [ **-BDFHIPWX** path ] [ **-adflnprsxu** ] [ **-b** backgrounds_dir ] [ **-c** command ] [ **-t** duration ]

# DESCRIPTION
Manage XScreenSaver slideshows, folders, and commands

# COMMAND LINE OPTIONS

**-b backgrounds_dir**
: set the folder from which to get background images

**-c command**
: *command* is one of *activate*, *deactivate*, *blank*, *demo*, *exit*, *lock*, *restart*, *slides*, or *start*

**-t duration**
: specified in seconds

**-a**
: indicates do not remove portrait format images

**-d**
: indicates use /u/pictures/Domai rather than /u/pictures/Wallhaven

**-f**
: indicates use /u/pictures/Femjoy rather than /u/pictures/Wallhaven

**-l**
: indicates list the pre-created wallpaper subdirs available for the selected type

**-n**
: indicates tell me what you would do without doing anything

**-p**
: indicates use /u/pictures/Playboy rather than /u/pictures/Wallhaven

**-r**
: indicates restart xscreensaver prior to running command

**-s**
: indicates use /u/pictures/Safe rather than /u/pictures/Wallhaven

**-x**
: indicates use /u/pictures/X-Art rather than /u/pictures/Wallhaven

**-u**
: displays usage message

The **-BFIPSWX path** options control the filesystem paths to original image folders
and pre-created folders of links to selected image folders.

**-I path**
: indicates use path as the top-level pathname to folders of original images

**-D n1, -F n2, -S n3, -W n4, -X n5**
: names of subfolders in the top-level folder

**-H path**
: indicates use path as the full pathname to PICDIR where links will be created

**-B name**
: indicates use name as the subfolder in PICDIR where folders of links live

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
SAVER is distributed under an Open Source license.
See the file LICENSE in the SAVER source distribution
for information on terms &amp; conditions for accessing and
otherwise using SAVER and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

