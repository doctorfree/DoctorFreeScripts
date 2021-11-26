# Changelog

All notable changes to this project will be documented in this file.

Fri Nov 26 09:18:28 2021 -0800 c9b636a :
   Set version to 4.0 in preparation for new release
Fri Nov 26 08:34:51 2021 -0800 c12c196 :
   Add Mac OS X installation and removal support, move postinstall and preremove out into etc
Fri Nov 26 06:31:18 2021 -0800 fd5db82 :
   Add sections on RPM installation and removal
Thu Nov 25 20:35:59 2021 -0800 eea3092 :
   Merge branch 'master' of ssh://gitlab.com/doctorfree/DoctorFreeScripts RPM integrated into Install/Uninstall
Thu Nov 25 20:35:27 2021 -0800 5602482 :
   Install/Uninstall now supports RPM, Debian, and Mac
Thu Nov 25 17:13:50 2021 -0800 c6a70bb :
   Add release to VERSION, enable RPM Packaging
Wed Nov 24 17:43:43 2021 -0800 5aa863a :
   Minor formatting of Fred Scripts download
Wed Nov 24 17:31:59 2021 -0800 c23805d :
   Move desktop files to /usr/local/...
Wed Nov 24 13:09:36 2021 -0800 9d28099 :
   Change name of repository to DoctorFreeScripts
Wed Nov 24 12:41:54 2021 -0800 f54f7cf :
   Added build action to drfree function, added checks
Wed Nov 24 12:16:50 2021 -0800 578a757 :
   Add drfree function
Mon Nov 22 11:34:42 2021 -0800 5ee498b :
   Set Architecture to 'all' in control file
Sat Nov 20 18:36:28 2021 -0800 528876c :
   Rename SUMS files as SUMS.txt
Fri Nov 19 16:09:36 2021 -0800 4f35a7c :
   Format Fred script download screen
Fri Nov 19 15:02:33 2021 -0800 5371240 :
   Silence curl download output
Fri Nov 19 14:46:29 2021 -0800 6dcd18c :
   Added mandelbrot script
Fri Nov 19 14:27:35 2021 -0800 8abf5ec :
   Added convenience script to prune local tags
Fri Nov 19 14:15:08 2021 -0800 4345845 :
   Update script locations in README
Fri Nov 19 13:40:42 2021 -0800 8ad5664 :
   Last pass at filtering commands for linking into /usr/local/bin, moving and deleting scripts
Fri Nov 19 10:57:08 2021 -0800 c19d79f :
   Additional deletions and renaming to prep for release
Fri Nov 19 10:03:09 2021 -0800 9b56b33 :
   Cleanup a bit
Fri Nov 19 09:56:13 2021 -0800 cf4688a :
   First round of culling out scripts not to be linked in /usr/local/bin, renaming and moving scripts, add ImageMagick subdir
Tue Nov 16 08:23:34 2021 -0800 1b1f209 :
   Link cap2any files
Tue Nov 16 07:55:42 2021 -0800 01f162e :
   Create symbolic links for the formats any2any can handle
Mon Nov 15 16:32:06 2021 -0800 71e36a6 :
   Remove old release artifacts
Mon Nov 15 15:11:33 2021 -0800 efad813 :
   Update Changelog in preparation for version 3.2 tag
Mon Nov 15 14:28:16 2021 -0800 2d62dc1 :
   Get version from VERSION
Mon Nov 15 13:50:49 2021 -0800 33b93df :
   Copy distribution packages into releases subdir
Mon Nov 15 13:30:05 2021 -0800 36c139c :
   export base scripts dir in maintenance scripts
Mon Nov 15 11:39:08 2021 -0800 7aae0a2 :
   Create and remove files in /usr/local/share in postinst and prerm
Mon Nov 15 10:18:29 2021 -0800 5504898 :
   Update gethue script with latest from MirrorCommandLine
Mon Nov 15 10:00:41 2021 -0800 90d3bb2 :
   Update Wallpapers/backgrounds.sh with latest from MirrorCommandLine development
Mon Nov 15 09:13:48 2021 -0800 e46355f :
   Move kv up with dot files
Mon Nov 15 08:59:59 2021 -0800 efa30b3 :
   Move utility scripts into bin subdir, move wallutils up with dot files
Mon Nov 15 08:14:40 2021 -0800 e46cbed :
   Resolve duplicates with MirrorCommandLine package
Mon Nov 15 07:44:06 2021 -0800 a2673cc :
   Begin resolving duplicates between packages, move mkpkg.sh to mkpkg
Sun Nov 14 14:43:31 2021 -0800 6300761 :
   Move toplevel scripts into scripts subdir
Sun Nov 14 14:07:02 2021 -0800 bbf18b4 :
   Move Wallpapers/clean.sh to wallclean.sh
Sun Nov 14 13:55:50 2021 -0800 6332b40 :
   Only run CI builds when there is a new tag
Sun Nov 14 13:52:02 2021 -0800 2665d95 :
   Fix check for Scripts dir in CI
Sun Nov 14 13:48:15 2021 -0800 9bc23c3 :
   Prepare for Gitlab continuous integration
Thu Nov 11 16:57:36 2021 -0800 743376b :
   Updated release archives with latest changes
Thu Nov 11 16:52:00 2021 -0800 e0a0be9 :
   Add sections on Installation and Removal
Thu Nov 11 16:37:11 2021 -0800 163d1ae :
   fix comment in quotes in gittag script
Thu Nov 11 16:34:44 2021 -0800 e53df69 :
   Add scripts to install/uninstall from Debian format package
Thu Nov 11 16:11:53 2021 -0800 de6efc3 :
   Add initial Debian format release
Thu Nov 11 15:58:10 2021 -0800 cc3864e :
   Post-install, if a command exists and is identical to that installed by this package then remove it and create a symbolic link
Thu Nov 11 15:30:46 2021 -0800 132beae :
   Use sudo to make directories in dist
Thu Nov 11 15:24:21 2021 -0800 0b08b37 :
   Copy additional files into dist for packaging
Thu Nov 11 14:15:22 2021 -0800 620bb6f :
   Merge branch 'master' of ssh://gitlab.com/doctorfree/Scripts
Thu Nov 11 14:15:02 2021 -0800 ea7216c :
   Create packaging scripts
Thu Nov 11 14:13:51 2021 -0800 6995de3 :
   Add AUTHORS and CHANGELOG, update LICENSE
Thu Nov 11 13:28:01 2021 -0800 97a9e58 :
   Use -L option to find in order to follow symbolic links
Thu Nov 11 12:10:36 2021 -0800 32fd6d0 :
   Delete duplicate scripts in Utils/bin
Wed Nov 10 11:30:48 2021 -0800 3dd575d :
   findgrep either regular file or symbolic link
Tue Oct 26 11:25:29 2021 -0700 22138b1 :
   Add sponsor funding link, how to clone submodules
Tue Oct 26 11:18:24 2021 -0700 d54d7da :
   Add MagicMirror submodule
Mon Oct 4 09:06:02 2021 -0700 5468ccf :
   Move MagicMirror out into its own repository
Sun Oct 3 10:31:03 2021 -0700 85521c6 :
   Comment out TelegramBot module config, add JAV creation and removal to mirror script
Sat Oct 2 12:59:00 2021 -0700 f5c95b2 :
   Updated MagicMirror config files that use animated GIF images
Sat Oct 2 11:42:42 2021 -0700 83f1cfe :
   Added attribution/source for pcmanslideshow script
Sat Oct 2 10:53:21 2021 -0700 67201dc :
   Set background wallpaper on MagicMirror
Sat Oct 2 10:29:07 2021 -0700 cb32679 :
   Use pcmanfm for slideshows on MagicMirror/Linux
Fri Oct 1 16:54:16 2021 -0700 236eee6 :
   If specified config not found, try to find one with partial match
Fri Oct 1 09:04:11 2021 -0700 cd54522 :
   Support for selecting Artists, better search for specified config
Thu Sep 30 15:55:37 2021 -0700 5b0ce41 :
   Update MagicMirror config files to syunc with latest mirror script and layout
Thu Sep 30 15:27:28 2021 -0700 54ccc06 :
   Add support for auto Artist creation and removal, create config file if it does not exist but image folder does
Thu Sep 30 14:43:40 2021 -0700 6ff3ac6 :
   Auto creation and removal of Photographer slide shows as well as Models and Idols
Thu Sep 30 14:22:20 2021 -0700 5a9d91b :
   Add Photographers to browsing and listing feature
Thu Sep 30 13:35:33 2021 -0700 b9f6507 :
   Simplify JAV slideshow selection
Thu Sep 30 12:58:12 2021 -0700 9f61385 :
   Refactor image and config layout and naming to simplify code, add convenience scripts
Mon Sep 27 11:09:20 2021 -0700 e64cab4 :
   Move mirror templates into subdir, add background photo folder creation scripts for MagicMirror
Sun Sep 26 16:05:43 2021 -0700 f747d3a :
   Support a variety of config file argument formats
