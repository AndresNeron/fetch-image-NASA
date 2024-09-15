#!/bin/bash

# Receives Date.
# Gnome and Xfce4 cases
set_Background() {
	date=$1
	image_path="$default_path2/$date"
	image=$(ls "$image_path" | grep -v "html")
	image="$image_path/$image"

	if [ "$firefox_var" -eq 1 ]; then
		firefox "$image_path/$date.html"
	fi

	if echo "$DESKTOP_SESSION" | grep -qi "xfce"; then
		# For workspace 0
		xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace0/last-image -s "$image"
		xfdesktop --reload
	elif echo "$DESKTOP_SESSION" | grep -qi "gnome"; then
		gsettings set org.gnome.desktop.background picture-uri-dark "file://$image"
	else
		echo "[*] Unsupported desktop environment: $DESKTOP_SESSION"
	fi
}


# Method for setting the background.
# XFCE4 case
set_Background_Xfce(){

	# If this output is xfce, then we know the environment
	echo "$XDG_CURRENT_DESKTOP"
	echo "$DESKTOP_SESSION"

	image="/mnt/Kali/usr/share/backgrounds/astronomy/NASA/Images/240308/Tarantula-HST-ESO-Webb-LL.jpg"

	echo "$image"

	# For workspace 0
	xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace0/last-image -s "$image"
	xfdesktop --reload
}
