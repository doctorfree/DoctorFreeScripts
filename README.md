Scripts
=======

Utility Bash shell scripts I've written - typically these will run on Unix,
Linux, OS X, and Cygwin. Includes some custom Bash and Vim startup scripts.

To clone:

    git clone https://gitlab.com/doctorfree/Scripts.git

    or

    git clone git@gitlab.com:doctorfree/Scripts.git

Contents:
--------

[**LICENSE**](LICENSE) - Copyright and licensing, roughly the MIT license but without the heavy handed use of the caps lock key.
     for easy bulk downloading.

[**Scripts/IFTTT**](IFTTT/README.md) - Scripts to invoke IFTTT applets I've configured. These include scripts to manage my lights and devices like my AppleTV, Bluray player, and TV.

[**Scripts/Utils**](Utils/README.md) - A few utility scripts

[**Scripts/Wallpapers**](Wallpapers/README.md) - Scripts to manage pics used for desktop wallpaper

[**Scripts/binance**](binance/README.md) - Scripts to access the Binance API providing command line support for placing buy/sell trade orders and retrieving ticker or average prices for trading pairs

[**Scripts/chrome-themes**](chrome-themes/README.md) - Scripts to create and manage themes for the Chrome browser including themes I have created

[**Scripts/coinmarketcap**](coinmarketcap/README.md) - Scripts to access the Coinmarketcap API providing command line support for retrieving market info on specified cryptocurrency coins and tokens

[**Scripts/profittrailer**](profittrailer/README.md) - Scripts to access the ProfitTrailer API providing command line support for listing, loading, managing, switching ProfitTrailer configurations including trading strategies

[**add2itunes**](add2itunes.sh) - Add the media files provided as arguments to the iTunes library. Uses OS X osascript to execute AppleScript.

[**any2any**](any2any.sh) - Uses ffmpeg to convert from any audio/video format to any other

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

[**audlinks**](audlinks.sh) - Create symbolic links to audio files where possible to reduce duplicate storage of songs. Link into my iTunes library.

[**bash_aliases**](bash_aliases) - Bash aliases, install in $HOME/.bash_aliases

[**bash_profile**](bash_profile) - Bash profile, install in $HOME/.bash_profile

[**bashrc**](bashrc) - Bash startup, install in $HOME/.bashrc

[**cap2any**](cap2any.sh) - Uses ffmpeg to capture screen video and write to the specified audio/video format

     This program works by either linking or copying cap2any to a file
     which specifies the desired output format by its name.
     Alternately, the -o command line option can be used to specify
     the output file format.
 
     For example, if you want to capture to MP4 then you could
     create a symbolic link from cap2any to cap2mp4 as follows:
         ln -s cap2any cap2mp4
     Similarly, symbolic links (or copies or hard links) could be created to
     capture to any other audio/video format. Default output format is AVI.

[**chkall**](chkall.sh) - Invokes "chk" to check the Aperture, Movies, and Pictures rsync'd directories and sync them if specified and necessary

[**chk**](chk.sh) - Check the specified directories/libraries and see if they need to by sync'd with rsync to the USB flash drive backup

    Note: to check other directories use the -s, -a, and -t arguments

    When invoked as chkaplibs it checks directories in my Apertures libraries

    When invoked as chkpicdir it checks directories in my Pictures dir

    When invoked as chkmovdir it checks directories in my Movies dir

    When invoked as chkhome it checks directories in $HOME

[**chkinst**](chkinst.sh) - Check if installed versions of files in current directory are different in order to determine if git repository is up-to-date.