Sun Sep 26 15:50:52 2021 -0700 c3507a0 :
   Format configs listing
Sun Sep 26 15:15:04 2021 -0700 79392f7 :
   Add support for JAV Idols, move model configs into subdirs
Sun Sep 26 07:58:04 2021 -0700 26d5901 :
   MagicMirror frontend script improvements - backgrounds slide show folder and configs
Fri Sep 24 12:41:06 2021 -0700 7359612 :
   Add Models subdirs to search
Wed Sep 22 17:29:51 2021 -0700 16c4cd0 :
   Format usage message, add support for additonal photographers
Wed Sep 22 16:44:23 2021 -0700 2c859a0 :
   Added several toplevel slideshow keywords, support for spaces in folder names
Wed Sep 22 14:37:39 2021 -0700 1a471ac :
   Suupport for XnView slideshows with subfolders
Wed Sep 22 11:29:31 2021 -0700 bb9149b :
   List available folders in selected image folder dir
Tue Sep 21 23:06:34 2021 -0700 2e72bb3 :
   Add notes to usage message
Tue Sep 21 12:29:03 2021 -0700 634894b :
   Updated READMEs including xnvslides support for slideshows with XnView
Tue Sep 21 11:34:44 2021 -0700 e18606a :
   Add support for XnView slideshow to backgrounds script, new xnvslides.sh to perform XnView slideshows
Tue Sep 14 12:47:29 2021 -0700 6480e49 :
   Default is to search all folders for models, photographers, etc
Thu Sep 9 10:36:38 2021 -0700 07ba35c :
   Simplify output, no output when model not found
Sun Aug 29 13:11:49 2021 -0700 28f2e5f :
   Look for background images in multiple locations, added prepared folders scripts
Thu Aug 12 07:02:31 2021 -0700 df0aa3d :
   Add support for subdir of Artists
Sat Aug 7 15:23:29 2021 -0700 08df11c :
   Update Time Machine delete script for Big Sur, new options for wallutils, new models
Sat Jul 10 10:19:17 2021 -0700 6e367a8 :
   Deleted MagicMirror config-plex.js
Sat Jul 10 10:16:56 2021 -0700 5ceb5f9 :
   Support for Playboy and Photodromm model subdirs
Sun May 23 07:25:08 2021 -0700 831ef49 :
   Add backup paths, models, and photographers
Sun Apr 11 18:18:16 2021 -0700 14631aa :
   Update the update to MagicMirror config files
Sun Apr 11 18:05:57 2021 -0700 871478d :
   Updated MagicMirror config files
Sat Apr 3 10:02:31 2021 -0700 470d98c :
   Replaced Roon directory with RoonCommandLine submodule
Sat Apr 3 09:59:28 2021 -0700 01610f2 :
   Removed Roon directory to replace it with submodule
Fri Apr 2 14:42:40 2021 -0700 2484209 :
   Improved introductory overview in Roon/README.md
Fri Apr 2 14:26:16 2021 -0700 5ac51dd :
   Added LICENSE and NOTICE to Contents
Fri Apr 2 14:23:01 2021 -0700 0a91a67 :
   Added licensing and copyright notice, updated INSTALL instructions
Fri Apr 2 13:48:32 2021 -0700 ae6fc33 :
   Add note about partial match media playback to README
Fri Apr 2 12:19:07 2021 -0700 a1a1151 :
   If play media not found then search for a partial match. If a single partial match is returned then play that
Fri Apr 2 10:29:53 2021 -0700 622e639 :
   Updated README with latest usage message
Fri Apr 2 10:20:56 2021 -0700 abc13b8 :
   Added play_album capability to play a specified album by album name
Fri Apr 2 09:09:05 2021 -0700 28854b7 :
   Move settings into .pyroonconf and automate detection of settings in install, add listing of albums and genres
Thu Apr 1 15:19:32 2021 -0700 44f7d94 :
   Added notes on applying my Python Roon API patches
Thu Apr 1 13:40:28 2021 -0700 1abaec1 :
   Another attempt to format usage message
Thu Apr 1 12:43:24 2021 -0700 3090a05 :
   Attempt to format usage message
Thu Apr 1 12:42:28 2021 -0700 61023d3 :
   Added to installation notes
Thu Apr 1 12:33:52 2021 -0700 30df9e5 :
   Fleshed out README with installation and usage notes
Thu Apr 1 10:18:08 2021 -0700 100b1a6 :
   Add list_artists scripts to Contents in READMEs
Thu Apr 1 09:55:21 2021 -0700 a5bbba0 :
   Add support for listing artists and zones by search term match
Wed Mar 31 17:01:26 2021 -0700 f0ca263 :
   Added patches to Python Roon API to support new method for retrieving a list of Roon objects that match a search criteria
Mon Mar 29 17:45:29 2021 -0700 bc21fe7 :
   Added support for playing a specified playlist
Mon Mar 29 17:06:55 2021 -0700 df80632 :
   Add entry for usage.txt to README
Mon Mar 29 17:05:12 2021 -0700 a108584 :
   Added roon usage message text file
Mon Mar 29 16:59:31 2021 -0700 edd0b55 :
   Added playlist todo scripts
Mon Mar 29 15:00:10 2021 -0700 5e4515e :
   Added some early versions of scripts to be implemented when the api supports it
Mon Mar 29 14:04:09 2021 -0700 582caf6 :
   Add support for shuffle and repeat commands
Mon Mar 29 13:50:15 2021 -0700 8f49055 :
   Renamed roonapi.ini to roon_api.ini and forgot to change it in the Python scripts. Sheesh.
Mon Mar 29 13:23:40 2021 -0700 f09bbac :
   Deleted scripts no longer needed after zone_command processes all commands
Mon Mar 29 13:15:36 2021 -0700 b700991 :
   Handle zone commands in a single script
Mon Mar 29 12:25:52 2021 -0700 600583d :
   Deleted play_tull scripts, added commands for play and pause in a zone
Mon Mar 29 11:41:13 2021 -0700 e1cdb73 :
   Add option and scripts to list available Roon Zones
Mon Mar 29 08:48:12 2021 -0700 93972f2 :
   Added an install.sh convenience installation script, updated READMEs
Sun Mar 28 16:44:05 2021 -0700 58a66b2 :
   Make a nicer usage message
Sun Mar 28 16:24:49 2021 -0700 c4443b0 :
   Dynamically set the Roon Zone in /Users/doctorwhen/.roonzone
Sun Mar 28 11:35:42 2021 -0700 072a68b :
   Added a configuration file, roon_api.ini, in which default values are stored
Sun Mar 28 10:39:19 2021 -0700 766d675 :
   Created some initial installation instructions for the Roon API scripts
Sun Mar 28 10:19:36 2021 -0700 4d695c7 :
   Add support for playing by genre, play tag not yet working
Sun Mar 28 08:15:05 2021 -0700 22e98b8 :
   Cleanup roon frontend script
Sat Mar 27 16:56:38 2021 -0700 8dda3e9 :
   Add front-end script 'roon' to run on systems that can SSH in to the Roon API server, replace exact match of target_zone with substring check to enable playing in grouped zones
Sat Mar 27 13:07:28 2021 -0700 64e9afd :
   Add script support for playing next/previous track and mute/unmute in specified zone
Fri Mar 26 14:10:28 2021 -0700 3c49c03 :
   Added History section to README
Fri Mar 26 13:48:22 2021 -0700 7fa5758 :
   Add argument processing for zone selection, add scripts for stopping playback in a zone
Fri Mar 26 10:05:32 2021 -0700 cf176ef :
   Added scripts to control Roon via the Roon API
Sat Feb 20 11:17:54 2021 -0800 2194967 :
   Add update capability to backgrounds script, update models and photographers, add SD image write script
Wed Jan 13 14:00:06 2021 -0800 5ea2978 :
   Update backgrounds with my Mac version, remove portrait script
Sun Nov 29 08:22:33 2020 -0800 b83ece2 :
   Invoke linkhaven with -q flag to silence
Sun Nov 29 08:20:15 2020 -0800 1df2b0b :
   Added silent execution mode for cron job
Mon Nov 16 10:29:21 2020 -0800 2193e02 :
   Update Wallhaven scripts, new scripts to backup/restore/delete Time Machine and rsync backups
Fri Nov 13 10:54:52 2020 -0800 d2dad90 :
   Ethminer systemd service, updated ethminer scripts
Thu Nov 12 17:02:15 2020 -0800 085cd53 :
   Deleted duplicate utility scripts
Thu Nov 12 17:00:16 2020 -0800 2e08841 :
   Updated Utils/bin with scripts from my Mac Pro
Thu Nov 12 13:31:28 2020 -0800 455fd6e :
   Additional git clone convenience scripts
Thu Nov 12 13:29:41 2020 -0800 9580862 :
   Added convenience scripts to clone my git repositories
Tue Nov 10 11:38:16 2020 -0800 2487b59 :
   Created convenience script to search apt repo and installed packages
Mon Nov 9 20:19:02 2020 -0800 bca351c :
   Openbox integration scripts for Variety, improved backgrounds script, wrappers for menus and sddm themes
