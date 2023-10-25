#!/bin/bash

# Function to clean up and exit
function cleanup() {
    kill %1  # Kill the background loop
    exit
}
