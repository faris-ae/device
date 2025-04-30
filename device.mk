#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sm8350-common
$(call inherit-product, device/xiaomi/sm8350-common/common.mk)

# Camera
$(call inherit-product-if-exists, vendor/xiaomi/camera/miuicamera.mk)
$(call soong_config_set,camera,package_name,com.android.camera)

# Init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.nfc.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.nfc.rc

# Logging
 SPAMMY_LOG_TAGS := \
     MiStcImpl \
     SDM \
     SDM-histogram \
     SRE \
     WifiHAL \
     cnss-daemon \
     libcitsensorservice@2.0-impl \
     libsensor-displayalgo \
     libsensor-parseRGB \
     libsensor-ssccalapi \
     sensors \
     vendor.qti.hardware.display.composer-service \
     vendor.xiaomi.sensor.citsensorservice@2.0-service
 
 ifneq ($(TARGET_BUILD_VARIANT),eng)
 PRODUCT_VENDOR_PROPERTIES += \
     $(foreach tag,$(SPAMMY_LOG_TAGS),log.tag.$(tag)=E)
 endif

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

# Overlays-RRO
PRODUCT_PACKAGES += \
    redwoodCNSettingsProviderOverlay \
    redwoodCNWifiOverlay \
    redwoodGLSettingsProviderOverlay \
    redwoodGLWifiOverlay \
    redwoodINSettingsProviderOverlay \
    redwoodINWifiOverlay \
    redwoodNfcOverlay

# Remove unwanted packages
PRODUCT_PACKAGES += \
    RemovePackages

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# SurfaceFlinger
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.set_idle_timer_ms=4000 \
    ro.surface_flinger.set_touch_timer_ms=4000 \
    ro.surface_flinger.set_display_power_timer_ms=1000

# Audio
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/media/audio,$(TARGET_COPY_OUT_PRODUCT)/media/audio)

# Sku properties
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/sku/,$(TARGET_COPY_OUT_ODM)/etc)

# WiFi Display
PRODUCT_SYSTEM_PROPERTIES += \
    vendor.sys.video.disable.ubwc=1

# Call the proprietary setup
$(call inherit-product, vendor/xiaomi/redwood/redwood-vendor.mk)

# Call the Leica Camera setup
$(call inherit-product-if-exists, vendor/xiaomi/redwood-miuicamera/products/miuicamera.mk)
