#!/bin/bash

last_image(){
	actual_date=$(date +'%y%m%d')
	actual_year=$(date +'%y')

	# Download all the images to the last day.
	#"$default_path/fetch-images-NASA.sh" -d "$actual_year" 

	# Set the last image as the background
	#"$default_path/fetch-images-NASA.sh" -f -b "$actual_date"
	"$default_path/fetch-images-NASA.sh" -b "$actual_date"
	
	echo
	echo -e "${orangeColor}\n[!] Last image $actual_date setup as the background.${endColor}"
}
