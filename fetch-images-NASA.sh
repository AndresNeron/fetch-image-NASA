#!/bin/bash

# This code fetchs the Astronomy Picture of the Day from NASA,
# and configure it as the desktop background. 
# You can download NASA's daily pictures in mass.

# Author: Grimaldi

#Colours
orangeColour="\e[0;32m\033[1m"
greenColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
purpleColour="\e[0;34m\033[1m"
grayColour="\e[0;37m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
endColour="\033[0m"

trap ctrl_c INT

function ctrl_c() {
    echo -e "\n${redColour}[!] Exiting...\n${endColour}"
    tput cnorm; 
    exit 1
}

function BackUp() {

	Backup_path="/opt/Backup/NASA"

    local script_dir="$(dirname "$0")"
	
    if [ ! -d "/opt/Backup/NASA" ]; then
        mkdir -p "/opt/Backup/NASA"
        if [ $? -ne 0 ]; then
            echo "Failed to create backup directory."
            return 1
        fi
    fi

    cp "$script_dir/fetch-images-NASA.sh" "/opt/Backup/NASA"
    if [ $? -ne 0 ]; then
        echo "Failed to create backup."
        return 1
    fi

    #echo "Backup of this program at $Backup_path"
    return 0
}

function helpPanel(){
	for i in $(seq 1 65); do echo -ne "${grayColour}-"; done; echo -ne ${endColour}
	echo -e "\n${purpleColour}This program fetchs the Astronomy Picture of the Day from NASA.${endColour}" 
	echo -e "${purpleColour}Display it as gallery or configure it as the desktop background.${endColour}"
	echo -e "${purpleColour}You can download NASA's daily pictures in mass too.${endColour}"
	for i in $(seq 1 65); do echo -ne "${grayColour}-"; done; echo -ne ${endColour}
	echo -e "\n${grayColour} [!] Usage:${endColour} ${orangeColour}./fetch-images-NASA.sh ${endColour} [options]"
	for i in $(seq 1 35); do echo -ne "${grayColour}-"; done; echo -ne ${endColour}
	echo -e "\n\t${orangeColour}-g\t${endColour}${grayColour} Get dates in format %y%m%d from a specific year ${endColour}"
	echo -e "\t${orangeColour}-d\t${endColour}${grayColour} Download images from a specific year in mass${endColour}"
	echo -e "\t${orangeColour}-p\t${endColour}${grayColour} Change default path${endColour}"
	echo -e "\t${orangeColour}-i\t${endColour}${grayColour} Open a specific image ${endColour}"
	echo -e "\t${orangeColour}-b\t${endColour}${grayColour} Set background based on specific date ${endColour}"
	echo -e "\t${orangeColour}-y\t${endColour}${grayColour} Open all images from a specific year in a randomized gallery mode${endColour}"
	echo -e "\t${orangeColour}-w\t${endColour}${grayColour} Open all wallpaper candidates of all downloaded years in a randomized gallery mode${endColour}"
	echo -e "\t${orangeColour}-a\t${endColour}${grayColour} Sets all wallpaper candidates as you background ${endColour}"
	echo -e "\t${orangeColour}-u\t${endColour}${grayColour} Sets all images from a year as you background in randomized mode${endColour}"
	echo -e "\t${orangeColour}-s\t${endColour}${grayColour} Change the number of seconds in each image slideshow (default: 10)${endColour}"
	echo -e "\t${orangeColour}-f\t${endColour}${grayColour} Firefox switch to view the .html file${endColour}"
	echo -e "\t${orangeColour}-h\t${endColour}${grayColour} Show this help message${endColour}"
	echo -e "\n\t${orangeColour}Examples:\t${endColour}"
	echo -e "\t${turquoiseColour} ./fetch-images-NASA.sh${endColour}${orangeColour} -g${endColour} ${greenColour}23${endColour}"
	echo -e "\t${turquoiseColour} ./fetch-images-NASA.sh${endColour}${orangeColour} -d${endColour} ${greenColour}23${endColour}"
	echo -e "\t${turquoiseColour} ./fetch-images-NASA.sh${endColour}${orangeColour} -p${endColour} ${greenColour}"./new_path"${endColour} ${orangeColour}-g${endColour} ${greenColour}22${endColour}"
	echo -e "\t${turquoiseColour} ./fetch-images-NASA.sh${endColour}${orangeColour} -s${endColour} ${greenColour}60${endColour} ${orangeColour}-y${endColour} ${greenColour}23${endColour}"
	echo -e "\t${turquoiseColour} ./fetch-images-NASA.sh${endColour}${orangeColour} -f -s${endColour} ${greenColour}300${endColour} ${orangeColour}-w${endColour} ${greenColour}23${endColour}"
	exit 1
}

