#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Environment Setup...${NC}"
rm -rf .repo/local_manifest
repo init -u https://github.com/AOSPA/manifest -b uvite
/opt/crave/resync.sh

echo -e "${BLUE}Patching AOSPA Sources...${NC}"
git config --global user.name "Kajal4414"
git config --global user.email "81718060+Kajal4414@users.noreply.github.com"
echo -e "${GREEN}frameworks/av${NC}"
(cd frameworks/av && git fetch https://github.com/pa-spes/android_frameworks_av && git cherry-pick d41b1dc 5e50b0d || git cherry-pick --abort)
echo -e "${GREEN}frameworks/base${NC}"
(cd frameworks/base && git fetch https://github.com/pa-spes/android_frameworks_base && git cherry-pick ed52cc6^..d742321 || git cherry-pick --abort)
echo -e "${GREEN}system/core${NC}"
(cd system/core && git fetch https://github.com/pa-spes/android_system_core && git cherry-pick d64258a 378111f 3c30966 e1872bf || git cherry-pick --abort)
echo -e "${GREEN}vendor/aospa${NC}"
(cd vendor/aospa && git fetch https://github.com/pa-spes/android_vendor_aospa && git cherry-pick b831e2d e62ac43 d6757b7 dcd4364 || git cherry-pick --abort)
echo -e "${GREEN}packages/apps/Settings${NC}"
(cd packages/apps/Settings && git fetch https://github.com/pa-spes/android_packages_apps_Settings && git cherry-pick b7851d1 f3fd662 bcb96e5 || git cherry-pick --abort)

echo -e "${BLUE}Starting Build...${NC}"
./rom-build.sh spes -i -v beta -t user
