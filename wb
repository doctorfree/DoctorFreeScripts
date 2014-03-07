#!/bin/bash
#
# wallbase - wallbase.net batch downloader modified 25-Nov-2011 by Ron Record
#      (ronaldrecord@gmail.com) to download my favorites
#
# Usage: wb [name of favorite set]
#
# Enter your username, password, and location of your Wallbase directory below
#
# Based on WallBase 2.2 from http://4geeksfromnet.com:
#
# This script gets the beautiful wallpapers from http://wallbase.cc
# This script is brought to you by 7sins@4geeksfromnet.com
# and at present is actively maintained by MacEarl
#
#
# Revision 2.2
# 1. Source Cleanup by Axa-Ru
# 2. Fixed Download Code for new System
# 3. Improved the check for already downloaded Files (much faster ;))
#
#
# Revision 2.1
# 1. Added a Feature to download "Your Favorites"
# 2. Added a Feature to download "user created collections"
# 3. Rewrote the check for already downloaded Files
#    (You now can rename or remove Wallpapers and they dont get downloaded again.
#     Eg. If you don''t like a wallpaper, just delete it and it won''t get downloaded again.
#     To re-enable the download of a specific Wallpaper you need to remove the
#     Wallpaper number from the file "downloaded.txt")
#
#
# Revision 2.0
# Contributed by MacEarl
# 1. Rewritten code for new Wallbase System
#
#
# Revision 1.2.1
# Contributed by MacEarl
# 1. Added Login Check for new Wallpapers
#
#
# Revision 1.2
# Contributed by MacEarl
# 1. Added a login feature to download NSFW content/category
#
#
# Revision 1.1.1
# Contributed by Hab
# 1. Updated mkdir option with -p flag
#
#
# Revision 1.1
# Contributed by MacEarl
# 1. Added a Search Function
# 2. Added a check for already existing Files
# 3. Fixed a bug (imageshack mirrored files)
#
#
# Revision 1.0
# Contributed by MacEarl
# 1. Added the much needed fixes for NSFW category
# 2. Updated the script with more options
# 3. Modified the script
#
#
#
# Wallpapers can be sorted according to
#
###############################
### Section 1 :: Resolution ###
###############################
#
# Resolution
#   Accepted values are 0 => All Standard
#       800x600 | 1024x768 | 1280x960 | 1280x1024 | 1400x1050 | 1600x1200 | 2560x2048
#   Widescreen
#       1024x600 | 1280x800 | 1366x768 | 1440x900 | 1600x900 | 1680x1050 | 1920x1080 | 1920x1200 | 2560x1440 | 2560x1600
#
#################################
### Section 2 :: Aspect Ratio ###
#################################
#
# Aspect Ratio
#   Accepted values are 0 => All
#   1.33 => 4:3
#   1.25 => 5:4
#   1.77 => 16:9
#   1.60 => 16:10
#   1.70 => Netbook
#   2.50 => Dual
#   3.20 => Dual Wide
#   0.99 => Portrait
#
###############################
### Section 3 :: Category   ###
###############################
#
# Category : SFW, Sketchy, NSFW
# Each being toggled by a 1/0 value
#   So to get only SFW use 100
#   To get all categories use 111
#   To get Sketchy and NSFW use 011
#
###############################
### Section 4 :: Topic      ###
###############################
#
# Topic : Anime/Manga, Wallpapers/General, High Resolution Images
#   To get Anime/Manga use 1
#   To get Wallpapers/General use 2
#   To get HR Images use 3
#   To get all use 123
#   To get only HR and WP use 23 and so on
#
###############################
### Section 5 :: Size       ###
###############################
#
# Size: at least and Exactly width x height
#   To get at least desired Resolution use gteq
#   To get exactly desired Resolution use eqeq
#
###############################
### Section 6 :: THPP       ###
###############################
#
# Thumbnails per page.
#  Accepted values are 20, 32, 40, 60
#
###############################
### Section 7 :: Location   ###
###############################
#
# The download location Foldername of desired Location e.g. "Wallpapers"
#
###############################
### Section 8 :: Best of    ###
###############################
#
# Best of:
#  All time = 0
#  3Months  = 3m
#  2Months  = 2m
#  1Month   = 1m
#  2Weeks   = 2w
#  1Week    = 1w
#  3Days    = 3d
#  1Day     = 1d
#
###############################
### Section 9 :: Type       ###
###############################
#
# Random                    = 1
# Toplist                   = 2
# Newest                    = 3
# Search                    = 4
# Favourites                = 5
# User created collections  = 6
#
###############################
### Section 10 :: Order     ###
###############################
#
# Date                  = date
# Amount of Views       = views
# Number of Favorites   = favs
# Relevancie            = relevance
#
###############################
### Section 11 :: OrderType ###
###############################
#
# The following two Options are possible:
#  Ascending    = asc
#  Descending   = desc
#
###############################
### Section 12 :: Search    ###
###############################
# Define your Search Query like this:
#  ./wallbase.sh Mario
#  For longer Search Queries you need to set QUERY manually
#  For Example set QUERY="Link OR Zelda OR Legend of Zelda OR OoT"
#  Accepted Operators are "AND" and "OR"
#
###############################
### Section 13 :: Login  ######
###############################
# Due to changes in the wallbase.cc "Policy"
#  you now need to login to see NSFW Content
#  Please provide your Username and Password below
#  to download NSFW content
#  It is also needed if you want to download "your own Favorites" (Duh!)
#
###############################
### Section 14 :: Collection###
###############################
# This Option is used for downloading your Favorites (You need an account for the same)
#  and to download Collections created by other users
#  Set the value to "-1" to download your Favorites in your "Home" Collection.
#  To download User Collections or different Favorite Collections open the desired
#  Collection in your Browser and copy the following part
#  1. For your Favorites: http://wallbase.cc/user/favorites/"#number_of_the_collection"
#  2. For user created collections: http://wallbase.cc/user/collection/"#number_of_the_collection"
#  You only need the number which is shown at the end of the URL
#
###############################
### Needed for NSFW/New     ###
###############################

