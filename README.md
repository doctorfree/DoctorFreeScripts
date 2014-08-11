Scripts
=======

Utility Bash shell scripts I've written - typically these will run on Unix,
Linux, OS X, and Cygwin. Includes some custom Bash and Vim startup scripts.

To clone:

    git clone https://github.com/doctorfree/Scripts.git

    or

    git clone git@github.com:doctorfree/Scripts.git

Contents:
--------

[**LICENSE**](LICENSE) - Copyright and licensing, roughly the MIT license but without the heavy handed use of the caps lock key.

[**add2itunes**](add2itunes) - Add the media files provided as arguments to the iTunes library. Uses OS X osascript to execute AppleScript.

[**any2any**](any2any) - Uses ffmpeg to convert from any audio/video format to any other

      This program works by either linking or copying any2any to a file
      which specifies the desired input and output formats by its name.
      For example, if you want to convert from WMV to MP4 then you could
      create a symbolic link from any2any to wmv2mp4 as follows:

          ln -s any2any wmv2mp4

      Similarly, symbolic links (or copies or hard links) could be created
      to convert from any (3 lowercase letter representation) audio/video format
      to any other audio/video format. Commonly used conversions include:

          wmv2mkv avi2mpg wmv2mp4 and so on.
 
      Naming restricton: [3 lowercase letters]2[3 lowercase letters]
      for a 7 letter name with "2" in the middle. The 3 letter prefix
      and suffix must also be a filename suffix that ffmpeg recognizes
      as a supported audio/video format.

[**bash_aliases**](bash_aliases) - Bash aliases, install in $HOME/.bash_aliases

[**bash_profile**](bash_profile) - Bash profile, install in $HOME/.bash_profile

[**bashrc**](bashrc) - Bash startup, install in $HOME/.bashrc

[**chkall**](chkall) - Invokes "chk" to check the Aperture, Movies, and Pictures rsync'd directories and sync them if specified and necessary

[**chk**](chk) - Check the specified directories/libraries and see if they need to by sync'd with rsync to the USB flash drive backup

    Note: to check other directories use the -s, -a, and -t arguments

    When invoked as chkaplibs it checks directories in my Apertures libraries

    When invoked as chkpicdir it checks directories in my Pictures dir

    When invoked as chkmovdir it checks directories in my Movies dir

    When invoked as chkhome it checks directories in $HOME

[**chkinst**](chkinst) - Check if installed versions of files in current directory are different in order to determine if git repository is up-to-date.

[**clndl**](clndl) - Moves the most recently downloaded versions of files to their regular filename without the (#) in the name. By default, relies on the Mac OS X convention of inserting (#) in the name of newer version filenames.

[**dircolors**](dircolors) - Settings for the dircolors utility to enable color support of ls. Install as $HOME/.dircolors

[**femzip**](femzip) - Convenience script to unzip Femjoy photo downloads

[**findempty**](findempty) - Find and report empty directories. Optionally, remove them.

[**findgrep**](findgrep) - Recursive grep in current directory.

[**latest**](latest) - List the top N newest files in a directory or hierarchy

[**mandelhist**](mandelhist) - Display a zoom on the Mandelbrot set with histograms using a built-in ffplay/ffmpeg filter.

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

[**mkseamless**](mkseamless) - Make a texture seamless. Uses ImageMagick and
the [**Vertical.png**](Vertical.png) image located in this repository.

    Vertical.png should be placed in /usr/local/lib on the system where
    mkseamless is run.

[**mkwmv**](mkwmv) - Creates a Readme.html in all subdirectories.

    Assumes all files of interest are WMV, MOV, MP4, or AVI. A quick way to
    populate my USB flash drive of movies with HTML documents to provide an
    initial way to navigate around.

[**audlinks**](audlinks) - Create symbolic links to audio files where possible to reduce duplicate storage of songs. Link into my iTunes library.

[**mvfem**](mvfem) - Rename a downloaded Femjoy zip archive that contains two model names to use only one model's name so it will work with femzip.

[**only**](only) - Report files or directories only in one directory hierarchy but not in a second directory hierarchy.

[**piclinks**](piclinks) - Create symbolic links to photo files where possible to reduce duplicate storage of photos. Link into my Aperture libraries.

[**stop_leapd**](stop_leapd) - Stop the Leap Motion daemon and agent then backup and remove the plist files so they do not auto start. Includes Bash functions to replace auto start with manual start/stop

[**upd**](upd) - Sync specified libraries/directories to a USB flash drive

    Note: to sync other directories use the -s, -a, and -t arguments

    When invoked as updaplibs it syncs directories in my Aperture libraries

    When invoked as updpicdir it syncs directories in my Pictures dir

    When invoked as updmovdir it syncs directories in my Movies dir

    When invoked as updhome it syncs directories in $HOME

[**updgit**](updgit) - Perform the git add, git commit, and git push to the remote repository associated with this clone.

[**updsums**](updsums) - Create or update a SUMS file which contains chksums
for all files in that directory hierarchy

[**updflash**](updflash) - Convenience script to frontend the rsyncs needed to sync my flash drive using my "upd" script.

[**vidlinks**](vidlinks) - Create symbolic links to movie files where possible to reduce duplicate storage of movies. Link into my iTunes library.

[**vimrc**](vimrc) - Vim startup configuration file. Install as $HOME/.vimrc

[**wb**](wb) - Automatically downloads my favorites from wallbase.cc

     You will need to configure your own Wallbase username/password as well as
     extensively modify the favorites by both name and number so this script
     may not be that useful to others. Get MacEarl's original and do to it
     what I have done to this.
