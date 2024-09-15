#!/bin/bash

# Input is absolute path.
wallpaper_displayed() {
		# Do whatever you want with $image_path
		image_path=$1
		identify -format "%w %h %i\n" "$image_path"

		#echo "$image_path"

		image_filename="${image_path##*/}"
		directory1="${image_path%/*}"
		directory2="${directory1##*/}"

		html_path="$directory1/$directory2.html"

		if [ "$firefox_var" -eq 1 ]; then
			firefox "$html_path"
		fi

		trap 'cleanup' SIGINT

		seconds="$global_seconds"
		count=1


		# Display the image using eog in the background
		timeout "${seconds}s" eog -f "$image_path" 2>&1 &
		# Store the PID of the eog process
		eog_pid=$!

		# Start the loop to print the countdown in the foreground
		while [ "$count" -le "$seconds" ]; do
			echo "$count"
			sleep 1
			count=$((count+1))
		done

		# Wait for the eog process to finish
		wait $eog_pid
		#kill $eog_pid

}