# This is the default path where the images will be saved.
# You can change it as needed.
default_path="/usr/share/backgrounds/astronomy/NASA"
if [ ! -d "$default_path" ]; then
	mkdir -p $default_path
fi

default_path2="$default_path/Images"
if [ ! -d "$default_path2" ]; then
	mkdir -p $default_path2
fi

# Receives new path
function change_Path() {
	default_path=$1
	if [ ! -d "$default_path" ]; then
		mkdir -p $default_path
	fi

	default_path2="$default_path/Images"
	if [ ! -d "$default_path2" ]; then
		mkdir -p $default_path2
	fi
}

# Global Variables
fails=()
count_total=0
count_fails=0
firefox_var=0

function firefox_switch() {
	firefox_var=1
}

# Receives Date.
function set_Background() {
	date=$1
	image_path="$default_path2/$date"
	image=$(ls "$image_path" | grep -v "html")
	image="$image_path/$image"

	if [ "$firefox_var" -eq 1 ]; then
			firefox "$image_path/$date.html"
	fi

	gsettings set org.gnome.desktop.background picture-uri-dark "file://$image"

}

# Receives absolute_path
function set_Background_full_path() {
	absolute_path=$1
	gsettings set org.gnome.desktop.background picture-uri-dark "file://$absolute_path"
}

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

