#!/bin/bash

cronjob_everyday() {

	actual_date=$(date +'%y%m%d')
	actual_year=$(date +'%y')

	echo -e "${turquoiseColour}Schedule cronjob to run daily. ${endColour}"

	if [ ! -e "$default_path/Images/$actual_date" ]; then
		echo -e "${turquoiseColour}Trying to download all the images of 20$actual_year year.${endColour}"
		$default_path/fetch-images-NASA.sh -d "$actual_year" 
		$default_path/fetch-images-NASA.sh -f -b "$actual_date" 
		return
	fi

}
