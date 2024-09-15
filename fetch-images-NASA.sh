#!/bin/bash

# This code fetchs the Astronomy Picture of the Day from NASA,
# and configure it as the desktop background. 
# You can download NASA's daily pictures in mass.

# Author: Andres Neron


# This is the default path where the images will be saved.
# You can change it as needed.
default_path="/usr/share/backgrounds/astronomy/NASA"
default_path=$(pwd) # Assuming you are in the root path of the project

# Create path if not exist
if [ ! -d "$default_path" ]; then
	mkdir -p $default_path
fi

default_path2="$default_path/Images"
if [ ! -d "$default_path2" ]; then
	mkdir -p $default_path2
fi

# Include function files
for file in "$default_path/functions/"*/*; do
	if [ -f "$file" ]; then
		source "$file"
	fi
done


# Global Variables
fails=()
count_total=0
count_fails=0
firefox_var=0
error=false
global_error=false
global_seconds=10



# Main Function
#BackUp

counter=0
while getopts "g:d:p:hi:b:cly:wau:s:f" arg; do
	case $arg in
		g)
			year=$OPTARG
			get_Dates2 $year
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
		c)
			cronjob_everyday
			let counter+=1
			;;
		l)
			last_image
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


