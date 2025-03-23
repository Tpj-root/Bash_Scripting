#!/bin/bash

UPLOAD_DIR="uploads"
PORT=8000

mkdir -p "$UPLOAD_DIR"

while true; do
    { 
        echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n"
        echo "<html><body>"
        echo "<h2>Upload a File</h2>"
        echo "<form method='POST' enctype='multipart/form-data' action='/'>"
        echo "<input type='file' name='file'>"
        echo "<input type='submit' value='Upload'>"
        echo "</form>"
        
        # Read the incoming request
        REQUEST=$(nc -l -p "$PORT" -q 1)
        
        # Extract the filename and file content from the request
        FILENAME=$(echo "$REQUEST" | tr -d '\0' | grep -oP 'filename="\K[^"]+')
        FILE_CONTENT=$(echo "$REQUEST" | sed -n '/^\r$/,$p' | tail -n +2)
        
        if [[ -n "$FILENAME" ]]; then
            echo "$FILE_CONTENT" > "$UPLOAD_DIR/$FILENAME"
            echo "<p>File <b>$FILENAME</b> uploaded successfully!</p>"
        else
            echo "<p>Upload failed. No file detected.</p>"
        fi

        echo "</body></html>"
    } | nc -l -p "$PORT" -q 1
done
