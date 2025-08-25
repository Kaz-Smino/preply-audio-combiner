#!/bin/bash

# Path to ZIP file to extract
zip_file="/Users/kazuyasumino/Downloads/lesson_recordings.zip"
# Extraction destination directory
input_dir="$HOME/Downloads/lesson_recordings"
# Output directory
output_dir="/Users/kazuyasumino/Library/CloudStorage/Dropbox/Preply_audio/"
# Get today's date
current_date=$(date +%Y_%m_%d)
# Output file name (mp3 format)
output_file="${output_dir}${current_date}_Preply_audio.mp3"

# Check if ZIP file exists
if [ ! -f "$zip_file" ]; then
  echo "❌ lesson_recordings.zip not found: $zip_file"
  exit 1
fi

# Extract ZIP file
echo "✅ Extracting ZIP file: $zip_file"
unzip -q "$zip_file" -d "$input_dir"  # Specify extraction destination

# Count extracted files
num_files=$(ls "$input_dir" | grep -E '^part_[0-9]+\.webm$' | wc -l)

# Check if required number of files exists
if [ "$num_files" -lt 1 ]; then
  echo "❌ No extracted files found. part_x.webm format files are required."
  exit 1
fi

# Check if all extracted files exist in sequential order
for i in $(seq -f "%02g" 1 "$num_files"); do
  part_file="${input_dir}/part_${i}.webm"
  if [ ! -f "$part_file" ]; then
    echo "❌ part_${i}.webm not found."
    exit 1
  fi
done

# Initialize file list for concatenation
rm -f file_list.txt

# Create list of part_01.webm to part_n.webm files
for i in $(seq -f "%02g" 1 "$num_files"); do
  part_file="${input_dir}/part_${i}.webm"
  if [ -f "$part_file" ]; then
    echo "file '$part_file'" >> file_list.txt
  fi
done

# Concatenation process (using ffmpeg to convert webm files to mp3 format)
echo "✅ Concatenating files..."
ffmpeg -f concat -safe 0 -i file_list.txt -c:v libx264 -c:a libmp3lame -b:a 192k "$output_file"

# Check after concatenation
if [ -f "$output_file" ]; then
  echo "✅ Concatenation completed: $output_file"
else
  echo "❌ Concatenation failed."
  exit 1
fi

# Delete extracted directory and ZIP file
echo "✅ Deleting ZIP file and extracted files..."
rm -rf "$input_dir"
rm "$zip_file"

echo "✅ Task completed."

