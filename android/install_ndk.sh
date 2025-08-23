#!/bin/bash

# Script to install the correct NDK version for the Cooking App
# This script uses the Android SDK Manager to download and install NDK version 25.1.8937393

echo "Installing NDK version 25.1.8937393..."

# Get the Android SDK directory from local.properties
SDK_DIR=$(grep "sdk.dir" local.properties | cut -d'=' -f2)

if [ -z "$SDK_DIR" ]; then
    echo "Error: Could not find sdk.dir in local.properties"
    exit 1
fi

echo "Android SDK directory: $SDK_DIR"

# Check if sdkmanager exists
SDKMANAGER="$SDK_DIR/cmdline-tools/latest/bin/sdkmanager"
if [ ! -f "$SDKMANAGER" ]; then
    echo "Error: sdkmanager not found at $SDKMANAGER"
    echo "Please make sure Android SDK Command-line Tools are installed"
    exit 1
fi

# Install the specific NDK version
echo "Installing NDK version 25.1.8937393..."
"$SDKMANAGER" "ndk;25.1.8937393"

if [ $? -eq 0 ]; then
    echo "NDK installation completed successfully!"
    echo "You can now build your Android project."
else
    echo "Error: Failed to install NDK"
    exit 1
fi
