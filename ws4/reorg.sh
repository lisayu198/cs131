#!/bin/bash

# Set PATH (optional, depending on your environment)
export PATH=~/bin:"$PATH"

# Define the dataset file
DATASET=~/cs131/2019-01-h1.csv

# Get current date and time
DATE_TIME=$(date "+%F-%T")

# Reorganize the 2019 taxi dataset by vendorid
sed -n '/^1.0,/p' "$DATASET" > "${DATE_TIME}-1.0.csv"
sed -n '/^2.0,/p' "$DATASET" > "${DATE_TIME}-2.0.csv"
sed -n '/^4.0,/p' "$DATASET" > "${DATE_TIME}-4.0.csv"

# Add above files to .gitignore
for i in *.csv; do
    echo "ws4/$i" >> ../.gitignore
done

# Add word count of each file to ws4.txt
touch ws4.txt
for i in *.csv; do
    wc "$i" >> ws4.txt
done

# Append contents of .gitignore to ws4.txt
cat ../.gitignore >> ws4.txt