# See Section 14
# Enter your Username
USER=yourusername
# Enter your password
PASS=yourpassword

###############################
### End needed for NSFW/New ###
###############################

###############################
### Configuration Options   ###
###############################

# Define the maximum number of wallpapers that you would like to download MAX_RANGE=26460
MAX_RANGE=2048
# For accepted values of resolution see Section 1
RESOLUTION=0
# For accepted values of aspect ratio see Section 2
ASPECTRATIO=0
# For accepted values of category see Section 3
CATEGORY=001
# For accepted values of topic see Section 4
TOPIC=123
# For accepted values for SIZE see Section 5
SIZE=gteq
# For accepted Thumbnails per page see Section 6
THPP=60
# Best of : see Section 8
TIME=0
# For Types see Section 9
TYPE=5
# For order Options see Section 10
ORDER=relevance
# See Section 11
ORDER_TYPE=desc
# See Section 12
QUERY="$1"

# Location prefix
PREFIX=/home/Username/Pictures/Wallbase

# For download location see Section 7
LOCATION=$PREFIX/Space

# For collection setting See Section 13
COLLECTION=10842

###############################
## End Configuration Options ##
###############################

case $QUERY in
Breasts|breasts)
    LOCATION=$PREFIX/Breasts
    COLLECTION=12337
    ;;
Nudes_4|nudes_4)
    LOCATION=$PREFIX/Nudes_4
    COLLECTION=19445
    ;;
Anime_3|anime_3)
    LOCATION=$PREFIX/Anime_3
    COLLECTION=25437
    ;;
Pussy|pussy)
    LOCATION=$PREFIX/Pussy
    COLLECTION=12382
    ;;
