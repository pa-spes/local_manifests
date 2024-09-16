#!/bin/bash

rm -rf .repo/local_manifest
repo init -u https://github.com/AOSPA/manifest -b uvite
/opt/crave/resync.sh

git config --global user.name "Kajal4414"
git config --global user.email "81718060+Kajal4414@users.noreply.github.com"
(cd frameworks/av && git fetch https://github.com/pa-spes/android_frameworks_av && git cherry-pick d41b1dc 5e50b0d || git cherry-pick --abort)
(cd system/core && git fetch https://github.com/pa-spes/android_system_core && git cherry-pick d64258a 378111f 3c30966 e1872bf || git cherry-pick --abort)
(cd packages/apps/Settings && git fetch https://github.com/pa-spes/android_packages_apps_Settings && git cherry-pick b7851d1 f3fd662 bcb96e5 || git cherry-pick --abort)
(cd vendor/aospa && git fetch https://github.com/pa-spes/android_vendor_aospa && git cherry-pick b831e2d e62ac43 d6757b7 dcd4364 || git cherry-pick --abort)

./rom-build.sh spes -i -v beta -t user
