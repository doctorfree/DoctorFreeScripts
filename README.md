> **"The cosmic operating system uses a command line interface. It runs on
> something like a teletype, with lots of noise and heat; punched-out bits
> flutter down into its hopper like drifting stars. The demiurge sits at his
> teletype, pounding out one command line after another, specifying the values
> of fundamental constants of physics:**
>
> `universe -G 6.672e-11 -e 1.602e-19 -h 6.626e-34 -protonmass 1.673e-27`
>
> **and when he’s finished typing out the command line, his right pinky hesitates
> above the enter key for an aeon or two, wondering what’s going to happen;
> then down it comes—and the whack you hear is another Big Bang."**
>
> ― Neal Stephenson, In the Beginning...Was the Command Line

# DoctorFreeScripts

Utility Bash shell scripts I've written - typically these will run on Unix,
Linux, OS X, and possibly under Cygwin or the Windows Subsystem for Linux.
Includes over 175 useful or convenient commands I've developed over decades
of work on Unix and Linux operating system environments.

## Table of Contents

1. [Clone the Source](#clone-the-source)
1. [Installation](#installation)
    1. [Debian Package installation](#debian-package-installation)
    1. [RPM Package installation](#rpm-package-installation)
    1. [Mac OS X installation](#mac-os-x-installation)
1. [Removal](#removal)
1. [Documentation](#documentation)
1. [Introduction to Using the Command Line](#introduction-to-using-the-command-line)
1. [Contents](#contents)

## Clone the Source

To clone:

```bash
    git clone https://gitlab.com/doctorfree/DoctorFreeScripts.git
```

    or

```bash
    git clone git@gitlab.com:doctorfree/DoctorFreeScripts.git
```

## Installation

DoctorFreeScripts version 3.1 and later includes both Debian and RPM format
packages which can be used to install the DoctorFreeScripts utilities with
either the Apt Package Management system or the Red Hat Package Management
system. Support is also included for installing on Mac OS X. Other systems
will require a manual installation described below. The Mac OS X installation
procedure may also work under Microsoft's Windows Subsystem for Linux but
it is as yet untested.

### Debian Package installation

Many Linux distributions, most notably Ubuntu and its derivatives, use the
Debian packaging system.

To tell if a Linux system is Debian based it is usually sufficient to
check for the existence of the file `/etc/debian_version` and/or examine the
contents of the file `/etc/os-release`.

To install on a Debian based Linux system, download the latest Debian format
package from the
[DoctorFreeScripts Releases](https://gitlab.com/doctorfree/DoctorFreeScripts/-/releases).

Install the DoctorFreeScripts package by executing the command

```bash
sudo apt install ./DoctorFreeScripts_<version>-<release>.deb
```
or
```bash
sudo dpkg -i ./DoctorFreeScripts_<version>-<release>.deb
```

### RPM Package installation

Red Hat Linux, SUSE Linux, and their derivatives use the RPM packaging
format. RPM based Linux distributions include Fedora, AlmaLinux, CentOS,
openSUSE, OpenMandriva, Mandrake Linux, Red Hat Linux, and Oracle Linux.

To install on an RPM based Linux system, download the latest RPM format
package from the
[DoctorFreeScripts Releases](https://gitlab.com/doctorfree/DoctorFreeScripts/-/releases).

Install the DoctorFreeScripts package by executing the command

```bash
sudo yum localinstall ./DoctorFreeScripts_<version>-<release>.rpm
```
or
```bash
sudo rpm -i ./DoctorFreeScripts_<version>-<release>.rpm
```

### Mac OS X installation

Installation of DoctorFreeScripts on Mac OS X systems can be accomplished by
cloning the DoctorFreeScripts repository and executing the `Install` script:

```bash
    git clone `https://gitlab.com/doctorfree/DoctorFreeScripts.git`
    cd DoctorFreeScripts
    ./Install
```

## Removal

On Debian based Linux systems where the DoctorFreeScripts package was installed
using the DoctorFreeScripts Debian format package, remove the DoctorFreeScripts
package by executing the command:

```bash
    sudo apt remove doctorfree-scripts
```
or
```bash
    sudo dpkg -r doctorfree-scripts
```

On RPM based Linux systems where the DoctorFreeScripts package was installed
using the DoctorFreeScripts RPM format package, remove the DoctorFreeScripts
package by executing the command:

```bash
    sudo yum remove DoctorFreeScripts
```
or
```bash
    sudo rpm -e DoctorFreeScripts
```

On Mac OS X systems, the DoctorFreeScripts package can be removed by executing
the "Uninstall" script in the DoctorFreeScripts source directory:

```bash
    git clone git@gitlab.com:doctorfree/DoctorFreeScripts.git
    cd DoctorFreeScripts
    ./Uninstall
```

**Note:** Removal may issue a warning about removing `/usr/local` and other
folders within `/usr/local`. This is an artifact of the Debian packaging system.
If you wish to silence that warning and prevent the Debian packaging system from
trying to remove `/usr/local` then install the
[core-custom-local Debian package](https://gitlab.com/doctorfree/core-custom-local/-/releases).

## Documentation

Many DoctorFreeScripts commands have manual pages. Execute `man <command-name>`
to view the manual page for a command. Most commands also have
help/usage messages that can be viewed with the **-u** argument option,
e.g. `any2any -u`.

Manual pages for these DoctorFreeScripts commands can be viewed by
issueing the following commands:

- [man any2any](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/any2any.1.md)
- [man ape2m4a](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/ape2m4a.1.md)
- [man ape2mp4](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/ape2mp4.1.md)
- [man avi2mp4](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/avi2mp4.1.md)
- [man backgrounds](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/backgrounds.1.md)
- [man cap2any](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/cap2any.1.md)
- [man cap2m4v](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/cap2m4v.1.md)
- [man cap2mp4](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/cap2mp4.1.md)
- [man f4v2mp4](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/f4v2mp4.1.md)
- [man flv2mp4](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/flv2mp4.1.md)
- [man m4a2mp3](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/m4a2mp3.1.md)
- [man m4v2mp4](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/m4v2mp4.1.md)
- [man md2man](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/md2man.1.md)
- [man mkv2mp4](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/mkv2mp4.1.md)
- [man mov2mp4](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/mov2mp4.1.md)
- [man mp42m4v](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/mp42m4v.1.md)
- [man mpg2mp4](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/mpg2mp4.1.md)
- [man png2jpg](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/png2jpg.1.md)
- [man saver](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/saver.1.md)
- [man sdbackup](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/sdbackup.1.md)
- [man sderase](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/sderase.1.md)
- [man sdrestore](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/sdrestore.1.md)
- [man setwall](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/setwall.1.md)
- [man updgit](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/updgit.1.md)
- [man wma2m4a](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/wma2m4a.1.md)
- [man wmv2m4v](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/wmv2m4v.1.md)
- [man wmv2mp4](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/wmv2mp4.1.md)
- [man xnvslides](https://gitlab.com/doctorfree/DoctorFreeScripts/-/blob/master/markdown/xnvslides.1.md)

## Introduction to Using the Command Line
The command line has a long and storied history in computing. Read some of that
history, learn how to open a command line terminal window on various systems,
how to get started using the command line, and see some examples of why the command
line interface is so powerful by reading the DoctorFreeScripts wiki article
[Introduction to Using the Command Line](https://gitlab.com/doctorfree/DoctorFreeScripts/-/wikis/Introduction-to-Using-the-Command-Line).

This introduction to the command line includes three example use cases of automation
using the command line:

- How to [automate resizing of multiple images](https://gitlab.com/doctorfree/DoctorFreeScripts/-/wikis/Introduction-to-Using-the-Command-Line#resize-images-example)
- How to [automate timed restaurant menu display](https://gitlab.com/doctorfree/DoctorFreeScripts/-/wikis/Introduction-to-Using-the-Command-Line#magicmirror-timed-menu-display-example)
- How to [automate timed playback of Roon playlists](https://gitlab.com/doctorfree/DoctorFreeScripts/-/wikis/Introduction-to-Using-the-Command-Line#roon-timed-zone-playback-example) in specified Roon zones

## Contents

[**LICENSE**](LICENSE) - Copyright and licensing, roughly the MIT license but without the heavy handed use of the caps lock key.
     for easy bulk downloading.

[**DoctorFreeScripts/IFTTT**](IFTTT/README.md) - Scripts to invoke IFTTT applets I've configured. These include scripts to manage my lights and devices like my AppleTV, Bluray player, and TV.

[**DoctorFreeScripts/MagicMirror**](https://gitlab.com/doctorfree/MirrorCommandLine) - Scripts to manage my MagicMirror (https://magicmirror.builders/)

[**DoctorFreeScripts/Roon**](https://gitlab.com/doctorfree/RoonCommandLine) - Scripts to control my Roon audio system via the Roon API (https://pypi.org/project/roonapi/)

[**DoctorFreeScripts/Utils/bin**](Utils/bin/README.md) - Utility scripts

[**DoctorFreeScripts/Wallpapers**](Wallpapers/README.md) - Scripts to manage pics used for desktop wallpaper and slideshows

[**DoctorFreeScripts/binance**](binance/README.md) - Scripts to access the Binance API providing command line support for placing buy/sell trade orders and retrieving ticker or average prices for trading pairs

[**DoctorFreeScripts/chrome-themes**](chrome-themes/README.md) - Scripts to create and manage themes for the Chrome browser including themes I have created

[**DoctorFreeScripts/coinmarketcap**](coinmarketcap/README.md) - Scripts to access the Coinmarketcap API providing command line support for retrieving market info on specified cryptocurrency coins and tokens

[**DoctorFreeScripts/profittrailer**](profittrailer/README.md) - Scripts to access the ProfitTrailer API providing command line support for listing, loading, managing, switching ProfitTrailer configurations including trading strategies

[**add2itunes**](scripts/add2itunes.sh) - Add the media files provided as arguments to the iTunes library. Uses OS X osascript to execute AppleScript.

[**any2any**](scripts/any2any.sh) - Uses ffmpeg to convert from any audio/video format to any other

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

[**audlinks**](scripts/audlinks.sh) - Create symbolic links to audio files where possible to reduce duplicate storage of songs. Link into my iTunes library.

[**bash_aliases**](bash_aliases) - Bash aliases, install in $HOME/.bash_aliases

[**bash_profile**](bash_profile) - Bash profile, install in $HOME/.bash_profile

[**bashrc**](bashrc) - Bash startup, install in $HOME/.bashrc

[**cap2any**](scripts/cap2any.sh) - Uses ffmpeg to capture screen video and write to the specified audio/video format

     This program works by either linking or copying cap2any to a file
     which specifies the desired output format by its name.
     Alternately, the -o command line option can be used to specify
     the output file format.
 
     For example, if you want to capture to MP4 then you could
     create a symbolic link from cap2any to cap2mp4 as follows:
         ln -s cap2any cap2mp4
     Similarly, symbolic links (or copies or hard links) could be created to
     capture to any other audio/video format. Default output format is AVI.

[**chkall**](scripts/chkall.sh) - Invokes "chk" to check the Aperture, Movies, and Pictures rsync'd directories and sync them if specified and necessary

[**chk**](scripts/chk.sh) - Check the specified directories/libraries and see if they need to by sync'd with rsync to the USB flash drive backup

    Note: to check other directories use the -s, -a, and -t arguments

    When invoked as chkaplibs it checks directories in my Apertures libraries

    When invoked as chkpicdir it checks directories in my Pictures dir

    When invoked as chkmovdir it checks directories in my Movies dir

    When invoked as chkhome it checks directories in $HOME

[**chkinst**](chkinst) - Check if installed versions of files in current directory are different in order to determine if git repository is up-to-date.

[**clndl**](scripts/clndl.sh) - Moves the most recently downloaded versions of files to their regular filename without the (#) in the name. By default, relies on the Mac OS X convention of inserting (#) in the name of newer version filenames.

[**cpBackups**](scripts/cpBackups.sh) - Copy, Move, or Remove Time Machine backups with bypass command. Depending on how this command is invoked (cpBackups, mvBackups, or rmBackups) or what arguments are supplied on the command-line, this will copy, move, or remove Time Machine backups using the bypass command

[**cron.bash**](scripts/cron.bash.sh) - Set SHELL=/usr/local/bin/cron.bash in your crontab to use this script to execute commands via cron. Modify this script to set any additional environment variables cron jobs might need, the PATH to use, etc.

[**dash2space**](scripts/dash2space.sh) - Convenience script to replace the first occurence of "-" in all MP3 filenames in this directory with " ". For example, this would rename "03-My Song.mp3" to "03 My Song.mp3".

[**dircolors**](dircolors) - Settings for the dircolors utility to enable color support of ls. Install as $HOME/.dircolors

[**eject**](scripts/eject.sh) - Convenience script to eject the CD/DVD

[**femzip**](scripts/femzip.sh) - Convenience script to unzip Femjoy photo downloads

[**filenuminc**](scripts/filenuminc.sh) - Convenience script to rename files beginning with a track number after increasing the number by some previously ripped number of tracks.  For example, the command "filenuminc 11" would rename "04 My Song.mp3" to "15 My Song.mp3".

[**filenumset**](scripts/filenumset.sh) - Convenience script to rename files beginning without a track number to a filename with track number as prefix. For example, the command "filenumset foo.mp3" might rename "foo.mp3" to "5 foo.mp3".

[**find2import**](scripts/find2import.sh) - Find and report photo albums and movies that may not have already been imported to iTunes

[**findbroken**](scripts/findbroken.sh) - Find and save a list of broken symbolic links in current directory

[**findempty**](scripts/findempty.sh) - Find and report empty directories. Optionally, remove them.

[**findgrep**](scripts/findgrep.sh) - Recursive grep in current directory.

[**gethue**](scripts/gethue.sh) - Retrieve info on lights, scenes, configuration, etc from Philips Hue bridge.

[**gitlog**](scripts/gitlog.sh) - pretty format the output of "git log ..."

[**latest**](scripts/latest.sh) - List the top N newest files in a directory or hierarchy

[**mandelhist**](scripts/mandelhist.sh) - Display a zoom on the Mandelbrot set with histograms using a built-in ffplay/ffmpeg filter.

[**mkcomps**](scripts/mkcomps.sh) - Join 2 or 3 images then split the resulting composite in half. Uses ImageMagick.

[**md2man**](scripts/md2man.sh) - Generate man pages from markdown using pandoc

[**mkreadme**](scripts/mkreadme.sh) - Creates a Readme.html in all subdirectories.
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

[**mkseamless**](scripts/mkseamless.sh) - Make a texture seamless. Uses ImageMagick and
the [**Vertical.png**](Vertical.png) image located in this repository.

    Vertical.png should be placed in /usr/local/lib on the system where
    mkseamless is run.

[**mkwmv**](scripts/mkwmv.sh) - Creates a Readme.html in all subdirectories.

    Assumes all files of interest are WMV, MOV, MP4, or AVI. A quick way to
    populate my USB flash drive of movies with HTML documents to provide an
    initial way to navigate around.

[**mvfem**](scripts/mvfem.sh) - Rename a downloaded Femjoy zip archive that contains two model names to use only one model's name so it will work with femzip.

[**only**](scripts/only.sh) - Report files or directories only in one directory hierarchy but not in a second directory hierarchy.

[**packaud**](scripts/packaud.sh) - archive and compress my Audacity project files.

[**piclinks**](scripts/piclinks.sh) - Create symbolic links to photo files where possible to reduce duplicate storage of photos. Link into my Aperture libraries.

[**progress_bar**](scripts/progress_bar.sh) - Function to display a progress bar and percent complete

[**revlink**](scripts/revlink.sh) - Reverse the direction of symbolic links

[**stop_leapd**](scripts/stop_leapd.sh) - Stop the Leap Motion daemon and agent then backup and remove the plist files so they do not auto start. Includes Bash functions to replace auto start with manual start/stop

[**upd**](scripts/upd.sh) - Sync specified libraries/directories to a USB flash drive

    Note: to sync other directories use the -s, -a, and -t arguments

    When invoked as updaplibs it syncs directories in my Aperture libraries

    When invoked as updpicdir it syncs directories in my Pictures dir

    When invoked as updmovdir it syncs directories in my Movies dir

    When invoked as updhome it syncs directories in $HOME

[**updgit**](scripts/updgit.sh) - Perform the git add, git commit, and git push to the remote repository associated with this clone.

[**updsums**](scripts/updsums.sh) - Create or update a SUMS file which contains chksums
for all files in that directory hierarchy

[**updflash**](scripts/updflash.sh) - Convenience script to frontend the rsyncs needed to sync my flash drive using my "upd" script.

[**vidlinks**](scripts/vidlinks.sh) - Create symbolic links to movie files where possible to reduce duplicate storage of movies. Link into my iTunes library.

[**vimrc**](vimrc) - Vim startup configuration file. Install as $HOME/.vimrc

[**wikivim**](scripts/wikivim.sh) - Use in conjunction with It's All Text Firefox Add-On to use Vim to edit wiki pages. On OS X use Applescript and iTerm 2, otherwise use Bash and xterm.

