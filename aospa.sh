#!/bin/bash

rm -rf .repo/local_manifest
repo init -u https://github.com/AOSPA/manifest -b uvite
/opt/crave/resync.sh

./rom-build.sh spes -i -v beta -t user
