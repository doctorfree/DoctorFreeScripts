Scripts
=======

Utility Bash shell scripts I've written - typically these will run on Linux,
OS X, and Cygwin

To clone:
    git clone https://github.com/doctorfree/Scripts.git
    or
    git clone git@github.com:doctorfree/Scripts.git

Contents:

chkall - invokes chkaplibs, chkmovdir, and chkpicdir to check the Aperture,
         Movies, and Pictures rsync'd directories and sync them if specified
         and necessary
chkaplibs - check the Aperture libraries and see if they need to by sync'd
            with rsync to the USB flash drive backup
            Note: to check other directories use the -s, -a, and -t arguments
            when invoked as chkpicdir it checks directories in my Pictures dir
            when invoked as chkmovdir it checks directories in my Movies dir
            when invoked as chkhome it checks directories in $HOME
femvidlinks - create symbolic links to movie files where possible to reduce
              duplicate storage of movies. Link into my iTunes library.
femzip - convenience script to unzip Femjoy photo downloads
latest - list the top N newest files in a directory or directory hierarchy
mkreadme - creates a 00_Readme.html in all subdirectories. Assumes a directory
           and file structure of Artist/Album/Tracks. A quick way to populate
           my USB drives with HTML documents to provide an initial way to
           navigate around. This currently only dives two levels deep to allow
           for Artist/Album/Tracks directory structure:
             Artist Name/
               Album Name/
                 Pics/if-any.jpg (put cover art and other pics in Pics folder)
                 Track1.m4a
                 Track2.m4a (and so on, any file format)
                 Year (Year file should just be year released in parens)
mkwmv - creates a Readme.html in all subdirectories. Assumes all files of
        interest are WMV, MOV, MP4, or AVI. A quick way to populate my USB
        flash drive of movies with HTML documents to provide an initial way
        to navigate around.
updaplibs - sync my Aperture libraries to a USB flash drive
            Note: to sync other directories use the -s, -a, and -t arguments
            when invoked as updpicdir it syncs directories in my Pictures dir
            when invoked as updmovdir it syncs directories in my Movies dir
            when invoked as updhome it syncs directories in $HOME
updsums - create or update a SUMS file which contains chksums for all files
          in that directory hierarchy
