#!/bin/bash

while true; do
    curl -s https://raw.githubusercontent.com/elonniu/s3_sync/main/sync_file.sh | bash
    sleep 1
done
