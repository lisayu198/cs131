#!/bin/bash

# Define the vendor IDs and corresponding file suffixes
VENDOR_IDS=(1.0 2.0 4.0)

# Get the current date and time
DATE_TIME=$(date "+%F-%T")

# Reorganize the data into separate files for each vendor ID
for VENDOR_ID in "${VENDOR_IDS[@]}"; do
    # Create the filename based on the date/time and vendor ID
    FILENAME="${DATE_TIME}-${VENDOR_ID}.csv"
    
    # Use awk to filter the data for the current vendor ID
    awk -v vendor_id="${VENDOR_ID}" '$1 == vendor_id {print $0}' 2019-01-h1.csv > "${FILENAME}"
    
    # Add the file to .gitignore
    echo "${FILENAME}" >> .gitignore
done

# Create a file "ws4.txt" with the word count results for each CSV file
for VENDOR_ID in "${VENDOR_IDS[@]}"; do
    FILENAME="${DATE_TIME}-${VENDOR_ID}.csv"
    wc "${FILENAME}" >> ws4.txt
done

# Append the contents of .gitignore to ws4.txt
cat .gitignore >> ws4.txt

