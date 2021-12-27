---
title: MD2MAN
section: 1
header: User Manual
footer: md2man 4.0
date: December 06, 2021
---
# NAME
**md2man** - uses markdown input and pandoc to generate man pages

# SYNOPSIS
**md2man** [-n command-name] [-s man-section] [-v command-version] [-aqu]

# DESCRIPTION
The *md2man* command generates a markdown template for input (if none exists)
with command name, sections, version, and as much info as it can derive
from command line arguments and git config. It then generates a man page
using the markdown as input.

See https://pandoc.org/ for more info on Pandoc.

# COMMAND LINE OPTIONS
**-u**
: displays this usage message

**-a**
: indicates generate all man pages from markdown found in *./markdown*

**-q**
: indicates quiet execution, no messages or prompts

**-n command-name**
: specifies the name of the command (without section)

**-s man-section**
: specifies the specifies the man page section number

**-v command-version**
: specifies the version of the command

# FILES
Markdown input and man page output are located by default in HOME/src/doc/.
These default locations can be overridden using command line arguments.

If there is a *markdown* subdirectory in the current working directory,
then that directory is used for markdown input. Similarly, if there is
a *man* subdirectory in the current working directory then that directory
is used for man page output.

# EXAMPLES
**md2man -n foo -s 3 -v 2.0.1**
: Generate markdown input for command name *foo* version *2.0.1* in manual
section *3*. Use the resulting markdown, *markdown/foo.3.md*, as input to generate
the man page *man/man3/foo.3*.

**md2man -a**
: Generate man pages for all markdown files found in *./markdown/&ast;.md*

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
MD2MAN is distributed under an Open Source license.
See the file LICENSE in the MD2MAN source distribution
for information on terms &amp; conditions for accessing and
otherwise using MD2MAN and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
**man**(1)

Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

