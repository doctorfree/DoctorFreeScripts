---
title: XNVSLIDES
section: 1
header: User Manual
footer: xnvslides 4.0
date: December 06, 2021
---
# NAME
**xnvslides** - AppleScript to open XnViewMP and start a slideshow

# SYNOPSIS
**xnvslides** [ **-u** ] [ **-lpP** ] [ **-s** subdir ] directory

# DESCRIPTION
Display a slideshow with XnViewMP using AppleScript. *XnViewMP* is freeware and
can be downloaded at https://www.xnview.com/en/xnviewmp/#downloads

Note that the *xnvlides* command uses AppleScript to display the slideshow
and is only supported on platforms that provide AppleScript (e.g. Mac OS X).

# COMMAND LINE OPTIONS
**-u**
: displays usage message and exits

**-l**
: indicates list files in specified slideshow folder

**-L**
: indicates list files in specified slideshow folder and show prepared folders

**-p**
: indicates search for slideshow folder in desktop background folders

**-P**
: indicates search for slideshow folder in desktop background folders and update

**-s &lt;subdir&gt;**
: searches in TOP/&lt;subdir&gt;

**Search Keywords:**
: cameron domai elite fap fractals femjoy jp kind metart mike models playboy tuigirl whvn xart

# CONFIGURATION
XnView keyboard shortcuts must be configured with:

- Slideshow shortcut: **Ctrl-Alt-S**
- Show files in subfolder shortcut: **Ctrl-Alt-O**

See:

- XnView -&gt; Preferences -&gt; Interface -&gt; Shortcuts

Create image folders to use for slideshows under a base folder. For example,
create subfolders in /u/pictures/

Edit the */usr/local/bin/xnvslides* script and set the TOP variable
to the base of your image folders, e.g. *TOP=/u/pictures*

# EXAMPLES
**xnvslides Fractals**
: Plays slideshow of fractal images in TOP/Fractals/

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
XNVSLIDES is distributed under an Open Source license.
See the file LICENSE in the XNVSLIDES source distribution
for information on terms &amp; conditions for accessing and
otherwise using XNVSLIDES and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

