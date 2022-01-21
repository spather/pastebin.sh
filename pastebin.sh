#!/bin/bash

set -euo pipefail

# Set the pastebin username (change if not $USER)
API_USERNAME=$USER

# Get the pastebin API devkey and password from keychain.
# Assumes these were previously saved in the keychain with
# the following commands:
# security add-generic-password -a {pastebin username} -s pastebin-api-devkey -w {pastebin api dev key}
# security add-generic-password -a {pastebin username} -s pastebin -w {pastebin password}
API_DEV_KEY=$(security find-generic-password -a $API_USERNAME -s pastebin-api-devkey -w)
API_PASSWORD=$(security find-generic-password -a $API_USERNAME -s pastebin -w)

# Obtain a user key by logging in (this will be used in the next request to create a paste owned by
# the logged-in user.
api_user_key=$(\
    curl -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" \
         -d "api_user_name=$API_USERNAME&api_user_password=$API_PASSWORD&api_dev_key=$API_DEV_KEY" \
         'https://pastebin.com/api/api_login.php' \
)

if [ -z "$api_user_key" ]; then
    echo "Unable to obtain api user key" 1>&2
    exit 1
fi

# Read input from stdin
input=$(cat)

# Create the paste
url=$(\
      curl -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" \
	   -d "api_option=paste&api_paste_code=$input&api_dev_key=$API_DEV_KEY&api_user_key=$api_user_key" \
	   'https://pastebin.com/api/api_post.php' \
)

echo $url
