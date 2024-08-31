#!/bin/bash

rm -rf .repo/local_manifest out
repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-13.1 --git-lfs
/opt/crave/resync.sh

rm -rf */xiaomi out
git config --global user.name "Kajal4414"
git config --global user.email "81718060+Kajal4414@users.noreply.github.com"
git clone -b arrow-13.1 https://github.com/scas-projects/android_device_xiaomi_spes.git device/xiaomi/spes
git clone -b arrow-13.1 https://github.com/scas-projects/android_vendor_xiaomi_spes.git vendor/xiaomi/spes
git clone -b arrow-13.1 --depth 1 https://github.com/scas-projects/android_kernel_xiaomi_spes.git kernel/xiaomi/spes

[ ! -d "hardware/xiaomi" ] && git clone -b arrow-13.1 https://github.com/ArrowOS-Devices/android_hardware_xiaomi.git hardware/xiaomi
[ ! -d "hardware/arrow/compat" ] && git clone -b arrow-13.1 https://github.com/ArrowOS/android_hardware_arrow_compat.git hardware/arrow/compat

. build/envsetup.sh && lunch arrow_spes-user && m bacon
