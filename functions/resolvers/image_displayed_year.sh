#!/bin/bash

# The input is Year.
function image_displayed_year() {
		year=$1
		txt_path="$default_path/Dates/Dates_$year.txt"
		
		lines=$(cat "$txt_path" | wc -l)
		shuffled_lines=$(shuf "$txt_path")

		for line in $(seq 1 $lines); do
			date=$(echo "$shuffled_lines" | awk "NR==$line")
			image_displayedd $date
		done
}
