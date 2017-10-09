#!/bin/bash
#
## @file mkreadme.sh
## @brief Creates a 00_Readme.html in all subdirectories
## @remark Assumes a directory and file structure of Artist/Album/Tracks.
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2014, Ronald Joe Record, all rights reserved.
## @date Written 23-Aug-2012
## @version 1.0.1
##
## A quick way to populate my USB drives with HTML documents to provide
## an initial way to navigate around. This currently only dives two levels
## deep to allow for Artist/Album/Tracks directory structure:
##
## Artist Name/
##     Album Name/
##         Pics/if-any.jpg (put cover art and other pics in Pics folder)
##         Track1.m4a
##         Track2.m4a (and so on, any file format)
##         Year (contents of Year file should just be year released in parens)
##
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# The Software is provided "as is", without warranty of any kind, express or
# implied, including but not limited to the warranties of merchantability,
# fitness for a particular purpose and noninfringement. In no event shall the
# authors or copyright holders be liable for any claim, damages or other
# liability, whether in an action of contract, tort or otherwise, arising from,
# out of or in connection with the Software or the use or other dealings in
# the Software.
#
# You can customize here with your own name, email, etc
URL="http://example.com/yourname"
FIRST="YourFirst"
LAST="YourLast"
EMAIL="you@youremail.com"
ADDRESS="555 Your Street, Your Town, Zip"
# End customize section

H=`pwd`
R="00_Readme.html"
HEAD="<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">
<html>
<head>
<title>"
BODY="</title>
<meta name=\"Generator\" content=\"Vim/7.2\">
<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\">
</head>
<body><font face=\"monospace\">
<br>"
TRACKS="<br>Tracklist:<br><br>"
ALBUMS="Album:<br><br>"
TAIL="<br>
Enjoy!<br>
<a href=\"$URL\">$FIRST $LAST</a><br>
<a href=\"mailto:$EMAIL\">$EMAIL</a><br>
</font></body>
</html>"

## @fn Create_Readme()
## @brief Concatenate the header, supplied HTML text, body, and tags
## @param param1 Directory in which to create Readme
Create_Readme() {
    echo $HEAD > $R
    echo "$1" >> $R
    echo $BODY >> $R
    echo "<h1>$1</h1>" >> $R
}

## @fn Add_Album()
## @brief Add an album to Readme in specified directory
## @param param1 Directory in which to add album to Readme
Add_Album() {
    [ "$1" = "$R" ] || {
      [ "$1" = "*" ] || {
          echo "&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"./$1/$R\">
$1</a><br>" >> $R
      }
    }
}

## @fn Add_Track()
## @brief Add a track to an album in Readme of specified directory
## @param param1 Directory in which to add track to album in Readme
Add_Track() {
    [ "$1" = "$R" ] || {
      [ "$1" = "*" ] || {
          echo "&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"./$1\">
$1</a><br>" >> $R
      }
    }
}

Top=
[ -f $R ] || {
    Top=1
    echo "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">
<html>
<head>
<title>$FIRST's USB Drive</title>
<meta name=\"Generator\" content=\"Vim/7.2\">
<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\">
</head>
<body><font face=\"monospace\">
This USB drive belongs to $FIRST $LAST.<br>
Please return to $ADDRESS<br>
or drop it of with one of the bartenders at burger. :)<br>
<br>
Contact $FIRST via email: <a href=\"mailto:$EMAIL\">
$EMAIL</a><br>
<br>
Contents:<br>
<br>
<a href=#0-9>0-9</a> <a href=#A>A</a> <a href=#B>B</a> <a href=#C>C</a> <a href=#D>D</a> <a href=#E>E</a> <a href=#F>F</a> <a href=#G>G</a> <a href=#H>H</a> <a href=#I>I</a> <a href=#J>J</a> <a href=#K>K</a> <a href=#L>L</a> <a href=#M>M</a> <a href=#N>N</a> <a href=#O>O</a> <a href=#P>P</a> <a href=#Q>Q</a> <a href=#R>R</a> <a href=#S>S</a> <a href=#T>T</a> <a href=#U>U</a> <a href=#V>V</a> <a href=#W>W</a> <a href=#X>X</a> <a href=#Y>Y</a> <a href=#Z>Z</a> <a href=#a-z>a-z</a>
<br>
<a name=0-9></a> 
<ul>" > $R
}

