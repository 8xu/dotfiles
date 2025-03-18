#!/bin/bash

# Enable strict error handling
set -e

GITCONFIG_LOCATION="$HOME/.gitconfig"
SOURCE_GITCONFIG="./.gitconfig"  # Assuming the .gitconfig file is in the current directory

# Check if the .gitconfig file exists in the home directory
if [ -f "$GITCONFIG_LOCATION" ]; then
  echo "A git configuration file already exists at $GITCONFIG_LOCATION"
  exit 1
fi

echo "Setting up your Git configuration..."

# Check whether a SSH key is already present in the ssh-agent
if ! ssh-add -L &> /dev/null; then
  echo "No SSH key found in the ssh-agent. Please add your SSH key to the ssh-agent before continuing."
  exit 1
else
  echo "SSH key is already added to the ssh-agent."
fi

# Ensure that the .gitconfig file exists in the current directory before copying
if [ ! -f "$SOURCE_GITCONFIG" ]; then
  echo ".gitconfig file not found in the current directory. Please ensure it's available."
  exit 1
fi

# Copy the .gitconfig file to the home directory
cp "$SOURCE_GITCONFIG" "$GITCONFIG_LOCATION" || { echo "Failed to copy .gitconfig"; exit 1; }

echo ".gitconfig has been successfully set up at $GITCONFIG_LOCATION!"