#!/bin/bash

# Receives absolute_path
function set_Background_full_path() {
	absolute_path=$1
	gsettings set org.gnome.desktop.background picture-uri-dark "file://$absolute_path"
}
