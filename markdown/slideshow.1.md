---
title: SLIDESHOW
section: 1
header: User Manual
footer: slideshow 4.0
date: December 06, 2021
---
# NAME
slideshow - Play slideshows

# SYNOPSIS
**slideshow** [ **-u** ] [ **-a** ] [ **-l** ] [ **-x** ] [ **-pP** ] [ **-S** ] [ **-n** numpics ] [ **-s** subdir ] directory

# DESCRIPTION
**slideshow** displays a slideshow of prepared image folders.

The *slideshow* command tries to be smart about detecting which platform it is
running on and what slideshow facilities are available. For example, if it
detects that it is running on Apple Mac OS X and the *osascript* facility is
present then it opens the Preview App and uses AppleScript to automatically
control the Preview App, playing a slideshow of the specified image folder.

On Linux systems *slideshow* tries to use *variety-slideshow* to display the
slideshow and, if *variety-slideshow* is not present then *slideshow* uses
the *pcmanslideshow* command included in the **DoctorFreeScripts package**.

The *slideshow* command is a link to the *backgrounds* command.

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

# EXAMPLES

**slideshow -l**
: List any installed wallpaper images in **/usr/local/share/backgrounds/** and indicate the location of prepared background image folders

**slideshow**
: Display a slideshow of images from the background images folder

**slideshow Owls**
: Searches the default image folders for a folder named *Owls* and displays a slideshow of those images.

**slideshow -p Owls**
: Searches the prepared image folders for a folder named *Owls* and copies any images in that folder into the default backgrounds folder for use as desktop wallpapers and slideshows. Any previous images in the default backgrounds folder are removed and replaced with the images from the *Owls* folder. After updating the default backgrounds folder, display a slideshow of those images.

**slideshow -a -p Fractals**
: Searches the prepared image folders for a folder named *Fractals* and copies any images in that folder into the default backgrounds folder for use as desktop wallpapers and slideshows. Any previous images in the default backgrounds folder are retained and the images from the *Fractals* folder are added to the default backgrounds folder. After updating the default backgrounds folder, display a slideshow of those images.

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
SLIDESHOW is distributed under an Open Source license.
See the file LICENSE in the SLIDESHOW source distribution
for information on terms &amp; conditions for accessing and
otherwise using SLIDESHOW and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
**backgrounds**(1), **slides**(1), **pcmanslideshow**(1)

Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

