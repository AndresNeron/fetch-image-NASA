#!/bin/bash

set_all_wallpapers() {
	year=$1
	txt_path="$default_path/Dates/Dates_$year.txt"
	
	lines=$(cat "$txt_path" | wc -l)
	shuffled_lines=$(shuf "$txt_path")

	seconds="$global_seconds"

	for line in $(seq 1 $lines); do
		count=1

		date=$(echo "$shuffled_lines" | awk "NR==$line")
		
			# Obtain the full image path using date
			image_path="$default_path2/$date"
			
			if [ "$firefox_var" -eq 1 ]; then
				firefox "$image_path/$date.html"
			fi

			image=$(ls "$image_path" | grep -v "html")
			image="$image_path/$image"

			#echo "identify -format %w %h %i\n $image"
			#identify -format "%w %h %i\n" "$image"
			identify -format "%wx%h %i" "$image" && set_Background "$date"

		#set_Background $date
		wallpaper_pid=$!
		
		# Start the loop to print the countdown in the foreground
		while [ "$count" -le "$seconds" ]; do
			echo "$count"
			sleep 1
			count=$((count+1))
		done
	done

	# Wait for the eog process to finish
	wait $wallpaper_pid
}
