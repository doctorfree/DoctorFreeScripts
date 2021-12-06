---
title: BACKGROUNDS
section: 1
header: User Manual
footer: backgrounds 4.0
date: December 06, 2021
---
# NAME
backgrounds - Manage desktop wallpapers, backgrounds, and slideshows

# SYNOPSIS
**backgrounds** [ **-u** ] [ **-a** ] [ **-l** ] [ **-x** ] [ **-pP** ] [ **-S** ] [ **-n** numpics ] [ **-s** subdir ] directory

# DESCRIPTION
**backgrounds** can be used to populate folders with image files to be cycled
through and used as desktop wallpaper. When invoked as *slides* or *slideshow*
it displays a slideshow of prepared image folders. Convenience links for *slides*
and *slideshow* are created during installation of the DoctorFreeScripts package.

# COMMAND LINE OPTIONS

**-u**
: display usage message

**-a**
: indicates add to existing background/slide pics

**-l**
: lists currently installed background/slide pics

**-p**
: indicates search for background pics in prepared folders

**-P**
: indicates search for background pics in prepared folders and update

**-n numpics**
: sets maximum number of pics to be copied (default 2048)

**-s subdir**
: searches in the root directory of your images for specified folder (e.g. on Linux systems search in */u/pictures* for *subdir*)

**-x**
: indicates use XnViewMP for slideshow

**-S**
: indicates run a slideshow of pics

# EXAMPLES

**backgrounds -l**
: List any installed wallpaper images in **/usr/local/share/backgrounds/** and indicate the location of prepared background image folders

**slideshow**
: Display a slideshow of images from the background images folder

**backgrounds -p Owls**
: Searches the prepared image folders for a folder named *Owls* and copies any images in that folder into the default backgrounds folder for use as desktop wallpapers and slideshows. Any previous images in the default backgrounds folder are removed and replaced with the images from the *Owls* folder.

**backgrounds -a -p Fractals**
: Searches the prepared image folders for a folder named *Fractals* and copies any images in that folder into the default backgrounds folder for use as desktop wallpapers and slideshows. Any previous images in the default backgrounds folder are retained and the images from the *Fractals* folder are added to the default backgrounds folder.

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
BACKGROUNDS is distributed under an Open Source license.
See the file LICENSE in the BACKGROUNDS source distribution
for information on terms &amp; conditions for accessing and
otherwise using BACKGROUNDS and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