Derriere|derriere|butt|Butt|Ass|ass)
    LOCATION=$PREFIX/Derriere
    COLLECTION=12475
    ;;
Wet|wet)
    LOCATION=$PREFIX/Wet
    COLLECTION=3452
    ;;
Asian|asian)
    LOCATION=$PREFIX/Asian
    COLLECTION=10841
    ;;
Evgenia|evgenia)
    LOCATION=$PREFIX/Evgenia
    COLLECTION=10873
    ;;
Corinna|corinna|Corrina|corrina)
    LOCATION=$PREFIX/Corinna
    COLLECTION=10874
    ;;
Monica|monica)
    LOCATION=$PREFIX/Monica
    COLLECTION=10916
    ;;
Klaudia|klaudia|Claudia|claudia)
    LOCATION=$PREFIX/Klaudia
    COLLECTION=11368
    ;;
Panties|panties)
    LOCATION=$PREFIX/Panties
    COLLECTION=19116
    ;;
Celeb|celeb)
    LOCATION=$PREFIX/Celeb
    COLLECTION=3160
    ;;
Anime|anime)
    LOCATION=$PREFIX/Anime
    COLLECTION=3159
    ;;
Anime_2|anime_2)
    LOCATION=$PREFIX/Anime_2
    COLLECTION=14951
    ;;
Art|art)
    LOCATION=$PREFIX/Art
    COLLECTION=12821
    ;;
Nudes|nudes)
    LOCATION=$PREFIX/Nudes
    COLLECTION=2150
    ;;
Nudes_2|nudes_2)
    LOCATION=$PREFIX/Nudes_2
    COLLECTION=11397
    ;;
Nudes_3|nudes_3)
    LOCATION=$PREFIX/Nudes_3
    COLLECTION=13164
    ;;
Dragonflies|dragonflies)
    LOCATION=$PREFIX/Dragonflies
    COLLECTION=3234
    ;;
Fractals|fractals)
    LOCATION=$PREFIX/Fractals
    COLLECTION=10843
    ;;
Space|space)
    LOCATION=$PREFIX/Space
    COLLECTION=10842
    ;;
Waterfalls|waterfalls)
    LOCATION=$PREFIX/Waterfalls
    COLLECTION=3233
    ;;
esac

mkdir -p $LOCATION
cd "$LOCATION"

if [ $CATEGORY == 001 ] || [ $CATEGORY == 011 ] || [ $CATEGORY == 111 ] || [$TYPE == 3 ] || [$TYPE == 5 ] || [$TYPE == 6 ] ; then
    if [ $USER == yourusername ] ; then
        echo "Please check the needed Options for NSFW/New Content (username and password)"
        echo ""
        echo "For further Information see Section 14"
        echo ""
        echo "Press any key to exit"
        read
        exit
    fi
    echo "username=$USER&usrname=$USER&pass=$PASS&nopass_email=wallbase@ronrecord.com&nopass=0&1=1" > login
    wget --keep-session-cookies --save-cookies=cookies.txt --referer=http://wallbase.cc/start/ --post-file=login http://wallbase.cc/user/login
    wget --keep-session-cookies --load-cookies=cookies.txt --save-cookies=cookies.txt --referer=wallbase.cc http://wallbase.cc/user/adult_confirm/1
    rm index.html
fi

if [ $TYPE == 1 ] ; then

    for (( count= 0; count< "$MAX_RANGE"; count=count+"$THPP" ));
        do
        wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc http://wallbase.cc/random/$TOPIC/$SIZE/$RESOLUTION/$ASPECTRATIO/$CATEGORY/$THPP
        URLSFORIMAGES="$(cat $THPP | grep -o "http:.*" | cut -d " " -f 1 | grep wallpaper)"
 		for imgURL in $URLSFORIMAGES
			do
			img="$(echo $imgURL | sed 's/.\{1\}$//')"
			number="$(echo $img | sed  's .\{29\}  ')"
			if cat downloaded.txt | grep "$number" >/dev/null
				then
					echo "File already downloaded!"
				else
					echo $number >> downloaded.txt
					wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc $img
					cat $number | egrep -o "http:.*(gif|png|jpg)" | egrep "wallbase2|imageshack.us|ovh.net" | wget --keep-session-cookies --load-cookies=cookies.txt --referer=http://wallbase.cc/wallpaper/$number -i -
					rm $number
			fi
			done
        rm $THPP
        done

