---
title: GH_GET_LATEST
section: 1
header: User Manual
footer: gh_get_latest 1.0
date: September 24, 2022
---
# NAME
**gh_get_latest** - list, print, or install the latest Github release asset(s) for a project

# SYNOPSIS
**gh_get_latest** [-i] [-l] [-o owner] [-p project]

# DESCRIPTION
*gh_get_latest* will display the download url for the latest release asset
of the specified Github project. If no project or owner is specified on the
command line then the `mpcplus` project and `doctorfree` owner will be used.
If the `-i` option is specified the latest release asset will be installed.
Otherwise, the download url is output unless `-l` has been specified in
which case all release asset download urls will be listed.

The *gh_get_latest* command detects the platform it is being run on and
attempts to locate any platfrom-specific release assets. Platforms supported
include Arch Linux, Ubuntu, Raspberry Pi OS, CentOS, Fedora, and RPM or
Debian based systems.

# COMMAND LINE OPTIONS

**-i**
: indicates install downloaded package (prints download url if no '-i' argument provided)

**-l**
: indicates list all release assets for the specified project

**-o owner**
: specifies the Github repository owner (default: doctorfree)

**-p project**
: specifies the Github repository name (default: mpcplus)

**-u**
: display usage message and exit

# EXAMPLES

**gh_get_latest -i -o doctorfree -p MusicPlayerPlus**
: Download and install the latest release asset for this platfrom of the MusicPlayerPlus project maintained by Github user doctorfree

**gh_get_latest -p RoonCommandLine**
: Print the latest release asset download url for this platfrom of the RoonCommandLine project maintained by Github user doctorfree

**gh_get_latest -l -o doctorfree -p Asciiville**
: List all release asset download urls of the Asciiville project maintained by Github user doctorfree

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
GH_GET_LATEST is distributed under an Open Source license.
See the file LICENSE in the GH_GET_LATEST source distribution
for information on terms &amp; conditions for accessing and
otherwise using GH_GET_LATEST and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

