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


if -n is_valid_semver "$1"; then
  echo "The provided string is a invalid Semantic Version: $1"
  exit 1
fi


IFS='.' read -ra PARTS <<< "$1"

MAJOR=${PARTS[0]}
MINOR=${PARTS[1]}
PATCH=${PARTS[2]}

case "$2" in
  major)
    ((MAJOR++))
    MINOR=0
    PATCH=0
    ;;
  minor)
    ((MINOR++))
    PATCH=0
    ;;
  patch)
    ((PATCH++))
    ;;
  y)
    ((PATCH++))
    ;;
  none)
    ;;
  *)
    echo "Invalid SemVer part provided"
    exit 1
    ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"
echo "::set-output name=new_version::$NEW_VERSION"
    