# The input is Date
function image_displayedd() {
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
function download_image() {
	date=$1
	image_url="https://apod.nasa.gov/apod/ap$date.html"
	echo -e "${grayColour}Fetching -> $image_url ${endColour}"

	if [ -d "$default_path2/$date" ]; then
		echo -e "${orangeColour}Directory: $default_path/Images/$date${endColour}"
	else
		mkdir "$default_path2/$date"
		echo -e "${orangeColour}Directory: $default_path/Images/$date${endColour}"
	fi
	curl -s -o "$default_path2"/"$date"/"$date.html" "$image_url"
	
	error=false
	url_day=$(grep "jpg" "$default_path2/$date"/"$date.html" | cut -d '"' -f 2 | awk "NR==1")
	if [ -z "$url_day" ]; then
		url_day=$(grep "jpeg" "$default_path2/$date/$date.html" | cut -d '"' -f 2 | awk "NR==1")
	fi
	if [ -z "$url_day" ]; then
		url_day=$(grep "png" "$default_path2/$date/$date.html" | cut -d '"' -f 2 | awk "NR==1")
	fi
	if [ -z "$url_day" ]; then
		echo -e "${redColour}[!] Manually check if the server https://apod.nasa.gov/apod/ap$date.html exists ${endColour}\n"
		error=true
	fi
	url_jpg="https://apod.nasa.gov/apod/$url_day"

	part_2=$(echo "$url_day" | cut -d '/' -f 2)
	part_3=$(echo "$url_day" | cut -d '/' -f 3)

	if [ ! -f "$default_path2/$date/$part_3" ]; then
		if [ "$error" = false ]; then
			curl -o "$default_path2/$date/$part_3" "$url_jpg"
		else
			fails+=("$default_path2/$date/$part_3")
			let count_fails+=1
		fi
		let count_total+=1
		echo -e "${yellowColour}------------------------------------------------------------${endColour}"
	else
		echo -e "${turquoiseColour}Image already exists.${endColour}"
		echo -e "${yellowColour}------------------------------------------------------------${endColour}"
	fi
	
}

function wallpaper_candidate_paths() {
    # Check if the directory exists; if not, create it
    if [ ! -d "$default_path/Paths/Paths" ]; then
        mkdir -p "$default_path/Paths/Paths"
    fi

    # Find and display the paths of image files within "$default_path/Images" that are not "*.html" files
    find "$default_path/Images" -type f ! -name "*.html" > "$default_path/Paths/Paths/image_absolute_paths.txt"

	lines=$(cat "$default_path/Paths/Paths/image_absolute_paths.txt" | wc -l)
	
	for line in $(seq 1 $lines); do
		image_path=$(cat "$default_path/Paths/Paths/image_absolute_paths.txt" | awk "NR==$line")
		#identify -format "%w %h %i\n" "$image_path" | awk 'print $1, $2'
		
		dimensions=$(identify -format "%w %h %i\n" "$image_path" 2>/dev/null | awk '{print $1, $2, $3}')
    
		read width height path <<< "$dimensions"
		
		#echo "Width: $width, Height: $height"
		#echo "$width $height $path" 2>/dev/null

		# Convert width and height to integers
		width=$(echo "$width" | awk '{print int($1)}')
		height=$(echo "$height" | awk '{print int($1)}')

		if [ "$width" -gt "$height" ]; then
			x=$(( "$width" / 16))
			y=$(( "$height" / 9))
		fi

		if [ "$x" -eq "$y" ]; then
			echo "$width $height $path" >> "$default_path/Paths/Paths/wallpapers_candidates1.txt"
			echo "$path" >> "$default_path/Paths/Paths/wallpapers_candidates2.txt"
		fi
	done
}

# Function to clean up and exit
cleanup() {
    kill %1  # Kill the background loop
    exit
}

# The input is Year. 
function image_displayed() {
	year=$1
	image_path="$default_path2/$year"

	if [ "$firefox_var" -eq 1 ]; then
		firefox "$image_path/$year.html"
	fi

	image_path=$(find "$image_path" -type f -not -name "*.html")
	identify -format "%w %h %i\n" "$image_path"
	eog -f "$image_path"
}


global_seconds=10
function seconds_set() {
	global_seconds=$1
}

# The input is Date
function image_displayedd() {
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

function display_wallpapers_candidates() {
		txt_path="$default_path/Paths//Paths/wallpapers_candidates2.txt"

		lines=$(cat "$txt_path" | wc -l)
		shuffled_lines=$(shuf "$txt_path")

		for line in $(seq 1 $lines); do
			image_path=$(echo "$shuffled_lines" | awk "NR==$line")
			wallpaper_displayed $image_path
		done
}

# Input is absolute path.
function wallpaper_displayed() {
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

# This function receives $year value.
function download_images() {
	year=$1

	get_Dates $year

	total=$(cat "$default_path/Dates/Dates_$year.txt" | wc -l )
	for i in $(seq 1 $total); do
		date=$(cat "$default_path/Dates/Dates_$year.txt" | awk "NR==$i")
		download_image $date
	done

	echo -e "${grayColour}Total url checked: $count_total${endColour}"
	echo -e "${redColour}Failed paths: $count_fails${endColour}"
	for path in "${fails[@]}"; do
		echo -e "${redColour}$path ${endColour}"
	done

	tput cnorm
}

function set_all_wallpapers() {
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

			echo "identify -format %w %h %i\n $image"
			identify -format "%w %h %i\n" "$image"

		set_Background $date
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

# Main Function
BackUp

counter=0
while getopts "g:d:p:hi:b:y:wau:s:f" arg; do
	case $arg in
		g)
			year=$OPTARG
			get_Dates $year
			echo "$default_path/Dates/Dates_$year.txt"
			let counter+=1
			;;
		d)
			year=$OPTARG
			download_images $year
			let counter+=1
			;;
		p)
			path=$OPTARG
			change_Path $path
			let counter+=1
			;;
		h)
			helpPanel;
			;;
		i)
			year=$OPTARG
			image_displayed $year
			let counter+=1
			;;
		b)
			date=$OPTARG
			set_Background $date
			let counter+=1
			;;
		y)
			year=$OPTARG
			image_displayed_year $year
			let counter+=1
			;;
		w) 
			display_wallpapers_candidates
			let counter+=1
			;;
		a)
			all_wallpapers_candidates
			let counter+=1
			;;
		u)
			year=$OPTARG
			set_all_wallpapers $year
			let counter+=1
			;;
		s)
			seconds_tmp=$OPTARG
			seconds_set $seconds_tmp
			let counter+=1
			;;
		f)
			firefox_switch
			let counter+=1
			;;
		*)
			helpPanel;
    		echo -e "\n${redColour}[!] Invalid option. Exiting...\n${endColour}"
			exit 1
			;;
	esac
done


tput cnorm

if [ $counter -eq 0 ]; then
	helpPanel
fi

