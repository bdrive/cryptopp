#!/usr/bin/env bash
set -e

# for local debugging
if [[ -f setenv-travis.sh ]]; then
    source setenv-travis.sh
fi

# install android deps
sudo apt-get -qq update
sudo apt-get -qq install --no-install-recommends openjdk-8-jdk unzip

# Required directories, set in the environment
mkdir -p "$ANDROID_HOME"
mkdir -p "$ANDROID_SDK_ROOT"
mkdir -p "$ANDROID_NDK_ROOT"

# https://stackoverflow.com/a/47028911/608639
touch "$ANDROID_HOME/repositories.cfg"

# android skd/ndk
curl -Lo /tmp/android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
unzip -qq /tmp/android-sdk.zip -d "$ANDROID_SDK"
rm -f /tmp/android-sdk.zip
echo y | "$ANDROID_SDK/tools/bin/sdkmanager" --update > /dev/null
for package in "ndk-bundle"; do
	echo install android $package
	echo y | "$ANDROID_SDK/tools/bin/sdkmanager" "$package" > /dev/null
done
