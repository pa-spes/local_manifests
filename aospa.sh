#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

cherry_pick() {
    local dir=$1
    local repo_url=$2
    shift 2
    (cd "$dir" && git fetch -q "$repo_url" && git cherry-pick "$@" && echo -e "${GREEN}Cherry-pick successful in ${dir}!${NC}" || { git cherry-pick --abort; echo -e "${RED}Cherry-pick failed in ${dir}${NC}"; })
}

echo -e "${BLUE}Environment Setup...${NC}"
rm -rf .repo/local_manifests
git config --global user.name "Kajal4414"
git config --global user.email "81718060+Kajal4414@users.noreply.github.com"
repo init -u https://github.com/AOSPA/manifest -b uvite && /opt/crave/resync.sh

echo -e "${BLUE}Patching AOSPA Sources...${NC}"
cherry_pick build/soong https://github.com/pa-spes/android_build_soong ba2d27d
cherry_pick frameworks/av https://github.com/pa-spes/android_frameworks_av b79ff3d 4363eed
cherry_pick frameworks/base https://github.com/pa-spes/android_frameworks_base 6d8a2f4^..59fa0f9
cherry_pick system/core https://github.com/pa-spes/android_system_core d64258a^..e1872bf
cherry_pick packages/modules/Connectivity https://github.com/pa-spes/android_packages_modules_Connectivity 401c14f
cherry_pick vendor/aospa https://github.com/pa-spes/android_vendor_aospa 3d12ad2 b9b4da4 3842e30
cherry_pick packages/apps/Settings https://github.com/pa-spes/android_packages_apps_Settings 734fa1d^..28e3041

echo -e "${BLUE}Starting Build...${NC}"
./rom-build.sh spes -i -v beta -t user
