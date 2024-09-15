#!/bin/bash

# The input is Date
image_displayedd() {
		date=$1
		# Do whatever you want with $image_path
		image_path="$default_path2/$date"
		
		if [ "$firefox_var" -eq 1 ]; then
			firefox "$image_path/$date.html"
		fi

		image=$(ls "$image_path" | grep -v "html")
		image="$image_path/$image"
		echo "$image"
		
		trap 'cleanup' SIGINT

		seconds="$global_seconds"
		count=1


		# Display the image using eog in the background
		timeout "${seconds}s" eog -f "$image" 2>&1 &
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
