#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Enable virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit proprietary targets
$(call inherit-product, vendor/xiaomi/redwood/redwood-vendor.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Add common definitions for Qualcomm
$(call inherit-product, hardware/qcom-caf/common/common.mk)

# API
BOARD_SHIPPING_API_LEVEL := 31
PRODUCT_SHIPPING_API_LEVEL := $(BOARD_SHIPPING_API_LEVEL)

# Audio
PRODUCT_PACKAGES += \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libtinycompress \
    libvolumelistener

PRODUCT_PACKAGES += \
    audioadsprpcd \
    audio.r_submix.default \
    audio.usb.default \
    sound_trigger.primary.lahaina

PRODUCT_PACKAGES += \
    android.hardware.audio@7.0-impl \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.audio.service \
    android.hardware.soundtrigger@2.3-impl

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_lahaina/audio_effects.xml \
    $(LOCAL_PATH)/audio/audio_io_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_lahaina/audio_io_policy.conf \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_lahaina/audio_policy_configuration.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_yupik/audio_effects.xml \
    $(LOCAL_PATH)/audio/audio_io_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_yupik/audio_io_policy.conf \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_yupik/audio_policy_configuration.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration_7_0.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc

# Bluetooth
PRODUCT_PACKAGES += \
    audio.bluetooth.default

PRODUCT_PACKAGES += \
    android.hardware.bluetooth.audio-impl

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot-service.qti \
    android.hardware.boot-service.qti.recovery

# Camera
$(call soong_config_set,camera,override_format_from_reserved,true)

PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service_64
	
PRODUCT_PACKAGES += \
    android.hidl.memory@1.0-impl

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/camera/camera_cnf.txt:$(TARGET_COPY_OUT_VENDOR)/etc/camera/camera_cnf.txt

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

# Camera
$(call inherit-product-if-exists, vendor/xiaomi/redwood-miuicamera/miuicamera.mk)
$(call soong_config_set,camera,package_name,com.android.camera)

# Camera Extensions permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/camerax-vendor-extensions.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/camerax-vendor-extensions.xml

# DebugFS
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@3.0-impl-qti-display \
    android.hardware.graphics.mapper@4.0-impl-qti-display \
    android.hardware.graphics.allocator@3.0 \
    vendor.qti.hardware.display.allocator-service \
    vendor.qti.hardware.display.composer-service \
    vendor.qti.hardware.display.composer-service.rc \
    vendor.qti.hardware.display.composer-service.xml \
    vendor.qti.hardware.memtrack-service

PRODUCT_COPY_FILES += \
    hardware/qcom-caf/sm8350/display/config/snapdragon_color_libs_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/snapdragon_color_libs_config.xml

# Dex to make OTA go faster
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    dalvik.vm.boot-dex2oat-cpu-set=1,2,3,4,5,6,7 \
    dalvik.vm.boot-dex2oat-threads=7 \
    dalvik.vm.image-dex2oat-cpu-set=0,1,2,3,4,5,6,7 \
    dalvik.vm.image-dex2oat-threads=8

# Dolby
$(call inherit-product, hardware/dolby/dolby.mk)

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey \
    libcrypto_shim

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint-service.xiaomi

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@2.1-impl-qti \
    android.hardware.gnss@2.1-service-qti

PRODUCT_PACKAGES += \
    libbatching \
    libgeofencing \
    libgnss \
    libsensorndkbridge

PRODUCT_PACKAGES += \
    apdr.conf \
    flp.conf \
    gnss_antenna_info.conf \
    gps.conf \
    izat.conf \
    lowi.conf \
    sap.conf

PRODUCT_PACKAGES += \
    gnss@2.0-base.policy \
    gnss@2.0-xtra-daemon.policy

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml

# Graphics
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.qti

# HotwordEnrollement
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-hotword.xml

# IFAA manager
PRODUCT_PACKAGES += \
     IFAAService
	 
# Input
PRODUCT_PACKAGES += \
    uinput-fortsense.kl \
    uinput-fpc.kl \
    uinput-goodix.kl

PRODUCT_PACKAGES += \
    uinput-fortsense.idc \
    uinput-fpc.idc \
    uinput-goodix.idc

# IPACM
PRODUCT_PACKAGES += \
    ipacm \
    IPACM_cfg.xml

# IR
PRODUCT_PACKAGES += \
    android.hardware.ir-service.lineage

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.consumerir.xml

# Kernel
ifeq ($(PREBUILT_KERNEL),true)
LOCAL_KERNEL := device/xiaomi/redwood-kernel/Image
PRODUCT_COPY_FILES += \
	$(LOCAL_KERNEL):kernel
endif
PRODUCT_ENABLE_UFFD_GC := true

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/keylayout/uinput-goodix.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/uinput-goodix.kl

# Lineage Health
$(call soong_config_set,lineage_health,charging_control_supports_bypass,false)

PRODUCT_PACKAGES += \
    vendor.lineage.health-service.default

$(call soong_config_set,lineage_health,charging_control_charging_disabled,1)
$(call soong_config_set,lineage_health,charging_control_charging_enabled,0)
$(call soong_config_set,lineage_health,charging_control_charging_path,/sys/class/qcom-battery/input_suspend)

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/init.qti.media.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qti.media.sh \
    $(LOCAL_PATH)/media/init.qti.media.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.qti.media.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/etc/media_codecs_lahaina.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_lahaina.xml \
    $(LOCAL_PATH)/media/etc/media_codecs_yupik_v1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_yupik_v1.xml

# Network
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.ipsec_tunnel_migration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnel_migration.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml

# NFC
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    Tag

PRODUCT_PACKAGES += \
    android.hardware.nfc-service.nxp

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.uicc.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.ese.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml

$(call soong_config_set,stagefright,target_disables_thumbnail_block_model,true)

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

PRODUCT_ENFORCE_RRO_TARGETS := *

# Overlays-RRO
PRODUCT_PACKAGES += \
    NcmTetheringOverlay \
    redwoodCNSettingsProviderOverlay \
    redwoodCNWifiOverlay \
    redwoodGLSettingsProviderOverlay \
    redwoodGLWifiOverlay \
    redwoodINSettingsProviderOverlay \
    redwoodINWifiOverlay \
    redwoodNfcOverlay

# Partitions
PRODUCT_PACKAGES += \
    vendor_bt_firmware_mountpoint \
    vendor_dsp_mountpoint \
    vendor_firmware_mnt_mountpoint \
    vendor_vm-system_mountpoint

PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Power
$(call soong_config_set,power_libperfmgr,mode_extension_lib,//$(LOCAL_PATH):libperfmgr-ext-xiaomi)

PRODUCT_PACKAGES += \
    android.hardware.power-service.lineage-libperfmgr \
    libqti-perfd-client

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/power/task_profiles.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json \
    $(LOCAL_PATH)/configs/power/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# PowerShare
$(call soong_config_set,lineage_powershare,powershare_path,/sys/class/qcom-battery/reverse_chg_mode)

# QTI
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sysconfig/qti_whitelist.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/qti_whitelist.xml

# QTI fwk-detect
PRODUCT_PACKAGES += \
    libvndfwk_detect_jni.qti.vendor # Needed by CNE app

# RIL
PRODUCT_PACKAGES += \
    CarrierConfigOverlay

# Rootdir
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/charger_fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/charger_fstab.qcom \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.default \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.default \
    $(LOCAL_PATH)/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.default \
    $(LOCAL_PATH)/rootdir/etc/init.recovery.qcom.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.qcom.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc

$(foreach f,$(wildcard $(LOCAL_PATH)/rootdir/etc/init/hw/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/$(notdir $f)))
$(foreach f,$(wildcard $(LOCAL_PATH)/rootdir/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/etc/init/$(notdir $f)))
$(foreach f,$(wildcard $(LOCAL_PATH)/rootdir/bin/*.sh),\
    $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/bin/$(notdir $f)))

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.xiaomi-multihal

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.hifi_sensors.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/google/interfaces \
    hardware/google/pixel \
    hardware/lineage/interfaces/power-libperfmgr \
    hardware/qcom-caf/common/libqti-perfd-client \
    hardware/xiaomi

# SurfaceFlinger
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.set_idle_timer_ms=4000 \
    ro.surface_flinger.set_touch_timer_ms=4000 \
    ro.surface_flinger.set_display_power_timer_ms=1000

# Sku properties
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/sku/,$(TARGET_COPY_OUT_ODM)/etc)

# TextClassifier
PRODUCT_PACKAGES += \
	libtextclassifier_annotator_en_model \
	libtextclassifier_annotator_universal_model \
	libtextclassifier_actions_suggestions_universal_model \
	libtextclassifier_lang_id_model

# Telephony
PRODUCT_PACKAGES += \
    ims-ext-common \
    ims_ext_common.xml \
    qti-telephony-hidl-wrapper \
    qti_telephony_hidl_wrapper.xml \
    qti-telephony-utils \
    qti_telephony_utils.xml \
    telephony-ext \
    xiaomi-telephony-stub \
    qcrilNrDb_vendor

PRODUCT_BOOT_JARS += \
    telephony-ext \
    xiaomi-telephony-stub

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml

# Touchscreen
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.qti \
    android.hardware.usb.gadget-service.qti \
    usb_compositions.conf

PRODUCT_PACKAGES += \
    init.qcom.usb.rc \
    init.qcom.usb.sh

PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/usb/etc

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

# Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

PRODUCT_COPY_FILES += \
    vendor/qcom/opensource/vibrator/excluded-input-devices.xml:$(TARGET_COPY_OUT_VENDOR)/etc/excluded-input-devices.xml

# VNDK
# vndservicemanager has been removed from API30 devices (aosp/1235751)
# but we still need it for display services.
PRODUCT_PACKAGES += \
    vndservicemanager

# Verified boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/android.software.verified_boot.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml

# Vulkan
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2020-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml

# WiFi
PRODUCT_PACKAGES += \
    android.hardware.wifi-service \
    hostapd \
    libwifi-hal-qcom \
    WifiOverlay \
    wpa_cli \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    $(LOCAL_PATH)/wifi/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.aware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.aware.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.rtt.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.rtt.xml

# WiFi firmware symlinks
PRODUCT_PACKAGES += \
    firmware_WCNSS_qcom_cfg.ini_symlink

# WiFi Display
PRODUCT_SYSTEM_PROPERTIES += \
    vendor.sys.video.disable.ubwc=1

-include vendor/lineage-priv/keys/keys.mk


Search within code
 
‎BoardConfig.mk‎
+38
-40
Lines changed: 38 additions & 40 deletions
Original file line number	Diff line number	Diff line change
@@ -18,6 +18,7 @@ AB_OTA_PARTITIONS += \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_dlkm \
    vendor_boot

# Architecture
@@ -39,6 +40,9 @@ ART_BUILD_TARGET_DEBUG := false
ART_BUILD_HOST_NDEBUG := true
ART_BUILD_HOST_DEBUG := false

# Assert
TARGET_OTA_ASSERT_DEVICE := redwood|redwoodin
# Audio
AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT := true
AUDIO_FEATURE_ENABLED_GKI := true
@@ -48,20 +52,17 @@ BOARD_SUPPORTS_OPENSOURCE_STHAL := true
BOARD_SUPPORTS_SOUND_TRIGGER := true
TARGET_PROVIDES_AUDIO_EXTNS := true

# Assert
TARGET_OTA_ASSERT_DEVICE := redwood|redwoodin
# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth/include
# Bootloader
TARGET_NO_BOOTLOADER := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(COMMON_PATH)/bluetooth/include

# Board
TARGET_BOOTLOADER_BOARD_NAME := redwood

# Bootloader
TARGET_NO_BOOTLOADER := true
# Display
TARGET_SCREEN_DENSITY ?= 411
TARGET_SCREEN_DENSITY ?= 440

# Filesystem
TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/configs/config.fs
@@ -73,21 +74,18 @@ HWUI_COMPILE_FOR_PERF := true
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default

# HIDL
DEVICE_MATRIX_FILE := hardware/qcom-caf/common/compatibility_matrix.xml
DEVICE_MATRIX_FILE += hardware/qcom-caf/common/compatibility_matrix.xml

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    $(DEVICE_PATH)/hidl/framework_compatibility_matrix.xml \
    hardware/qcom-caf/common/vendor_framework_compatibility_matrix.xml \
    vendor/lineage/config/device_framework_matrix.xml \
    hardware/xiaomi/vintf/xiaomi_framework_compatibility_matrix.xml
    hardware/xiaomi/vintf/xiaomi_framework_compatibility_matrix.xml \
    vendor/lineage/config/device_framework_matrix.xml

DEVICE_MANIFEST_FILE += \
    $(DEVICE_PATH)/hidl/manifest_lahaina.xml \
    $(DEVICE_PATH)/hidl/manifest_xiaomi.xml

# Ignore overriding commands errors
BUILD_BROKEN_DUP_RULES := true
# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image
@@ -99,6 +97,9 @@ BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

TARGET_KERNEL_ADDITIONAL_FLAGS := TARGET_PRODUCT=$(PRODUCT_DEVICE)
TARGET_KERNEL_NO_GCC := true
TARGET_KERNEL_SOURCE := kernel/xiaomi/redwood
TARGET_KERNEL_CONFIG := vendor/lahaina-qgki_defconfig vendor/debugfs.config vendor/xiaomi_QGKI.config
TARGET_KERNEL_CONFIG += vendor/redwood_QGKI.config

BOARD_KERNEL_CMDLINE += \
    androidboot.console=ttyMSM0 \
@@ -120,39 +121,40 @@ BOARD_KERNEL_CMDLINE += \
KERNEL_CC := CC=clang
override KERNEL_TOOLCHAIN_PREFIX_arm := arm-linux-android-

# Kernel
ifeq ($(PREBUILT_KERNEL),true)
KERNEL_PATH := device/xiaomi/redwood-kernel
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_KERNEL_SOURCE := $(KERNEL_PATH)/kernel-headers
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtb
BOARD_MKBOOTIMG_ARGS += --dtb $(BOARD_PREBUILT_DTBIMAGE_DIR)/01_dtbdump_Qualcomm_Technologies,_Inc._Yupik_SoC.dtb
else
TARGET_KERNEL_SOURCE := kernel/xiaomi/redwood
TARGET_KERNEL_CONFIG := vendor/lahaina-qgki_defconfig vendor/debugfs.config vendor/xiaomi_QGKI.config
TARGET_KERNEL_CONFIG += vendor/redwood_QGKI.config
endif
# Kernel modules
BOOT_KERNEL_MODULES := \
    adsp_loader_dlkm.ko \
    apr_dlkm.ko \
    focaltech_touch.ko \
    goodix_core.ko \
    mmhardware_sysfs_dlkm.ko \
    q6_notifier_dlkm.ko \
    q6_pdr_dlkm.ko \
    qti_battery_charger_main.ko \
    snd_event_dlkm.ko \
    xiaomi_touch.ko
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(BOOT_KERNEL_MODULES)

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 201326592
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_USERDATAIMAGE_PARTITION_SIZE := 113254576128
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_USES_METADATA_PARTITION := true

BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := odm system system_ext vendor product
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_ext vendor vendor_dlkm
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200 # BOARD_SUPER_PARTITION_SIZE - 4MB

BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_USERDATAIMAGE_PARTITION_SIZE := 113254576128
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

ifeq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 104857600
@@ -166,10 +168,11 @@ endif
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 104857600
BOARD_VENDORIMAGE_PARTITION_RESERVED_SIZE := 104857600

TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# Platform
TARGET_BOARD_PLATFORM := lahaina
@@ -187,7 +190,7 @@ BOARD_USES_QCOM_HARDWARE := true

# Recovery
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
@@ -210,9 +213,6 @@ BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
# SurfaceFlinger
TARGET_USE_AOSP_SURFACEFLINGER := true

## torch control ##
TARGET_CAMERA_SERVICE_EXT_LIB := //$(DEVICE_PATH):libcameraservice_extension.redwood
# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
@@ -225,6 +225,7 @@ BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# WiFi
BOARD_WLAN_DEVICE := qcwcn
@@ -244,8 +245,5 @@ WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION := VER_0_8_X

# Inherit proprietary blobs
# Include proprietary files
include vendor/xiaomi/redwood/BoardConfigVendor.mk
# Firmware
-include vendor/xiaomi/redwood-firmware/BoardConfigVendor.mk
‎device.mk‎
+44
-10
Lines changed: 44 additions & 10 deletions
Original file line number	Diff line number	Diff line change
@@ -118,7 +118,7 @@ PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

# Camera
$(call inherit-product-if-exists, vendor/xiaomi/camera/miuicamera.mk)
$(call inherit-product-if-exists, vendor/xiaomi/redwood-miuicamera/miuicamera.mk)
$(call soong_config_set,camera,package_name,com.android.camera)

# Camera Extensions permissions
@@ -150,7 +150,7 @@ PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    dalvik.vm.image-dex2oat-threads=8

# Dolby
$(call inherit-product-if-exists, hardware/dolby/dolby.mk)
$(call inherit-product, hardware/dolby/dolby.mk)

# DRM
PRODUCT_PACKAGES += \
@@ -217,7 +217,6 @@ PRODUCT_PACKAGES += \
PRODUCT_PACKAGES += \
    uinput-fortsense.kl \
    uinput-fpc.kl \
    uinput-goodix.kl

PRODUCT_PACKAGES += \
    uinput-fortsense.idc \
@@ -244,10 +243,6 @@ PRODUCT_COPY_FILES += \
endif
PRODUCT_ENABLE_UFFD_GC := true

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/keylayout/uinput-goodix.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/uinput-goodix.kl
# Lineage Health
$(call soong_config_set,lineage_health,charging_control_supports_bypass,false)

@@ -508,7 +503,46 @@ PRODUCT_PACKAGES += \
PRODUCT_SYSTEM_PROPERTIES += \
    vendor.sys.video.disable.ubwc=1

# Call the Leica Camera setup
$(call inherit-product-if-exists, vendor/xiaomi/redwood-miuicamera/miuicamera.mk)
-include vendor/lineage-priv/keys/keys.mk
#<!-------- Codec Dolby --------->
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media_codecs_dolby_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_dolby_audio.xml
#<!-------- AxionAOSP Flags ----------->
# Disable EPPE for better compatibility
TARGET_DISABLE_EPPE := true
# Inherit LineageOS base configuration
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
# AxionOS Device Info (About Phone)
AXION_CAMERA_REAR_INFO := 108,8,2
AXION_CAMERA_FRONT_INFO := 16
AXION_MAINTAINER := Faris
AXION_PROCESSOR := Snapdragon_778G
# AxionOS CPU and Performance Settings (Max Fluidez)
AXION_CPU_SMALL_CORES ?= 0,1,2,3
AXION_CPU_BIG_CORES ?= 4,5,6,7
AXION_ALL_CORES ?= 0-7
AXION_CPU_BG ?= 0-3           # Background small cores
AXION_CPU_SYS_BG ?= 0-3       # System background small cores
AXION_CPU_FG ?= 0-7           # Foreground uses all cores
AXION_CPU_LIMIT_BG ?= 0-2     # Background heavy tasks
AXION_CPU_LIMIT_UI ?= 0-5     # UI can use small + 2 big cores
AXION_CPU_DISPLAY ?= 0-7      # Display uses all cores
# AxionOS dex2oat Optimization (Fast First Boot)
DEX2OAT_CORES ?= 0-5
DEX2OAT_THREADS ?= 6
# Device Features
BYPASS_CHARGE_SUPPORTED ?= false
PERF_GOV_SUPPORTED ?= true
PERF_DEFAULT_GOV ?= schedutil
PERF_ANIM_OVERRIDE ?= true
HBM_SUPPORTED ?= true
HBM_NODE ?= /sys/class/backlight/panel0-backlight/hbm_mode
