#!/bin/bash

# Function to clean up and exit
cleanup() {
    kill %1  # Kill the background loop
    exit
}
