#!/bin/bash

# Detect all downloaded profiles that are directories, sorted by modification time (oldest first)
PROFILE_LIST=($(find . -maxdepth 1 -type d -name 'newprofile-*' | sort))

# Check if profiles exist
if [ ${#PROFILE_LIST[@]} -eq 0 ]; then
    echo "Error: No downloaded profiles found!"
    exit 1
fi

echo "Detected ${#PROFILE_LIST[@]} profiles."

# Loop through each profile dynamically
for PROFILE in "${PROFILE_LIST[@]}"; do
    echo "Opening Firefox with profile: $PROFILE"
    
    # Open Firefox with the profile and execute tasks
    nohup firefox --no-remote --new-instance --profile "$PROFILE" --purgecaches &
    sleep 3
    bash github.sh

  # Check if github.sh executed successfully
    if [ $? -ne 0 ]; then
      echo "github.sh failed to execute on cycle $i."
      exit 1
    fi

    # Wait for the tasks to complete (Modify sleep time as per task duration)
    sleep 4  # Adjust this time according to your task execution duration

    # Close Firefox gracefully (Ensure `wmctrl` is installed)
    while wmctrl -l | grep -i "Mozilla Firefox" >/dev/null; do
        wmctrl -c "Mozilla Firefox"
        sleep 0.5
    done

    echo "Closed Firefox with profile: $PROFILE"
    sleep 2  # Small delay before launching the next profile
done

echo "All profiles processed successfully!"
