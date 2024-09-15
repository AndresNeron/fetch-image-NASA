helpPanel(){
	for i in $(seq 1 65); do echo -ne "${grayColour}-"; done; echo -ne ${endColour}
	echo -e "\n${purpleColour}This program fetchs the Astronomy Picture of the Day from NASA.${endColour}" 
	echo -e "${purpleColour}Display it as gallery or configure it as the desktop background.${endColour}"
	echo -e "${purpleColour}You can download NASA's daily pictures in mass too.${endColour}"
	echo -e "${turquoiseColour}Written by Andres Neron.${endColour}"
	for i in $(seq 1 65); do echo -ne "${grayColour}-"; done; echo -ne ${endColour}
	echo -e "\n${grayColour} [!] Usage:${endColour} ${orangeColour}./fetch-images-NASA.sh ${endColour} [options]"
	for i in $(seq 1 35); do echo -ne "${grayColour}-"; done; echo -ne ${endColour}
	echo -e "\n\t${orangeColour}-g\t${endColour}${grayColour} Get dates in format %y%m%d from a specific year ${endColour}"
	echo -e "\t${orangeColour}-d\t${endColour}${grayColour} Download images from a specific year in mass${endColour}"
	echo -e "\t${orangeColour}-p\t${endColour}${grayColour} Change default path where images will be stored.${endColour}"
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
	echo -e "\t${turquoiseColour} ./fetch-images-NASA.sh${endColour}${orangeColour} -b${endColour} ${greenColour}240416${endColour}"
	echo -e "\t${turquoiseColour} ./fetch-images-NASA.sh${endColour}${orangeColour} -p${endColour} ${greenColour}"./new_path"${endColour} ${orangeColour}-g${endColour} ${greenColour}22${endColour}"
	echo -e "\t${turquoiseColour} ./fetch-images-NASA.sh${endColour}${orangeColour} -s${endColour} ${greenColour}60${endColour} ${orangeColour}-y${endColour} ${greenColour}24${endColour}"
	echo -e "\t${turquoiseColour} ./fetch-images-NASA.sh${endColour}${orangeColour} -s${endColour} ${greenColour}60${endColour} ${orangeColour}-u${endColour} ${greenColour}24${endColour}"
	echo -e "\t${turquoiseColour} ./fetch-images-NASA.sh${endColour}${orangeColour} -s${endColour} ${greenColour}60${endColour} ${orangeColour}-a${endColour} ${greenColour}24${endColour}"
	echo -e "\t${turquoiseColour} ./fetch-images-NASA.sh${endColour}${orangeColour} -f -s${endColour} ${greenColour}300${endColour} ${orangeColour}-w${endColour} ${greenColour}23${endColour}"
	exit 0
}