[**clndl**](clndl.sh) - Moves the most recently downloaded versions of files to their regular filename without the (#) in the name. By default, relies on the Mac OS X convention of inserting (#) in the name of newer version filenames.

[**cpBackups**](cpBackups.sh) - Copy, Move, or Remove Time Machine backups with bypass command. Depending on how this command is invoked (cpBackups, mvBackups, or rmBackups) or what arguments are supplied on the command-line, this will copy, move, or remove Time Machine backups using the bypass command

[**cron.bash**](cron.bash.sh) - Set SHELL=/usr/local/bin/cron.bash in your crontab to use this script to execute commands via cron. Modify this script to set any additional environment variables cron jobs might need, the PATH to use, etc.

[**dash2space**](dash2space.sh) - Convenience script to replace the first occurence of "-" in all MP3 filenames in this directory with " ". For example, this would rename "03-My Song.mp3" to "03 My Song.mp3".

[**dircolors**](dircolors) - Settings for the dircolors utility to enable color support of ls. Install as $HOME/.dircolors

[**eject**](eject.sh) - Convenience script to eject the CD/DVD

[**femzip**](femzip.sh) - Convenience script to unzip Femjoy photo downloads

[**filenuminc**](filenuminc.sh) - Convenience script to rename files beginning with a track number after increasing the number by some previously ripped number of tracks.  For example, the command "filenuminc 11" would rename "04 My Song.mp3" to "15 My Song.mp3".

[**filenumset**](filenumset.sh) - Convenience script to rename files beginning without a track number to a filename with track number as prefix. For example, the command "filenumset foo.mp3" might rename "foo.mp3" to "5 foo.mp3".

[**find2import**](find2import.sh) - Find and report photo albums and movies that may not have already been imported to iTunes

[**findbroken**](findbroken.sh) - Find and save a list of broken symbolic links in current directory

[**findempty**](findempty.sh) - Find and report empty directories. Optionally, remove them.

[**findgrep**](findgrep.sh) - Recursive grep in current directory.

[**gitlog**](gitlog.sh) - pretty format the output of "git log ..."

[**latest**](latest.sh) - List the top N newest files in a directory or hierarchy

[**mandelhist**](mandelhist.sh) - Display a zoom on the Mandelbrot set with histograms using a built-in ffplay/ffmpeg filter.

[**mkcomps**](mkcomps.sh) - Join 2 or 3 images then split the resulting composite
in half. Uses ImageMagick.

[**mkreadme**](mkreadme.sh) - Creates a Readme.html in all subdirectories.
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

[**mkseamless**](mkseamless.sh) - Make a texture seamless. Uses ImageMagick and
the [**Vertical.png**](Vertical.png) image located in this repository.

    Vertical.png should be placed in /usr/local/lib on the system where
    mkseamless is run.

[**mkwmv**](mkwmv.sh) - Creates a Readme.html in all subdirectories.

    Assumes all files of interest are WMV, MOV, MP4, or AVI. A quick way to
    populate my USB flash drive of movies with HTML documents to provide an
    initial way to navigate around.

[**mvfem**](mvfem.sh) - Rename a downloaded Femjoy zip archive that contains two model names to use only one model's name so it will work with femzip.

[**only**](only.sh) - Report files or directories only in one directory hierarchy but not in a second directory hierarchy.

[**packaud**](packaud.sh) - archive and compress my Audacity project files.

[**piclinks**](piclinks.sh) - Create symbolic links to photo files where possible to reduce duplicate storage of photos. Link into my Aperture libraries.

[**progress_bar**](progress_bar.sh) - Function to display a progress bar and percent complete

[**revlink**](revlink.sh) - Reverse the direction of symbolic links

[**stop_leapd**](stop_leapd.sh) - Stop the Leap Motion daemon and agent then backup and remove the plist files so they do not auto start. Includes Bash functions to replace auto start with manual start/stop

[**upd**](upd.sh) - Sync specified libraries/directories to a USB flash drive

    Note: to sync other directories use the -s, -a, and -t arguments

    When invoked as updaplibs it syncs directories in my Aperture libraries

    When invoked as updpicdir it syncs directories in my Pictures dir

    When invoked as updmovdir it syncs directories in my Movies dir

    When invoked as updhome it syncs directories in $HOME

[**updgit**](updgit.sh) - Perform the git add, git commit, and git push to the remote repository associated with this clone.

[**updsums**](updsums.sh) - Create or update a SUMS file which contains chksums
for all files in that directory hierarchy

[**updflash**](updflash.sh) - Convenience script to frontend the rsyncs needed to sync my flash drive using my "upd" script.

[**vidlinks**](vidlinks.sh) - Create symbolic links to movie files where possible to reduce duplicate storage of movies. Link into my iTunes library.

[**vimrc**](vimrc) - Vim startup configuration file. Install as $HOME/.vimrc

[**wikivim**](wikivim.sh) - Use in conjunction with It's All Text Firefox Add-On to use Vim to edit wiki pages. On OS X use Applescript and iTerm 2, otherwise use Bash and xterm.