Mon Nov 9 19:35:42 2020 -0800 55b93c4 :
   Updated Lubuntu 20.04 customized config files
Mon Nov 9 07:28:00 2020 -0800 5b04a85 :
   Variety scripts to utilize new support for multiple profiles
Mon Nov 9 07:26:59 2020 -0800 bc39925 :
   Support for multiple Variety profiles, extended openbox key bindings, Variety fractals profile
Sun Nov 8 12:18:57 2020 -0800 11b2c5a :
   Delete time machine backups via command line
Sun Nov 8 10:39:05 2020 -0800 c643b1b :
   Keyboard mapping, openbox configuration, and convenience scripts
Sun Nov 8 10:38:03 2020 -0800 d086465 :
   My home directory bin convenience scripts on Ubuntu
Sun Nov 8 10:25:59 2020 -0800 264dd43 :
   Lubuntu 20.04 LTS config files and convenience scripts from my ETH miner
Sun Nov 8 07:40:56 2020 -0800 172c55b :
   Add restore and list options to pt convenience script
Thu Aug 27 07:31:44 2020 -0700 4c47659 :
   New models and photographers
Wed Aug 26 15:43:39 2020 -0700 7209f44 :
   IFTTT suspended its SMS service. Nothing works anymore.
Mon Jul 27 07:42:59 2020 -0700 c65b307 :
   Dot in wallutils prior to processing arguments
Mon Jul 27 07:24:50 2020 -0700 259719b :
   Typo in get-photographers
Sun Jul 26 12:52:12 2020 -0700 3e7b865 :
   Added models, photographers, and anime wallpapers. New convenience script to checkout git branch
Tue Jun 9 06:10:28 2020 -0700 e0f5d8e :
   New photographers and models, convenience script to diff get scripts
Wed May 6 15:58:52 2020 -0700 ed544e9 :
   Added gitshow convenience script
Tue Mar 31 09:29:00 2020 -0700 d083d05 :
   No Google Assistant for Youtube config
Mon Mar 30 14:02:26 2020 -0700 9b4b188 :
   Created config file for YouTube play via Google Assistant addon
Mon Mar 30 11:20:35 2020 -0700 69f058d :
   Specify USER for VNC login
Mon Mar 30 10:49:07 2020 -0700 df753ed :
   Created convenience script to remotely start VNC server, run VNC viewer, and remotely stop VNC server
Sun Mar 29 16:34:58 2020 -0700 31d6b5e :
   Copy in my modules changes and additions
Sun Mar 29 15:04:11 2020 -0700 6c11772 :
   More voice commands to switch configs
Sun Mar 29 12:50:49 2020 -0700 d966cb9 :
   Additional smart mirror voice commands, disable addons for slide shows
Sat Mar 28 18:16:53 2020 -0700 a13cc4d :
   Added Google Assistant and Hotword to all config files, added commands to my mirror script recipe
Sat Mar 28 15:58:50 2020 -0700 df7d297 :
   Initial Google Assistant recipe to execute mirror script with voice commands
Sat Mar 28 15:01:00 2020 -0700 af07f36 :
   Enable Google Assistant and Hotword
Sat Mar 21 19:35:31 2020 -0700 691cb2c :
   Added diff check for mirror.sh
Sat Mar 21 19:33:03 2020 -0700 801a93b :
   Added diff checks for mmgetb and mmsetb
Sat Mar 21 19:08:57 2020 -0700 21b8c6f :
   Updated with latest from MagicMirror deployment
Sat Mar 21 12:15:26 2020 -0700 302901f :
   Moved slideshow pics down into pics dir
Fri Mar 20 15:36:36 2020 -0700 4ef71fa :
   Install snowboy and briefToday addons for MMM-AssistantMk2
Fri Mar 20 13:35:20 2020 -0700 0a13cb9 :
   Added Health Weather Map to iFrame
Wed Mar 18 16:50:38 2020 -0700 58439ad :
   Disable Bluetooth and related services
Wed Mar 18 15:15:47 2020 -0700 02d2b87 :
   Created config-all.js to cycle through several pages of modules
Tue Mar 17 10:02:06 2020 -0700 fb728e6 :
   Added Italy, Iran, Canada, Mexico to COVID pinned
Mon Mar 16 18:27:36 2020 -0700 8803464 :
   Update COVID-19, install addons for Assistant
Mon Mar 16 15:20:44 2020 -0700 e99c3d4 :
   Add many options to getopt processing as well as preserving existing argument processing
Sun Mar 15 10:47:28 2020 -0700 0a3cd0c :
   Ignore dot-wireless-home.txt
Fri Mar 13 14:46:50 2020 -0700 272f68f :
   Added 'Memory Split' to info mem option
Thu Mar 12 15:50:30 2020 -0700 82d3718 :
   Updated MMM-COVID-19 has new config and css
Thu Mar 12 12:57:24 2020 -0700 5f3e1b9 :
   Use MMM-Remote-Control API Key
Wed Mar 11 16:15:08 2020 -0700 3afcc8b :
   Added API Key to MMM-Remote-Control config
Wed Mar 11 15:12:03 2020 -0700 c72661b :
   Added 'wh' and 'whrm' options to create and remove configs for Wallhaven dirs
Tue Mar 10 17:45:17 2020 -0700 5b9a38b :
   Install ImageMagick
Tue Mar 10 14:58:42 2020 -0700 8fb0f0d :
   Use 1M block size for all dd reads and writes
Tue Mar 10 14:11:07 2020 -0700 9dce885 :
   Add project and model ids to Assistant configuration, new test config
Tue Mar 10 13:54:15 2020 -0700 9dae5fd :
   New model aliases, also check get-photographers for aliases, script to check for new mods
Tue Mar 10 13:34:10 2020 -0700 0b2ca93 :
   Added deviceInstance.json
Tue Mar 10 10:53:41 2020 -0700 3f8e5de :
   Use getopt, added options to specify input/output/disk/name and usage
Mon Mar 9 19:12:14 2020 -0700 cbd06f0 :
   Add MMM-Hotword personal model and recipe
Mon Mar 9 18:33:58 2020 -0700 235dcb2 :
   Deleted Scheduler and Hello-Lucy entries
Mon Mar 9 17:55:35 2020 -0700 3ed6c34 :
   Remove MMM-cryptocurrency and Hello-Lucy from installs
Mon Mar 9 16:41:35 2020 -0700 4d7c98e :
   Use getopt to process arguments, add usage message and options for demo and device
Sun Mar 8 17:09:01 2020 -0700 90c681e :
   Add config file for Google Assistant
Sun Mar 8 12:43:00 2020 -0700 da028fa :
   Install MMM-Hotword
Sat Mar 7 14:22:48 2020 -0800 141a1a7 :
   Removed Hello-Lucy module configuration entries
Fri Mar 6 13:04:56 2020 -0800 22352f3 :
   Improved config-stocks, comment out empty calendar ics entry
Fri Mar 6 11:30:21 2020 -0800 ccc99b0 :
   Added https://ncov2019.live/tweets to Coronavirus iFrame
Fri Mar 6 11:24:18 2020 -0800 55e551f :
   Added https://ncov2019.live/map to Coronavirus iFrame
Fri Mar 6 11:07:14 2020 -0800 ce20f1a :
   Added -o outfile option to sdbackup, added Apple TV ip addresses to config files
Thu Mar 5 16:26:41 2020 -0800 a4506ae :
   Added MMM-cryptocurrency
Thu Mar 5 15:02:53 2020 -0800 5638386 :
   Added config-stocks.js, use POLYBNB rather than POLYUSDT
Thu Mar 5 12:25:27 2020 -0800 bfc4137 :
   Create symlink /usr/bin/vdirsyncer
Thu Mar 5 12:09:30 2020 -0800 c635890 :
   Try to fix interaction issue between Hello-Lucy and MMM-Remote-Control
Tue Mar 3 16:15:09 2020 -0800 2b61f84 :
   Update arp-scan vendor database
Tue Mar 3 16:00:28 2020 -0800 de97da7 :
   Install arp-scan for MMM-NetworkScanner
Tue Mar 3 12:41:04 2020 -0800 0f14837 :
   Script demonstrating how to prune dirs from find command
Mon Mar 2 16:47:07 2020 -0800 22aff0d :
   Rework the colors and header of the MMM-COVID-19 module
Mon Mar 2 16:05:52 2020 -0800 9b90cee :
   Install Hello-Lucy
Mon Mar 2 11:50:48 2020 -0800 b89ac0d :
   Change width of hue lights depending on which region it is in
Mon Mar 2 11:02:07 2020 -0800 652d789 :
   First argument of 'normal' now refers to the config file config-normal.js
Mon Mar 2 09:08:55 2020 -0800 8ad28b0 :
   Add config file for unrotated display, only zip SD backup if -z given
Sun Mar 1 13:23:12 2020 -0800 89178ee :
   Use MMM-pages module to rotate coronavirus pages
