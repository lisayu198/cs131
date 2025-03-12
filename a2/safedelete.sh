#!/bin/bash


TRASH_DIR="$HOME/.trash"  # Define the trash directory (defaults to ~/.trash)

mkdir -p "$TRASH_DIR"  # Create the trash directory if it doesn't exist

# Function to display usage instructions
usage() {
  echo "Usage: safedelete.sh <file(s)> | safedelete.sh --undo"
  exit 1  # Exit with an error code
}

# Function to move a file to the trash directory
trash_file() {
  local file="$1"  # Get the first argument, the filename from the argument
  mv "$file" "$TRASH_DIR/"  # Move the file to the trash
  # Check if the move was successful
  if [ $? -eq 0 ]; then
    echo "Moved '$file' to trash." 
  else
    echo "Error moving '$file' to trash."  
  fi
}

# Function to restore the most recently deleted file from the trash
restore_last() {
  local last_file 

  # Find the most recently deleted file in the trash directory
  last_file=$(find "$TRASH_DIR" -maxdepth 1 -type f -printf "%T+ %p\n" | sort -nr | head -n 1 | awk '{print $2}')

  # Check if the trash is empty
  if [ -z "$last_file" ]; then
    echo "Trash is empty."  
    return  
  fi

  local original_name=$(basename "$last_file")  # Get the original filename

  mv "$last_file" .  # Move the file from the trash back to the current directory
  # Check if the move was successful
  if [ $? -eq 0 ]; then
    echo "Restored '$original_name'."  
  else
    echo "Error restoring '$original_name'." 
  fi
}

# --- Main script logic ---

# Check if no arguments are provided
if [ $# -eq 0 ]; then
  usage  
fi

# Check if the --undo option is provided
if [ "$1" == "--undo" ]; then
  restore_last  # Restore the most recently deleted file
  exit 0  
fi

# If it's not --undo, assume it's a list of files to trash
for file in "$@"; do  # Loop through all arguments
  # Check if the file exists
  if [ -e "$file" ]; then
    trash_file "$file"  # Move the file to the trash
  else
    echo "File '$file' not found." 
  fi
done

exit 0  
