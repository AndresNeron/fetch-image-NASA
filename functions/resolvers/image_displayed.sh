#!/bin/bash

# The input is Year. 
image_displayed() {
	year=$1
	image_path="$default_path2/$year"

	if [ "$firefox_var" -eq 1 ]; then
		firefox "$image_path/$year.html"
	fi

	image_path=$(find "$image_path" -type f -not -name "*.html")
	identify -format "%w %h %i\n" "$image_path"
	eog -f "$image_path"
}
