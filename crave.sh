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

(cd device/xiaomi/spes && git pull && git cherry-pick 503d4ac^..aee6729 && git cherry-pick d4204b2 )
(cd packages/apps/WallpaperPicker2 && git fetch https://github.com/Kajal4414/android_packages_apps_WallpaperPicker2.git && git cherry-pick 18ef092 || git cherry-pick --abort)
(cd packages/apps/crDroidSettings && git fetch https://github.com/Kajal4414/android_packages_apps_crDroidSettings.git && git cherry-pick 61c1e51 e1b424c || git cherry-pick --abort)
(cd frameworks/base && git fetch https://github.com/Kajal4414/android_frameworks_base.git && git cherry-pick d264ce2 3c2cc04 || git cherry-pick --abort)
(cd vendor/lineage && git fetch https://github.com/Kajal4414/android_vendor_crdroid.git && git cherry-pick 0e584f7 || git cherry-pick --abort)

. build/envsetup.sh && lunch lineage_spes-user && make installclean && m bacon
