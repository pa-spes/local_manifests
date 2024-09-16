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
rm -rf .repo/local_manifest
git config --global user.name "Kajal4414"
git config --global user.email "81718060+Kajal4414@users.noreply.github.com"
repo init -u https://github.com/AOSPA/manifest -b uvite && /opt/crave/resync.sh

echo -e "${BLUE}Patching AOSPA Sources...${NC}"
cherry_pick frameworks/av https://github.com/pa-spes/android_frameworks_av d41b1dc 5e50b0d
cherry_pick frameworks/base https://github.com/pa-spes/android_frameworks_base ed52cc6 abced6b 0a706f0 836019b c9d43cf 32adc68 d742321
cherry_pick system/core https://github.com/pa-spes/android_system_core d64258a 378111f e1872bf
cherry_pick vendor/aospa https://github.com/pa-spes/android_vendor_aospa b831e2d d6757b7 dcd4364 02f09b9
cherry_pick packages/apps/Settings https://github.com/pa-spes/android_packages_apps_Settings b7851d1 f3fd662 bcb96e5

echo -e "${BLUE}Starting Build...${NC}"
./rom-build.sh spes -i -v beta -t user
