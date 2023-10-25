#!/bin/bash

# The input is Year to filter.
# The function saves the list of Dates in a file named "Dates_$1.txt"
function get_Dates() {
	filter_year=$1

	years=()
	for ((i = 23; i >= 0; i--)); do
		formatted_year=$(printf "%02d" "$i")
		years+=("$formatted_year")
	done

	months=()
	for ((i = 1; i <= 12; i++)); do
		formatted_month=$(printf "%02d" "$i")
		months+=("$formatted_month")
	done

	days=()
	for ((i = 1; i <= 31; i++)); do
		formatted_day=$(printf "%02d" "$i")
		days+=("$formatted_day")
	done

	if [ "$filter_year" = "23" ]; then
		current_date=$(date +'%y%m%d')
	else
		current_year=$(date -d "$filter_year-12-31" +'%y')
    	current_date="${current_year}1231"
	fi

	all_dates=()
	found_current_date=false

	for i in ${years[@]}; do
		for j in ${months[@]}; do
			for k in ${days[@]}; do
				formatted_date="${i}${j}${k}"
				#echo "${month[j]}"
				#echo "$formatted_date"
				if ((formatted_date <= current_date)); then
					all_dates+=("$formatted_date")
					if [ "$formatted_date" = "$current_date" ]; then
						found_current_date=true
						break 3
					fi
				else
					break 
				fi
			done
			if [ "$found_current_date" = true ]; then
				break 2
			fi
		done
	done

	if [ ! -d "$default_path/Dates" ]; then
		mkdir -p "$default_path/Dates"
	fi

	if [ -e "$default_path/Dates/Dates_$filter_year.txt" ]; then
		rm "$default_path/Dates/Dates_$filter_year.txt"
		touch "$default_path/Dates/Dates_$filter_year.txt"
	fi


	count=1
	for ((index = ${#all_dates[@]} - 1; index >= 0; index--)); do
		dates="${all_dates[index]}"
		if [[ $dates =~ ^$filter_year ]]; then
			echo "$dates" >> "$default_path/Dates/Dates_$filter_year.txt"
		fi
		let count+=1
	done

	tput cnorm

}
