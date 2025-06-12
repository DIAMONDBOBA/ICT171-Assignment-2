##!/bin/bash

# Le Gout deployment


LOCAL_SITE="/mnt/c/Users/nkatu/OneDrive/Desktop/LeGoutWebsite"
KEY_FILE="/home/cd/Awskeypair.pem" 
SERVER="ubuntu@ec2-52-1-191-87.compute-1.amazonaws.com"
WEB_DIR="/var/www/html/"

echo " Deploying Le Gout..."

# Basic checks
[ ! -d "$LOCAL_SITE" ] && { echo " Can't find local site at $LOCAL_SITE"; exit 1; }
[ ! -f "$KEY_FILE" ] && { echo "SSH key missing: $KEY_FILE"; exit 1; }

# Push files
echo " Syncing files..."
if ! scp -r -i "$KEY_FILE" "$LOCAL_SITE"/* "$SERVER:$WEB_DIR" 2>/dev/null; then
    echo " Upload failed - check and makre sure the connection/keys are correct"
    exit 1
fi

# Fix permissions remotely  
echo " Setting permissions..."
ssh -i "$KEY_FILE" "$SERVER" << 'REMOTE'
    sudo chown -R www-data:www-data /var/www/html/
    sudo find /var/www/html/ -type d -exec chmod 755 {} \;
    sudo find /var/www/html/ -type f -exec chmod 644 {} \;
    echo " Permissions updated"
REMOTE

if [ $? -eq 0 ]; then
    echo " Deployment complete!"
    echo "Check it out: https://le gout.click"
    echo " Hard refresh (Ctrl+F5) if changes don't show right away "
else
    echo " Permission update failed"
    exit 1
fi
