#!/bin/bash

# Check if the directory to be backed up exists
if [ ! -d "$1" ]; then
  echo "Error could not find the directory."
  exit 1
fi

# Define backup file name and location
backup_file="temp/backup_$(date +%Y-%m-%d).tar.gz"

# Check if the backup file already exists
if [ -f "$backup_file" ]; then
  echo "Error the backup file was already made"
 exit 1
fi

# Time the execution of the tar command
startSeconds=$(date +%s)
tar -czf "$backup_file" "$1"
endSeconds=$(date +%s)

# Print execution time
echo "Backup has been made in $((endSeconds-startSeconds)) seconds."
