#!/bin/bash

rm -rf .repo/local_manifest
repo init -u https://github.com/AOSPA/manifest -b uvite
/opt/crave/resync.sh

git config --global user.name "Kajal4414"
git config --global user.email "81718060+Kajal4414@users.noreply.github.com"
(cd vendor/aospa && git fetch https://github.com/pa-spes/android_vendor_aospa && git cherry-pick b831e2d)

./rom-build.sh spes -i -v beta -t user
