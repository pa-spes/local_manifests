#!/bin/bash

sudo apt update && sudo apt install rlwrap bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-gtk3-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev
mkdir ~/bin && PATH=~/bin:$PATH && curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo

mkdir Android && cd Android
git clone -b android-11.0.0_r46 --depth 1 https://android.googlesource.com/platform/prebuilts/vndk/v28 prebuilts/vndk/v28
git clone -b android-11.0.0_r46 --depth 1 https://android.googlesource.com/platform/prebuilts/vndk/v29 prebuilts/vndk/v29
git clone -b android-11.0.0_r46 --depth 1 https://android.googlesource.com/platform/prebuilts/go/linux-x86 prebuilts/go/linux-x86
git clone -b android-11.0.0_r46 --depth 1 https://android.googlesource.com/platform/external/golang-protobuf external/golang-protobuf

git clone -b lineage-18.1 --depth 1 https://github.com/LineageOS/android_build_blueprint build/blueprint
git clone -b lineage-18.1 --depth 1 https://github.com/LineageOS/android_prebuilts_tools-lineage prebuilts/tools-lineage
git clone -b lineage-18.1 --depth 1 https://github.com/LineageOS/android_device_qcom_sepolicy_vndr device/qcom/sepolicy_vndr

git clone -b 11.0 --depth 1 https://github.com/crdroidandroid/android_build build/make
git clone -b 11.0 --depth 1 https://github.com/crdroidandroid/android_build_soong build/soong
git clone -b 11.0 --depth 1 https://github.com/crdroidandroid/android_system_core system/core
git clone -b 11.0 --depth 1 https://github.com/crdroidandroid/android_vendor_crdroid vendor/lineage
git clone -b 11.0 --depth 1 https://github.com/crdroidandroid/android_prebuilts_build-tools prebuilts/build-tools
git clone -b 11.0 --depth 1 https://github.com/crdroidandroid/android_packages_apps_Dialer.git packages/apps/Dialer # Target

# build/make (Adjust 'ActionRecoveryBuilder')
cp build/make/core/root.mk Makefile
ln -s /workspace/ActionRecoveryBuilder/Android/build/make/core /workspace/ActionRecoveryBuilder/Android/build/core
ln -s /workspace/ActionRecoveryBuilder/Android/build/make/tools /workspace/ActionRecoveryBuilder/Android/build/tools
ln -s /workspace/ActionRecoveryBuilder/Android/build/make/target /workspace/ActionRecoveryBuilder/Android/build/target
ln -s /workspace/ActionRecoveryBuilder/Android/build/make/envsetup.sh /workspace/ActionRecoveryBuilder/Android/build/envsetup.sh
ln -s /workspace/ActionRecoveryBuilder/Android/build/make/CleanSpec.mk /workspace/ActionRecoveryBuilder/Android/build/CleanSpec.mk
ln -s /workspace/ActionRecoveryBuilder/Android/build/make/buildspec.mk.default /workspace/ActionRecoveryBuilder/Android/build/buildspec.mk.default

# build/soong - (Adjust 'ActionRecoveryBuilder')
ln -s /workspace/ActionRecoveryBuilder/Android/build/soong/root.bp /workspace/ActionRecoveryBuilder/Android/Android.bp
ln -s /workspace/ActionRecoveryBuilder/Android/build/soong/bootstrap.bash /workspace/ActionRecoveryBuilder/Android/bootstrap.bash

# Build
. build/envsetup.sh
lunch aosp_arm-eng
mmm packages/apps/Dialer
# mmma packages/apps/Dialer
