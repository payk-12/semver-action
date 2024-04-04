#!/bin/bash

# Function to check if the input string is a valid SemVer
# Returns 0 if valid, 1 otherwise

function is_valid_semver {
    local VERSION="$1"
    if [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}
CURRENT_SEMVER="1.0.0"

# Main script logic

if [[ -f "$1" ]]; then
    
    # If the first parameter is a file
    FILE_CONTENT=$(<"$1")

    if is_valid_semver "$FILE_CONTENT"; then
        echo "The content of the file is a valid Semantic Version: $FILE_CONTENT"
        echo "$FILE_CONTENT"
        echo "::set-output name=current_version::$FILE_CONTENT"
        exit 0
    fi

elif [[ $(is_valid_semver "$1") ]]; then
    echo "The provided string is a valid Semantic Version: $1"
    echo "::set-output name=current_version::$1"
    exit 0
fi

IFS='.' read -ra PARTS <<< "$CURRENT_SEMVER"

MAJOR=${PARTS[0]}
MINOR=${PARTS[1]}
PATCH=${PARTS[2]}

CURRENT_SEMVER="$MAJOR.$MINOR.$PATCH"
if is_valid_semver "$CURRENT_SEMVER" == 0; then
    echo "The current Semantic Version is: $CURRENT_SEMVER"
else
    echo "The current Semantic Version is invalid: $CURRENT_SEMVER"
    exit 1
fi
echo "::set-output name=current_version::$CURRENT_SEMVER"