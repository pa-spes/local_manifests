#!/bin/bash

rm -rf .repo/local_manifest
repo init -u https://github.com/crdroidandroid/android.git -b 13.0 --git-lfs
/opt/crave/resync.sh

rm -rf */xiaomi
git config --global user.name "Kajal4414"
git config --global user.email "81718060+Kajal4414@users.noreply.github.com"
git clone -b lineage-20.0 https://github.com/scas-projects/android_device_xiaomi_spes.git device/xiaomi/spes
git clone -b arrow-13.1 https://github.com/scas-projects/android_vendor_xiaomi_spes.git vendor/xiaomi/spes
git clone -b arrow-13.1 --depth 1 https://github.com/scas-projects/android_kernel_xiaomi_spes.git kernel/xiaomi/spes

[ ! -d "hardware/xiaomi" ] && git clone -b lineage-20 https://github.com/LineageOS/android_hardware_xiaomi.git hardware/xiaomi
[ ! -d "hardware/lineage/compat" ] && git clone -b lineage-20.0 https://github.com/LineageOS/android_hardware_lineage_compat.git hardware/lineage/compat
# [ ! -d "packages/apps/GCamGOPrebuilt" ] && git clone -b arrow-13.1 https://github.com/ArrowOS-Devices/android_packages_apps_GCamGOPrebuilt.git packages/apps/GCamGOPrebuilt

. build/envsetup.sh && lunch lineage_spes-user && make installclean && m bacon
