#!/bin/bash

function get_Dates2 (){
	filter_year="20$1"
	start_date="${filter_year}-01-01"

	if [ "$filter_year" = "2023" ]; then
		end_date=$(date +'%Y-%m-%d')
	else
		end_date="${filter_year}-12-31"
	fi


	if [ ! -d "$default_path/Dates" ]; then
		mkdir -p "$default_path/Dates"
	fi

	# Create the path where the Dates will be saved
	desired_path="$default_path/Dates/Dates_$1.txt"	
	if [ -e "$desired_path" ]; then
		rm "$desired_path"
		touch "$desired_path"
	else 
		touch "$desired_path"
	fi

	# Generate dates and filter out invalid ones
	current_date="$start_date"
	while [ "$current_date" != "$end_date" ]; do
		formatted_date=$(date -d "$current_date" +'%y%m%d')
		#echo "$formatted_date"
		echo "$formatted_date"  >> "$desired_path"
		current_date=$(date -d "$current_date + 1 day" +'%Y-%m-%d')
	done


	# Print the end date
	formatted_end_date=$(date -d "$end_date" +'%y%m%d')
	echo "$formatted_end_date" >> "$desired_path"
	tac "$desired_path" > tmp_file && mv tmp_file "$desired_path"
}
