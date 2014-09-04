#!/bin/bash

VENDOR=sony
OUTDIR=vendor/$VENDOR/$DEVICE
MAKEFILE=../../../$OUTDIR/$DEVICE-vendor-blobs.mk

if [ $BOARDCONFIGVENDOR != "true" ]; then

(cat << EOF) > ../../../$OUTDIR/$DEVICE-vendor.mk
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

ifeq (\$(BOARD_USES_QC_TIME_SERVICES),true)
PRODUCT_PACKAGES += \\
    libtime_genoff
endif

ifeq (\$(SOMC_CFG_SENSORS_COMPASS_AK8963),yes)
ifeq (\$(SOMC_CFG_SENSORS_AKM8963_DUMMY),)

PRODUCT_PACKAGES += \\
    libsensors_akm8963

endif
endif

\$(call inherit-product, vendor/$VENDOR/$DEVICE/$DEVICE-vendor-blobs.mk)
EOF

(cat << EOF) > ../../../$OUTDIR/Android.mk
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

ifeq (\$(BOARD_VENDOR),sony)
ifeq (\$(BOARD_VENDOR_PLATFORM),$BOARD_VENDOR_PLATFORM)

LOCAL_PATH := \$(call my-dir)

ifeq (\$(BOARD_USES_QC_TIME_SERVICES),true)

include \$(CLEAR_VARS)
LOCAL_MODULE := libtime_genoff
LOCAL_MODULE_OWNER := sony
LOCAL_SRC_FILES := proprietary/vendor/lib/libtime_genoff.so
LOCAL_MODULE_PATH := \$(PRODUCT_OUT)/system/vendor/lib
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
include \$(BUILD_PREBUILT)

endif

ifeq (\$(SOMC_CFG_SENSORS_COMPASS_AK8963),yes)
ifeq (\$(SOMC_CFG_SENSORS_AKM8963_DUMMY),)

include \$(CLEAR_VARS)
LOCAL_MODULE := libsensors_akm8963
LOCAL_MODULE_OWNER := sony
LOCAL_SRC_FILES := proprietary/lib/libsensors_akm8963.so
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
include \$(BUILD_PREBUILT)

endif
endif

include \$(CLEAR_VARS)
LOCAL_MODULE := com.qualcomm.location
LOCAL_MODULE_OWNER := sony
LOCAL_SRC_FILES := proprietary/app/com.qualcomm.location.apk
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .apk
LOCAL_MODULE_CLASS := APPS
LOCAL_CERTIFICATE := platform
include \$(BUILD_PREBUILT)

endif
endif
EOF
fi
