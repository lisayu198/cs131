#!/bin/bash

# Simplified safedelete - Restore only the most recent deleted file

TRASH_DIR="$HOME/.trash"

mkdir -p "$TRASH_DIR"

usage() {
  echo "Usage: safedelete.sh <file(s)> | safedelete.sh --undo"
  exit 1
}

trash_file() {
  local file="$1"
  mv "$file" "$TRASH_DIR/"
  if [ $? -eq 0 ]; then
    echo "Moved '$file' to trash."
  else
    echo "Error moving '$file' to trash."
  fi
}

restore_last() {
  local last_file
  last_file=$(find "$TRASH_DIR" -maxdepth 1 -type f -printf "%T+ %p\n" | sort -nr | head -n 1 | awk '{print $2}')

  if [ -z "$last_file" ]; then
    echo "Trash is empty."
    return
  fi

  local original_name=$(basename "$last_file")

  mv "$last_file" .
  if [ $? -eq 0 ]; then
    echo "Restored '$original_name'."
  else
    echo "Error restoring '$original_name'."
  fi
}

# Main script logic

if [ $# -eq 0 ]; then
  usage
fi

if [ "$1" == "--undo" ]; then
  restore_last
  exit 0
fi

for file in "$@"; do
  if [ -e "$file" ]; then
    trash_file "$file"
  else
    echo "File '$file' not found."
  fi
done

exit 0