Sun Mar 1 12:47:43 2020 -0800 314ca73 :
   Install bc
Sun Mar 1 12:12:07 2020 -0800 e6d43da :
   Added MMM-pages to MODULES
Sun Mar 1 10:35:44 2020 -0800 a6d02d5 :
   Rename fstab to fstab-append
Sun Mar 1 10:33:46 2020 -0800 ba24dbb :
   Install autofs, only append fstab nfs mounts as UUID of SD card can change
Sun Mar 1 08:47:01 2020 -0800 43afcb8 :
   Added script to automate creation of my picture folder symbolic links
Sun Mar 1 08:21:24 2020 -0800 8e80bf1 :
   Check for broken symbolic link when updating config.js
Sun Mar 1 07:59:30 2020 -0800 2f096da :
   Display screen status (on/off) as well
Sat Feb 29 20:56:36 2020 -0800 cf6c804 :
   Remove noback config file
Sat Feb 29 20:50:34 2020 -0800 652cd4f :
   Added crypto symbols BAT, POLY, ZRX, and MCO
Sat Feb 29 20:17:02 2020 -0800 3a8ad10 :
   Reformat, use DateOnly module
Sat Feb 29 19:25:08 2020 -0800 3108361 :
   No iframe or volume in default config
Sat Feb 29 19:10:47 2020 -0800 0fdf6a2 :
   Check for config.js existence before moving
Sat Feb 29 18:36:59 2020 -0800 5ae0a40 :
   Add 'screen' menu options, add unused config files to .gitignore
Sat Feb 29 17:14:47 2020 -0800 018cb00 :
   Add config files for news and coronavirus, update all with unique strings for private keys
Sat Feb 29 14:46:22 2020 -0800 d7ad606 :
   Added rotate option to rotate screen display left, right, or normal
Sat Feb 29 13:50:51 2020 -0800 f3ca407 :
   Do not bother with setting brightness after installing new config
Sat Feb 29 11:55:40 2020 -0800 963140f :
   Added MMM-News, MMM-COVID-19 must be installed manually
Fri Feb 28 19:17:45 2020 -0800 0f016fe :
   Use zip rather than gzip to create SD backups
Fri Feb 28 15:41:16 2020 -0800 20044ee :
   Updated config files with Telegram Bot and MMM-Tools settings
Fri Feb 28 14:29:16 2020 -0800 031ce79 :
   Added MMM-COVID-19 module
Fri Feb 28 14:25:44 2020 -0800 3b6b298 :
   Added MMM-Volume to modules, SD scripts take an argument specifying device name
Fri Feb 28 12:54:49 2020 -0800 b0ac72e :
   Redirect stdout to /dev/null when invoking vcgencmd
Fri Feb 28 12:51:21 2020 -0800 0a1db43 :
   Add 'screen [on|off|status]' option to turn display on or off
Fri Feb 28 09:58:32 2020 -0800 c2c12ac :
   Added MMM-TelegramBot and MMM-Tools to modules
Thu Feb 27 12:22:53 2020 -0800 cd4c4d7 :
   Added MMM-Tools and MMM-TelegramBot to install, mirror status now check config(s), use date to name SD backup
Thu Feb 27 00:01:21 2020 -0800 47c6d0f :
   Added Google Assistant and YouTube modules
Wed Feb 26 23:41:33 2020 -0800 ba98759 :
   Reinstate vulnerability audit and repair
Wed Feb 26 23:02:29 2020 -0800 0adc7cd :
   Set BOLD and NORMAL text modes, pretty formatting
Wed Feb 26 20:29:42 2020 -0800 d4e53f7 :
   Comment out audit and repair for now
Wed Feb 26 18:26:07 2020 -0800 fe4d6b5 :
   Edit lightdm.conf to disable screensaver
Wed Feb 26 16:44:01 2020 -0800 268867f :
   Further cleanup progress output, start MagicMirror before exiting
Wed Feb 26 15:17:11 2020 -0800 9301a9a :
   Redirect some stderr as well, prompt if user is using default password - if so, do not enable SSH
Wed Feb 26 13:51:40 2020 -0800 682d406 :
   Add .local/bin to PATH prior to installing mmpm to avoid warning
Wed Feb 26 12:51:54 2020 -0800 12f875e :
   Perform a check on device name and if no match, exit
Wed Feb 26 11:50:48 2020 -0800 1926699 :
   Audit and fix discovered vulnerabilities
Wed Feb 26 11:21:45 2020 -0800 6d09c02 :
   Add description banner before selection dialogs
Wed Feb 26 10:45:49 2020 -0800 9ec718c :
   iCal calendar sync with vdirsyncer setup
Wed Feb 26 09:26:12 2020 -0800 7501836 :
   Source in modified .bashrc outside sudo to pickup new PATH
Wed Feb 26 08:45:27 2020 -0800 a282b4f :
   Rotate screen if requested, disable screensaver, redirect apt-get stdout to /dev/null
Wed Feb 26 08:10:33 2020 -0800 fee6cc5 :
   Install needed Vim packages, cleanup with autoremove before exit
Tue Feb 25 21:48:57 2020 -0800 822887c :
   Enable SSH, install and autostart pm2 and MagicMirror
Tue Feb 25 21:10:55 2020 -0800 1cecbc6 :
   Auto answer 'yes' to apt-get installs
Tue Feb 25 20:23:15 2020 -0800 cd56546 :
   Make sure we are in the home directory before installing MagicMirror
Tue Feb 25 14:46:12 2020 -0800 c9d2c20 :
   Added scripts to erase, backup, and restore an SD card
Tue Feb 25 09:43:22 2020 -0800 ebfe49b :
   No need for USER and HOST with backups on mounted FS
Tue Feb 25 09:22:53 2020 -0800 94349de :
   Added script to automate wireless network setup
Mon Feb 24 19:56:03 2020 -0800 e8f0ebd :
   Don't clobber /sbin/shutdown!
Mon Feb 24 19:07:18 2020 -0800 cfa5d0f :
   Use manual installation for MagicMirror rather than mmpm
Mon Feb 24 18:56:22 2020 -0800 b167e5f :
   List files with api keys and note that during install
Mon Feb 24 18:42:30 2020 -0800 5d7ddbd :
   Separate force and install options, use 'chkinst -f -i' to force install
Mon Feb 24 17:58:45 2020 -0800 da4bf67 :
   Added duplicity exclude file, updated chkinst with that
Mon Feb 24 17:44:15 2020 -0800 caf1dc7 :
   Difference exceptions for new files
Mon Feb 24 17:36:05 2020 -0800 2b4fc10 :
   Added MagicMirror install script and system customization files from /etc
Mon Feb 24 13:08:36 2020 -0800 b047928 :
   Add all scripts from /usr/local/bin on Raspberry Pi in preparation for reinstall
Mon Feb 24 10:33:56 2020 -0800 607ef57 :
   Added my .asoundrc for audio playback thru headphone jack and audio capture by usb mic
Sun Feb 23 13:02:00 2020 -0800 6ed0029 :
   Added custom sentence/command setting for Hello-Lucy, custom welcome messages, and development folder
Sun Feb 23 12:25:40 2020 -0800 0c1eb0b :
   Add Hello-Lucy module to configs, remove tabs, initial implementation of custom Hello-Lucy commands
Sat Feb 22 19:10:30 2020 -0800 e957fa4 :
   Added script to backup home dir with duplicity
Sat Feb 22 18:42:57 2020 -0800 84b9c67 :
   Added custom css for DarkSky Weather, add diff allowance for config-weather to chkinst
Thu Feb 20 16:17:36 2020 -0800 b518036 :
   Updated chkinst to check config files
Thu Feb 20 16:17:03 2020 -0800 688caad :
   Added config file for weather display
Thu Feb 20 11:29:35 2020 -0800 bb87ff0 :
   Added my MagicMirror config files with api keys etc blanked out
Thu Feb 20 09:38:43 2020 -0800 6d6c7b2 :
   Custom css to lower size of medium font style in calendar
Thu Feb 20 09:11:28 2020 -0800 2a9df5c :
   Exit with error return if config test fails
Wed Feb 19 13:32:25 2020 -0800 d5c94ae :
   Added support for checking all config files, created custom css for Hue Lights
Sun Feb 16 14:28:31 2020 -0800 38548a7 :
   Add script to get current track info from Apple Music, update scripts to use Music rather than iTunes
Sun Feb 16 11:37:58 2020 -0800 9d4daa4 :
   Newline after call to curl to format response without jq
Sun Feb 16 11:32:00 2020 -0800 9c5e258 :
   Updated chktemp differ line count
Sun Feb 16 11:26:47 2020 -0800 ae5936d :
   Added gethue.sh to diff allowance
Sun Feb 16 11:09:49 2020 -0800 7f11c01 :
   Check if jq is installed and in /home/pi/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:/home/pi/.local/bin before using it
Sun Feb 16 10:00:02 2020 -0800 67548a8 :
   Added toplevel entry for MagicMirror directory of scripts
Sun Feb 16 09:55:11 2020 -0800 0e334a5 :
   Added Readme for MagicMirror directory of scripts
