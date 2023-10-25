#!/bin/bash

function cronjob_everyday() {

	#hour=$1
	#hour_1=$(echo "$hour" | cut -d ":" -f 1)
	#hour_2=$(echo "$hour" | cut -d ":" -f 2)

	actual_date=$(date +'%y%m%d')
	actual_year=$(date +'%y')

	# Define the cron job command
	#cron_job="$hour_2 $hour_1 * * * $default_path/fetch-images-NASA.sh -c $hour"

	# Delete the last cron job from the user's crontab
	#(crontab -l | head -n -1) | crontab -

	# Add the cron job to the user's crontab
	#(crontab -l 2>/dev/null; echo "$cron_job") | crontab -

	echo -e "${turquoiseColour}Cron job scheduled to run at hour $hour daily. ${endColour}"
	echo -e "${orangeColour}$cron_job ${endColour}\n"

	if [ ! -e "$default_path/Images/$actual_date" ]; then
		mkdir -p ~/Flag/Flag3
		echo -e "${turquoiseColour}Trying to download all the images of 20$actual_year year.${endColour}"
		#echo -e "${orangeColour}All images of 20$actual_year year already in the system.${endColour}"
		$default_path/fetch-images-NASA.sh -b "$actual_date" 
		return
	else
		mkdir -p ~/Flag/Flag2
		echo -e "Images will be downloaded... \n"

		$default_path/fetch-images-NASA.sh -d "$actual_year"
		echo
		
	fi

}
