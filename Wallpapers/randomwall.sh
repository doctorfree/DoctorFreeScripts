#!/usr/bin/env bash
#
# randomwall.sh - download a random wallpaper image from Unsplash
#
# From https://randthoughts.github.io/random-wallpaper-with-just-bash-and-systemd/
# Modified by Ronald Record <ronaldrecord@gmail.com>

# Add your Unsplash access key here:
ACCESS_KEY="YOUR-UNSPLASH-ACCESS-KEY"

# Select an Unsplash topic ID:
# 
# Current Events: BJJMtteDJA4
# Wallpapers: bo8jQKTaE0Y (the one I use)
# 3D Renders: CDwuwXJAbEw
# Textures & Patterns: iUIsnVtjB0Y
# Experimental: qPYsDzvJOYc
# Architecture: rnSKDHwwYUk
# Nature: 6sMVjTLSkeQ
# Business & Work: aeu6rL-j6ew
# Fashion: S4MKLAsBB74
# Film: hmenvQhUmxM
TOPIC="bo8jQKTaE0Y" # "Wallpapers"

# Specify the wallpaper background folder to use:
WALLPAPER_DIR="${HOME}/.local/share/backgrounds"

if ! photo_path="$(mktemp -p "${WALLPAPER_DIR}" "unsplash.com.XXXXXXXXXX.jpg")"
then
  >&2 echo "Error: failed to create temporary file."
  exit 1
fi

if ! photo_url="$(curl --silent --show-error --header "Authorization: Client-ID ${ACCESS_KEY}" \
  "https://api.unsplash.com/photos/random?orientation=landscape&topic=${TOPIC}" \
  | grep --ignore-case --only-matching --perl-regexp '(?<=download":").*?(?=")')"
then
  >&2 echo "Error: failed to retrieve download URL."
  exit 1
fi

if ! curl --silent --show-error --location --header "Authorization: Client-ID ${ACCESS_KEY}" \
  --output "${photo_path}" "${photo_url}"
then
  >&2 echo "Error: failed to download photo."
  exit 1
fi

for setting_name in "background" "screensaver"; do
  if ! gsettings set "org.gnome.desktop.${setting_name}" "picture-uri" "file:///${photo_path}"
  then
    >&2 echo "Error: failed to set photo as ${setting_name}."
    exit 1
  fi
done
