#!/bin/bash

set -e  # Exit on error

# Detect system architecture
ARCH=$(uname -m)

# Map architecture to required format
case "$ARCH" in
    x86_64) ARCH="amd64" ;;
    i686|i386) ARCH="386" ;;
    aarch64) ARCH="arm64" ;;
    armv7l|armv6l) ARCH="arm" ;;
    *) echo "Unsupported architecture: $ARCH" && exit 1 ;;
esac

echo "Detected architecture: $ARCH"

# Define version
VERSION="v2.30.3"

# Check if wget is installed
if ! command -v wget &> /dev/null; then
    echo "wget is not installed. Please install it before running this script."
    exit 1
fi

# Check if unzip is installed
if ! command -v unzip &> /dev/null; then
    echo "unzip is not installed. Please install it before running this script."
    exit 1
fi

# Check if sudo is available
if ! command -v sudo &> /dev/null; then
    echo "sudo is required for installation but not found."
    exit 1
fi

# Set temp directory for extraction
TMP_DIR=$(mktemp -d)
ZIP_FILE="${TMP_DIR}/op.zip"

# Download 1Password CLI
echo "⬇️  Downloading 1Password CLI..."
if ! wget -q "https://cache.agilebits.com/dist/1P/op2/pkg/${VERSION}/op_linux_${ARCH}_${VERSION}.zip" -O "$ZIP_FILE"; then
    echo "Failed to download 1Password CLI. Check your internet connection."
    exit 1
fi

# Extract the downloaded zip
echo "Extracting files..."
unzip -q -d "$TMP_DIR" "$ZIP_FILE"

# Move binary to /usr/local/bin
echo "Installing 1Password CLI..."
sudo mv "$TMP_DIR/op" /usr/local/bin/

# Cleanup
rm -rf "$TMP_DIR"

# Set permissions
sudo groupadd -f onepassword-cli
sudo chgrp onepassword-cli /usr/local/bin/op
sudo chmod g+s /usr/local/bin/op

echo "1Password CLI installed successfully!"
