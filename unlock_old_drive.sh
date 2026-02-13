#!/bin/bash

# unlock_old_drive.sh
# Run this script on your NEW Arch Linux system after connecting the old drive.

echo "--- Old Drive Unlocker ---"
echo "This script will take ownership of all files on a mounted drive,"
echo "making them fully accessible to your current user."
echo ""

# 1. Ask for mount point
read -p "Enter the path where the old drive is mounted (e.g., /mnt/old_system): " MOUNT_POINT

# 2. Verify mount point
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Error: Directory '$MOUNT_POINT' does not exist."
    exit 1
fi

# 3. Confirm
echo ""
echo "WARNING: This will change ownership of ALL files in '$MOUNT_POINT' to user '$USER'."
echo "This operation might take a while for large drives."
read -p "Are you sure you want to proceed? (y/N): " CONFIRM

if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo "Aborted."
    exit 0
fi

# 4. Execute chown
echo ""
echo "Taking ownership..."
sudo chown -R "$USER":"$USER" "$MOUNT_POINT"

if [ $? -eq 0 ]; then
    echo ""
    echo "Success! You now have full access to '$MOUNT_POINT'."
else
    echo ""
    echo "Error: Failed to change ownership. Check sudo permissions."
fi