Sun Feb 16 09:45:09 2020 -0800 44ed233 :
   Added script to retrieve info on lights etc from Philips Hue bridge
Fri Feb 14 11:40:44 2020 -0800 7c96286 :
   Added rmlandscape script to remove landscape photos from a directory
Fri Feb 14 09:52:41 2020 -0800 d0d4dbb :
   Merge branch 'master' of ssh://gitlab.com/doctorfree/Scripts
Fri Feb 14 09:50:20 2020 -0800 7582821 :
   Added crontab entry to check temp every 5 min without SMS, quiet option for chktemp
Fri Feb 14 09:06:28 2020 -0800 9515623 :
   Created simple script to remotely execute mirror commands using ssh
Thu Feb 13 15:03:24 2020 -0800 72b206f :
   Allow for chktemp to differ from installed version due to blanked out api key and secret
Thu Feb 13 14:49:50 2020 -0800 7ae7e0d :
   New script to get and send the RPi temperature and crontab entry to run it daily
Tue Feb 11 12:35:20 2020 -0800 6cd0185 :
   Enhance select menus to support either text or numeric replies
Tue Feb 11 12:09:12 2020 -0800 0e14703 :
   Split up system info into types, accept numeric or text for main menu select which is now in an infinite loop
Tue Feb 11 10:00:16 2020 -0800 63d8f09 :
   Added 'info' arg and 'system info' menu entry, pretty printf formatting
Mon Feb 10 21:42:18 2020 -0800 aebc98b :
   If invoked with no arguments display select menu of commands
Mon Feb 10 20:47:16 2020 -0800 83dd6dc :
   Add select option and selection dialog to choose config from list
Mon Feb 10 19:52:36 2020 -0800 7db1bc9 :
   Dynamically create list of config files for usage message
Mon Feb 10 19:34:07 2020 -0800 52251cc :
   Use printf rather than echo for easier formatting
Mon Feb 10 18:59:26 2020 -0800 2fce229 :
   Add support for listing configs
Mon Feb 10 15:11:02 2020 -0800 6d2ff89 :
   Added support for 'list active' and 'list installed' to list modules using Remote-Control API
Mon Feb 10 14:36:56 2020 -0800 c180d0f :
   Added status option to mirror, use --silent with npm checks
Sun Feb 9 18:00:24 2020 -0800 dfb1953 :
   Added rand_back.sh to set desktop background
Sun Feb 9 17:32:45 2020 -0800 13ad193 :
   Added support for getting and setting brightness
Sun Feb 9 17:17:13 2020 -0800 30981a0 :
   Added usage message
Sun Feb 9 17:05:56 2020 -0800 90248c7 :
   Corrected some initial errors, added chkinst, redirect curl stderr
Sun Feb 9 13:45:38 2020 -0800 f2de314 :
   Created MagicMirror convenience scripts
Sat Jan 25 12:32:46 2020 -0800 69dbbe2 :
   Added get-label and get-some, modified to work when executed from anywhere in PATH
Fri Jan 24 14:37:42 2020 -0800 1b9dfe4 :
   New model aliases
Sun Jan 19 09:13:18 2020 -0800 e4b79d3 :
   New models, aliases, and photographers
Thu Nov 21 11:21:43 2019 -0800 69c1c5e :
   Check for symlink as well as regular file
Thu Nov 21 11:19:17 2019 -0800 b8526d7 :
   New models, photographers, and label synonyms
Tue Nov 5 15:31:15 2019 -0800 249c71b :
   Corrected typo in linkhaven
Sun Nov 3 16:15:49 2019 -0800 4f68439 :
   Fixed bug in symlinking in linkhaven, added models and aliases
Sat Oct 5 10:52:37 2019 -0700 7a39ea5 :
   New model aliases
Mon Sep 16 10:49:44 2019 -0700 32f3e71 :
   New models, support for Stasy Q
Sat Sep 7 11:53:08 2019 -0700 d159246 :
   Added models, enhance echk to check backup names as well
Wed Aug 28 17:57:29 2019 -0700 5f23683 :
   Modified top Pictures path, added models, updated wallhaven script
Thu Jul 25 12:13:22 2019 -0700 c3f6570 :
   New models and aliases, expanded symlinking
Thu Jul 11 08:31:49 2019 -0700 f449662 :
   New model aliases
Mon Jul 1 11:50:23 2019 -0700 ddbb172 :
   Add support for reverse date search mode, new models and photographers
Fri Jun 21 13:51:36 2019 -0700 7847829 :
   Update Wallhaven get scripts with new models and photographers
Mon May 27 10:37:53 2019 -0700 808e7aa :
   Add support for JAV Idol subdir
Sun May 26 09:18:46 2019 -0700 b9f05d0 :
   Add support for retrieving and canceling open Binance orders, comment crontab better
Sat May 25 09:42:42 2019 -0700 84b617d :
   Added model aliases and retrieve latest options
Sat Apr 20 20:42:52 2019 -0700 cb41e2d :
   Update Readme's with all the newer script descriptions and entries
Sat Apr 20 15:21:31 2019 -0700 bd47bf1 :
   Remove chrome theme entries mistakenly included here
Sat Apr 20 15:17:52 2019 -0700 0f11c3c :
   Update/Create README's
Sat Apr 20 13:11:47 2019 -0700 af242d1 :
   Moved Wallpapers/ scripts descriptions to Wallpapers subdir README.md
Sat Apr 20 12:36:46 2019 -0700 f4ef10b :
   Process return body with awk and sed if jq not available
Sat Apr 20 11:46:36 2019 -0700 b0559ee :
   Pull out price from json, add average p/ticker price retrieval and percent offset to BinanceOrder
Fri Apr 19 16:56:01 2019 -0700 7505389 :
   Added scripts to get symbol price, average and ticker. Scripts to test connection and get time
Fri Apr 19 14:17:17 2019 -0700 1edb828 :
   Rename limitbuy to BinanceOrder, add arguments to set various data parameters
Fri Apr 19 13:24:45 2019 -0700 32c445a :
   Add scripts for Binance limit buy and Coinmarketcap exchange pair
Thu Apr 18 13:17:10 2019 -0700 e0621f8 :
   Initial pass at scripts to access Coinmarketcap API
Wed Apr 17 10:49:29 2019 -0700 aa58a13 :
   Get license and api token from application.properties
Tue Apr 16 21:07:10 2019 -0700 0f76972 :
   Add scripts to display ProfitTrailer logs and set/override Sell Only Mode
Tue Apr 16 20:24:01 2019 -0700 e6df950 :
   Add script to retrieve the ProfitTrailer error log
Tue Apr 16 20:14:37 2019 -0700 9fc0b9e :
   Add script to retrieve ProfitTrailer data
Tue Apr 16 17:31:23 2019 -0700 44de896 :
   Add script to load and display specified config file
Tue Apr 16 16:36:01 2019 -0700 9039c2b :
   Add script to delete ProfitTrailer configuration
Tue Apr 16 16:23:30 2019 -0700 b019c99 :
   Added scripts to list and switch ProfitTrailer configurations
Sun Apr 14 09:57:46 2019 -0700 4ad1ca1 :
   Added support for JAV_Idol models
Thu Apr 11 13:49:47 2019 -0700 6dc6ed3 :
   Added argument processing, support for specified models
Tue Apr 9 10:49:49 2019 -0700 dc84659 :
   Process args with getopts
Tue Apr 9 10:32:47 2019 -0700 12ed4e0 :
   Add count to models, add new models to get scripts
Wed Feb 13 15:04:24 2019 -0800 cca0615 :
   Minor improvements to models and photographers get scripts
Mon Feb 11 15:57:59 2019 -0800 6c0bfde :
   Updated to support Suicide Girls folders
Mon Feb 11 15:00:33 2019 -0800 13cf5db :
   Updated Wallhaven get scripts to support separate Suicide Girls folders
Mon Feb 11 11:10:24 2019 -0800 a018593 :
   Added models.sh script to list models and photographers
Wed Jan 16 15:57:42 2019 -0800 72532f5 :
   Updated Wallhaven get scripts, added options and usage to shownext
Sat Jan 12 12:01:37 2019 -0800 737eb66 :
   Added support for JP Erotica, new scripts for opening browser with next model and creating/showing description
Fri Dec 28 12:49:21 2018 -0800 d38a0aa :
   Add support for Linux slideshow with Variety, improved usage message
Fri Dec 28 10:49:47 2018 -0800 f132661 :
   Added slideshow capability and support for more folders
Tue Dec 11 14:53:11 2018 -0800 eaaab38 :
   Updated mvdown.sh to use getopts and additional dirs
Tue Dec 11 14:52:13 2018 -0800 84bc47d :
   Added mvdown.sh script to move downloaded files
Wed Nov 14 14:19:58 2018 -0800 f846c0b :
   Moved Favs folder to Misc subdir
Tue Nov 13 23:55:35 2018 -0800 ff1b681 :
   Fixes to work around spaces in filenames
