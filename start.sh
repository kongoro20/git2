#!/bin/bash

# Run run.sh first
echo "Starting run.sh..."
source run.sh
echo "Finished run.sh. Sleeping for 4 hours..."
sleep 14500  # 4 hours (3600 seconds * 4)

# Execute boocle.sh 100 times with 4-hour sleep between each execution
for i in {1..100}; do
    echo "Execution $i of boocle.sh..."
    bash boocle.sh
    echo "Finished execution $i of boocle.sh. Sleeping for 4 hours..."
    sleep 14500  # 4 hours
done

echo "All tasks completed!"
