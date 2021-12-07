---
title: UPDGIT
section: 1
header: User Manual
footer: updgit 4.0
date: December 06, 2021
---
# NAME
**updgit** - Perform git add/commit/push to the repo associated with this clone

# SYNOPSIS
**updgit** [ **-u** ] [ **-a** ] [ **-d** ] [ **-m "message comment"** ] [ file1 ... ]

# DESCRIPTION
Convenience script to combine the *git add*, *git commit*, and *git push* operations
into a single command. In addition, *updgit* attempts to determine what the name
of the branch to push is. This alleviates some of the irritation involved with the
recent renaming of the Github and Gitlab default branch from 'master' to 'main'.

# COMMAND LINE OPTIONS
**-u**
: display usage message

**-a**
: indicates to commit all staged files.

**-d**
: indicates to demonstrate what you would do without doing it.

**-m comment**
: adds the comment string as the commit message.

**file1 file2 ...**
: lists files to be staged and commited.

Note, you must either specify **-a** or a list of file(s).

# EXAMPLES
**updgit -a -m "Example message for example command"**
: This would add, commit, and push all modifications and new files, deletions, and renaming that has occurred in the local clone to the remote git repository

# AUTHORS
Written by Ronald Record &lt;github@ronrecord.com&gt;

# LICENSING
UPDGIT is distributed under an Open Source license.
See the file LICENSE in the UPDGIT source distribution
for information on terms &amp; conditions for accessing and
otherwise using UPDGIT and for a DISCLAIMER OF ALL WARRANTIES.

# BUGS
Submit bug reports online at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts/issues&gt;

# SEE ALSO
Full documentation and sources at: &lt;https://gitlab.com/doctorfree/DoctorFreeScripts&gt;

