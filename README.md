Scripts
=======

Utility Bash shell scripts I've written - typically these will run on Unix,
Linux, OS X, and Cygwin.

To clone:

    git clone https://github.com/doctorfree/Scripts.git

    or

    git clone git@github.com:doctorfree/Scripts.git

Contents:
--------

[**any2any**](any2any) - Uses ffmpeg to convert from any video format to any other

      This program works by either linking or copying any2any to a file
      which specifies the desired input and output formats by its name.
      For example, if you want to convert from WMV to MP4 then you could
      create a symbolic link from any2any to wmv2mp4 as follows:

          ln -s any2any wmv2mp4

      Similarly, symbolic links (or copies or hard links) could be created
      to convert from any (3 lowercase letter representation) video format
      to any other video format. Commonly used conversions include:

          wmv2mkv avi2mpg wmv2mp4 and so on.
 
      Naming restricton: [3 lowercase letters]2[3 lowercase letters]
      for a 7 letter name with "2" in the middle. The 3 letter prefix
      and suffix must also be a filename suffix that ffmpeg recognizes
      as a supported video format.

[**chkall**](chkall) - Invokes chkaplibs, chkmovdir, and chkpicdir to check
the Aperture, Movies, and Pictures rsync'd directories and sync them if
specified and necessary

[**chkaplibs**](chkaplibs) - Check the Aperture libraries and see if they
need to by sync'd with rsync to the USB flash drive backup

    Note: to check other directories use the -s, -a, and -t arguments

    When invoked as chkpicdir it checks directories in my Pictures dir

    When invoked as chkmovdir it checks directories in my Movies dir

    When invoked as chkhome it checks directories in $HOME

[**femvidlinks**](femvidlinks) - Create symbolic links to movie files where
possible to reduce duplicate storage of movies. Link into my iTunes library.

[**femzip**](femzip) - Convenience script to unzip Femjoy photo downloads

[**latest**](latest) - List the top N newest files in a directory or hierarchy

[**mkcomps**](mkcomps) - Join 2 or 3 images then split the resulting composite
in half. Uses ImageMagick.

[**mkreadme**](mkreadme) - Creates a Readme.html in all subdirectories.
Assumes a directory and file structure of Artist/Album/Tracks. A quick way to
populate my USB drives with HTML documents to provide an initial way to
navigate around. This currently only dives two levels deep to allow for
Artist/Album/Tracks directory structure:

             Artist Name/

               Album Name/

                 Pics/if-any.jpg (put cover art and other pics in Pics folder)

                 Track1.m4a

                 Track2.m4a (and so on, any file format)

                 Year (Year file should just be year released in parens)

[**mkseamless**](mkseamless) - Make a texture seamless. Uses ImageMagick.

    Uses the [**Vertical.png**](Vertical.png) image located in this repository.
    Vertical.png should be placed in /usr/local/lib on the system where
    mkseamless is run.

[**mkwmv**](mkwmv) - Creates a Readme.html in all subdirectories.

    Assumes all files of interest are WMV, MOV, MP4, or AVI. A quick way to
    populate my USB flash drive of movies with HTML documents to provide an
    initial way to navigate around.

[**updaplibs**](updaplibs) - Sync my Aperture libraries to a USB flash drive

    Note: to sync other directories use the -s, -a, and -t arguments

    When invoked as updpicdir it syncs directories in my Pictures dir

    When invoked as updmovdir it syncs directories in my Movies dir

    When invoked as updhome it syncs directories in $HOME

[**updsums**](updsums) - Create or update a SUMS file which contains chksums
for all files in that directory hierarchy

[**wb**](wb) - Automatically downloads my favorites from wallbase.cc

     You will need to configure your own Wallbase username/password as well as
     extensively modify the favorites by both name and number so this script
     may not be that useful to others. Get MacEarl's original and do to it
     what I have done to this.
