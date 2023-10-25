#!/bin/bash

function all_wallpapers_candidates() {
		txt_path="$default_path/Paths//Paths/wallpapers_candidates2.txt"

		lines=$(cat "$txt_path" | wc -l)
		shuffled_lines=$(shuf "$txt_path")

	
		seconds="$global_seconds"

		for line in $(seq 1 $lines); do
			count=1

			image_path=$(echo "$shuffled_lines" | awk "NR==$line")
			identify -format "%w %h %i\n" "$image_path"
			set_Background_full_path $image_path
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
