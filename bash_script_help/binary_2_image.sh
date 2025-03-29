#!/bin/bash

# Input ZIP file
ZIP_FILE="hello.sh.zip"
WIDTH=1280
HEIGHT=720
PIXELS=$((WIDTH * HEIGHT))

# Read ZIP file as raw binary and convert to a sequence of 0s and 1s
xxd -b "$ZIP_FILE" | awk '{for (i=2; i<=9; i++) printf "%s", $i} END {print ""}' | tr -d ' \n' > binary_data.txt

# Read binary data
BIN_DATA=$(cat binary_data.txt)
TOTAL_PIXELS=${#BIN_DATA}
IMAGE_COUNT=$(( (TOTAL_PIXELS + PIXELS - 1) / PIXELS )) # Round up

# Generate images
for ((img=0; img<IMAGE_COUNT; img++)); do
    START=$((img * PIXELS))
    CHUNK=${BIN_DATA:$START:$PIXELS}

    # Pad if last chunk is smaller than PIXELS
    CHUNK=$(printf "%-${PIXELS}s" "$CHUNK" | tr ' ' '0')

    # Create PGM file
    PGM_FILE="binary_image_${img}.pgm"
    {
        echo "P2"
        echo "$WIDTH $HEIGHT"
        echo "1"
        echo "$CHUNK" | sed 's/\(.\)/\1 /g' | fold -w $((WIDTH * 2))
    } > "$PGM_FILE"

    # Convert to PNG
    #convert "$PGM_FILE" "binary_image_${img}.png"
    convert "$PGM_FILE" "binary_image_${img}.png" || echo "Failed to convert $PGM_FILE"

    echo "Saved: binary_image_${img}.png"
done

echo "Process completed!"
