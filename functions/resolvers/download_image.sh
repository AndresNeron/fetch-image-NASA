#!/bin/bash

function download_image() {
	date=$1
	image_url="https://apod.nasa.gov/apod/ap$date.html"
	echo -e "${orangeColour}Fetching -> $image_url ${endColour}"

	if [ -d "$default_path2/$date" ]; then
		echo -e "${grayColour}Directory: $default_path/Images/$date${endColour}"
	else
		mkdir "$default_path2/$date"
		echo -e "${grayColour}Directory: $default_path/Images/$date${endColour}"
	fi
	curl -s -o "$default_path2"/"$date"/"$date.html" "$image_url"
 
	url_day=$(grep "jpg" "$default_path2/$date"/"$date.html" | cut -d '"' -f 2 | awk "NR==1")
	if [ -z "$url_day" ]; then
		url_day=$(grep "jpeg" "$default_path2/$date/$date.html" | cut -d '"' -f 2 | awk "NR==1")
	fi
	if [ -z "$url_day" ]; then
		url_day=$(grep "png" "$default_path2/$date/$date.html" | cut -d '"' -f 2 | awk "NR==1")
	fi
	if [ -z "$url_day" ]; then
		echo -e "${redColour}[!] Manually check if the server https://apod.nasa.gov/apod/ap$date.html exists ${endColour}\n"
		#error=true
	fi
	url_jpg="https://apod.nasa.gov/apod/$url_day"

	part_2=$(echo "$url_day" | cut -d '/' -f 2)
	part_3=$(echo "$url_day" | cut -d '/' -f 3)


	echo -e "${orangeColour}$default_path2/$date/$part_3${endColour}"
	echo
	if [ ! -e "$default_path2/$date/$part_3" ]; then
		if [ ! "$error" = "true" ]; then
			echo
			curl -o "$default_path2/$date/$part_3" "$url_jpg"
		else
			fails+=("$default_path2/$date/$part_3")
			let count_fails+=1
		fi
		let count_total+=1
		echo -e "${yellowColour}------------------------------------------------------------${endColour}"
	else
		echo -e "${turquoiseColour}Image already exists. And all the others images of this year.${endColour}"
		echo -e "${yellowColour}------------------------------------------------------------${endColour}"
		global_error=true
	fi
	
}
