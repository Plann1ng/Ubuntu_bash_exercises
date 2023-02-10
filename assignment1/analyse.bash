#!/bin/bash
if curl --head --silent --fail "$1" 2> /dev/null;
 then
 curl -sI "$1" | grep -i "Content-Disposition" > /dev/null
if [ $? -eq 0 ]; then
  filename=$(curl -sI "$1" | grep -oP 'filename=.*' | cut -d= -f2 | tr -d '"')
else
  filename=$(echo "$1" | rev | cut -d/ -f1 | rev)
fi
extension="."
extension+="${filename##*.}"
name="downloadTrial"
name+="$extension"
  wget - "$1" -O "$name"
   file_type=$(file $name)
   if echo "$file_type" | grep -q "text"; then
     echo
     echo number of lines ↓
     result_tmp=$(wc -l "$name")
     count=$(echo "$result_tmp" | awk '{print $1}')
     echo "$count"
     echo number of words ↓
     result=$(wc -w "$name")
     count=$(echo "$result" | awk '{print $1}')
     echo "$count"
     echo number of empty lines ↓
     grep -o ' ' "$name" | wc -l
   byte_counter=0
   byte_counter2=0
   counter=0
   ten_first=" "
   ten_last=" "
   first_line=" "
   last_line=" "
   file="$name"
   last_line_indx=0
   while read -r line; do
      ((last_line_indx++))
   done < "$file"
    while read -r line; do
     ((counter++))
        if [[ $counter -eq 1 ]]; then
           first_line=$line
           echo
           echo first line ↓
           echo "$first_line"
        elif [[ $counter -eq last_line_indx ]]; then
           echo last line ↓
           last_line=$line
           echo "$last_line"
       fi
    done < "$file"
   echo size "$( wc -c "$name")"
for char in $(echo "$first_line" | fold -w1); do
((byte_counter++))
if [ $byte_counter -lt 11 ]; then
  ten_first="$ten_first $char"
fi
done
for char in $(echo "$last_line" | fold -w1); do
((byte_counter2++))
if [ $byte_counter2 -lt 11 ]; then
   last_bytes=$(hexdump -C $char | tail -n 1 | awk '{print $1}')
   ten_last="$ten_last $last_bytes"
fi
done
     echo first ten bytes ↓
     first_bytes=$(hexdump -n 20 -C $file | head -n 1 | awk '{print $2,$3,$4,$5,$6,$7,$8,$9,$10}')
     echo "$first_bytes"
     echo last ten bytes ↓
     last_bytes=$(hexdump -n 10 -C $file | tail -n 1 | awk '{print $2,$3,$4,$5,$6,$7,$8,$9,$10}')
     echo "$last_bytes"
     echo "The file is a text file."
   else
     echo
     echo "The file is not a text file."
   fi

  if echo "$file_type" | grep -q "image"; then
    wslview "$name"
    echo "The file is an image file."
  else
    echo
    echo "The file is not an image file."
fi
 else
  echo
  echo "This page does not exist."
fi
