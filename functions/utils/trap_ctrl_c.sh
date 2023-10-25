#!/bin/bash

trap ctrl_c INT

function ctrl_c() {
    echo -e "\n${redColour}[!] Exiting...\n${endColour}"
    tput cnorm; 
    exit 1
}