else

if [ $TYPE == 2 ] ; then

    for (( count= 0; count< "$MAX_RANGE"; count=count+"$THPP" ));
        do
        wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc http://wallbase.cc/toplist/$count/$TOPIC/$SIZE/$RESOLUTION/$ASPECTRATIO/$CATEGORY/$THPP/$TIME
        URLSFORIMAGES="$(cat $TIME | grep -o "http:.*" | cut -d " " -f 1 | grep wallpaper)"
 		for imgURL in $URLSFORIMAGES
			do
			img="$(echo $imgURL | sed 's/.\{1\}$//')"
			number="$(echo $img | sed  's .\{29\}  ')"
			if cat downloaded.txt | grep "$number" >/dev/null
				then
					echo "File already downloaded!"
				else
					echo $number >> downloaded.txt
					wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc $img
					cat $number | egrep -o "http:.*(gif|png|jpg)" | egrep "wallbase2|imageshack.us|ovh.net" | wget --keep-session-cookies --load-cookies=cookies.txt --referer=http://wallbase.cc/wallpaper/$number -i -
					rm $number
			fi
			done
		rm $TIME
        done

else

if [ $TYPE == 3 ] ; then

    for (( count= 0; count< "$MAX_RANGE"; count=count+"$THPP" ));
		do
		wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc http://wallbase.cc/search/$count/$TOPIC/$SIZE/$RESOLUTION/$ASPECTRATIO/$CATEGORY/$THPP
		URLSFORIMAGES="$(cat $THPP | grep -o "http:.*" | cut -d " " -f 1 | grep wallpaper)"
 		for imgURL in $URLSFORIMAGES
			do
			img="$(echo $imgURL | sed 's/.\{1\}$//')"
			number="$(echo $img | sed  's .\{29\}  ')"
			if cat downloaded.txt | grep "$number" >/dev/null
				then
					echo "File already downloaded!"
				else
					echo $number >> downloaded.txt
					wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc $img
					cat $number | egrep -o "http:.*(gif|png|jpg)" | egrep "wallbase2|imageshack.us|ovh.net" | wget --keep-session-cookies --load-cookies=cookies.txt --referer=http://wallbase.cc/wallpaper/$number -i -
					rm $number
			fi
			done
		rm $THPP
		done

else