Tue Nov 13 22:42:01 2018 -0800 df0f2d6 :
   Add support for Playboy wallpapers
Tue Nov 13 20:42:58 2018 -0800 27a1dc5 :
   Add support for Domai wallpapers
Tue Nov 13 16:04:48 2018 -0800 68604bf :
   Add scripts for getting desktop background pic and linking to it
Tue Nov 13 10:58:46 2018 -0800 f9b9b93 :
   Check if symlink exists before creating, improve usage message and current status
Mon Nov 12 16:40:20 2018 -0800 16592a9 :
   More fixes for spaces in symlink filenames
Mon Nov 12 16:29:13 2018 -0800 1fecc92 :
   Fixes for parsing symlinks with spaces in filenames
Mon Nov 12 15:40:57 2018 -0800 ae58ce4 :
   Highlight user settings comments
Mon Nov 12 15:26:12 2018 -0800 ca2d4af :
   Added support for Safe wallpapers using -s switch
Mon Nov 12 10:18:03 2018 -0800 386c43d :
   Added options to specify image paths and folder names, better comments and user defined settings area
Sun Nov 11 22:19:06 2018 -0800 8c71617 :
   Added blank and slides command arguments to switch between xscreensaver modes
Sun Nov 11 18:35:39 2018 -0800 85fd4de :
   Modify so can be run from anywhere
Sun Nov 11 18:21:27 2018 -0800 7d10172 :
   Added list option, only make new background dir if no previous dir exists
Sun Nov 11 16:06:08 2018 -0800 1bd5ff9 :
   Add restrictions on width and height
Sun Nov 11 15:34:50 2018 -0800 6f6ca0e :
   Move xscreensaver wallpaper dirs to subdirs, added support for Femjoy and X-Art wallpapers, added mkall mkfavs and mkrelink convenience scripts
Fri Nov 9 17:41:59 2018 -0800 d96db59 :
   Add scripts to create backgrounds dir and remove portrait images
Fri Nov 9 09:28:40 2018 -0800 faa97fc :
   Added search and creation facilities to support arbitrary background folder specification on command line
Thu Nov 8 10:53:08 2018 -0800 bda3ff9 :
   Added Anime and Hentai wallpaper folders
Thu Nov 8 10:31:29 2018 -0800 ac16713 :
   Update backgrounds.sh with copyright, add saver.sh for xscreensaver slideshow management
Fri Oct 26 09:45:57 2018 -0700 2f6de7c :
   Explanatory comments, example modifications
Thu Oct 25 11:19:07 2018 -0700 d34a4bb :
   Add explanatory comments to off-peak crontab
Thu Oct 25 10:53:34 2018 -0700 99271b3 :
   Fix start_miner hours
Thu Oct 25 10:10:28 2018 -0700 62d9433 :
   Convenience script to search and retrieve wallpapers by model name
Thu Oct 25 10:06:00 2018 -0700 60469ad :
   Initial crontab for running miner only in off-peak hours
Fri Aug 24 09:16:12 2018 -0700 6799799 :
   Use case statement in get-all, add Melisa Mendiny to get-models
Thu Aug 23 11:16:59 2018 -0700 5408c76 :
   Added Watch4Beauty to linkhaven script
Thu Aug 23 10:52:58 2018 -0700 eaa7380 :
   Added Wallhaven scripts to get all Models and get all Photographers
Wed Aug 1 17:10:15 2018 -0700 0cb01a1 :
   Added playkeynote script t o front-end Keynote presentations
Thu Jul 26 12:45:14 2018 -0700 76538fc :
   Add Domai and Met-Art destinations
Thu Jul 26 12:41:46 2018 -0700 9ef5d98 :
   Merge branch 'master' of https://gitlab.com/doctorfree/Scripts
Thu Jul 26 12:40:52 2018 -0700 3e91379 :
   Use awk to pull out just the filenames when listing
Wed Jul 4 20:44:23 2018 -0700 64da118 :
   Progress messages added
Wed Jul 4 20:39:40 2018 -0700 b3cf541 :
   Added Femjoy as destination
Wed Jul 4 16:47:17 2018 -0700 44be399 :
   Add Met-Art destination
Wed Jul 4 16:30:26 2018 -0700 cb5ed34 :
   Add People destination
Mon Jul 2 15:26:05 2018 -0700 58ee1e4 :
   Added People, improved usage message, support hard links in linkhaven.sh
Mon Jul 2 12:37:42 2018 -0700 ed93859 :
   Implement ALL feature in linkhaven to run through all scenarios
Sun Jul 1 13:02:34 2018 -0700 fc3b9e1 :
   Ability to set Photographers as source in linkhaven
Fri Jun 29 18:47:36 2018 -0700 9285f2d :
   Added Wallpapers/linkhaven.sh script that creates symbolic links for duplicates
Sat Jun 16 11:49:26 2018 -0700 86b48d9 :
   Added new binance, bittrex, and ProfitTrailer scripts
Sat Jun 16 09:49:27 2018 -0700 b31b7f6 :
   Added cron.bash.sh crontab SHELL script, changed github to gitlab where appropriate
Fri Jun 15 18:19:41 2018 -0700 eb0d907 :
   Added backgrounds.sh and randmodel.sh wallpaper script and random model/photographer selecter script
Fri Mar 16 13:29:11 2018 -0700 236c2e4 :
   Add entry to grc.conf so grc will use ProfitTrailer config by default; Improved regular ProfitTrailer expressions
Thu Mar 15 15:42:55 2018 -0700 1ef5115 :
   Added ProfitTrailer log colorizing with grc; improvements to pt scripts
Sun Mar 11 17:13:44 2018 -0700 5c6bd04 :
   Updated ProfitTrailer scripts to use latest strategies and added ETH market support
Wed Mar 7 11:20:28 2018 -0800 3ccdb53 :
   Generalized paths where possible using environment variables
Tue Mar 6 22:23:49 2018 -0800 ffc3876 :
   Added scripts for ProfitTrailer admin
Tue Nov 7 13:16:17 2017 -0800 24659f3 :
   Added get-sizes for github slack integration test
Mon Oct 9 15:44:59 2017 -0700 86c476d :
   Update mkreadme to use cover image and year
Fri Oct 6 09:34:47 2017 -0700 97a48e1 :
   Adding wallpaper convenience scripts to reget and get sizes of wallhaven dirs
Fri Oct 6 08:36:37 2017 -0700 330c0e3 :
   Add ffmpeg default options for encoding MP3
Thu Feb 2 12:00:47 2017 -0800 682b88d :
   Created yaml2json script to convert YAML to JSON
Mon Jan 30 08:41:40 2017 -0800 c955d8c :
   Rename all IFTTT scripts with .sh suffix
Mon Jan 30 08:35:11 2017 -0800 1349e20 :
   Added name, date, version, copyright header
Mon Jan 30 08:30:32 2017 -0800 b6cb16c :
   Rename ifttt with .sh suffix
Mon Jan 30 08:18:20 2017 -0800 e318cbf :
   Added examples to ifttt script
Sun Jan 29 17:44:37 2017 -0800 b50016c :
   Created ifttt script and convenience scripts that invoke it
Tue Dec 13 10:24:54 2016 -0800 ab699d8 :
   Recent updates, add xmldiff and findupthumbs
Thu Nov 17 18:26:49 2016 -0800 4657f2a :
   Add revlink, update get-all and get-search
Tue Oct 18 15:04:48 2016 -0700 cb7bdd4 :
   Add support for Photographers photo subdirs
Sat Oct 15 17:56:42 2016 -0700 b1a32c0 :
   Symbolic link checking and repairing scripts
Wed Oct 12 12:16:55 2016 -0700 267bb55 :
   Add quiet flag to wallhaven script
Sun Oct 9 15:54:10 2016 -0700 bd936af :
   Count added since last count, improved dup removal, improve get-all, clean, and findbroken
Wed Oct 5 10:24:00 2016 -0700 e78dbb2 :
   Use specified download dir if provided on command line
Wed Oct 5 08:48:57 2016 -0700 2bbc890 :
   Move findbroken.sh up from Wallpapers
Tue Oct 4 18:04:17 2016 -0700 9322614 :
   Fix fixlinks and findups, add links2files conversion script
Tue Oct 4 09:36:37 2016 -0700 32a3e12 :
   Update chkinst to handle Utils, get-list takes a 2nd arg
Mon Oct 3 14:40:34 2016 -0700 e961572 :
   Fix counts.sh for single directory
Mon Oct 3 13:41:24 2016 -0700 2de6502 :
   Add  get-list.sh, retrieve wallpapers using list of search terms
