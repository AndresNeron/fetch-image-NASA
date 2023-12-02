#!/bin/bash

# This function receives $year value.
function download_images() {
	year=$1

	get_Dates2 $year

	total=$(cat "$default_path/Dates/Dates_$year.txt" | wc -l )
	for i in $(seq 1 $total); do
		date=$(cat "$default_path/Dates/Dates_$year.txt" | awk "NR==$i")
		if [ "$global_error" == "false" ]; then
			download_image $date
		else
			return
		fi
	done

	echo -e "${grayColour}Total url checked: $count_total${endColour}"
	echo -e "${redColour}Failed paths: $count_fails${endColour}"
	for path in "${fails[@]}"; do
		echo -e "${redColour}$path ${endColour}"
	done

	tput cnorm
}
