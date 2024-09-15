#!/bin/bash

BackUp() {

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