Mon Oct 3 13:32:32 2016 -0700 37914f9 :
   Adjust LSCOLORS, update chkinst to install Wallpapers/*.sh, write INSTALL instructions
Mon Oct 3 09:55:58 2016 -0700 8eb5a1d :
   Move utility functions wallutils and kv to Utils subdir
Mon Oct 3 09:13:54 2016 -0700 741a1f5 :
   Comment functions in counts.sh
Sun Oct 2 22:17:29 2016 -0700 fb99e64 :
   Replace _ with space in printed directory names
Sun Oct 2 20:43:42 2016 -0700 2dac453 :
   Source /usr/local/share/bash/..., use kv-bash if present. Improve counts
Sun Oct 2 10:28:02 2016 -0700 8855776 :
   Generalize fixlinks, added link fixing for models, improved findups
Fri Sep 30 14:48:21 2016 -0700 bb350e5 :
   Add vt220 to supported terminal types in dircolors
Fri Sep 30 14:28:50 2016 -0700 86a797f :
   Add .gitignore
Thu Sep 29 11:33:30 2016 -0700 372f700 :
   Simplify findups, only print percent done if it has changed
Tue Sep 27 13:29:02 2016 -0700 923beae :
   Add utility wallpaper scripts and maintenance scripts, support subdirs in People
Mon Sep 26 13:09:30 2016 -0700 42c1c27 :
   Update bash startup files, fix setwall, enhance diffem, update chkinst
Sun Sep 25 20:43:11 2016 -0700 9ce0ad1 :
   Set desktop picture working, still working on picture folder. Added option to revert setting
Sun Sep 25 19:54:57 2016 -0700 5b0d68a :
   Initial pass at osascript for setwall, add diff & inst commands
Sat Sep 24 19:20:24 2016 -0700 8db77db :
   Added shell files without .sh suffix to doxygen build
Sat Sep 24 18:04:22 2016 -0700 a504e1a :
   Sync README.md and doc/mainpage.sh
Sat Sep 24 17:40:09 2016 -0700 a6dc831 :
   Reflect name changes in README, rename wikivim
Sat Sep 24 17:31:05 2016 -0700 b6dd8b7 :
   Fixup paths, reflect name changes in README, update Doxyfile
Sat Sep 24 15:35:15 2016 -0700 7275e44 :
   Add doxygen generated doc
Sat Sep 24 15:33:45 2016 -0700 cc93e0b :
   Move doxygen mainpage to doc subdir and revert to github README
Sat Sep 24 15:30:53 2016 -0700 0cb2bf0 :
   Convert to use doxygen generated doc using bash-doxygen project
Sat Sep 24 10:47:09 2016 -0700 3277f6e :
   Rename shell scripts with .sh extension, use bash-doxygen to generate html doc
Sat Sep 24 00:43:02 2016 -0700 e6db2c7 :
   Add progress bar, split that and getopts/usage out into utils
Fri Sep 23 19:43:28 2016 -0700 b4176a1 :
   Improved search and symlinking
Wed Sep 21 19:58:18 2016 -0700 1752b38 :
   Enhance get wallhaven scripts, add findbroken and fixlinks scripts
Fri Sep 16 22:50:44 2016 -0700 c5c6edc :
   Improved wallpaper scripts
Fri Sep 16 15:58:38 2016 -0700 3cc299d :
   Added Wallpapers folder for wallpaper set/download scripts
Wed Jul 6 18:33:52 2016 -0700 dcdcb3d :
   update chrome mktheme
Sat May 7 08:31:33 2016 -0700 eca63e5 :
   Add mkicon and mktheme to README
Sat May 7 07:30:48 2016 -0700 bb16fc3 :
   Chrome Theme generator
Tue Jan 19 10:27:47 2016 -0800 cea9de9 :
   Update line diffs for bash startup files
Tue Jan 19 10:27:16 2016 -0800 88d4073 :
   Add -f flag to force new sums
Wed Jan 13 08:45:41 2016 -0800 f7fe2a8 :
   Use Vertical.png from the Github repo
Tue Jan 12 14:23:19 2016 -0800 e0ec1b2 :
   Added option to specify excludes, updated dirs to sync
Tue Jan 12 14:21:28 2016 -0800 af20a77 :
   Remove unused endblur() function
Tue Dec 29 10:04:03 2015 -0800 7ce95cc :
   Deal with both Aperture and Photos libraries, move iTunes library
Tue Oct 27 18:55:39 2015 -0700 58230e1 :
   Use new iTunes library location
Sat Oct 3 15:15:37 2015 -0700 9ef10d7 :
   Add Audiobooks to audlinks
Sun Sep 27 09:26:04 2015 -0700 11accdf :
   Add find2import
Mon Aug 10 08:46:29 2015 -0700 0059973 :
   Updated to work with both Aperture and Photos libraries
Sat Jul 25 12:43:08 2015 -0700 75f2654 :
   update line difference for bash_aliases
Sun Jul 19 11:42:21 2015 -0700 dfbc2ad :
   Added character interface for systems without AppleScript
Thu Jul 9 17:10:44 2015 -0700 1e40d7c :
   Options for output filename and use defaults
Tue Jul 7 23:10:29 2015 -0700 f87c76d :
   Use AppleScript dialogs to allow user to select audio and video devices to capture
Mon Jul 6 22:17:22 2015 -0700 165c268 :
   Added cap2any, screen capture with ffmpeg and write to specified video and audio format
Mon Jul 6 11:28:19 2015 -0700 21c88aa :
   Update chkinst
Sun Jul 5 21:04:30 2015 -0700 7eb6b94 :
   Generalize script
Sat Jul 4 18:58:57 2015 -0700 5bad737 :
   Add wikivim to README
Sat Jul 4 18:55:17 2015 -0700 6951b5e :
   Use Applescript and iTerm2 if on OS X, use xterm otherwise
Sat Jul 4 14:59:25 2015 -0700 8974115 :
   Add tab_bash to bashrc, create wikivim Applescript to vi Wikipedia in iTerm2
Sat Jul 4 11:02:46 2015 -0700 006e422 :
   updated sums for bashrc scripts
Sat Apr 18 08:34:27 2015 -0700 b75a1c2 :
   Update diff line counts
Sat Mar 28 14:33:46 2015 -0700 8115ce7 :
   Remove mvBackups and rmBackups as they are now symlinks to cpBackups
Sat Mar 28 14:32:40 2015 -0700 d87367f :
   Added cpBackups to copy backup database, with symlinks to mvBackups and rmBackups and command-line args to select
Sat Mar 28 12:08:12 2015 -0700 2d28038 :
   Display command use in usage message, use BYPASS variable for location of bypass command
Sat Mar 28 11:45:55 2015 -0700 63cbaa6 :
   Added scripts to move and remove Time Machine backup directories
Sat Mar 28 11:32:40 2015 -0700 2a496a7 :
   Update line counts
Sat Mar 28 11:29:43 2015 -0700 6033870 :
   Add option for reverse display
Wed Mar 11 12:26:56 2015 -0700 077ff8b :
   updated
Wed Mar 11 12:08:35 2015 -0700 c4b759b :
   Added gitlog script to format output of git log
Mon Feb 16 14:20:33 2015 -0800 8e54ad3 :
   add -b and -m options for both and music only
Mon Feb 9 14:46:17 2015 -0800 b6abf4a :
   Add quick option to piclinks
Sun Feb 1 10:58:14 2015 -0800 cc36c39 :
   Added convenience script filenumset
Sun Feb 1 09:50:54 2015 -0800 9f83206 :
   Added convenience scripts dash2space and filenuminc
Sat Jan 31 16:41:05 2015 -0800 a2d2f9e :
   Add verbose option
Sat Jan 31 16:06:11 2015 -0800 6089380 :
   Add report option
Sat Jan 31 16:05:31 2015 -0800 8968cae :
   Initial revisions, use getopt
Fri Jan 30 15:47:03 2015 -0800 ba80cc0 :
   Initial version of packaud, archive and compress my Audacity project files
Sat Jan 24 17:13:46 2015 -0800 c50fb1f :
   Updated bash_aliases line count
Sat Jan 24 17:11:09 2015 -0800 928b4d5 :
   Updated audlinks to check author/title dirs in iTunes, added JDK version switch aliases
Fri Nov 28 10:54:50 2014 -0800 6023a43 :
   Added eject convenience script to eject CD/DVD
Mon Oct 20 11:37:37 2014 -0700 8b33e94 :
   Increased bash_aliases differ count to 100
Mon Oct 20 11:36:55 2014 -0700 cab0268 :
   Fix find check for newer by also checking directories
Mon Aug 11 10:06:14 2014 -0700 d95bb3c :
   Added findgrep recursive grep in current directory
Sat Aug 2 18:49:05 2014 -0700 bbdfcf0 :
   4 space tabstop, shiftwidth
Thu Jul 24 10:46:52 2014 -0700 7ac4410 :
   bash_aliases line diff again
Thu Jul 24 10:30:25 2014 -0700 a82e24a :
   bash_aliases diff line count
Sat Jul 12 12:01:58 2014 -0700 1bcc963 :
   Do not use wildcard with rsync to avoid too many arguments
Sun Jul 6 18:27:08 2014 -0700 b5df45f :
   Added bash alias for day one log script
Sun Jul 6 10:45:51 2014 -0700 2d6f455 :
   Clean up comments wrt ffmpeg and audio conversion, add more example names
Sun Jun 29 12:07:12 2014 -0700 21ab6ed :
   Delay usage message until after option processing is done and directories are set
Sun Jun 29 11:59:13 2014 -0700 3218801 :
   Increased number of lines of diff for bash_aliases
Sun Jun 29 11:56:03 2014 -0700 c3e9478 :
   Added support for sync of Audio directory, fixed bug in directory option handling
Fri Jun 20 15:21:43 2014 -0700 69efd84 :
   Rename musiclinks to audlinks
Tue Jun 17 17:58:31 2014 -0700 22f4c1b :
   alias for audio dir
Sun Jun 15 10:59:26 2014 -0700 7685df5 :
   Reset defaults
Sun Jun 15 10:58:47 2014 -0700 edd479d :
   escape percent character in usage message
Mon May 19 13:34:54 2014 -0700 676cc4f :
   Add license and copyright
Mon May 12 10:06:23 2014 -0700 ad4c26a :
   Added findempty, find and optionally remove empty directories
Sat May 3 21:39:57 2014 -0700 10849fb :
   Added argument processing and usage
Thu May 1 16:58:49 2014 -0700 a869f89 :
   Created clndl script to clean the download area
Tue Apr 29 12:43:59 2014 -0700 19cbfe7 :
   Backslash brackets in filenames so grep doesn't barf
Wed Apr 23 14:24:02 2014 -0700 747fcf3 :
   Updated bash_aliases diff count
Wed Apr 16 19:10:54 2014 -0700 5abfb78 :
   Corrected comment on MacEarl version
Mon Apr 14 21:57:54 2014 -0700 8d4416e :
   Incorporated bugfix for wb, commented LICENSE so it can just be included in a shell script
Mon Apr 14 18:11:38 2014 -0700 cb1dec7 :
   Added list of installed files which differ from those in my git repo and prompt if updating any of these
Mon Apr 14 17:19:44 2014 -0700 85b46d3 :
   Obfuscate my email address
Mon Apr 14 17:10:42 2014 -0700 70c356c :
   Added script named 'only' - Report files or directories only in one directory hierarchy but not in a second directory hierarchy
Mon Apr 14 12:37:11 2014 -0700 5057b83 :
   Note this script is OS X specific
Sun Apr 13 11:22:45 2014 -0700 babd337 :
   Input and output format options -i and -o
Sat Apr 12 12:40:55 2014 -0700 0aa3773 :
   Added support for Bash and Vim startup files installed in the users Home directory
Sat Apr 12 12:02:36 2014 -0700 b168e0b :
   Add Bash and Vim startup files
Sat Apr 12 11:26:55 2014 -0700 3c02897 :
   Added stop_leapd script to replace auto start of Leap Motion daemon and agent with manual start/stop
Mon Apr 7 23:50:08 2014 -0700 79e70c6 :
   musiclinks description
Mon Apr 7 22:59:40 2014 -0700 5dd7b4a :
   Created musiclinks to symlink song files into my iTunes library
Thu Apr 3 15:49:42 2014 -0700 aa4ae10 :
   Updated chkall to conform to new options to chk and upd
Tue Apr 1 17:07:06 2014 -0700 1a286e7 :
   List dirs in Pictures and Movies rather than just Work
Tue Apr 1 13:48:55 2014 -0700 3ffd1e0 :
   Option to check if rsync needed prior to actual rsync
Mon Mar 31 11:21:07 2014 -0700 0efc974 :
   Set HOME_DIRS, add license
Mon Mar 31 10:28:53 2014 -0700 382bf73 :
   Get rsync exclude option syntax correct
Sun Mar 30 17:24:10 2014 -0700 85c6985 :
   Exclude .DS_Store from rsync
Sun Mar 30 13:50:36 2014 -0700 de94a4f :
   Added verbose option for rsync
Sat Mar 29 19:31:09 2014 -0700 3342df8 :
   Reflect name change of chkaplibs to chk
Sat Mar 29 19:26:15 2014 -0700 4c24dd4 :
   Rename chkaplibs to simply chk
Sat Mar 29 19:25:25 2014 -0700 2862f74 :
   Use options or command names to specify sync dirs
Sat Mar 29 18:52:50 2014 -0700 5aa5d15 :
   Renamed updaplibs to simply upd and renamed updtranscend to updflash
Sat Mar 29 18:36:58 2014 -0700 803491e :
   Added updtranscend
Sat Mar 29 18:35:21 2014 -0700 f0ee632 :
   Convenience script to frontend the rsyncs needed to sync my Transcend flash drive
Sat Mar 29 18:33:40 2014 -0700 c8ce66a :
   Wait to issue usage message until after options have been processed
Sun Mar 23 16:46:23 2014 -0700 153daa6 :
   Created piclinks similar to vidlinks for photo files
Sun Mar 23 16:43:38 2014 -0700 dd39160 :
   Fixed bug setting ck1 when using sums
Sun Mar 23 14:57:02 2014 -0700 6ae33ab :
   Renamed femvidlinks to vidlinks
Wed Mar 19 23:55:08 2014 -0700 e61bf60 :
   Support for option to follow symbolic links when rsyncing
Sat Mar 15 17:32:17 2014 -0700 9c48679 :
   Use the SUMS file if comparing cksums
Sat Mar 15 15:46:50 2014 -0700 8bb747d :
   Improved usage message, added support for Aperture slide shows, skip dirs that don't exist
Mon Mar 10 10:30:01 2014 -0700 8438662 :
   Tell the user when updates are happening
Mon Mar 10 10:25:17 2014 -0700 2af1a0c :
   fixed bug not recognizing -f option
Mon Mar 10 10:23:50 2014 -0700 f20ab27 :
   default to wmv2mp4, prompt before creating output directory if it does not already exist
Mon Mar 10 10:01:35 2014 -0700 e9b71e5 :
   Separate options for specifying audio and video bitrates
Sun Mar 9 12:19:14 2014 -0700 f69067d :
   Added install feature to chkinst, move PREFIX up to user config section in wb
Sun Mar 9 11:39:58 2014 -0700 1bbff21 :
   Added copyright and license to each script
Sun Mar 9 04:01:50 2014 -0700 bd8ab41 :
   Add license file
Sun Mar 9 03:43:57 2014 -0700 8db2823 :
   Added support for adding file to iTunes upon completion of conversion, clarify use of presets, default to slow preset
Sun Mar 9 00:41:57 2014 -0800 ebcc41d :
   Improve to work with any specified path to input files
Sat Mar 8 23:46:52 2014 -0800 e766cb9 :
   Add add2itunes script which adds media files to an iTunes library via the command line.
Sat Mar 8 22:46:06 2014 -0800 c4132d3 :
   Added mvfem
Sat Mar 8 21:24:46 2014 -0800 dfd8772 :
   Add support for qscale argument and special case wb
Sat Mar 8 20:31:17 2014 -0800 7168108 :
   Specify defaults for additional formats, improve quality, add some options for specifying bitrate and preset
Sat Mar 8 13:07:09 2014 -0800 6701459 :
   Added chkinst and mandelhist
Sat Mar 8 08:41:36 2014 -0800 5617336 :
   Add support for -a option to updgit
Sat Mar 8 08:24:35 2014 -0800 f35a5ad :
   Added updgit convenience script
Fri Mar 7 17:39:53 2014 -0800 b656a11 :
   Trying to get link to Vertical.png to work
Fri Mar 7 17:37:30 2014 -0800 a82b945 :
   bold text for image
Fri Mar 7 17:32:33 2014 -0800 1f74a41 :
   Added Vertical.png
Fri Mar 7 17:30:11 2014 -0800 d54794e :
   Added mkseamless and mkcomps
Fri Mar 7 17:01:17 2014 -0800 2e68c63 :
   Initial debug and fixes - first run success
Fri Mar 7 16:12:30 2014 -0800 d00a276 :
   Link to scripts in README
Fri Mar 7 15:58:04 2014 -0800 9841e5f :
   Testing my first use of basic markdown
Fri Mar 7 15:46:59 2014 -0800 aa100bd :
   Added any2any video converter
Fri Mar 7 00:13:23 2014 -0800 08d51ca :
   Updated with new description of wb
Fri Mar 7 00:13:02 2014 -0800 0f9cd9d :
   Latest version of my version of MacEarl's Wallbase auto downloader
Fri Mar 7 00:07:43 2014 -0800 7a130d5 :
   Delete wb
Thu Mar 6 20:46:56 2014 -0800 9dab8f2 :
   added wb description
Thu Mar 6 20:44:28 2014 -0800 8faf238 :
   Newer version of wb
Thu Mar 6 20:42:06 2014 -0800 ea21726 :
   Older initial version of wb
Thu Mar 6 20:38:47 2014 -0800 dac5036 :
   added SSH clone url
Thu Mar 6 20:19:34 2014 -0800 c98148c :
   Add brief descriptions for contents
Thu Mar 6 20:16:06 2014 -0800 e7b009c :
   Initial Scripts git repo
Thu Mar 6 19:48:50 2014 -0800 dfeacfd :
   Initial commit
