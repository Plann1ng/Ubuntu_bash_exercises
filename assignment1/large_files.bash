#!/bin/bash
if [ ! -d "$1" ]; then
  echo "Error: directory $1 does not exist."
  exit 1
fi
sizes=()
names=()
COUNTER=0
# shellcheck disable=SC2044  # Don't warn about unreachable commands in this function
#
#Recursively iterate over directory
#
#
for dir in $(find "$1" -type d); do
COUNTER=$((COUNTER + 1))
  for file in "$dir"/*; do
    name=$(basename "$file")
    size=$(du -b "$file" | awk '{print $1}')
done
    sizes+=("$((size))")
    names+=("$name")
done
#
#Modifying two lists together regarding the size. Algorithm taken from internet reference will be given.
#
#
len=${#sizes[@]}
for ((i=0; i<len-1; i++)); do
  max_index=$i
  for ((j=i+1; j<len; j++)); do
    if [ "${sizes[j]}" -gt "${sizes[max_index]}" ]; then
      max_index=$j
        max_index=$j
    fi
  done
  temp="${sizes[i]}"
  names[i]="${names[max_index]}"
  sizes[i]="${sizes[max_index]}"
  names[max_index]="$temp"
  sizes[max_index]="$temp"
done


totalSize=$(du -s "$1" | awk '{print $1}')
echo ""
echo "Total number of files scanned $COUNTER"
echo "Total size of $1 is --->  $totalSize"
for ((i=1; i<6; i++)); do
echo "$i. ${names[i-1]} ---->  ${sizes[i-1]}"
done