# Preply Audio Combiner

A shell script to extract, combine, and convert Preply lesson recording files into a single MP3 audio file.

## Background

Preply provides lesson recordings as downloadable ZIP files containing multiple WebM segments. However, these files are originally streaming files and cannot be played directly. This script combines them into a single playable MP3 file.

## Prerequisites

- **ffmpeg**: Required for audio conversion and concatenation
  - macOS: `brew install ffmpeg`
  - Ubuntu/Debian: `sudo apt install ffmpeg`
  - Windows: Download from [ffmpeg.org](https://ffmpeg.org/download.html)

- **unzip**: Usually pre-installed on most systems

**Note**: This script has been tested on macOS. Windows compatibility has not been verified.

## Setup

1. Clone or download this repository
2. Make the script executable:
   ```bash
   chmod +x combine_audio.sh
   ```

3. Edit the script to update the file paths for your system:
   ```bash
   # Path to ZIP file to extract
   zip_file="/path/to/your/Downloads/lesson_recordings.zip"
   
   # Extraction destination directory
   input_dir="$HOME/Downloads/lesson_recordings"
   
   # Output directory
   output_dir="/path/to/your/output/directory/"
   ```

## Usage

1. Download your lesson recordings ZIP file from Preply
   - On macOS, this will automatically be saved to `/Users/[your-username]/Downloads/lesson_recordings.zip`
   - The script expects the file to be named exactly `lesson_recordings.zip`
2. Update the script paths if your username or download location differs from the default
3. Run the script:
   ```bash
   ./combine_audio.sh
   ```

## What it does

1. **Extracts** the ZIP file containing WebM segments
2. **Validates** that all required `part_XX.webm` files are present
3. **Combines** all segments using ffmpeg
4. **Converts** to MP3 format with 192k bitrate
5. **Saves** the final file with today's date: `YYYY_MM_DD_Preply_audio.mp3`
6. **Cleans up** by removing the ZIP file and extracted files

## File Structure

The script expects WebM files in the format:
```
part_01.webm
part_02.webm
part_03.webm
...
```

## Output

The combined audio file will be saved as:
```
YYYY_MM_DD_Preply_audio.mp3
```

## Troubleshooting

- **"lesson_recordings.zip not found"**: Check the ZIP file path in the script
- **"No extracted files found"**: Verify the ZIP contains `part_XX.webm` files
- **"Concatenation failed"**: Ensure ffmpeg is installed and accessible

## License

MIT License - Feel free to modify and distribute.

## Contributing

Issues and pull requests welcome!