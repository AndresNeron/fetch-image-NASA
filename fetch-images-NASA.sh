#!/bin/bash

# This code fetchs the Astronomy Picture of the Day from NASA,
# and configure it as the desktop background. 
# You can download NASA's daily pictures in mass.

# Author: Andres Neron


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
	echo -e "\t${orangeColour}-c\t${endColour}${grayColour} Schedule a daily cronjob to download and set the latest image as the background at the specified HOUR in format HH:MM.${endColour}"
	echo -e "\t${orangeColour}-l\t${endColour}${grayColour} Update the background with the last image.${endColour}"
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
BackUp

counter=0
while getopts "g:d:p:hi:b:c:ly:wau:s:f" arg; do
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
		c)
			hour=$OPTARG

			if [[ "$hour" =~ ^([0-1][0-9]|2[0-3]):[0-5][0-9]$ ]]; then
				cronjob_everyday $hour
			else
				echo "Invalid time format. Please use HH:MM."
			fi
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