ANCHOR=A
PREVIOUS=
FILES=
for i in *
do
    [ -d "$i" ] && {
        # Is this an empty directory ? If so, delete it
        FILES=`ls -A "$i"`
        [ "$FILES" ] || {
            echo "Removing empty artist directory $i"
            rmdir "$i"
            continue
        }
        FILES=
        # Do we need to add an anchor here ?
        LETTER=`echo ${i:0:1}`
        [ "$LETTER" = "$ANCHOR" ] && {
            echo "<a name=$ANCHOR></a><br>" >> $R
            ANCHOR=
            PREVIOUS=$LETTER
        }
        [ "$PREVIOUS" ] && {
            [ "$LETTER" = "$PREVIOUS" ] || {
                # Are we to the a-z section yet ?
                LOWER=`echo $LETTER | tr '[:upper:]' '[:lower:]'`
                if [ "$PREVIOUS" = "Z" ] || [ "$LETTER" = "$LOWER" ]
                then
                    echo "<a name=a-z></a><br>" >> $R
                    PREVIOUS=
                else
                    echo "<a name=$LETTER></a><br>" >> $R
                    PREVIOUS=$LETTER
                fi
            }
        }
        cd "$i"
        [ "$Top" ] && {
	        echo "<li><a href=\"$i/$R\">$i</a><br><ul>" >> ../$R
        }
        Created=
        [ -f $R ] || {
	        Create_Readme "$i"
            echo $ALBUMS >> $R
	        Created=1
	    }
        EMPTY=
        FILES=
        for j in *
        do
    	    [ -d "$j" ] && {
                # Is this an empty directory ? If so, delete it
                FILES=`ls -A "$j"`
                [ "$FILES" ] || {
                    echo "Removing empty album directory $i/$j"
                    rmdir "$j"
                    [ "$(ls -A)" ] || {
                        EMPTY=1
                    }
                    continue
                }
                FILES=
	        cd "$j"
		    year=
		    [ -r Year ] && year=`cat Year`
	        [ "$Top" ] && {
	            echo "<li><a href=\"$i/$j/$R\">
$i - &quot;$j&quot; $year</a><br>" >> ../../$R
            }
            [ -f $R ] || {
	            Create_Readme "$i"
                echo "<h2>\"$j\"</h2>" >> $R
		        [ -f Year ] && {
                    echo "<h2>$year</h2>" >> $R
                }
		        [ -f cover.jpg ] && {
			        echo "<br><img src=\"cover.jpg\" alt=\"cover.jpg\" border=0><br>" >> $R
	            }
                echo $TRACKS >> $R
	            for k in *
	            do
			        [ "$k" = "Year" ] && continue
			        [ "$k" = "cover.jpg" ] && continue
			        [ -d "$k" ] && continue
	                Add_Track "$k"
	            done
		        [ -d Pics ] && {
		            for pic in Pics/*
			        do
			            [ "$pic" = "Pics/*" ] && continue
			            echo "<br><a href=\"$pic\"><img src=\"$pic\" alt=\"$pic\" border=0></a><br>" >> $R
			        done
	            }
		        echo $TAIL >> $R
	        }
		    cd ..
	        }
	        [ "$Created" ] && {
	            Add_Album "$j"
	        }
	    done
        [ "$Created" ] && {
	        echo $TAIL >> $R
	    }
	    cd ..
        [ "$Top" ] && {
            echo "<br></ul>" >> $R
        }
        [ "$EMPTY" ] && {
            echo "Removing empty artist directory $i"
            echo "You may want to re-run this script"
            rmdir "$i"
            EMPTY=
        }
    }
    cd "$H"
done
[ "$Top" ] && {
    echo "</ul><br></font></body></html>" >> $R
}
