#!/bin/bash

function display_wallpapers_candidates() {
		txt_path="$default_path/Paths//Paths/wallpapers_candidates2.txt"

		lines=$(cat "$txt_path" | wc -l)
		shuffled_lines=$(shuf "$txt_path")

		for line in $(seq 1 $lines); do
			image_path=$(echo "$shuffled_lines" | awk "NR==$line")
			wallpaper_displayed $image_path
		done
}
