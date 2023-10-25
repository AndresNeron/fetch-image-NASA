#!/bin/bash

# Receives Date.
function set_Background() {
	date=$1
	image_path="$default_path2/$date"
	image=$(ls "$image_path" | grep -v "html")
	image="$image_path/$image"

	if [ "$firefox_var" -eq 1 ]; then
			firefox "$image_path/$date.html"
	fi

	gsettings set org.gnome.desktop.background picture-uri-dark "file://$image"

}