if [ $TYPE == 4 ] ; then

	echo "query=$QUERY&board=$TOPIC&nsfw=$CATEGORY&res=$RESOLUTION&res_opt=$SIZE&aspect=$ASPECTRATIO&orderby=$ORDER&orderby_opt=$ORDER_TYPE&thpp=$THPP&section=wallpapers&1=1" > data
	wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc/ --post-file=data http://wallbase.cc/search/
	URLSFORIMAGES="$(cat index.html | grep -o "http:.*" | cut -d " " -f 1 | grep wallpaper)"
 		for imgURL in $URLSFORIMAGES
			do
			img="$(echo $imgURL | sed 's/.\{1\}$//')"
			number="$(echo $img | sed  's .\{29\}  ')"
			if cat downloaded.txt | grep "$number" >/dev/null
				then
					echo "File already downloaded!"
				else
					echo $number >> downloaded.txt
					wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc $img
					cat $number | egrep -o "http:.*(gif|png|jpg)" | egrep "wallbase2|imageshack.us|ovh.net" | wget --keep-session-cookies --load-cookies=cookies.txt --referer=http://wallbase.cc/wallpaper/$number -i -
					rm $number
			fi
			done
	rm index.html

	(( nsfw_sfw=(10#$CATEGORY / 100) ))
	(( nsfw_sketchy=(10#$CATEGORY % 100 / 10) ))
	(( nsfw_nsfw=(10#$CATEGORY % 10) ))

	for (( count= $THPP; count< "$MAX_RANGE"; count=count+"$THPP" ));
        do
        rm data
        echo "query=$QUERY&board=$TOPIC&res_opt=$SIZE&res=$RESOLUTION&aspect=$ASPECTRATIO&nsfw_sfw=$nsfw_sfw&nsfw_sketchy=$nsfw_sketchy&nsfw_nsfw=$nsfw_nsfw&thpp=$THPP&orderby=$ORDER&orderby_opt=$ORDER_TYPE&section=wallpapers&1=1" > data
        wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc/search --post-file=data http://wallbase.cc/search/$count
        URLSFORIMAGES="$(cat $count | grep -o "http:.*" | cut -d " " -f 1 | grep wallpaper)"
 		for imgURL in $URLSFORIMAGES
			do
			img="$(echo $imgURL | sed 's/.\{1\}$//')"
			number="$(echo $img | sed  's .\{29\}  ')"
			if cat downloaded.txt | grep "$number" >/dev/null
				then
					echo "File already downloaded!"
				else
					echo $number >> downloaded.txt
					wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc $img
					cat $number | egrep -o "http:.*(gif|png|jpg)" | egrep "wallbase2|imageshack.us|ovh.net" | wget --keep-session-cookies --load-cookies=cookies.txt --referer=http://wallbase.cc/wallpaper/$number -i -
					rm $number
			fi
			done
        rm $count
        done
    rm data

else

if [ $TYPE == 5 ] ; then
	for (( count= 0; count< "$MAX_RANGE"; count=count+"32" ));
		do
		wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc http://wallbase.cc/user/favorites/$COLLECTION/$count
		URLSFORIMAGES="$(cat $count | grep -o "http:.*" | cut -d " " -f 1 | grep wallpaper)"
 		for imgURL in $URLSFORIMAGES
			do
			img="$(echo $imgURL | sed 's/.\{1\}$//')"
			number="$(echo $img | sed  's .\{29\}  ')"
			if cat downloaded.txt | grep "$number" >/dev/null
				then
					echo "File already downloaded!"
				else
					echo $number >> downloaded.txt
					wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc $img
					cat $number | egrep -o "http:.*(gif|png|jpg)" | egrep "wallbase2|imageshack.us|ovh.net" | wget --keep-session-cookies --load-cookies=cookies.txt --referer=http://wallbase.cc/wallpaper/$number -i -
					rm $number
			fi
			done
		rm $count
		done

else

if [ $TYPE == 6 ] ; then
	for (( count= 0; count< "$MAX_RANGE"; count=count+"32" ));
		do
		wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc http://wallbase.cc/user/collection/$COLLECTION/1/$count
		URLSFORIMAGES="$(cat $count | grep -o "http:.*" | cut -d " " -f 1 | grep wallpaper)"
 		for imgURL in $URLSFORIMAGES
			do
			img="$(echo $imgURL | sed 's/.\{1\}$//')"
			number="$(echo $img | sed  's .\{29\}  ')"
			if cat downloaded.txt | grep "$number" >/dev/null
				then
					echo "File already downloaded!"
				else
					echo $number >> downloaded.txt
					wget --keep-session-cookies --load-cookies=cookies.txt --referer=wallbase.cc $img
					cat $number | egrep -o "http:.*(gif|png|jpg)" | egrep "wallbase2|imageshack.us|ovh.net" | wget --keep-session-cookies --load-cookies=cookies.txt --referer=http://wallbase.cc/wallpaper/$number -i -
					rm $number
			fi
			done
		rm $count
		done
else

echo error in TYPE please check Variable

fi
fi
fi
fi
fi
fi

rm "1" "cookies.txt" "login"
