#!/bin/bash

# Check if the directory to be backed up exists
if [ ! -d "$1" ]; then
  echo "Error: directory $1 does not exist."
  exit 1
fi

# Define backup file name and location
backup_file="temp/backup_$(date +%Y-%m-%d).tar.gz"

# Check if the backup file already exists
if [ -f "$backup_file" ]; then
  echo "Error: backup file $backup_file already exists."
  exit 1
fi

# Time the execution of the tar command
start=$(date +%s)
tar -czf "$backup_file" "$1"
end=$(date +%s)

# Print execution time
echo "Backup completed in $((end-start)) seconds."

