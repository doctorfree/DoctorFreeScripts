#!/bin/bash

inst=`type -p osascript`
if [ "$inst" ]
then
osascript <<EOF
  tell application "Music"
    set trackName to name of current track
    set artistName to artist of current track
    set albumName to album of current track
    set output to ("Song: " & trackName & " - " & "Artist: " & artistName & " - " & "Album: " & albumName)
    do shell script "echo " & quoted form of output
  end tell
EOF
else
    echo "osascript not found in $PATH"
fi
